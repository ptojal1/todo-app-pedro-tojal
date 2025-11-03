# 📑 Índice - Navegação Rápida

## 🚀 Por Onde Começar?

### Se você quer começar RÁPIDO (Recomendado):
👉 Leia: **[INICIO_RAPIDO.md](INICIO_RAPIDO.md)** (5 minutos)

### Se você quer entender TUDO primeiro:
👉 Leia: **[README.md](README.md)** (10 minutos)

### Se você quer um RESUMO completo:
👉 Leia: **[RESUMO_FINAL.md](RESUMO_FINAL.md)** (5 minutos)

---

## 📚 Documentação por Categoria

### 🎯 Guias de Execução
| Arquivo | Descrição | Quando usar |
|---------|-----------|-------------|
| [INICIO_RAPIDO.md](INICIO_RAPIDO.md) | Início rápido em 5 minutos | Quer começar agora |
| [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) | Guia detalhado completo | Primeira vez, sem pressa |
| [RESUMO_FINAL.md](RESUMO_FINAL.md) | Resumo executivo | Overview do projeto |

### 📖 Documentação Técnica
| Arquivo | Descrição | Quando usar |
|---------|-----------|-------------|
| [README.md](README.md) | Documentação principal | Visão geral do projeto |
| [ESTRUTURA_PROJETO.md](ESTRUTURA_PROJETO.md) | Estrutura e arquitetura | Entender o fluxo CI/CD |
| [COMANDOS_UTEIS.md](COMANDOS_UTEIS.md) | Referência de comandos | Consulta rápida |

### 📦 Entrega e Validação
| Arquivo | Descrição | Quando usar |
|---------|-----------|-------------|
| [ENTREGAVEIS.md](ENTREGAVEIS.md) | Lista de entregáveis | Preparar entrega |
| [evidencias/README.md](evidencias/README.md) | Como capturar evidências | Documentar execução |

---

## 🔧 Scripts Disponíveis

### Scripts PowerShell (na pasta `scripts/`)

#### 1. install-tools.ps1
```powershell
.\scripts\install-tools.ps1
```
**O que faz**: Instala Terraform, AWS CLI, kubectl, Git  
**Quando usar**: Primeira vez, ambiente limpo  
**Requer**: PowerShell como Administrador

#### 2. setup-credentials.ps1
```powershell
.\scripts\setup-credentials.ps1
```
**O que faz**: Configura credenciais AWS interativamente  
**Quando usar**: Após instalar ferramentas  
**Requer**: Access Key ID e Secret Access Key

#### 3. prepare-repo.ps1
```powershell
.\scripts\prepare-repo.ps1
```
**O que faz**: Clona e prepara repositório da aplicação  
**Quando usar**: Após configurar AWS  
**Requer**: Git instalado

#### 4. quick-start.ps1 ⭐ RECOMENDADO
```powershell
.\scripts\quick-start.ps1
```
**O que faz**: Executa TODO o processo automaticamente  
**Quando usar**: Modo rápido, execução completa  
**Requer**: Ferramentas instaladas

#### 5. validate-pipeline.ps1
```powershell
.\scripts\validate-pipeline.ps1
```
**O que faz**: Valida pipeline, ECR, EKS e aplicação  
**Quando usar**: Após deployment, troubleshooting  
**Requer**: Pipeline criado

---

## 📂 Estrutura de Arquivos

```
infra/
├── 📄 Documentação (6 arquivos)
│   ├── README.md
│   ├── INICIO_RAPIDO.md
│   ├── INSTRUCOES_PASSO_A_PASSO.md
│   ├── RESUMO_FINAL.md
│   ├── ENTREGAVEIS.md
│   ├── COMANDOS_UTEIS.md
│   ├── ESTRUTURA_PROJETO.md
│   └── INDICE.md (este arquivo)
│
├── 🔧 Scripts (5 scripts)
│   └── scripts/
│       ├── install-tools.ps1
│       ├── setup-credentials.ps1
│       ├── prepare-repo.ps1
│       ├── quick-start.ps1
│       └── validate-pipeline.ps1
│
├── ⚙️ Terraform (8 arquivos)
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── ecr.tf
│       ├── codebuild.tf
│       ├── codepipeline.tf
│       ├── iam.tf
│       └── outputs.tf
│
├── 📋 Buildspecs (2 arquivos)
│   └── buildspec/
│       ├── buildspec-build.yml
│       └── buildspec-deploy.yml
│
├── ☸️ Kubernetes (2 arquivos)
│   └── kubernetes/
│       ├── deployment.yaml
│       └── service.yaml
│
├── 🐳 Docker (2 arquivos)
│   └── app/
│       ├── Dockerfile
│       └── .dockerignore
│
└── 📸 Evidências
    └── evidencias/
        └── README.md
```

---

## 🎯 Fluxo de Trabalho Recomendado

### Primeira Vez (Configuração Inicial)

```
1. INICIO_RAPIDO.md
   ↓
2. scripts/install-tools.ps1
   ↓
3. scripts/quick-start.ps1
   ↓
4. scripts/validate-pipeline.ps1
   ↓
5. ENTREGAVEIS.md
```

### Modo Detalhado (Passo a Passo)

```
1. README.md (entender projeto)
   ↓
2. INSTRUCOES_PASSO_A_PASSO.md
   ↓
3. Seguir cada passo manualmente
   ↓
4. ENTREGAVEIS.md (preparar entrega)
```

### Troubleshooting / Debug

```
1. COMANDOS_UTEIS.md (referência)
   ↓
2. scripts/validate-pipeline.ps1
   ↓
3. Logs no Console AWS
   ↓
4. INSTRUCOES_PASSO_A_PASSO.md (seção Troubleshooting)
```

---

## 🔍 Encontrar Informações Específicas

### Como instalar ferramentas?
- **Rápido**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) → Passo 1
- **Detalhado**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Passo 1
- **Script**: `scripts/install-tools.ps1`

### Como configurar AWS?
- **Rápido**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) → Passo 2
- **Detalhado**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Passo 2
- **Script**: `scripts/setup-credentials.ps1`

### Como criar repositório GitHub?
- **Rápido**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) → Passo 4
- **Detalhado**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Passo 4

### Como executar Terraform?
- **Rápido**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) → Passo 6
- **Detalhado**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Passo 6
- **Comandos**: [COMANDOS_UTEIS.md](COMANDOS_UTEIS.md) → Seção Terraform

### Como validar pipeline?
- **Rápido**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) → Passo 8
- **Detalhado**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Passo 8
- **Script**: `scripts/validate-pipeline.ps1`

### Como capturar evidências?
- **Lista completa**: [ENTREGAVEIS.md](ENTREGAVEIS.md) → Seção 6
- **Instruções**: [evidencias/README.md](evidencias/README.md)

### Comandos úteis?
- **Referência completa**: [COMANDOS_UTEIS.md](COMANDOS_UTEIS.md)

### Entender a arquitetura?
- **Estrutura**: [ESTRUTURA_PROJETO.md](ESTRUTURA_PROJETO.md)
- **Fluxo CI/CD**: [ESTRUTURA_PROJETO.md](ESTRUTURA_PROJETO.md) → Fluxo Completo

### O que entregar?
- **Checklist**: [ENTREGAVEIS.md](ENTREGAVEIS.md)
- **Critérios**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Checklist Final

---

## ❓ FAQs Rápidas

### Q: Por onde começar?
**A**: Execute `.\scripts\quick-start.ps1` - ele vai guiar você!

### Q: Preciso instalar tudo manualmente?
**A**: Não! Use `.\scripts\install-tools.ps1` (PowerShell como Admin)

### Q: Já tenho as ferramentas, e agora?
**A**: Execute `.\scripts\quick-start.ps1` ou siga [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md)

### Q: Como testar se está funcionando?
**A**: Execute `.\scripts\validate-pipeline.ps1`

### Q: Onde encontro os comandos?
**A**: [COMANDOS_UTEIS.md](COMANDOS_UTEIS.md)

### Q: O que preciso entregar?
**A**: Veja [ENTREGAVEIS.md](ENTREGAVEIS.md)

### Q: Pipeline falhou, e agora?
**A**: [INSTRUCOES_PASSO_A_PASSO.md](INSTRUCOES_PASSO_A_PASSO.md) → Troubleshooting

### Q: Quanto tempo vai levar?
**A**: ~30-45 minutos total (veja [RESUMO_FINAL.md](RESUMO_FINAL.md))

---

## 🎓 Recursos de Aprendizado

### Conceitos Básicos
- **CI/CD**: [ESTRUTURA_PROJETO.md](ESTRUTURA_PROJETO.md) → Fluxo Completo
- **Terraform**: [terraform/](terraform/) → Arquivos .tf comentados
- **Kubernetes**: [kubernetes/](kubernetes/) → Manifestos comentados
- **Docker**: [app/Dockerfile](app/Dockerfile)

### AWS Services
- **CodePipeline**: [terraform/codepipeline.tf](terraform/codepipeline.tf)
- **CodeBuild**: [terraform/codebuild.tf](terraform/codebuild.tf)
- **ECR**: [terraform/ecr.tf](terraform/ecr.tf)
- **IAM**: [terraform/iam.tf](terraform/iam.tf)

---

## 🚀 Atalhos Rápidos

### Execução Rápida (Automatizada)
```powershell
# PowerShell Admin
.\scripts\install-tools.ps1
# Fechar e abrir novo PowerShell
.\scripts\quick-start.ps1
```

### Validação Rápida
```powershell
.\scripts\validate-pipeline.ps1
```

### Comandos Terraform
```powershell
cd terraform
terraform init
terraform plan
terraform apply
```

### Comandos Kubernetes
```powershell
kubectl get deployments
kubectl get pods
kubectl get services
```

### Ver Aplicação
```powershell
kubectl get service todo-app-service
# Acesse o EXTERNAL-IP no navegador
```

---

## 📞 Ajuda Adicional

### Documentação Externa
- **AWS CodePipeline**: https://docs.aws.amazon.com/codepipeline/
- **AWS EKS**: https://docs.aws.amazon.com/eks/
- **Terraform AWS**: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- **Kubernetes**: https://kubernetes.io/docs/

### Pipeline de Referência
https://325583868777-ewzfl5y2.us-east-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/k8s-lab/view?region=us-east-1

---

## ✅ Checklist Rápido

- [ ] Leu este índice
- [ ] Escolheu modo rápido ou detalhado
- [ ] Instalou ferramentas
- [ ] Configurou AWS
- [ ] Criou repositório GitHub
- [ ] Executou Terraform
- [ ] Pipeline rodando
- [ ] Aplicação acessível
- [ ] Evidências capturadas
- [ ] Pronto para entregar

---

**💡 DICA**: Favorito esta página para fácil navegação!

**🎯 COMECE AQUI**: [INICIO_RAPIDO.md](INICIO_RAPIDO.md) ou [RESUMO_FINAL.md](RESUMO_FINAL.md)

