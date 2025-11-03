# Script para configurar credenciais AWS

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Configuração de Credenciais AWS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Este script irá configurar suas credenciais AWS." -ForegroundColor Yellow
Write-Host ""
Write-Host "Você precisará fornecer:" -ForegroundColor White
Write-Host "  1. AWS Access Key ID" -ForegroundColor White
Write-Host "  2. AWS Secret Access Key" -ForegroundColor White
Write-Host "  3. Região padrão (eu-central-1 para Frankfurt)" -ForegroundColor White
Write-Host ""

# Verificar se AWS CLI está instalado
if (-not (Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "❌ AWS CLI não encontrado!" -ForegroundColor Red
    Write-Host "   Execute primeiro: .\scripts\install-tools.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host "Digite suas credenciais AWS:" -ForegroundColor Cyan
Write-Host ""

# Solicitar Access Key
$accessKey = Read-Host "AWS Access Key ID"

# Solicitar Secret Key
$secretKey = Read-Host "AWS Secret Access Key"

# Região padrão
$region = Read-Host "AWS Region [eu-central-1]"
if ([string]::IsNullOrWhiteSpace($region)) {
    $region = "eu-central-1"
}

# Output format
$outputFormat = Read-Host "Output format [json]"
if ([string]::IsNullOrWhiteSpace($outputFormat)) {
    $outputFormat = "json"
}

Write-Host ""
Write-Host "Configurando AWS CLI..." -ForegroundColor Yellow

# Criar diretório .aws se não existir
$awsDir = "$env:USERPROFILE\.aws"
if (-not (Test-Path $awsDir)) {
    New-Item -ItemType Directory -Path $awsDir | Out-Null
}

# Criar arquivo credentials
$credentialsFile = "$awsDir\credentials"
$credentialsContent = @"
[default]
aws_access_key_id = $accessKey
aws_secret_access_key = $secretKey
"@

Set-Content -Path $credentialsFile -Value $credentialsContent

# Criar arquivo config
$configFile = "$awsDir\config"
$configContent = @"
[default]
region = $region
output = $outputFormat
"@

Set-Content -Path $configFile -Value $configContent

Write-Host ""
Write-Host "✅ Credenciais configuradas com sucesso!" -ForegroundColor Green
Write-Host ""

# Testar credenciais
Write-Host "Testando credenciais..." -ForegroundColor Yellow
try {
    $identity = aws sts get-caller-identity 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Credenciais válidas!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Informações da conta:" -ForegroundColor Cyan
        $identity | ConvertFrom-Json | Format-List
    } else {
        Write-Host "❌ Erro ao validar credenciais!" -ForegroundColor Red
        Write-Host $identity -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Erro ao testar credenciais: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Próximo passo: Clonar repositório e configurar Terraform" -ForegroundColor Cyan
Write-Host ""

