# Pipeline CI/CD - Todo List App no AWS EKS

Este projeto implementa um pipeline completo de CI/CD usando AWS CodePipeline, CodeBuild, ECR e EKS para deploy da aplicação Todo List.

## 📋 Pré-requisitos

### Ferramentas Necessárias (Vamos instalar todas!)
- ✅ Terraform
- ✅ AWS CLI
- ✅ kubectl
- ✅ Git
- ✅ Chocolatey (gerenciador de pacotes para Windows)

## 🔧 Passo 1: Instalação das Ferramentas

### 1.1 Execute o script de instalação

Abra o PowerShell como **Administrador** e execute:

```powershell
# Habilitar execução de scripts
Set-ExecutionPolicy Bypass -Scope Process -Force

# Executar o instalador
.\scripts\install-tools.ps1
```

### 1.2 Após a instalação, abra um NOVO PowerShell e verifique:

```powershell
terraform --version
aws --version
kubectl version --client
git --version
```

## 🔑 Passo 2: Configurar Credenciais AWS

Você precisará das credenciais AWS da turma (Access Key ID e Secret Access Key).

```powershell
aws configure
```

Quando solicitado, informe:
- **AWS Access Key ID**: [Pegar com o professor/turma]
- **AWS Secret Access Key**: [Pegar com o professor/turma]
- **Default region name**: `eu-central-1` (Frankfurt - onde está o EKS)
- **Default output format**: `json`

## 📦 Passo 3: Clonar e Preparar o Repositório

```powershell
# Clonar o repositório original
git clone https://github.com/dockersamples/todo-list-app
cd todo-list-app

# Copiar arquivos para o nosso projeto
cd ..
.\scripts\prepare-repo.ps1
```

## 🏗️ Passo 4: Criar Repositório no GitHub

1. Acesse https://github.com/new
2. Crie um repositório público (ex: `todo-list-app-pipeline`)
3. Anote o nome do repositório
4. Crie um Personal Access Token:
   - Acesse: https://github.com/settings/tokens
   - Generate new token (classic)
   - Selecione: `repo` (full control)
   - Copie o token gerado

## 🚀 Passo 5: Configurar Variáveis do Terraform

Edite o arquivo `terraform/terraform.tfvars`:

```hcl
aws_region          = "eu-central-1"
project_name        = "todo-app-pipeline"
ecr_repository_name = "todo-list-app"
github_owner        = "SEU_USUARIO_GITHUB"
github_repo         = "SEU_REPOSITORIO"
github_branch       = "main"
github_token        = "SEU_TOKEN_GITHUB"
eks_cluster_name    = "eksDeepDiveFrankfurt"
```

## ⚡ Passo 6: Provisionar Infraestrutura

```powershell
cd terraform

# Inicializar Terraform
terraform init

# Ver o que será criado
terraform plan

# Criar infraestrutura
terraform apply
```

Digite `yes` quando solicitado.

## 📤 Passo 7: Fazer Push para o GitHub

```powershell
cd ..
git init
git add .
git commit -m "Initial commit - Todo List App Pipeline"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
git push -u origin main
```

## ✅ Passo 8: Validar Pipeline

1. Acesse o Console AWS → CodePipeline
2. Verifique se o pipeline foi executado com sucesso
3. Acesse o Console AWS → ECR e verifique se a imagem foi criada
4. Verifique o deployment no cluster EKS:

```powershell
aws eks update-kubeconfig --name eksDeepDiveFrankfurt --region eu-central-1
kubectl get deployments
kubectl get pods
kubectl get services
```

## 📁 Estrutura do Projeto

```
infra/
├── README.md
├── scripts/
│   ├── install-tools.ps1      # Instala ferramentas necessárias
│   └── prepare-repo.ps1        # Prepara repositório
├── app/
│   ├── Dockerfile              # Dockerfile da aplicação
│   └── [arquivos da app]       # Código fonte
├── kubernetes/
│   ├── deployment.yaml         # Deployment do Kubernetes
│   └── service.yaml            # Service do Kubernetes
├── terraform/
│   ├── main.tf                 # Configuração principal
│   ├── variables.tf            # Variáveis
│   ├── terraform.tfvars        # Valores das variáveis
│   ├── ecr.tf                  # Repositório ECR
│   ├── codebuild.tf            # Projetos CodeBuild
│   ├── codepipeline.tf         # Pipeline
│   ├── iam.tf                  # Roles e policies
│   └── outputs.tf              # Outputs
└── buildspec/
    ├── buildspec-build.yml     # Build da imagem Docker
    └── buildspec-deploy.yml    # Deploy no EKS
```

## 🔍 Troubleshooting

### Erro de credenciais AWS
```powershell
aws sts get-caller-identity
```

### Erro de acesso ao EKS
```powershell
aws eks update-kubeconfig --name eksDeepDiveFrankfurt --region eu-central-1
```

### Ver logs do CodeBuild
```powershell
aws codebuild list-builds --region eu-central-1
```

## 📚 Referências

- [Pipeline de referência](https://325583868777-ewzfl5y2.us-east-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/k8s-lab/view?region=us-east-1)
- [Documentação AWS CodePipeline](https://docs.aws.amazon.com/codepipeline/)
- [Documentação Terraform AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 👥 Entregáveis

- ✅ Scripts Terraform
- ✅ Pipeline funcionando
- ✅ Imagem no ECR
- ✅ Aplicação rodando no EKS
- ✅ Documentação completa

