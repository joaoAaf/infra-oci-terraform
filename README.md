## Projeto de Infraestrutura na OCI com Terraform

### **AINDA ESTA EM CONSTRUÇÃO!**
### **Atualizações:**
- Definição da VCN (Virtual Cloud Network);
- Definição de subnet privada;
- Definição de listas de segurança para controle de tráfego;
- Definição da uma VM com Ubuntu 22.04 LTS (aarch64), que receberá o banco de dados;
- Elaboração de arquivo `docker-compose.yml` para subir os seguintes containers:
  * Banco de dados PostgreSQL;
  * Servidor WebDAV baseado em Nginx, que receberá os backups do banco de dados.
- Elaboração de arquivo `cloud-init.yaml` para personalização da VM do banco de dados, contendo:
  * Instalação e configuração dos pacotes Docker, Tailscale, Cron e outros necessários;
  * Personalização do Usuário padrão da instancia;
  * Criação de script para backup do banco de dados;
  * Configuração do Cron para automatização dos backups do banco de dados;
  * Inicialização dos containers definidos no arquivo `docker-compose.yml`.

### **Sobre o projeto:**

Este projeto cria uma infraestrutura simples no Oracle Cloud Infrastructure (OCI) com Terraform, inicialmente com duas instâncias de VMs com o sistema operacional Ubuntu 22.04 LTS (aarch64), acessível via SSH e configurada com Docker, Tailscale e outros pacotes essenciais.

O intuito é subir em uma destas instancias um banco de dados PostgreSQL com backup automatizado, que poderá ser acessado via Tailscale, sem a necessidade de permitir o acesso público, e na outra uma aplicação web que expõe uma API RESTful.

### **Pre-requisitos:**

1. Possuir conta na [OCI](https://www.oracle.com/br/cloud/) e no site do [Tailscale](https://tailscale.com/);
2. Instalar o [Terraform](https://developer.hashicorp.com/terraform/install), [Tailscale](https://tailscale.com/download) e o [Git](https://git-scm.com/downloads) (se não estiver instalado);
3. [Gerar par chaves SSH](https://wiki.archlinux.org/title/SSH_keys) na maquina local; (se não existir)
4. Gerar chave privada para que o terraform possa acessar a API da OCI (ver abaixo nas observações);
5. [Gerar Auth Key](https://tailscale.com/kb/1085/auth-keys#generate-an-auth-key) do Tailscale;
6. Reunir as seguintes informações (ver abaixo nas observações):
    * Tenancy OCID;
    * User OCID;
    * Fingerprint;
    * Region;
    * Caminho da chave privada (PEM), gerada no passo 4;
    * Chave pública SSH, gerada no passo 3;
    * Auth Keys do Tailscale, gerada no passo 5.
7. Criar um arquivo `config` no diretório `~/.oci`, conforme o modelo `example/config.example`, e preenchê-lo com os dados reunidos no passo 6;
8. Clonar este repositório com `git clone`;
9. Criar o diretório `private` na pasta raiz do projeto;
10. No diretório `private`, criar o arquivo `vars.tfvar`, conforme o modelo `example/vars.tfvar.example`, preenchê-lo com os dados reunidos no passo 6 e demais informados no modelo;

Obs: Para os passos 4 e 6, consulte o seguinte link da documentação oficial da OCI: [Configurar o OCI Terraform](https://docs.oracle.com/pt-br/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm).

### **Como usar:**

1. Garanta que todos os pré-requisitos estão atendidos;
2. Abra o terminal no diretório `terraform` na raiz do projeto;
3. Execute `terraform init` para inicializar o Terraform;
4. Execute `terraform plan -var-file=../private/vars.tfvar` para visualizar a estrutura que será criada;
5. Execute `terraform apply -var-file=../private/vars.tfvar -auto-approve` para aplicar as alterações na sua conta OCI;
6. Para acessar a instância criada via ssh pela rede do Tailscale, será necessário seguir os seguintes passos:
    * Executar o comando `tailscale up` para se conectar à rede do Tailscale;
    * executar `ssh dba@<nome_da_instancia>`, substituindo `<nome_da_instancia>` pelo nome instância retornado no output do terraform;
    * Caso obtenha algum erro verique no console do Tailscale, ou execute o comando `tailscale status`, para verificar se sua maquina e a instância criada estão conectados à rede ou se o nome da instância está correto. (Caso já tenha criado e destruído a infraestrutura, possivelmente o nome da instância estará diferente do que foi mostrado no output do terraform)

Obs¹: Para destruir toda a infraestrutura criada, execute `terraform destroy -var-file=../private/vars.tfvar -auto-approve`.

Obs²: Após completada a criação dos recursos, pode demorar alguns minutos até que o cloud-init termine de configurar as instâncias.

Obs³: Caso queira fazer uma configuração personalizada para a máquina, basta alterar o arquivo `cloud-init.yml` na pasta `scripts` e reconstruir a infraestrutura com o passo 5.

### **Licença:**

Este projeto está sob a licença MIT - veja o arquivo [LICENSE](https://github.com/joaoAaf/infra-oci-terraform/blob/main/LICENSE) para mais detalhes.

### **Contato e Redes Sociais:**

Caso tenha alguma dúvida ou sugestão, entre em contato comigo.

<div> 
  <a href = "mailto:joao.anderson.af@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" target="_blank"></a>
  <a href="https://www.linkedin.com/in/jo%C3%A3o-anderson-33366057" target="_blank"><img src="https://img.shields.io/badge/-LinkedIn-%230077B5?style=for-the-badge&logo=linkedin&logoColor=white" target="_blank"></a>   
</div>