variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "ptm-todo-app-pipeline"
}

variable "ecr_repository_name" {
  description = "Nome do repositório ECR"
  type        = string
  default     = "ptm-todo-list-app"
}

variable "github_owner" {
  description = "Owner do repositório GitHub"
  type        = string
}

variable "github_repo" {
  description = "Nome do repositório GitHub"
  type        = string
}

variable "github_branch" {
  description = "Branch do GitHub"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "Token de acesso pessoal do GitHub"
  type        = string
  sensitive   = true
}

variable "eks_cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "eksDeepDiveFrankfurt"
}

variable "codebuild_service_role_arn" {
  description = "ARN da Service Role do CodeBuild (fornecida pela atividade)"
  type        = string
  default     = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"
}

variable "aws_account_id" {
  description = "ID da conta AWS"
  type        = string
  default     = "325583868777"
}

variable "tags" {
  description = "Tags para recursos AWS"
  type        = map(string)
  default = {
    Project     = "todo-app-pipeline"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

