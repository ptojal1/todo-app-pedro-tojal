# Script Final - Preparar Git com repositório criado
# Execute no diretório do projeto: infra/

Write-Host "========================================" -ForegroundColor Green
Write-Host "  FINALIZANDO SETUP DO GIT" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "✅ Repositório GitHub criado!" -ForegroundColor Green
Write-Host "   Nome: todo-app-pedro-tojal" -ForegroundColor Cyan
Write-Host "   URL: https://github.com/ptojal1/todo-app-pedro-tojal" -ForegroundColor Blue
Write-Host ""

# Verificar se Git está disponível
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git não encontrado!" -ForegroundColor Red
    exit 1
}

Write-Host "Passo 1: Inicializando Git..." -ForegroundColor Yellow

# Remover .git se existir
if (Test-Path ".git") {
    Write-Host "  Removendo .git anterior..." -ForegroundColor Yellow
    Remove-Item -Path ".git" -Recurse -Force
}

# Inicializar
git init
Write-Host "✅ Git inicializado!" -ForegroundColor Green
Write-Host ""

# Adicionar arquivos
Write-Host "Passo 2: Adicionando arquivos..." -ForegroundColor Yellow
git add .
Write-Host "✅ Arquivos adicionados!" -ForegroundColor Green
Write-Host ""

# Commit
Write-Host "Passo 3: Fazendo commit..." -ForegroundColor Yellow
git commit -m "Initial commit - Pipeline CI/CD Todo App - Pedro Tojal"
Write-Host "✅ Commit realizado!" -ForegroundColor Green
Write-Host ""

# Renomear branch
Write-Host "Passo 4: Renomeando branch para main..." -ForegroundColor Yellow
git branch -M main
Write-Host "✅ Branch main configurada!" -ForegroundColor Green
Write-Host ""

# Adicionar remote
Write-Host "Passo 5: Configurando remote..." -ForegroundColor Yellow
git remote add origin https://github.com/ptojal1/todo-app-pedro-tojal.git
Write-Host "✅ Remote configurado!" -ForegroundColor Green
Write-Host ""

# Mostrar status
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "STATUS DO REPOSITÓRIO:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
git log --oneline -1
Write-Host ""
git remote -v
Write-Host ""

Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ GIT CONFIGURADO COM SUCESSO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "⚠️  IMPORTANTE: NÃO FAÇA GIT PUSH AINDA!" -ForegroundColor Yellow
Write-Host ""
Write-Host "PRÓXIMOS PASSOS:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. ⏸️  Aguardar credenciais AWS da turma" -ForegroundColor White
Write-Host "2. ⏸️  Executar: aws configure" -ForegroundColor White
Write-Host "3. ⏸️  Executar: cd terraform && terraform apply" -ForegroundColor White
Write-Host "4. ✅ Depois: git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  O push só deve ser feito APÓS terraform apply!" -ForegroundColor Yellow
Write-Host "   Senão o pipeline vai falhar (infraestrutura não existe ainda)" -ForegroundColor Yellow
Write-Host ""

