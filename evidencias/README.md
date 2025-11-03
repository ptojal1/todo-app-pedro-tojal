# 📸 Evidências da Execução

## Instruções

Coloque nesta pasta todas as capturas de tela e arquivos de log que comprovam a execução bem-sucedida do pipeline.

## Arquivos Necessários

### Screenshots (PNG ou JPG)

1. `01-terraform-apply.png` - Terminal mostrando terraform apply concluído
2. `02-pipeline-success.png` - Console AWS mostrando pipeline em Succeeded
3. `03-codebuild-build.png` - Logs do CodeBuild (Build)
4. `04-codebuild-deploy.png` - Logs do CodeBuild (Deploy)
5. `05-ecr-images.png` - Console ECR mostrando imagens
6. `06-kubectl-resources.png` - Terminal com kubectl get all
7. `07-app-running.png` - Navegador com aplicação funcionando

### Arquivos de Log (TXT ou JSON)

Execute os comandos abaixo e salve os resultados nesta pasta:

```powershell
# 1. Terraform outputs
cd terraform
terraform output > ../evidencias/terraform-outputs.txt
cd ..

# 2. Pipeline executions
aws codepipeline list-pipeline-executions --pipeline-name todo-app-pipeline --region eu-central-1 > evidencias/pipeline-executions.json

# 3. ECR images
aws ecr describe-images --repository-name todo-list-app --region eu-central-1 > evidencias/ecr-images.json

# 4. Kubernetes resources
kubectl get all -o yaml > evidencias/k8s-resources.yaml
```

## Como Capturar Screenshots

### Windows

1. **Ferramenta de Recorte**: `Win + Shift + S`
2. **Print Screen**: `PrtScn` (tela inteira)
3. **Alt + Print Screen**: Janela ativa

### Salvar

Salve as imagens com os nomes especificados acima nesta pasta.

## Checklist

- [ ] 01-terraform-apply.png
- [ ] 02-pipeline-success.png
- [ ] 03-codebuild-build.png
- [ ] 04-codebuild-deploy.png
- [ ] 05-ecr-images.png
- [ ] 06-kubectl-resources.png
- [ ] 07-app-running.png
- [ ] terraform-outputs.txt
- [ ] pipeline-executions.json
- [ ] ecr-images.json
- [ ] k8s-resources.yaml

## Importante

✅ Certifique-se de que todas as evidências mostram claramente:
- Data/hora da execução
- Status de sucesso
- Recursos criados
- Aplicação funcionando

