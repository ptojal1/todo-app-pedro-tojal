# 📦 Entregáveis da Atividade

## ✅ Lista de Entregáveis

### 1. Scripts Terraform ✅

Todos os arquivos da pasta `terraform/`:
- ✅ `main.tf` - Configuração principal e provider
- ✅ `variables.tf` - Definição de variáveis
- ✅ `terraform.tfvars` - Valores das variáveis (configurado)
- ✅ `ecr.tf` - Repositório ECR
- ✅ `codebuild.tf` - Projetos CodeBuild (Build e Deploy)
- ✅ `codepipeline.tf` - Pipeline CI/CD
- ✅ `iam.tf` - Roles, policies e bucket S3
- ✅ `outputs.tf` - Outputs dos recursos

### 2. Manifestos Kubernetes ✅

Arquivos da pasta `kubernetes/`:
- ✅ `deployment.yaml` - Deployment da aplicação
- ✅ `service.yaml` - Service com LoadBalancer

### 3. Buildspecs ✅

Arquivos da pasta `buildspec/`:
- ✅ `buildspec-build.yml` - Build e push da imagem Docker
- ✅ `buildspec-deploy.yml` - Deploy no cluster EKS

### 4. Scripts de Automação ✅

Arquivos da pasta `scripts/`:
- ✅ `install-tools.ps1` - Instalação de ferramentas
- ✅ `setup-credentials.ps1` - Configuração AWS
- ✅ `prepare-repo.ps1` - Preparação do repositório
- ✅ `validate-pipeline.ps1` - Validação do pipeline

### 5. Documentação ✅

- ✅ `README.md` - Documentação completa do projeto
- ✅ `INSTRUCOES_PASSO_A_PASSO.md` - Guia detalhado
- ✅ `ENTREGAVEIS.md` - Este arquivo

### 6. Evidências da Execução

#### 6.1 Prints Necessários

Capture screenshots de:

1. **Terminal - Terraform Apply**
   - Comando: `terraform apply`
   - Mostrando: Recursos criados com sucesso
   - Arquivo: `evidencias/01-terraform-apply.png`

2. **Console AWS - CodePipeline**
   - Tela: Pipeline completo
   - Mostrando: Todos os stages em "Succeeded"
   - Arquivo: `evidencias/02-pipeline-success.png`

3. **Console AWS - CodeBuild (Build)**
   - Tela: Logs do projeto de build
   - Mostrando: Build concluído com sucesso
   - Arquivo: `evidencias/03-codebuild-build.png`

4. **Console AWS - CodeBuild (Deploy)**
   - Tela: Logs do projeto de deploy
   - Mostrando: Deploy concluído com sucesso
   - Arquivo: `evidencias/04-codebuild-deploy.png`

5. **Console AWS - ECR**
   - Tela: Repositório ECR
   - Mostrando: Imagens publicadas
   - Arquivo: `evidencias/05-ecr-images.png`

6. **Terminal - kubectl get all**
   - Comando: `kubectl get deployments,pods,services`
   - Mostrando: Recursos rodando no EKS
   - Arquivo: `evidencias/06-kubectl-resources.png`

7. **Navegador - Aplicação**
   - Tela: Aplicação Todo List funcionando
   - URL: LoadBalancer EXTERNAL-IP
   - Arquivo: `evidencias/07-app-running.png`

#### 6.2 Arquivos de Log

Salve os seguintes outputs:

1. **Terraform Output**
```powershell
cd terraform
terraform output > ../evidencias/terraform-outputs.txt
```

2. **Pipeline Execution**
```powershell
aws codepipeline list-pipeline-executions --pipeline-name todo-app-pipeline --region eu-central-1 > evidencias/pipeline-executions.json
```

3. **ECR Images**
```powershell
aws ecr describe-images --repository-name todo-list-app --region eu-central-1 > evidencias/ecr-images.json
```

4. **Kubernetes Resources**
```powershell
kubectl get all -o yaml > evidencias/k8s-resources.yaml
```

### 7. Repositório GitHub

- ✅ Repositório público criado
- ✅ Código fonte da aplicação (pasta `app/`)
- ✅ Scripts Terraform
- ✅ Manifestos Kubernetes
- ✅ Buildspecs
- ✅ Documentação completa

**URL do Repositório**: ___________________________

### 8. Informações do Projeto

Criar arquivo `PROJETO-INFO.txt` com:

```text
===========================================
INFORMAÇÕES DO PROJETO - PIPELINE CI/CD
===========================================

DUPLA:
- Aluno 1: [Nome]
- Aluno 2: [Nome]

REPOSITÓRIO GITHUB:
- URL: https://github.com/[usuario]/[repositorio]
- Visibilidade: Público

RECURSOS AWS CRIADOS:
- ECR Repository: todo-list-app
- CodePipeline: todo-app-pipeline
- CodeBuild Build: todo-app-pipeline-build
- CodeBuild Deploy: todo-app-pipeline-deploy
- S3 Bucket: todo-app-pipeline-artifacts-325583868777
- EKS Cluster: eksDeepDiveFrankfurt

REGIÃO AWS:
- eu-central-1 (Frankfurt)

SERVICE ROLE UTILIZADA:
- arn:aws:iam::325583868777:role/service-role/codebuild-asn-demo-lab-service-role

URL DA APLICAÇÃO:
- LoadBalancer: [EXTERNAL-IP do LoadBalancer]

DATA DE CONCLUSÃO:
- [Data]

OBSERVAÇÕES:
- Pipeline executa automaticamente no push para main
- Imagem Docker construída e enviada para ECR
- Deploy automático no cluster EKS
- Aplicação acessível via LoadBalancer
===========================================
```

---

## 📁 Estrutura Final para Entrega

```
entrega/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── ecr.tf
│   ├── codebuild.tf
│   ├── codepipeline.tf
│   ├── iam.tf
│   └── outputs.tf
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
├── buildspec/
│   ├── buildspec-build.yml
│   └── buildspec-deploy.yml
├── evidencias/
│   ├── 01-terraform-apply.png
│   ├── 02-pipeline-success.png
│   ├── 03-codebuild-build.png
│   ├── 04-codebuild-deploy.png
│   ├── 05-ecr-images.png
│   ├── 06-kubectl-resources.png
│   ├── 07-app-running.png
│   ├── terraform-outputs.txt
│   ├── pipeline-executions.json
│   ├── ecr-images.json
│   └── k8s-resources.yaml
├── README.md
├── INSTRUCOES_PASSO_A_PASSO.md
├── ENTREGAVEIS.md
└── PROJETO-INFO.txt
```

---

## ✅ Checklist de Verificação Final

Antes de entregar, verifique:

### Terraform
- [ ] Todos os arquivos .tf presentes
- [ ] terraform.tfvars configurado (sem o token exposto se for público)
- [ ] Terraform apply executado com sucesso
- [ ] Outputs salvos

### Pipeline
- [ ] Pipeline criado e visível no console
- [ ] Pipeline executado com sucesso pelo menos 1 vez
- [ ] Todos os stages (Source, Build, Deploy) em "Succeeded"
- [ ] Logs dos builds salvos

### ECR
- [ ] Repositório criado
- [ ] Pelo menos 1 imagem presente
- [ ] Imagem com tags corretas

### EKS
- [ ] Deployment criado e rodando
- [ ] Pods em estado "Running"
- [ ] Service com LoadBalancer funcionando
- [ ] Aplicação acessível via navegador

### Documentação
- [ ] README.md completo
- [ ] Instruções passo a passo claras
- [ ] Todas as evidências capturadas
- [ ] PROJETO-INFO.txt preenchido

### Repositório GitHub
- [ ] Repositório público criado
- [ ] Todo o código commitado
- [ ] README visível na página inicial
- [ ] .gitignore configurado (sem expor credenciais)

---

## 🎯 Critérios de Avaliação Atendidos

1. ✅ **Cluster EKS existente utilizado**: eksDeepDiveFrankfurt
2. ✅ **Pipeline CI/CD construído**: CodePipeline + CodeBuild
3. ✅ **Repositório ECR criado**: todo-list-app
4. ✅ **Build da imagem no push**: Automático via pipeline
5. ✅ **Atualização da tag no deployment**: Buildspec atualiza automaticamente
6. ✅ **Deploy no cluster**: Buildspec-deploy.yml
7. ✅ **Provisionamento com Terraform**: 100% Terraform
8. ✅ **Service Role especificada**: codebuild-asn-demo-lab-service-role
9. ✅ **Scripts entregues**: Todos na pasta terraform/
10. ✅ **Validação do fluxo**: Script de validação incluído

---

## 📤 Formato de Entrega

### Opção 1: ZIP
```powershell
Compress-Archive -Path * -DestinationPath pipeline-cicd-todoapp.zip
```

### Opção 2: GitHub
- Compartilhar o link do repositório público
- Garantir que todos os arquivos estão commitados
- Incluir branch main com todo o código

### Opção 3: Plataforma da Faculdade
- Seguir instruções específicas do professor
- Incluir todos os arquivos e evidências

---

## 📞 Contato

Em caso de dúvidas sobre os entregáveis:
- Consultar professor
- Revisar README.md e instruções
- Verificar pipeline de referência fornecido

**Boa sorte na entrega! 🚀**

