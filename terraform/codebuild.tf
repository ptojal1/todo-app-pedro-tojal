# CodeBuild Project - Build da Imagem Docker
resource "aws_codebuild_project" "build" {
  name          = "${var.project_name}-build"
  description   = "Build Docker image and push to ECR"
  service_role  = var.codebuild_service_role_arn
  build_timeout = 30

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.ecr_repository_name
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }

    environment_variable {
      name  = "ECR_REPOSITORY_URI"
      value = aws_ecr_repository.app.repository_url
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec/buildspec-build.yml"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  tags = {
    Name = "${var.project_name}-build"
  }
}

# CodeBuild Project - Deploy no EKS
resource "aws_codebuild_project" "deploy" {
  name          = "${var.project_name}-deploy"
  description   = "Deploy application to EKS cluster"
  service_role  = var.codebuild_service_role_arn
  build_timeout = 30

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_region
    }

    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = var.eks_cluster_name
    }

    environment_variable {
      name  = "ECR_REPOSITORY_URI"
      value = aws_ecr_repository.app.repository_url
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec/buildspec-deploy.yml"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  tags = {
    Name = "${var.project_name}-deploy"
  }
}

# Outputs dos projetos CodeBuild
output "codebuild_build_project_name" {
  description = "Nome do projeto CodeBuild de build"
  value       = aws_codebuild_project.build.name
}

output "codebuild_deploy_project_name" {
  description = "Nome do projeto CodeBuild de deploy"
  value       = aws_codebuild_project.deploy.name
}

