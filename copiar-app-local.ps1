# Script para copiar arquivos do repositório clonado
# Execute este script no diretório do projeto (infra/)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Copiando Aplicação Todo List" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$sourceRepo = "C:\Users\ptoja\todo-list-app"
$targetApp = ".\app"

if (-not (Test-Path $sourceRepo)) {
    Write-Host "❌ Repositório não encontrado em: $sourceRepo" -ForegroundColor Red
    Write-Host "Execute primeiro: git clone https://github.com/dockersamples/todo-list-app" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Repositório encontrado!" -ForegroundColor Green
Write-Host ""

# Remover pasta app antiga (se existir)
if (Test-Path $targetApp) {
    Write-Host "Removendo pasta app/ antiga..." -ForegroundColor Yellow
    Remove-Item -Path $targetApp -Recurse -Force
}

# Criar nova pasta app
Write-Host "Criando pasta app/..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $targetApp -Force | Out-Null

# Copiar arquivos
Write-Host "Copiando arquivos..." -ForegroundColor Yellow
Copy-Item -Path "$sourceRepo\*" -Destination $targetApp -Recurse -Force

Write-Host ""
Write-Host "✅ Aplicação copiada com sucesso!" -ForegroundColor Green
Write-Host ""

# Verificar arquivos copiados
Write-Host "Arquivos na pasta app/:" -ForegroundColor Cyan
Get-ChildItem $targetApp | Select-Object Name, Length | Format-Table

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Próximo passo: Inicializar Terraform" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

