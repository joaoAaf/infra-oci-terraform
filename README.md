## Projeto de Infraestrutura na OCI com Terraform

#### **AINDA ESTA EM CONSTRUÇÃO!**
**-->No momento só está sendo criada uma instância de VM, apenas com Docker e Tailscale<--**

Este projeto cria uma infraestrutura simples no Oracle Cloud Infrastructure (OCI) com Terraform, inicialmente com duas instâncias de VMs com o sistema operacional Ubuntu 22.04 LTS (aarch64), acessível via SSH e configurada com Docker, Tailscale e outros pacotes essenciais.

O intuito é subir em uma destas instancias um banco de dados PostgreSQL, que poderá ser acessado via Tailscale, sem a necessidade de permitir o acesso público, e na outra uma aplicação web que expõe uma API RESTful.

**Pre-requisitos:**

1. Possuir conta na [OCI](https://www.oracle.com/br/cloud/) e no site do [Tailscale](https://tailscale.com/);
2. Instalar o Terraform e o Git (se não estiver instalado);
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
    * Auth Key do Tailscale, gerada no passo 5.
7. Clonar este repositório com `git clone`;
8. Criar o diretório `private` na pasta raiz do projeto;
9. Criar o arquivo `vars.tfvar`, conforme o modelo `example/vars.tfvar.example`, o preencher com os dados reunidos no passo 5 e coloca-lo no diretório `private`;
10. Criar um arquivo `ssh_authorized_keys`, conforme o modelo `example/ssh_authorized_keys.example`, contendo a chave pública criada no passo 3 e, eventualmente, qualquer outra chave pública das maquinas que poderão ter acesso a sua instancia na OCI, e coloca-lo no diretório `private`.

Obs: Para os passos 4 e 6, consulte o seguinte link da documentação oficial da OCI: [Configurar o OCI Terraform](https://docs.oracle.com/pt-br/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm).

**Como usar:**

1. Garanta que todos os pré-requisitos estão atendidos;
2. Abra o terminal no diretório raiz do projeto;
3. Execute `terraform init` para inicializar o Terraform;
4. Execute `terraform plan -var-file=./private/vars.tfvar` para visualizar a estrutura que será criada;
5. Execute `terraform apply -var-file=./private/vars.tfvar -auto-approve` para aplicar as alterações na sua conta OCI;
6. Para acessar a instância criada via ssh pelo IP público, basta executar `ssh ubuntu@<ip_da_instancia>`, substituindo `<ip_da_instancia>` pelo IP fornecido no output do terraform. (esta opção só estará disponível temporariamente, até a conclusão da configuração das instâncias com o Tailscale);
7. Para acessar a instância criada via ssh pela rede do Tailscale, será necessário seguir os seguintes passos:
    * Instalar o cliente Tailscale, que pode ser feito por meio das instruções no  [site do Tailscale](https://tailscale.com/download);
    * Executar o comando `tailscale up` para se conectar à rede do Tailscale;
    * Executar o comando `tailscale status` para visualizar os dispositivos conectados à rede;
    * Executar o passo  6, substituindo o `<ip_da_instancia>` pelo nome instância retornado no output do terraform;
    * Caso obtenha algum erro verique no console do Tailscale, ou execute o comando `tailscale status`, para verificar se sua maquina e a instância criada estão conectados à rede ou se o nome da instância está correto. (Caso já tenha criado e destruído a infraestrutura, possivelmente o nome da instância estará diferente do que foi mostrado no output do terraform)

Obs¹: Para destruir toda a infraestrutura criada, execute `terraform destroy -var-file=./private/vars.tfvar -auto-approve`.

Obs²: Após completada a criação dos recursos, pode demorar alguns minutos até que o cloud-init termine de configurar as instâncias, e então você poderá acessar via SSH ou Tailscale.

Obs³: Caso queira fazer uma configuração personalizada para a máquina, basta alterar o arquivo `cloud-init.yml` na pasta `scripts`, destruir e reconstruir a infraestrutura com o passo 5.

**Licença:**

Este projeto está sob a licença BSD 3-Clause License - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

**Contato:**

Caso tenha alguma dúvida ou sugestão, entre em contato comigo através do email: joao.anderson.af@gmail.com.

**Redes Sociais:**

[LinkedIn](https://www.linkedin.com/in/jo%C3%A3o-anderson-33366057/)