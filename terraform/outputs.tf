# Outputs consolidados do projeto

output "summary" {
  description = "Resumo dos recursos criados"
  value = {
    ecr_repository_url      = aws_ecr_repository.app.repository_url
    codepipeline_name       = aws_codepipeline.pipeline.name
    codebuild_build_project = aws_codebuild_project.build.name
    codebuild_deploy_project = aws_codebuild_project.deploy.name
    artifacts_bucket        = aws_s3_bucket.artifacts.id
    pipeline_console_url    = "https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.pipeline.name}/view?region=${var.aws_region}"
    ecr_console_url         = "https://${var.aws_region}.console.aws.amazon.com/ecr/repositories/private/${data.aws_caller_identity.current.account_id}/${var.ecr_repository_name}?region=${var.aws_region}"
  }
}

output "next_steps" {
  description = "Próximos passos"
  value = <<-EOT
    
    ✅ Infraestrutura criada com sucesso!
    
    Próximos passos:
    
    1. Acesse o pipeline no console AWS:
       ${aws_codepipeline.pipeline.name}
    
    2. Faça push do código para o GitHub para iniciar o pipeline:
       git add .
       git commit -m "Initial commit"
       git push origin main
    
    3. Monitore o build no CodeBuild
    
    4. Verifique a imagem no ECR:
       ${aws_ecr_repository.app.repository_url}
    
    5. Verifique o deployment no EKS:
       aws eks update-kubeconfig --name ${var.eks_cluster_name} --region ${var.aws_region}
       kubectl get deployments
       kubectl get pods
       kubectl get services
  EOT
}

