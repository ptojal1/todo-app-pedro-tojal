@echo off
chcp 65001 >nul
echo === CONFIGURANDO GIT E FAZENDO PUSH ===
echo.

cd /d "%USERPROFILE%\OneDrive\Área de Trabalho\infra"
if errorlevel 1 (
    echo ERRO: Não foi possível navegar para o diretório do projeto
    exit /b 1
)

echo Diretório atual: %CD%
echo.

REM Inicializar Git se necessário
if not exist ".git" (
    echo Inicializando repositório Git...
    git init
    git branch -M main
    echo Git inicializado!
) else (
    echo Repositório Git já existe
)

echo.
echo Configurando Git...
git config user.name "Pedro Tojal"
git config user.email "ptojal1@users.noreply.github.com"
echo Git configurado!

echo.
echo Verificando remote...
git remote | findstr /C:"origin" >nul
if errorlevel 1 (
    echo Adicionando remote origin...
    git remote add origin https://github.com/ptojal1/todo-app-pedro-tojal.git
    echo Remote adicionado!
) else (
    echo Remote origin já existe
)

echo.
echo Adicionando arquivos...
git add .
echo Arquivos adicionados!

echo.
echo Fazendo commit...
git commit -m "Initial commit - CI/CD Pipeline setup with Terraform - ECR repository: ptm-todo-list-app - CodeBuild projects: ptm-todo-app-pipeline-build, ptm-todo-app-pipeline-deploy - CodePipeline: ptm-todo-app-pipeline - Kubernetes manifests for deployment - Complete Terraform infrastructure as code - Service Role: codebuild-asn-demo-lab-service-role - Target EKS cluster: eksDeepDiveFrankfurt"
if errorlevel 1 (
    echo AVISO: Commit falhou ou não havia mudanças
)

echo.
echo ==========================================
echo FAZENDO PUSH PARA GITHUB...
echo Repositório: https://github.com/ptojal1/todo-app-pedro-tojal.git
echo Branch: main
echo ==========================================
echo.

git push -u origin main

if errorlevel 1 (
    echo.
    echo ERRO NO PUSH!
    echo Verifique o token do GitHub e as permissões
    exit /b 1
) else (
    echo.
    echo ========================================
    echo PUSH REALIZADO COM SUCESSO!
    echo PIPELINE DISPARADO AUTOMATICAMENTE!
    echo ========================================
    echo.
    echo Monitore o pipeline em:
    echo https://eu-central-1.console.aws.amazon.com/codesuite/codepipeline/pipelines/ptm-todo-app-pipeline/view?region=eu-central-1
    echo.
)

