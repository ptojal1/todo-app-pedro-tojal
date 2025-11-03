# Script para usar ferramentas locais (sem instalar)
# Execute: .\usar-ferramentas-locais.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Configurando Ferramentas Locais" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Obter caminho absoluto da pasta bin
$binPath = Join-Path $PSScriptRoot "bin"

# Adicionar ao PATH da sessão atual
$env:Path = "$binPath;$env:Path"

Write-Host "✅ Ferramentas adicionadas ao PATH desta sessão!" -ForegroundColor Green
Write-Host ""
Write-Host "Agora você pode usar:" -ForegroundColor Cyan
Write-Host "  - terraform --version" -ForegroundColor White
Write-Host "  - kubectl version --client" -ForegroundColor White
Write-Host ""

# Testar
Write-Host "Testando..." -ForegroundColor Yellow
Write-Host ""

Write-Host "Terraform:" -ForegroundColor Cyan
terraform --version

Write-Host ""
Write-Host "kubectl:" -ForegroundColor Cyan
kubectl version --client

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "⚠️  IMPORTANTE:" -ForegroundColor Yellow
Write-Host "Estas ferramentas estão disponíveis APENAS nesta sessão!" -ForegroundColor Yellow
Write-Host "Quando fechar o PowerShell, precisará executar este script novamente." -ForegroundColor Yellow
Write-Host ""
Write-Host "Para instalação permanente (requer Admin):" -ForegroundColor Cyan
Write-Host "  .\scripts\install-tools.ps1" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

