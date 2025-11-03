# Script para preparar o repositório da aplicação

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Preparando Repositório Todo List App" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se o diretório todo-list-app existe
if (-not (Test-Path "todo-list-app")) {
    Write-Host "❌ Diretório todo-list-app não encontrado!" -ForegroundColor Red
    Write-Host "   Execute primeiro: git clone https://github.com/dockersamples/todo-list-app" -ForegroundColor Yellow
    exit 1
}

# Criar diretório app se não existir
if (-not (Test-Path "app")) {
    New-Item -ItemType Directory -Path "app" | Out-Null
}

# Copiar arquivos da aplicação
Write-Host "📦 Copiando arquivos da aplicação..." -ForegroundColor Yellow
Copy-Item -Path "todo-list-app\*" -Destination "app\" -Recurse -Force

Write-Host "✅ Arquivos copiados com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Próximo passo: Criar repositório no GitHub e configurar terraform.tfvars" -ForegroundColor Cyan
Write-Host ""

