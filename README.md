# Pré requisitos
- Ter o docker e docker-compose instalados na máquina. (se não tiver basta seguir este link https://docs.docker.com/compose/install/)

# Rodando com o Docker Compose
- Criar um arquivo .env na raiz do projeto (basta copiar ou renomear o arquivo .env.example). Nele, você pode escolher a porta que será mapeada para o jupyter-notebook que estará rodando no docker
- Para rodar o projeto com o docker, basta executar o comando ```docker-compose up```
- Para acessar o notebook, basta acessar o localhost da sua máquina, na porta definida no .env (por padrão apenas ```localhost```)
