# Configurações do Projeto
aws_region          = "eu-central-1"
project_name        = "ptm-todo-app-pipeline"
ecr_repository_name = "ptm-todo-list-app"

# Configurações do GitHub
# Configurado para: Pedro Tojal
github_owner  = "ptojal1"
github_repo   = "todo-app-pedro-tojal"
github_branch = "main"
github_token  = "" # Token será fornecido via variável de ambiente ou Terraform Cloud
# Para usar: export TF_VAR_github_token="seu_token_aqui"

# Configurações do EKS
eks_cluster_name = "eksDeepDiveFrankfurt"

# Service Role (NÃO ALTERAR - fornecida pela atividade)
codebuild_service_role_arn = "arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role"

# Account ID (NÃO ALTERAR)
aws_account_id = "325583868777"

