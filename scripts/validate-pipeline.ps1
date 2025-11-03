# Script para validar a execução do pipeline

param(
    [string]$PipelineName = "todo-app-pipeline",
    [string]$Region = "eu-central-1"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Validação do Pipeline CI/CD" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar credenciais AWS
Write-Host "1. Verificando credenciais AWS..." -ForegroundColor Yellow
try {
    $identity = aws sts get-caller-identity | ConvertFrom-Json
    Write-Host "   ✅ Conectado como: $($identity.Arn)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Erro ao verificar credenciais!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Verificar pipeline
Write-Host "2. Verificando pipeline '$PipelineName'..." -ForegroundColor Yellow
try {
    $pipeline = aws codepipeline get-pipeline --name $PipelineName --region $Region 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Pipeline encontrado!" -ForegroundColor Green
    } else {
        Write-Host "   ❌ Pipeline não encontrado!" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "   ❌ Erro ao buscar pipeline: $_" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Verificar última execução
Write-Host "3. Verificando última execução do pipeline..." -ForegroundColor Yellow
try {
    $executions = aws codepipeline list-pipeline-executions --pipeline-name $PipelineName --region $Region | ConvertFrom-Json
    
    if ($executions.pipelineExecutionSummaries.Count -gt 0) {
        $lastExecution = $executions.pipelineExecutionSummaries[0]
        $status = $lastExecution.status
        $executionId = $lastExecution.pipelineExecutionId
        
        Write-Host "   Status: $status" -ForegroundColor $(if ($status -eq "Succeeded") { "Green" } else { "Yellow" })
        Write-Host "   Execution ID: $executionId" -ForegroundColor White
        
        # Detalhes dos stages
        $pipelineState = aws codepipeline get-pipeline-state --name $PipelineName --region $Region | ConvertFrom-Json
        
        Write-Host ""
        Write-Host "   Stages:" -ForegroundColor Cyan
        foreach ($stage in $pipelineState.stageStates) {
            $stageName = $stage.stageName
            $stageStatus = $stage.latestExecution.status
            $statusColor = switch ($stageStatus) {
                "Succeeded" { "Green" }
                "InProgress" { "Yellow" }
                "Failed" { "Red" }
                default { "White" }
            }
            Write-Host "   - $stageName : $stageStatus" -ForegroundColor $statusColor
        }
    } else {
        Write-Host "   ⚠️  Nenhuma execução encontrada" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ❌ Erro ao verificar execuções: $_" -ForegroundColor Red
}
Write-Host ""

# Verificar repositório ECR
Write-Host "4. Verificando imagens no ECR..." -ForegroundColor Yellow
try {
    $images = aws ecr describe-images --repository-name todo-list-app --region $Region 2>&1 | ConvertFrom-Json
    
    if ($images.imageDetails.Count -gt 0) {
        Write-Host "   ✅ $($images.imageDetails.Count) imagem(ns) encontrada(s)" -ForegroundColor Green
        
        $latestImage = $images.imageDetails | Sort-Object -Property imagePushedAt -Descending | Select-Object -First 1
        Write-Host "   Última imagem:" -ForegroundColor Cyan
        Write-Host "   - Tags: $($latestImage.imageTags -join ', ')" -ForegroundColor White
        Write-Host "   - Pushed: $($latestImage.imagePushedAt)" -ForegroundColor White
    } else {
        Write-Host "   ⚠️  Nenhuma imagem encontrada" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ⚠️  Repositório ECR não encontrado ou sem imagens" -ForegroundColor Yellow
}
Write-Host ""

# Verificar deployment no EKS
Write-Host "5. Verificando deployment no EKS..." -ForegroundColor Yellow
try {
    # Configurar kubeconfig
    aws eks update-kubeconfig --name eksDeepDiveFrankfurt --region $Region 2>&1 | Out-Null
    
    # Verificar deployment
    $deployment = kubectl get deployment todo-app -o json 2>&1 | ConvertFrom-Json
    
    if ($deployment) {
        $replicas = $deployment.status.replicas
        $readyReplicas = $deployment.status.readyReplicas
        
        Write-Host "   ✅ Deployment encontrado!" -ForegroundColor Green
        Write-Host "   - Replicas: $readyReplicas/$replicas ready" -ForegroundColor White
        
        # Verificar pods
        Write-Host ""
        Write-Host "   Pods:" -ForegroundColor Cyan
        kubectl get pods -l app=todo-app
        
        # Verificar service
        Write-Host ""
        Write-Host "   Service:" -ForegroundColor Cyan
        kubectl get service todo-app-service
        
        # Obter URL do LoadBalancer
        $service = kubectl get service todo-app-service -o json | ConvertFrom-Json
        $loadBalancer = $service.status.loadBalancer.ingress[0].hostname
        
        if ($loadBalancer) {
            Write-Host ""
            Write-Host "   🌐 URL da aplicação: http://$loadBalancer" -ForegroundColor Green
        }
    }
} catch {
    Write-Host "   ⚠️  Não foi possível verificar o deployment no EKS" -ForegroundColor Yellow
    Write-Host "   Erro: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Validação concluída!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# URLs úteis
Write-Host "🔗 Links úteis:" -ForegroundColor Cyan
Write-Host "   Pipeline: https://$Region.console.aws.amazon.com/codesuite/codepipeline/pipelines/$PipelineName/view?region=$Region" -ForegroundColor White
Write-Host "   ECR: https://$Region.console.aws.amazon.com/ecr/repositories?region=$Region" -ForegroundColor White
Write-Host "   EKS: https://$Region.console.aws.amazon.com/eks/home?region=$Region" -ForegroundColor White
Write-Host ""

