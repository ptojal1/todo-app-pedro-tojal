# Script de Instalação de Ferramentas - Windows
# Execute como Administrador

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Instalador de Ferramentas - AWS + K8s" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se está rodando como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "❌ ERRO: Este script precisa ser executado como Administrador!" -ForegroundColor Red
    Write-Host "   Clique com botão direito no PowerShell e selecione 'Executar como Administrador'" -ForegroundColor Yellow
    exit 1
}

# Função para verificar se um comando existe
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# 1. Instalar Chocolatey (se não estiver instalado)
Write-Host "📦 Verificando Chocolatey..." -ForegroundColor Yellow
if (-not (Test-CommandExists choco)) {
    Write-Host "   Instalando Chocolatey..." -ForegroundColor Green
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    
    # Atualizar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    Write-Host "   ✅ Chocolatey já instalado" -ForegroundColor Green
}

Write-Host ""

# 2. Instalar Git
Write-Host "📦 Verificando Git..." -ForegroundColor Yellow
if (-not (Test-CommandExists git)) {
    Write-Host "   Instalando Git..." -ForegroundColor Green
    choco install git -y
} else {
    Write-Host "   ✅ Git já instalado" -ForegroundColor Green
}

Write-Host ""

# 3. Instalar Terraform
Write-Host "📦 Verificando Terraform..." -ForegroundColor Yellow
if (-not (Test-CommandExists terraform)) {
    Write-Host "   Instalando Terraform..." -ForegroundColor Green
    choco install terraform -y
} else {
    Write-Host "   ✅ Terraform já instalado" -ForegroundColor Green
}

Write-Host ""

# 4. Instalar AWS CLI
Write-Host "📦 Verificando AWS CLI..." -ForegroundColor Yellow
if (-not (Test-CommandExists aws)) {
    Write-Host "   Instalando AWS CLI..." -ForegroundColor Green
    choco install awscli -y
} else {
    Write-Host "   ✅ AWS CLI já instalado" -ForegroundColor Green
}

Write-Host ""

# 5. Instalar kubectl
Write-Host "📦 Verificando kubectl..." -ForegroundColor Yellow
if (-not (Test-CommandExists kubectl)) {
    Write-Host "   Instalando kubectl..." -ForegroundColor Green
    choco install kubernetes-cli -y
} else {
    Write-Host "   ✅ kubectl já instalado" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Instalação Concluída!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  IMPORTANTE: Feche e abra um NOVO PowerShell para usar as ferramentas!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Para verificar as instalações, execute em um novo PowerShell:" -ForegroundColor Cyan
Write-Host "   terraform --version" -ForegroundColor White
Write-Host "   aws --version" -ForegroundColor White
Write-Host "   kubectl version --client" -ForegroundColor White
Write-Host "   git --version" -ForegroundColor White
Write-Host ""

# Atualizar PATH da sessão atual
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Pressione qualquer tecla para continuar..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

