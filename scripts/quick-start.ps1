# Quick Start - Execução Rápida de Todo o Processo

Write-Host @"
========================================
    QUICK START - Pipeline CI/CD
    Todo List App - AWS EKS
========================================
"@ -ForegroundColor Cyan

Write-Host ""
Write-Host "Este script vai guiar você por todo o processo!" -ForegroundColor Yellow
Write-Host ""

# Função para pausar e aguardar confirmação
function Wait-ForUser {
    param($message = "Pressione qualquer tecla para continuar...")
    Write-Host ""
    Write-Host $message -ForegroundColor Green
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Write-Host ""
}

# Passo 1: Verificar ferramentas
Write-Host "=== PASSO 1: Verificando Ferramentas ===" -ForegroundColor Cyan
Write-Host ""

$tools = @("terraform", "aws", "kubectl", "git")
$allInstalled = $true

foreach ($tool in $tools) {
    if (Get-Command $tool -ErrorAction SilentlyContinue) {
        Write-Host "  ✅ $tool instalado" -ForegroundColor Green
    } else {
        Write-Host "  ❌ $tool NÃO instalado" -ForegroundColor Red
        $allInstalled = $false
    }
}

if (-not $allInstalled) {
    Write-Host ""
    Write-Host "⚠️  Algumas ferramentas não estão instaladas!" -ForegroundColor Yellow
    Write-Host "Deseja instalar agora? (S/N)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "S" -or $response -eq "s") {
        Write-Host "Executando instalador..." -ForegroundColor Yellow
        & .\scripts\install-tools.ps1
        
        Write-Host ""
        Write-Host "⚠️  IMPORTANTE: Feche este PowerShell e abra um novo!" -ForegroundColor Red
        Write-Host "Depois execute novamente: .\scripts\quick-start.ps1" -ForegroundColor Yellow
        exit
    } else {
        Write-Host "Por favor, instale as ferramentas antes de continuar." -ForegroundColor Red
        exit 1
    }
}

Wait-ForUser

# Passo 2: Verificar credenciais AWS
Write-Host "=== PASSO 2: Verificando Credenciais AWS ===" -ForegroundColor Cyan
Write-Host ""

try {
    $identity = aws sts get-caller-identity 2>&1 | ConvertFrom-Json
    Write-Host "  ✅ Conectado como: $($identity.Arn)" -ForegroundColor Green
    Write-Host "  ✅ Account ID: $($identity.Account)" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Credenciais AWS não configuradas!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Deseja configurar agora? (S/N)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "S" -or $response -eq "s") {
        & .\scripts\setup-credentials.ps1
    } else {
        Write-Host "Configure as credenciais antes de continuar." -ForegroundColor Red
        exit 1
    }
}

Wait-ForUser

# Passo 3: Clonar repositório
Write-Host "=== PASSO 3: Preparando Repositório ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path "todo-list-app")) {
    Write-Host "Clonando repositório todo-list-app..." -ForegroundColor Yellow
    git clone https://github.com/dockersamples/todo-list-app
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Repositório clonado!" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Erro ao clonar repositório!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "  ✅ Repositório já existe!" -ForegroundColor Green
}

if (-not (Test-Path "app")) {
    Write-Host "Copiando arquivos..." -ForegroundColor Yellow
    & .\scripts\prepare-repo.ps1
}

Write-Host "  ✅ Repositório preparado!" -ForegroundColor Green

Wait-ForUser

# Passo 4: Configurar GitHub
Write-Host "=== PASSO 4: Configuração do GitHub ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Antes de continuar, você precisa:" -ForegroundColor Yellow
Write-Host "  1. Criar um repositório público no GitHub" -ForegroundColor White
Write-Host "  2. Criar um Personal Access Token" -ForegroundColor White
Write-Host "  3. Anotar essas informações" -ForegroundColor White
Write-Host ""
Write-Host "Já fez isso? (S/N)" -ForegroundColor Yellow
$response = Read-Host

if ($response -ne "S" -and $response -ne "s") {
    Write-Host ""
    Write-Host "Por favor, siga estas instruções:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Criar repositório:" -ForegroundColor White
    Write-Host "   https://github.com/new" -ForegroundColor Blue
    Write-Host "   - Nome: todo-list-app-pipeline (ou similar)" -ForegroundColor White
    Write-Host "   - Visibilidade: Public" -ForegroundColor White
    Write-Host "   - NÃO inicialize com README" -ForegroundColor White
    Write-Host ""
    Write-Host "2. Criar token:" -ForegroundColor White
    Write-Host "   https://github.com/settings/tokens" -ForegroundColor Blue
    Write-Host "   - Generate new token (classic)" -ForegroundColor White
    Write-Host "   - Selecione scope: repo" -ForegroundColor White
    Write-Host "   - Copie o token!" -ForegroundColor White
    Write-Host ""
    
    Wait-ForUser "Pressione qualquer tecla quando estiver pronto..."
}

# Passo 5: Configurar terraform.tfvars
Write-Host "=== PASSO 5: Configurando Terraform ===" -ForegroundColor Cyan
Write-Host ""

$tfvarsPath = "terraform\terraform.tfvars"

Write-Host "Agora vamos configurar o arquivo terraform.tfvars" -ForegroundColor Yellow
Write-Host ""

Write-Host "Digite seu usuário do GitHub:" -ForegroundColor Cyan
$githubOwner = Read-Host

Write-Host "Digite o nome do seu repositório:" -ForegroundColor Cyan
$githubRepo = Read-Host

Write-Host "Digite o token do GitHub:" -ForegroundColor Cyan
$githubToken = Read-Host

# Atualizar terraform.tfvars
$tfvarsContent = Get-Content $tfvarsPath -Raw
$tfvarsContent = $tfvarsContent -replace 'github_owner\s*=\s*"[^"]*"', "github_owner  = `"$githubOwner`""
$tfvarsContent = $tfvarsContent -replace 'github_repo\s*=\s*"[^"]*"', "github_repo   = `"$githubRepo`""
$tfvarsContent = $tfvarsContent -replace 'github_token\s*=\s*"[^"]*"', "github_token  = `"$githubToken`""

Set-Content -Path $tfvarsPath -Value $tfvarsContent

Write-Host "  ✅ terraform.tfvars configurado!" -ForegroundColor Green

Wait-ForUser

# Passo 6: Terraform
Write-Host "=== PASSO 6: Provisionando Infraestrutura ===" -ForegroundColor Cyan
Write-Host ""

Set-Location terraform

Write-Host "Inicializando Terraform..." -ForegroundColor Yellow
terraform init

if ($LASTEXITCODE -ne 0) {
    Write-Host "  ❌ Erro ao inicializar Terraform!" -ForegroundColor Red
    exit 1
}

Write-Host "  ✅ Terraform inicializado!" -ForegroundColor Green
Write-Host ""

Wait-ForUser "Pressione qualquer tecla para ver o plano..."

Write-Host "Gerando plano..." -ForegroundColor Yellow
terraform plan

Wait-ForUser "Pressione qualquer tecla para aplicar (criar recursos)..."

Write-Host "Aplicando configuração..." -ForegroundColor Yellow
Write-Host "⚠️  Isso vai criar recursos na AWS!" -ForegroundColor Yellow
Write-Host ""

terraform apply -auto-approve

if ($LASTEXITCODE -ne 0) {
    Write-Host "  ❌ Erro ao aplicar Terraform!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Write-Host ""
Write-Host "  ✅ Infraestrutura criada com sucesso!" -ForegroundColor Green

Set-Location ..

Wait-ForUser

# Passo 7: Git Push
Write-Host "=== PASSO 7: Enviando para GitHub ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path ".git")) {
    Write-Host "Inicializando Git..." -ForegroundColor Yellow
    git init
    git add .
    git commit -m "Initial commit - Pipeline CI/CD Todo App"
    git branch -M main
    git remote add origin "https://github.com/$githubOwner/$githubRepo.git"
}

Write-Host "Fazendo push para GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✅ Código enviado para GitHub!" -ForegroundColor Green
    Write-Host "  ✅ Pipeline deve iniciar automaticamente!" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Erro ao fazer push!" -ForegroundColor Yellow
    Write-Host "  Você pode precisar fazer manualmente." -ForegroundColor Yellow
}

Wait-ForUser

# Passo 8: Validação
Write-Host "=== PASSO 8: Validando Pipeline ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "Aguardando pipeline iniciar (30 segundos)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

& .\scripts\validate-pipeline.ps1

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "      ✅ PROCESSO CONCLUÍDO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "🔗 Próximos passos:" -ForegroundColor Cyan
Write-Host "  1. Acesse o console AWS para ver o pipeline rodando" -ForegroundColor White
Write-Host "  2. Aguarde o pipeline concluir (5-10 minutos)" -ForegroundColor White
Write-Host "  3. Acesse a aplicação via LoadBalancer" -ForegroundColor White
Write-Host "  4. Capture evidências para entrega" -ForegroundColor White
Write-Host ""

Write-Host "📚 Consulte:" -ForegroundColor Cyan
Write-Host "  - README.md - Documentação completa" -ForegroundColor White
Write-Host "  - INSTRUCOES_PASSO_A_PASSO.md - Guia detalhado" -ForegroundColor White
Write-Host "  - ENTREGAVEIS.md - Lista de entregáveis" -ForegroundColor White
Write-Host ""

