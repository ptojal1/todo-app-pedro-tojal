# 🛠️ Comandos Úteis - Referência Rápida

## 🔧 Instalação e Configuração

### Instalar Ferramentas (PowerShell Admin)
```powershell
.\scripts\install-tools.ps1
```

### Configurar AWS
```powershell
# Opção 1: Script
.\scripts\setup-credentials.ps1

# Opção 2: Manual
aws configure
# Region: eu-central-1
# Output: json
```

### Verificar Instalações
```powershell
terraform --version
aws --version
kubectl version --client
git --version
```

### Testar Credenciais AWS
```powershell
aws sts get-caller-identity
```

## 📦 Preparação do Projeto

### Clonar Repositório Original
```powershell
git clone https://github.com/dockersamples/todo-list-app
```

### Preparar Aplicação
```powershell
.\scripts\prepare-repo.ps1
```

## ⚙️ Terraform

### Inicializar
```powershell
cd terraform
terraform init
```

### Planejar (Ver o que será criado)
```powershell
terraform plan
```

### Aplicar (Criar recursos)
```powershell
terraform apply
# ou com auto-approve
terraform apply -auto-approve
```

### Ver Outputs
```powershell
terraform output
```

### Destruir Recursos (CUIDADO!)
```powershell
terraform destroy
```

### Validar Configuração
```powershell
terraform validate
```

### Formatar Código
```powershell
terraform fmt
```

## 🐙 Git e GitHub

### Inicializar Repositório
```powershell
git init
git add .
git commit -m "Initial commit - Pipeline CI/CD"
git branch -M main
```

### Adicionar Remote e Push
```powershell
# Substitua SEU_USUARIO e SEU_REPO
git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git
git push -u origin main
```

### Verificar Status
```powershell
git status
git log --oneline
```

### Fazer Mudanças e Push
```powershell
git add .
git commit -m "Descrição da mudança"
git push
```

## 🔄 AWS CodePipeline

### Listar Pipelines
```powershell
aws codepipeline list-pipelines --region eu-central-1
```

### Ver Estado do Pipeline
```powershell
aws codepipeline get-pipeline-state --name todo-app-pipeline --region eu-central-1
```

### Listar Execuções
```powershell
aws codepipeline list-pipeline-executions --pipeline-name todo-app-pipeline --region eu-central-1
```

### Iniciar Execução Manual
```powershell
aws codepipeline start-pipeline-execution --name todo-app-pipeline --region eu-central-1
```

### Ver Detalhes da Última Execução
```powershell
aws codepipeline get-pipeline-execution --pipeline-name todo-app-pipeline --region eu-central-1 --pipeline-execution-id [ID]
```

## 🏗️ AWS CodeBuild

### Listar Projetos
```powershell
aws codebuild list-projects --region eu-central-1
```

### Ver Builds de um Projeto
```powershell
aws codebuild list-builds-for-project --project-name todo-app-pipeline-build --region eu-central-1
```

### Ver Logs de um Build
```powershell
aws codebuild batch-get-builds --ids [BUILD_ID] --region eu-central-1
```

### Iniciar Build Manual
```powershell
aws codebuild start-build --project-name todo-app-pipeline-build --region eu-central-1
```

## 🐳 AWS ECR

### Listar Repositórios
```powershell
aws ecr describe-repositories --region eu-central-1
```

### Listar Imagens
```powershell
aws ecr list-images --repository-name todo-list-app --region eu-central-1
```

### Descrever Imagens (com detalhes)
```powershell
aws ecr describe-images --repository-name todo-list-app --region eu-central-1
```

### Login no ECR (para Docker local)
```powershell
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 325583868777.dkr.ecr.eu-central-1.amazonaws.com
```

### Pull de Imagem
```powershell
docker pull 325583868777.dkr.ecr.eu-central-1.amazonaws.com/todo-list-app:latest
```

## ☸️ Kubernetes / EKS

### Configurar kubectl para EKS
```powershell
aws eks update-kubeconfig --name eksDeepDiveFrankfurt --region eu-central-1
```

### Ver Informações do Cluster
```powershell
kubectl cluster-info
kubectl get nodes
```

### Ver Recursos
```powershell
# Todos os recursos
kubectl get all

# Deployments
kubectl get deployments
kubectl get deployment todo-app
kubectl describe deployment todo-app

# Pods
kubectl get pods
kubectl get pods -l app=todo-app
kubectl describe pod [POD_NAME]

# Services
kubectl get services
kubectl get service todo-app-service
kubectl describe service todo-app-service
```

### Ver Logs
```powershell
# Logs de um pod específico
kubectl logs [POD_NAME]

# Logs em tempo real (follow)
kubectl logs -f [POD_NAME]

# Logs de todos os pods de um deployment
kubectl logs -l app=todo-app --all-containers=true
```

### Aplicar Manifestos
```powershell
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

# Aplicar todos os arquivos de uma pasta
kubectl apply -f kubernetes/
```

### Deletar Recursos
```powershell
kubectl delete deployment todo-app
kubectl delete service todo-app-service

# Ou usando os manifestos
kubectl delete -f kubernetes/
```

### Ver Status de Rollout
```powershell
kubectl rollout status deployment/todo-app
kubectl rollout history deployment/todo-app
```

### Escalar Deployment
```powershell
kubectl scale deployment todo-app --replicas=3
```

### Executar Comando em Pod
```powershell
kubectl exec -it [POD_NAME] -- /bin/sh
```

### Port Forward (testar localmente)
```powershell
kubectl port-forward service/todo-app-service 8080:80
# Acesse: http://localhost:8080
```

### Ver Eventos
```powershell
kubectl get events --sort-by=.metadata.creationTimestamp
```

## 📊 Monitoramento e Debug

### Script de Validação Completo
```powershell
.\scripts\validate-pipeline.ps1
```

### Ver Logs do CodeBuild
```powershell
# Build project
aws codebuild batch-get-builds --ids $(aws codebuild list-builds-for-project --project-name todo-app-pipeline-build --region eu-central-1 --query 'ids[0]' --output text) --region eu-central-1

# Deploy project
aws codebuild batch-get-builds --ids $(aws codebuild list-builds-for-project --project-name todo-app-pipeline-deploy --region eu-central-1 --query 'ids[0]' --output text) --region eu-central-1
```

### Monitorar Pipeline
```powershell
# Loop para monitorar status
while ($true) {
    aws codepipeline get-pipeline-state --name todo-app-pipeline --region eu-central-1 --query 'stageStates[*].[stageName,latestExecution.status]' --output table
    Start-Sleep -Seconds 10
}
```

### Monitorar Pods
```powershell
# Watch pods
kubectl get pods -l app=todo-app -w

# Ver pods com mais detalhes
kubectl get pods -l app=todo-app -o wide
```

## 🧹 Limpeza

### Deletar Recursos Kubernetes
```powershell
kubectl delete -f kubernetes/
```

### Deletar Recursos Terraform
```powershell
cd terraform
terraform destroy
```

### Limpar Repositório Git Local
```powershell
# Remove .git
Remove-Item -Recurse -Force .git
```

## 📸 Evidências

### Salvar Outputs
```powershell
# Terraform
cd terraform
terraform output > ../evidencias/terraform-outputs.txt
cd ..

# Pipeline executions
aws codepipeline list-pipeline-executions --pipeline-name todo-app-pipeline --region eu-central-1 > evidencias/pipeline-executions.json

# ECR images
aws ecr describe-images --repository-name todo-list-app --region eu-central-1 > evidencias/ecr-images.json

# Kubernetes resources
kubectl get all -o yaml > evidencias/k8s-resources.yaml
```

## 🔗 URLs Úteis

### Console AWS
```
Pipeline:
https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/todo-app-pipeline/view?region=eu-central-1

CodeBuild:
https://eu-central-1.console.aws.amazon.com/codesuite/codebuild/projects?region=eu-central-1

ECR:
https://eu-central-1.console.aws.amazon.com/ecr/repositories?region=eu-central-1

EKS:
https://eu-central-1.console.aws.amazon.com/eks/home?region=eu-central-1#/clusters/eksDeepDiveFrankfurt
```

### GitHub
```
Novo Repositório:
https://github.com/new

Tokens:
https://github.com/settings/tokens
```

## 🆘 Troubleshooting

### Pipeline não inicia
```powershell
# Verificar webhook
aws codepipeline list-webhooks --region eu-central-1

# Iniciar manualmente
aws codepipeline start-pipeline-execution --name todo-app-pipeline --region eu-central-1
```

### Pods não iniciam
```powershell
# Ver eventos
kubectl describe pod [POD_NAME]
kubectl get events --sort-by=.metadata.creationTimestamp

# Ver logs
kubectl logs [POD_NAME]
```

### Erro de credenciais
```powershell
# Reconfigurar
aws configure

# Verificar
aws sts get-caller-identity
```

### LoadBalancer sem IP
```powershell
# Aguardar e verificar
kubectl get service todo-app-service -w

# Ver eventos do service
kubectl describe service todo-app-service
```

## 🔄 Fluxo Típico de Trabalho

```powershell
# 1. Fazer mudanças no código
# ... editar arquivos ...

# 2. Commit e push
git add .
git commit -m "Descrição da mudança"
git push

# 3. Monitorar pipeline
.\scripts\validate-pipeline.ps1

# 4. Verificar deployment
kubectl get pods -l app=todo-app
kubectl get service todo-app-service

# 5. Testar aplicação
# Acesse o EXTERNAL-IP no navegador
```

## 💡 Dicas

### Alias Úteis (adicione ao seu PowerShell profile)
```powershell
# Editar profile
notepad $PROFILE

# Adicione:
function k { kubectl $args }
function tf { terraform $args }
function awsp { aws codepipeline $args }
```

### Ver Custo dos Recursos
```powershell
# Ver serviços em uso
aws ce get-cost-and-usage --time-period Start=2024-01-01,End=2024-01-31 --granularity MONTHLY --metrics "BlendedCost" --region eu-central-1
```

### Backup de Configuração
```powershell
# Backup do terraform.tfvars (sem token!)
$content = Get-Content terraform\terraform.tfvars
$content -replace 'github_token\s*=\s*"[^"]*"', 'github_token  = "REDACTED"' | Set-Content terraform\terraform.tfvars.backup
```

---

**💡 TIP**: Salve este arquivo como referência rápida durante o desenvolvimento!

