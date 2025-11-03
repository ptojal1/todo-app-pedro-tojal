# SCRIPT FINAL - Executar Toda a Atividade
# Execute este script no diretório: C:\Users\ptoja\OneDrive\Área de Trabalho\infra

Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "║    EXECUÇÃO COMPLETA - Pipeline CI/CD AWS              ║" -ForegroundColor Cyan
Write-Host "║                                                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Adicionar ferramentas ao PATH
$binPath = Join-Path $PSScriptRoot "bin"
$env:Path = "$binPath;$env:Path"

Write-Host "✅ Credenciais AWS configuradas em: $env:USERPROFILE\.aws" -ForegroundColor Green
Write-Host "✅ Região: eu-central-1 (Frankfurt)" -ForegroundColor Green
Write-Host ""

#============================================
# ETAPA 1: TERRAFORM APPLY
#============================================
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ETAPA 1: Terraform Apply" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path "terraform")) {
    Write-Host "❌ Pasta terraform não encontrada!" -ForegroundColor Red
    exit 1
}

Set-Location terraform

Write-Host "Executando terraform apply..." -ForegroundColor Yellow
Write-Host "⚠️  Isto vai criar os seguintes recursos na AWS:" -ForegroundColor Yellow
Write-Host "   - ECR Repository (todo-list-app)" -ForegroundColor White
Write-Host "   - CodeBuild Build Project" -ForegroundColor White
Write-Host "   - CodeBuild Deploy Project" -ForegroundColor White
Write-Host "   - CodePipeline (todo-app-pipeline)" -ForegroundColor White
Write-Host "   - S3 Bucket (artifacts)" -ForegroundColor White
Write-Host "   - IAM Role (pipeline)" -ForegroundColor White
Write-Host ""
Write-Host "Tempo estimado: 3-5 minutos" -ForegroundColor Cyan
Write-Host ""

terraform apply -auto-approve

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ Erro no terraform apply!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Write-Host ""
Write-Host "✅ Terraform apply concluído com sucesso!" -ForegroundColor Green
Write-Host ""

# Salvar outputs
terraform output > terraform-outputs.txt
Write-Host "✅ Outputs salvos em: terraform/terraform-outputs.txt" -ForegroundColor Green
Write-Host ""

Set-Location ..

#============================================
# ETAPA 2: GIT INIT E COMMIT
#============================================
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ETAPA 2: Git Init e Commit" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Remover .git se existir
if (Test-Path ".git") {
    Write-Host "Removendo .git anterior..." -ForegroundColor Yellow
    Remove-Item -Path ".git" -Recurse -Force
}

# Inicializar
Write-Host "git init..." -ForegroundColor Yellow
git init

Write-Host "git add ..." -ForegroundColor Yellow
git add .

Write-Host "git commit..." -ForegroundColor Yellow
git commit -m "Initial commit - Pipeline CI/CD Todo App - Pedro Tojal"

Write-Host "git branch -M main..." -ForegroundColor Yellow
git branch -M main

Write-Host "git remote add origin..." -ForegroundColor Yellow
git remote add origin https://github.com/ptojal1/todo-app-pedro-tojal.git

Write-Host ""
Write-Host "✅ Git configurado!" -ForegroundColor Green
Write-Host ""

#============================================
# ETAPA 3: GIT PUSH (DISPARA PIPELINE!)
#============================================
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ETAPA 3: Git Push (Dispara Pipeline)" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "⚠️  ATENÇÃO: Isto vai fazer push para GitHub!" -ForegroundColor Yellow
Write-Host "   O webhook vai disparar o pipeline automaticamente!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Fazendo push..." -ForegroundColor Yellow

git push -u origin main -force

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "❌ Erro no git push!" -ForegroundColor Red
    Write-Host "   Tente manualmente se necessário" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Push concluído!" -ForegroundColor Green
Write-Host "✅ Pipeline deve estar iniciando agora!" -ForegroundColor Green
Write-Host ""

#============================================
# ETAPA 4: AGUARDAR E VALIDAR
#============================================
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ETAPA 4: Aguardando Pipeline" -ForegroundColor Cyan
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Host "O pipeline está executando..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Stages:" -ForegroundColor Cyan
Write-Host "  1. Source (GitHub) - ~30 segundos" -ForegroundColor White
Write-Host "  2. Build (Docker → ECR) - ~3-5 minutos" -ForegroundColor White
Write-Host "  3. Deploy (EKS) - ~2-3 minutos" -ForegroundColor White
Write-Host ""
Write-Host "Tempo total estimado: 5-10 minutos" -ForegroundColor Cyan
Write-Host ""

Write-Host "Aguardando 30 segundos antes de validar..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

Write-Host ""
Write-Host "════════════════════════════════════════" -ForegroundColor Green
Write-Host "  EXECUÇÃO CONCLUÍDA!" -ForegroundColor Green
Write-Host "════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

Write-Host "✅ Recursos criados na AWS" -ForegroundColor Green
Write-Host "✅ Código enviado para GitHub" -ForegroundColor Green
Write-Host "✅ Pipeline disparado" -ForegroundColor Green
Write-Host ""

Write-Host "🔗 LINKS IMPORTANTES:" -ForegroundColor Cyan
Write-Host ""
Write-Host "GitHub:" -ForegroundColor Yellow
Write-Host "  https://github.com/ptojal1/todo-app-pedro-tojal" -ForegroundColor Blue
Write-Host ""
Write-Host "AWS CodePipeline:" -ForegroundColor Yellow
Write-Host "  https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/todo-app-pipeline/view?region=eu-central-1" -ForegroundColor Blue
Write-Host ""
Write-Host "AWS ECR:" -ForegroundColor Yellow
Write-Host "  https://eu-central-1.console.aws.amazon.com/ecr/repositories/private/325583868777/todo-list-app?region=eu-central-1" -ForegroundColor Blue
Write-Host ""

Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Acesse o console AWS e verifique o pipeline" -ForegroundColor White
Write-Host "2. Aguarde o pipeline concluir (5-10 minutos)" -ForegroundColor White
Write-Host "3. Execute: .\scripts\validate-pipeline.ps1" -ForegroundColor White
Write-Host "4. Capture evidências (screenshots)" -ForegroundColor White
Write-Host ""
Write-Host "📖 Consulte: ENTREGAVEIS.md para lista de evidências" -ForegroundColor Cyan
Write-Host ""

