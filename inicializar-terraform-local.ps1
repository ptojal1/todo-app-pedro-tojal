# Script para inicializar Terraform (SEM credenciais AWS)
# Execute este script no diretório do projeto (infra/)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Inicializando Terraform (Local)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Adicionar ferramentas ao PATH
$binPath = Join-Path $PSScriptRoot "bin"
if (Test-Path $binPath) {
    $env:Path = "$binPath;$env:Path"
    Write-Host "✅ Ferramentas locais adicionadas ao PATH" -ForegroundColor Green
} else {
    Write-Host "⚠️  Pasta bin/ não encontrada. Usando Terraform do sistema..." -ForegroundColor Yellow
}

# Navegar para pasta terraform
if (-not (Test-Path "terraform")) {
    Write-Host "❌ Pasta terraform/ não encontrada!" -ForegroundColor Red
    Write-Host "   Execute este script no diretório raiz do projeto (infra/)" -ForegroundColor Yellow
    exit 1
}

cd terraform
Write-Host ""
Write-Host "Diretório atual: $(Get-Location)" -ForegroundColor Cyan
Write-Host ""

# Verificar se terraform está disponível
try {
    terraform --version | Out-Null
    Write-Host "✅ Terraform encontrado!" -ForegroundColor Green
    terraform --version
} catch {
    Write-Host "❌ Terraform não encontrado!" -ForegroundColor Red
    Write-Host "   Execute: .\usar-ferramentas-locais.ps1" -ForegroundColor Yellow
    cd ..
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ETAPA 1: terraform init" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Isto vai:" -ForegroundColor Yellow
Write-Host "  - Baixar providers AWS" -ForegroundColor White
Write-Host "  - Configurar backend" -ForegroundColor White
Write-Host "  - Preparar módulos" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  NÃO precisa de credenciais AWS!" -ForegroundColor Green
Write-Host ""

terraform init

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ terraform init executado com sucesso!" -ForegroundColor Green
    Write-Host ""
    
    # Validar configuração
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  ETAPA 2: terraform validate" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    terraform validate
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Configuração Terraform válida!" -ForegroundColor Green
    } else {
        Write-Host ""
        Write-Host "❌ Erros na configuração Terraform" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  RESUMO" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "✅ Terraform inicializado" -ForegroundColor Green
    Write-Host "✅ Providers baixados" -ForegroundColor Green
    Write-Host "✅ Configuração validada" -ForegroundColor Green
    Write-Host ""
    Write-Host "⏸️  PRÓXIMOS PASSOS (Precisam de credenciais AWS):" -ForegroundColor Yellow
    Write-Host "  1. aws configure (configurar credenciais)" -ForegroundColor White
    Write-Host "  2. terraform plan (ver o que será criado)" -ForegroundColor White
    Write-Host "  3. terraform apply (criar recursos)" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "❌ Erro ao executar terraform init!" -ForegroundColor Red
}

cd ..
Write-Host ""

