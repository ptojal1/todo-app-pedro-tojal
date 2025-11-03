# 🚀 Início Rápido - 5 Minutos

Para quem quer começar rápido!

## Opção A: Script Automatizado (Recomendado)

### Passo 1: Execute o instalador
Abra PowerShell como **Administrador**:
```powershell
cd "C:\Users\ptoja\OneDrive\Área de Trabalho\infra"
Set-ExecutionPolicy Bypass -Scope Process -Force
.\scripts\install-tools.ps1
```

### Passo 2: Feche e abra um NOVO PowerShell normal

### Passo 3: Execute o Quick Start
```powershell
cd "C:\Users\ptoja\OneDrive\Área de Trabalho\infra"
.\scripts\quick-start.ps1
```

O script vai guiá-lo por todo o processo interativamente!

---

## Opção B: Manual (Passo a Passo)

### 1. Instalar Ferramentas (PowerShell como Admin)
```powershell
.\scripts\install-tools.ps1
```
Feche e abra novo PowerShell.

### 2. Configurar AWS
```powershell
aws configure
```
- Region: `eu-central-1`
- Output: `json`

### 3. Clonar e Preparar Repositório
```powershell
git clone https://github.com/dockersamples/todo-list-app
.\scripts\prepare-repo.ps1
```

### 4. Criar no GitHub
1. Crie repositório público: https://github.com/new
2. Crie token: https://github.com/settings/tokens (scope: `repo`)

### 5. Configurar Terraform
Edite `terraform/terraform.tfvars`:
```hcl
github_owner = "SEU_USUARIO"
github_repo  = "SEU_REPOSITORIO"
github_token = "SEU_TOKEN"
```

### 6. Provisionar
```powershell
cd terraform
terraform init
terraform apply
cd ..
```

### 7. Push para GitHub
```powershell
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git
git push -u origin main
```

### 8. Validar
```powershell
.\scripts\validate-pipeline.ps1
```

---

## ✅ Pronto!

🎯 **O que aconteceu:**
- ✅ ECR repository criado
- ✅ CodeBuild projects criados
- ✅ CodePipeline criado
- ✅ Pipeline executando automaticamente
- ✅ Imagem sendo construída e enviada para ECR
- ✅ Deploy sendo feito no EKS

🔗 **Acesse:**
- Pipeline: Console AWS → CodePipeline
- Aplicação: `kubectl get service todo-app-service` (EXTERNAL-IP)

📚 **Documentação Completa:**
- `README.md` - Visão geral
- `INSTRUCOES_PASSO_A_PASSO.md` - Guia detalhado
- `ENTREGAVEIS.md` - O que entregar

---

## ⏱️ Tempo Estimado

- Instalação de ferramentas: 5-10 min
- Configuração: 5 min
- Terraform apply: 2-5 min
- Pipeline execution: 5-10 min
- **TOTAL**: ~20-30 minutos

---

## 🆘 Problemas?

1. Consulte `INSTRUCOES_PASSO_A_PASSO.md` seção Troubleshooting
2. Execute: `.\scripts\validate-pipeline.ps1`
3. Verifique logs no Console AWS

**Boa sorte! 🚀**

