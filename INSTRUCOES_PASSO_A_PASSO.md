# 📝 Instruções Passo a Passo - Atividade AWS Pipeline

## ✅ Checklist Completo da Atividade

### Preparação do Ambiente Local

- [ ] Instalar ferramentas (Terraform, AWS CLI, kubectl, Git)
- [ ] Configurar credenciais AWS
- [ ] Clonar repositório da aplicação
- [ ] Criar repositório GitHub da dupla
- [ ] Criar token GitHub

### Infraestrutura Terraform

- [ ] Configurar terraform.tfvars
- [ ] Executar terraform init
- [ ] Executar terraform plan
- [ ] Executar terraform apply
- [ ] Verificar recursos criados (ECR, CodeBuild, CodePipeline)

### Pipeline CI/CD

- [ ] Fazer push do código para GitHub
- [ ] Pipeline executar automaticamente
- [ ] Build da imagem Docker (CodeBuild)
- [ ] Push da imagem para ECR
- [ ] Deploy no cluster EKS
- [ ] Validar aplicação rodando

---

## 🚀 PASSO 1: Instalação das Ferramentas

### 1.1 Abrir PowerShell como Administrador

1. Pressione `Win + X`
2. Clique em "Windows PowerShell (Administrador)"

### 1.2 Executar o instalador

```powershell
# Navegar até o diretório do projeto
cd "C:\Users\ptoja\OneDrive\Área de Trabalho\infra"

# Permitir execução de scripts
Set-ExecutionPolicy Bypass -Scope Process -Force

# Executar instalador
.\scripts\install-tools.ps1
```

### 1.3 Fechar e abrir um NOVO PowerShell

### 1.4 Verificar instalações

```powershell
terraform --version
aws --version
kubectl version --client
git --version
```

**✅ CHECKPOINT**: Todas as ferramentas devem mostrar suas versões.

---

## 🔑 PASSO 2: Configurar Credenciais AWS

### 2.1 Obter credenciais

Peça ao professor ou à turma:
- AWS Access Key ID
- AWS Secret Access Key

### 2.2 Configurar AWS CLI

**Opção A - Script automatizado:**
```powershell
.\scripts\setup-credentials.ps1
```

**Opção B - Manualmente:**
```powershell
aws configure
```

Quando solicitado:
- **AWS Access Key ID**: [cole aqui]
- **AWS Secret Access Key**: [cole aqui]
- **Default region name**: `eu-central-1`
- **Default output format**: `json`

### 2.3 Testar credenciais

```powershell
aws sts get-caller-identity
```

**✅ CHECKPOINT**: Deve mostrar informações da conta AWS (325583868777).

---

## 📦 PASSO 3: Clonar Repositório e Preparar Código

### 3.1 Clonar o repositório original

```powershell
# Voltar ao diretório infra (se necessário)
cd "C:\Users\ptoja\OneDrive\Área de Trabalho\infra"

# Clonar repositório
git clone https://github.com/dockersamples/todo-list-app
```

### 3.2 Copiar arquivos para o projeto

```powershell
.\scripts\prepare-repo.ps1
```

**✅ CHECKPOINT**: Deve ter uma pasta `app` com os arquivos da aplicação.

---

## 🐙 PASSO 4: Criar Repositório no GitHub

### 4.1 Criar repositório

1. Acesse: https://github.com/new
2. **Repository name**: `todo-list-app-pipeline` (ou outro nome)
3. **Visibility**: Public ✅
4. **NÃO** inicialize com README, .gitignore ou license
5. Clique em "Create repository"

### 4.2 Anotar informações

- Nome do repositório: ___________________
- Seu usuário GitHub: ___________________

### 4.3 Criar Personal Access Token

1. Acesse: https://github.com/settings/tokens
2. Clique em "Generate new token" → "Generate new token (classic)"
3. **Note**: "AWS Pipeline Token"
4. **Expiration**: 90 days (ou mais)
5. **Select scopes**: 
   - ✅ `repo` (Full control of private repositories)
6. Clique em "Generate token"
7. **COPIE O TOKEN** (você não verá novamente!)

Token: ___________________

**⚠️ IMPORTANTE**: Guarde esse token em local seguro!

**✅ CHECKPOINT**: Repositório criado e token copiado.

---

## ⚙️ PASSO 5: Configurar Terraform

### 5.1 Editar terraform.tfvars

```powershell
# Abrir arquivo no bloco de notas
notepad terraform\terraform.tfvars
```

### 5.2 Preencher as informações

```hcl
# Configurações do Projeto
aws_region          = "eu-central-1"
project_name        = "todo-app-pipeline"
ecr_repository_name = "todo-list-app"

# Configurações do GitHub - PREENCHA AQUI!
github_owner  = "SEU_USUARIO_GITHUB"     # Ex: "joaosilva"
github_repo   = "todo-list-app-pipeline"  # Nome do seu repositório
github_branch = "main"
github_token  = "COLE_SEU_TOKEN_AQUI"    # Token do passo 4.3

# Configurações do EKS
eks_cluster_name = "eksDeepDiveFrankfurt"

# Service Role (NÃO ALTERAR)
codebuild_service_role_arn = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"

# Account ID (NÃO ALTERAR)
aws_account_id = "325583868777"
```

### 5.3 Salvar e fechar

**✅ CHECKPOINT**: Arquivo terraform.tfvars configurado corretamente.

---

## 🏗️ PASSO 6: Provisionar Infraestrutura com Terraform

### 6.1 Navegar para o diretório terraform

```powershell
cd terraform
```

### 6.2 Inicializar Terraform

```powershell
terraform init
```

**Deve aparecer**: "Terraform has been successfully initialized!"

### 6.3 Planejar (ver o que será criado)

```powershell
terraform plan
```

**Deve mostrar**: Lista de recursos que serão criados:
- aws_ecr_repository
- aws_codebuild_project (2x)
- aws_codepipeline
- aws_s3_bucket
- aws_iam_role
- etc.

### 6.4 Aplicar (criar recursos)

```powershell
terraform apply
```

1. Revise os recursos
2. Digite `yes` quando solicitado
3. **Aguarde** (pode demorar 2-5 minutos)

### 6.5 Verificar outputs

No final, deve mostrar:
- ECR repository URL
- Pipeline name
- CodeBuild projects
- Links para console AWS

**✅ CHECKPOINT**: Terraform apply concluído com sucesso! Todos os recursos criados.

---

## 📤 PASSO 7: Fazer Push para GitHub

### 7.1 Voltar ao diretório raiz

```powershell
cd ..
```

### 7.2 Inicializar Git e fazer commit

```powershell
# Inicializar git
git init

# Adicionar todos os arquivos
git add .

# Fazer commit
git commit -m "Initial commit - Pipeline CI/CD Todo App"

# Renomear branch para main
git branch -M main

# Adicionar remote (SUBSTITUA com seu usuário e repositório!)
git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git

# Fazer push
git push -u origin main
```

**Se pedir autenticação:**
- Username: seu_usuario_github
- Password: **USE O TOKEN** (não a senha do GitHub!)

**✅ CHECKPOINT**: Código enviado para GitHub. Pipeline deve iniciar automaticamente!

---

## 🔍 PASSO 8: Validar Pipeline

### 8.1 Acessar Console AWS

1. Acesse: https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/pipelines
2. Faça login com as credenciais da turma
3. Procure por `todo-app-pipeline`
4. Clique no pipeline

### 8.2 Acompanhar execução

Você verá 3 stages:
1. **Source** (GitHub) - Busca o código
2. **Build** (CodeBuild) - Constrói a imagem Docker
3. **Deploy** (CodeBuild) - Deploy no EKS

**Aguarde** até todos os stages ficarem verdes (✅ Succeeded)

### 8.3 Verificar imagem no ECR

1. Acesse: https://eu-central-1.console.aws.amazon.com/ecr/repositories
2. Procure por `todo-list-app`
3. Clique no repositório
4. Deve ter pelo menos 1 imagem

### 8.4 Verificar deployment no EKS

```powershell
# Configurar kubectl
aws eks update-kubeconfig --name eksDeepDiveFrankfurt --region eu-central-1

# Verificar deployments
kubectl get deployments

# Verificar pods
kubectl get pods

# Verificar services
kubectl get services

# Obter URL da aplicação
kubectl get service todo-app-service
```

**Procure por**: EXTERNAL-IP (URL do LoadBalancer)

### 8.5 Acessar aplicação

Copie o EXTERNAL-IP e acesse no navegador:
```
http://[EXTERNAL-IP]
```

**✅ CHECKPOINT**: Aplicação Todo List rodando no navegador!

---

## 🎉 PASSO 9: Validação Automática

### 9.1 Executar script de validação

```powershell
.\scripts\validate-pipeline.ps1
```

Este script verifica:
- ✅ Credenciais AWS
- ✅ Pipeline existente
- ✅ Última execução
- ✅ Imagens no ECR
- ✅ Deployment no EKS
- ✅ URL da aplicação

---

## 📸 PASSO 10: Documentar para Entrega

### 10.1 Capturar evidências

Tire prints das seguintes telas:

1. **Terraform Apply**: Terminal mostrando sucesso
2. **CodePipeline**: Pipeline com todos os stages em Succeeded
3. **CodeBuild - Build**: Logs do build bem-sucedido
4. **CodeBuild - Deploy**: Logs do deploy bem-sucedido
5. **ECR**: Repositório com imagens
6. **Kubectl**: Comandos mostrando pods/services rodando
7. **Navegador**: Aplicação funcionando

### 10.2 Organizar entrega

Crie uma pasta com:
- ✅ Scripts Terraform (pasta `terraform/`)
- ✅ Prints das evidências
- ✅ README.md com instruções
- ✅ Arquivo de outputs do Terraform

```powershell
# Gerar outputs do terraform
cd terraform
terraform output > terraform-outputs.txt
cd ..
```

---

## 🐛 Troubleshooting

### Erro: "Terraform not found"
**Solução**: Feche e abra um novo PowerShell após instalar as ferramentas.

### Erro: "Access Denied" na AWS
**Solução**: Verifique as credenciais AWS (`aws sts get-caller-identity`).

### Erro no Pipeline: "Repository not found"
**Solução**: Verifique se o token GitHub tem permissões `repo`.

### Pipeline não inicia após push
**Solução**: Vá no console do CodePipeline e clique em "Release change".

### Pods não iniciam no EKS
**Solução**: 
```powershell
kubectl describe pod [nome-do-pod]
kubectl logs [nome-do-pod]
```

### LoadBalancer sem EXTERNAL-IP
**Solução**: Aguarde 2-5 minutos. O AWS leva tempo para provisionar.

---

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs do CodeBuild
2. Execute o script de validação
3. Consulte o README.md principal
4. Peça ajuda ao professor ou colegas

---

## ✅ Checklist Final de Entrega

- [ ] Terraform scripts funcionando
- [ ] Pipeline executado com sucesso
- [ ] Imagem no ECR
- [ ] Aplicação rodando no EKS
- [ ] Prints/evidências capturadas
- [ ] README.md documentado
- [ ] Repositório GitHub da dupla criado e público
- [ ] Outputs do Terraform salvos

---

## 🎯 Critérios de Avaliação

1. ✅ Pipeline CI/CD funcional
2. ✅ Build automático no push para main
3. ✅ Imagem enviada para ECR
4. ✅ Deploy automático no EKS
5. ✅ Aplicação acessível via LoadBalancer
6. ✅ Todo provisionado com Terraform
7. ✅ Service Role especificada utilizada
8. ✅ Documentação completa

**Boa sorte! 🚀**

