# Script para fazer push para GitHub e disparar pipeline
# Pedro Tojal - CI/CD Pipeline

Write-Host "=== CONFIGURANDO GIT E FAZENDO PUSH ===" -ForegroundColor Cyan
Write-Host ""

# Caminho do projeto
$projectPath = "C:\Users\ptoja\OneDrive\Área de Trabalho\infra"
Write-Host "Navegando para: $projectPath" -ForegroundColor Yellow

# Verificar se já é um repositório Git
if (Test-Path "$projectPath\.git") {
    Write-Host "✅ Repositório Git já existe" -ForegroundColor Green
} else {
    Write-Host "📦 Inicializando repositório Git..." -ForegroundColor Yellow
    Set-Location $projectPath
    git init
    git branch -M main
    Write-Host "✅ Git inicializado!" -ForegroundColor Green
}

Set-Location $projectPath

# Configurar Git
Write-Host ""
Write-Host "🔧 Configurando Git..." -ForegroundColor Yellow
git config user.name "Pedro Tojal"
git config user.email "ptojal1@users.noreply.github.com"
Write-Host "✅ Git configurado!" -ForegroundColor Green

# Verificar remote
Write-Host ""
Write-Host "🔗 Verificando remote..." -ForegroundColor Yellow
$remoteExists = git remote | Where-Object { $_ -eq "origin" }

if ($remoteExists) {
    Write-Host "✅ Remote 'origin' já existe" -ForegroundColor Green
    git remote -v
} else {
    Write-Host "📡 Adicionando remote 'origin'..." -ForegroundColor Yellow
    git remote add origin https://github.com/ptojal1/todo-app-pedro-tojal.git
    Write-Host "✅ Remote adicionado!" -ForegroundColor Green
}

# Adicionar todos os arquivos
Write-Host ""
Write-Host "📁 Adicionando arquivos ao Git..." -ForegroundColor Yellow
git add .
Write-Host "✅ Arquivos adicionados!" -ForegroundColor Green

# Ver status
Write-Host ""
Write-Host "📊 Status do Git:" -ForegroundColor Cyan
git status --short | Select-Object -First 20
$totalFiles = (git status --short | Measure-Object).Count
Write-Host "Total de arquivos: $totalFiles" -ForegroundColor Cyan

# Commit
Write-Host ""
Write-Host "💾 Fazendo commit..." -ForegroundColor Yellow
git commit -m "Initial commit - CI/CD Pipeline setup with Terraform

- ECR repository: ptm-todo-list-app
- CodeBuild projects: ptm-todo-app-pipeline-build, ptm-todo-app-pipeline-deploy
- CodePipeline: ptm-todo-app-pipeline
- Kubernetes manifests for deployment
- Complete Terraform infrastructure as code
- Service Role: codebuild-asn-demo-lab-service-role
- Target EKS cluster: eksDeepDiveFrankfurt
"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Commit realizado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "⚠️ Erro no commit (código: $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Push
Write-Host ""
Write-Host "🚀 Fazendo push para GitHub..." -ForegroundColor Yellow
Write-Host "   Repositório: https://github.com/ptojal1/todo-app-pedro-tojal.git" -ForegroundColor Cyan
Write-Host "   Branch: main" -ForegroundColor Cyan
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✅ PUSH REALIZADO COM SUCESSO!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "🔥 PIPELINE DISPARADO AUTOMATICAMENTE!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📊 Monitore o pipeline em:" -ForegroundColor Cyan
    Write-Host "   https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/ptm-todo-app-pipeline/view?region=eu-central-1" -ForegroundColor Blue
    Write-Host ""
    Write-Host "📦 ECR Repository:" -ForegroundColor Cyan
    Write-Host "   https://eu-central-1.console.aws.amazon.com/ecr/repositories/private/325583868777/ptm-todo-list-app?region=eu-central-1" -ForegroundColor Blue
    Write-Host ""
    Write-Host "🎯 Fluxo do Pipeline:" -ForegroundColor Cyan
    Write-Host "   1. Source: Clone do GitHub" -ForegroundColor White
    Write-Host "   2. Build: Construir imagem Docker e push para ECR" -ForegroundColor White
    Write-Host "   3. Deploy: Deploy no cluster eksDeepDiveFrankfurt" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ ERRO NO PUSH!" -ForegroundColor Red
    Write-Host "Código de erro: $LASTEXITCODE" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possíveis causas:" -ForegroundColor Yellow
    Write-Host "1. Token GitHub expirado ou inválido" -ForegroundColor White
    Write-Host "2. Permissões insuficientes no repositório" -ForegroundColor White
    Write-Host "3. Repositório não existe" -ForegroundColor White
    Write-Host ""
    exit $LASTEXITCODE
}

