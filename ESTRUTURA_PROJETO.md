# 📁 Estrutura Completa do Projeto

```
infra/
│
├── 📄 README.md                          # Documentação principal do projeto
├── 📄 INICIO_RAPIDO.md                   # Guia de início rápido (5 min)
├── 📄 INSTRUCOES_PASSO_A_PASSO.md       # Guia detalhado passo a passo
├── 📄 ENTREGAVEIS.md                     # Lista de entregáveis da atividade
├── 📄 ESTRUTURA_PROJETO.md               # Este arquivo
├── 📄 .gitignore                         # Arquivos ignorados pelo Git
├── 📄 .gitattributes                     # Configuração de line endings
│
├── 📂 scripts/                           # Scripts de automação
│   ├── 🔧 install-tools.ps1             # Instala Terraform, AWS CLI, kubectl, Git
│   ├── 🔧 setup-credentials.ps1         # Configura credenciais AWS
│   ├── 🔧 prepare-repo.ps1              # Prepara repositório da aplicação
│   ├── 🔧 quick-start.ps1               # Execução automatizada completa
│   └── 🔧 validate-pipeline.ps1         # Valida pipeline e deployment
│
├── 📂 terraform/                         # Infraestrutura como Código
│   ├── ⚙️ main.tf                       # Configuração principal e provider AWS
│   ├── ⚙️ variables.tf                  # Definição de variáveis
│   ├── ⚙️ terraform.tfvars              # Valores das variáveis (CONFIGURAR!)
│   ├── ⚙️ ecr.tf                        # AWS ECR Repository
│   ├── ⚙️ codebuild.tf                  # AWS CodeBuild Projects (Build + Deploy)
│   ├── ⚙️ codepipeline.tf               # AWS CodePipeline
│   ├── ⚙️ iam.tf                        # IAM Roles, Policies, S3 Bucket
│   └── ⚙️ outputs.tf                    # Outputs dos recursos criados
│
├── 📂 buildspec/                         # Especificações de build
│   ├── 📋 buildspec-build.yml           # Build da imagem Docker e push para ECR
│   └── 📋 buildspec-deploy.yml          # Deploy no cluster EKS
│
├── 📂 kubernetes/                        # Manifestos Kubernetes
│   ├── ☸️ deployment.yaml               # Deployment da aplicação (2 réplicas)
│   └── ☸️ service.yaml                  # Service LoadBalancer
│
├── 📂 app/                               # Código da aplicação
│   ├── 🐳 Dockerfile                    # Imagem Docker da aplicação
│   ├── 📄 .dockerignore                 # Arquivos ignorados no build
│   └── 📦 [arquivos da aplicação]       # Código fonte (clonado do GitHub)
│
└── 📂 evidencias/                        # Capturas de tela e logs
    ├── 📄 README.md                      # Instruções para evidências
    └── 🖼️ [screenshots e logs]          # Arquivos de evidência

```

## 🏗️ Recursos AWS que serão criados

### 1. Amazon ECR (Elastic Container Registry)
```
Nome: todo-list-app
Função: Armazenar imagens Docker da aplicação
Features:
  ✅ Scan de vulnerabilidades automático
  ✅ Lifecycle policy (mantém últimas 10 imagens)
  ✅ Criptografia AES256
```

### 2. AWS CodeBuild - Build Project
```
Nome: todo-app-pipeline-build
Função: Construir imagem Docker
Service Role: codebuild-asn-demo-lab-service-role
Processo:
  1. Faz login no ECR
  2. Constrói imagem Docker
  3. Tageia imagem (latest + commit hash)
  4. Faz push para ECR
  5. Atualiza manifest do Kubernetes
```

### 3. AWS CodeBuild - Deploy Project
```
Nome: todo-app-pipeline-deploy
Função: Deploy no cluster EKS
Service Role: codebuild-asn-demo-lab-service-role
Processo:
  1. Instala kubectl
  2. Configura acesso ao cluster EKS
  3. Aplica manifests (deployment + service)
  4. Aguarda rollout
  5. Verifica status
```

### 4. AWS CodePipeline
```
Nome: todo-app-pipeline
Função: Orquestrar o fluxo CI/CD

Stages:
  ┌─────────────┐
  │   Source    │  ← GitHub (webhook automático)
  └─────────────┘
         ↓
  ┌─────────────┐
  │    Build    │  ← CodeBuild (build image)
  └─────────────┘
         ↓
  ┌─────────────┐
  │   Deploy    │  ← CodeBuild (deploy to EKS)
  └─────────────┘

Trigger: Push para branch main no GitHub
```

### 5. Amazon S3 Bucket
```
Nome: todo-app-pipeline-artifacts-325583868777
Função: Armazenar artifacts do pipeline
Features:
  ✅ Versionamento habilitado
  ✅ Criptografia AES256
  ✅ Bloqueio de acesso público
  ✅ Lifecycle (deleta artifacts após 30 dias)
```

### 6. IAM Roles
```
CodePipeline Role:
  - Nome: todo-app-pipeline-codepipeline-role
  - Permissões: S3, CodeBuild, GitHub

CodeBuild Service Role:
  - ARN: arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role
  - Fornecida pela atividade (NÃO criamos)
```

## ☸️ Recursos Kubernetes no EKS

### 1. Deployment
```yaml
Nome: todo-app
Namespace: default
Replicas: 2
Image: 325583868777.dkr.ecr.eu-central-1.amazonaws.com/todo-list-app:latest
Port: 3000

Resources:
  Requests: 100m CPU, 128Mi RAM
  Limits: 200m CPU, 256Mi RAM

Health Checks:
  ✅ Liveness Probe (HTTP /)
  ✅ Readiness Probe (HTTP /)
```

### 2. Service
```yaml
Nome: todo-app-service
Type: LoadBalancer
Port: 80 → 3000
Selector: app=todo-app

Expõe a aplicação publicamente via LoadBalancer
```

## 🔄 Fluxo Completo do Pipeline

```
┌──────────────────────────────────────────────────────────────┐
│                    FLUXO CI/CD COMPLETO                       │
└──────────────────────────────────────────────────────────────┘

1. DESENVOLVEDOR
   │
   ├─→ Faz mudanças no código
   ├─→ Commit
   └─→ Push para GitHub (branch main)
        │
        ↓
2. GITHUB
   │
   ├─→ Recebe push
   ├─→ Webhook notifica CodePipeline
   └─→ Código disponibilizado
        │
        ↓
3. CODEPIPELINE - Stage: Source
   │
   ├─→ Detecta mudança
   ├─→ Baixa código do GitHub
   └─→ Salva em S3 (artifacts)
        │
        ↓
4. CODEBUILD - Build Project
   │
   ├─→ Baixa código do S3
   ├─→ Faz login no ECR
   ├─→ Executa docker build
   ├─→ Tageia imagem (latest + commit hash)
   ├─→ Faz docker push para ECR
   ├─→ Atualiza deployment.yaml com nova tag
   └─→ Salva artifacts em S3
        │
        ↓
5. ECR (Elastic Container Registry)
   │
   ├─→ Recebe nova imagem
   ├─→ Escaneia vulnerabilidades
   └─→ Armazena imagem
        │
        ↓
6. CODEBUILD - Deploy Project
   │
   ├─→ Baixa artifacts do S3
   ├─→ Instala kubectl
   ├─→ Configura acesso ao EKS
   ├─→ Aplica deployment.yaml (kubectl apply)
   ├─→ Aplica service.yaml (kubectl apply)
   ├─→ Aguarda rollout status
   └─→ Verifica deployment
        │
        ↓
7. EKS (Cluster Kubernetes)
   │
   ├─→ Recebe novos manifests
   ├─→ Faz pull da imagem do ECR
   ├─→ Cria/atualiza pods
   ├─→ Espera pods ficarem Ready
   └─→ Atualiza LoadBalancer
        │
        ↓
8. LOAD BALANCER
   │
   ├─→ Roteia tráfego para pods
   └─→ Expõe aplicação publicamente
        │
        ↓
9. USUÁRIO FINAL
   │
   └─→ Acessa aplicação via http://[EXTERNAL-IP]

┌──────────────────────────────────────────────────────────────┐
│  ✅ APLICAÇÃO ATUALIZADA E RODANDO!                           │
└──────────────────────────────────────────────────────────────┘
```

## ⏱️ Tempos Estimados

| Etapa | Tempo |
|-------|-------|
| Source (GitHub) | ~10 segundos |
| Build (CodeBuild) | ~3-5 minutos |
| Deploy (CodeBuild) | ~2-3 minutos |
| **Total Pipeline** | **~5-10 minutos** |

## 🔍 Monitoramento

### Console AWS
- **CodePipeline**: https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/
- **CodeBuild**: https://eu-central-1.console.aws.amazon.com/codesuite/codebuild/
- **ECR**: https://eu-central-1.console.aws.amazon.com/ecr/
- **EKS**: https://eu-central-1.console.aws.amazon.com/eks/

### Linha de Comando
```powershell
# Ver status do pipeline
aws codepipeline get-pipeline-state --name todo-app-pipeline --region eu-central-1

# Ver últimas execuções
aws codepipeline list-pipeline-executions --pipeline-name todo-app-pipeline --region eu-central-1

# Ver imagens no ECR
aws ecr list-images --repository-name todo-list-app --region eu-central-1

# Ver pods no EKS
kubectl get pods -l app=todo-app

# Ver service e LoadBalancer
kubectl get service todo-app-service
```

## 📊 Diagrama de Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                         DEVELOPER                            │
│                            │                                 │
│                            ↓                                 │
│                        ┌────────┐                           │
│                        │ GitHub │                           │
│                        └────────┘                           │
│                            │                                 │
│                            ↓ (webhook)                       │
├─────────────────────────────────────────────────────────────┤
│                        AWS CLOUD                             │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              AWS CodePipeline                         │  │
│  │                                                        │  │
│  │  ┌─────────┐  ┌──────────┐  ┌─────────────┐        │  │
│  │  │ Source  │→ │  Build   │→ │   Deploy    │        │  │
│  │  │ GitHub  │  │CodeBuild │  │  CodeBuild  │        │  │
│  │  └─────────┘  └──────────┘  └─────────────┘        │  │
│  │                     │                │                │  │
│  └─────────────────────┼────────────────┼───────────────┘  │
│                        ↓                ↓                   │
│                  ┌──────────┐    ┌───────────┐            │
│                  │   ECR    │    │    EKS    │            │
│                  │ (Images) │    │ (Cluster) │            │
│                  └──────────┘    └───────────┘            │
│                                        │                    │
│                                        ↓                    │
│                                 ┌─────────────┐            │
│                                 │LoadBalancer │            │
│                                 └─────────────┘            │
│                                        │                    │
└────────────────────────────────────────┼───────────────────┘
                                         ↓
                                   ┌──────────┐
                                   │  USERS   │
                                   └──────────┘
```

## 📋 Checklist de Uso

### Preparação
- [ ] Instalar ferramentas (Terraform, AWS CLI, kubectl, Git)
- [ ] Configurar credenciais AWS
- [ ] Criar repositório GitHub
- [ ] Criar token GitHub
- [ ] Clonar aplicação todo-list-app

### Configuração
- [ ] Editar terraform.tfvars com dados do GitHub
- [ ] Verificar service role ARN
- [ ] Validar region (eu-central-1)

### Execução
- [ ] terraform init
- [ ] terraform plan
- [ ] terraform apply
- [ ] git push para GitHub

### Validação
- [ ] Pipeline executado com sucesso
- [ ] Imagem no ECR
- [ ] Pods rodando no EKS
- [ ] Aplicação acessível via LoadBalancer
- [ ] Capturar evidências

### Entrega
- [ ] Scripts Terraform
- [ ] Screenshots
- [ ] Logs
- [ ] Documentação
- [ ] Repositório GitHub público

## 🎯 Objetivo da Atividade

✅ Demonstrar conhecimento em:
- Infrastructure as Code (Terraform)
- CI/CD (CodePipeline + CodeBuild)
- Container Registry (ECR)
- Container Orchestration (Kubernetes/EKS)
- Automação de Deploy
- Integração GitHub → AWS

---

**📚 Para mais detalhes, consulte os outros arquivos de documentação!**

