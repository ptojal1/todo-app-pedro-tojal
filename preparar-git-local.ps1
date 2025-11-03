# Script para preparar Git localmente
# Execute no diretório do projeto (infra/)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Preparando Git Local" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se git está disponível
try {
    git --version | Out-Null
    Write-Host "✅ Git disponível!" -ForegroundColor Green
} catch {
    Write-Host "❌ Git não encontrado!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Inicializar repositório Git
if (Test-Path ".git") {
    Write-Host "⚠️  Repositório Git já existe" -ForegroundColor Yellow
    Write-Host "   Removendo .git antigo..." -ForegroundColor Yellow
    Remove-Item -Path ".git" -Recurse -Force
}

Write-Host "Inicializando repositório Git..." -ForegroundColor Yellow
git init
Write-Host "✅ Git inicializado!" -ForegroundColor Green

Write-Host ""

# Adicionar todos os arquivos
Write-Host "Adicionando arquivos ao staging..." -ForegroundColor Yellow
git add .

Write-Host "✅ Arquivos adicionados!" -ForegroundColor Green
Write-Host ""

# Fazer commit
Write-Host "Fazendo commit..." -ForegroundColor Yellow
git commit -m "Initial commit - Pipeline CI/CD Todo App - Pedro Tojal"

Write-Host ""
Write-Host "✅ Commit realizado!" -ForegroundColor Green

Write-Host ""

# Renomear branch para main
Write-Host "Renomeando branch para 'main'..." -ForegroundColor Yellow
git branch -M main

Write-Host "✅ Branch renomeada para 'main'!" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Git Preparado!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Mostrar status
Write-Host "Status do repositório:" -ForegroundColor Cyan
git log --oneline -1
git status

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Crie o repositório no GitHub:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Blue
Write-Host "   - Nome: todo-app-pedro-tojal" -ForegroundColor White
Write-Host "   - Visibilidade: Public" -ForegroundColor White
Write-Host "   - NÃO inicialize com README" -ForegroundColor White
Write-Host ""
Write-Host "2. Depois execute:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/ptojal1/todo-app-pedro-tojal.git" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  MAS SÓ FAÇA O PUSH APÓS:" -ForegroundColor Yellow
Write-Host "   - Configurar AWS (aws configure)" -ForegroundColor White
Write-Host "   - Executar terraform apply" -ForegroundColor White
Write-Host ""

