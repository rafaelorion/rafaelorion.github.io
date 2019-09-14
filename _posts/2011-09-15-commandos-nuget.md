---
layout: post
title: Comandos do Nuget
image:
subtitle:
tags: [nuget,visual studio]
---


![Nuget](/img/posts/nuget-64x64.png){:align="left"}

No post anterior falei um pouco sobre o NuGet, agora vou listar alguns dos principais comandos para você utilizar no console do Visual Studio.



Para exibir o shell de comandos do NuGet, vá no menu **View/Other Windows/Package Manage Console**.

A seguinte janela irá ficar  visível:

![nuget package manager](/img/posts/pm-nuget.jpg)

No combo do lado esquerdo selecionamos qual será nosso repositório, por padrão ele busca da web mas podemos informar um repositório privado.

No combo do lado direito selecionamos o projeto no qual as referencias serão aplicadas.

## Pesquisando um pacote pelo NuGet:

Para pesquisar um pacote, por exemplo o NHibernate basta digitar o seguinte comando:

**PM> Get-Package nhibernate -remote**

Esse comando trará todos os pacotes que possuem “NHibernate” no nome.

O parametro “- remote” indica que o pacote será pesquisado no repositório selecionado em vez de buscar os pacotes instalados no projeto.


## Adicionando referência de um pacote ao Projeto:

Para adicionar a referencia de um pacote, por exemplo o FluentNhibernate:

**PM> Install-Package fluentnhibernate**

Esse comando instalará o fluent e todas suas  dependências, como por exemplo o NHibernate e Iesi.Collections, ele buscará sempre a versão mais atual.

Para não instalar as dependências basta adicionar o parâmetro  **“-ignoreDependencies”**

**PM> Install-Package fluentnhibernate -IgnoreDependencies**

Também podemos informar qual versão desejamos instalar com o parâmetro  **-Version**

## Removendo um pacote do Projeto:

Para remover uma referencia basta usar o comando:

**PM> Uninstall-Package FluentNHibernate**

## Atualizando um pacote adicionado:

Para atualizar um pacote para a versão mais recente:
**PM> Update-Package FluentNHibernate**

Para atualizar um pacote para uma versão especifica:
**PM> Update-Package FluentNHibernate -version 1.0.0**

## Listando os pacotes Instalados:

Para listar os pacotes instalados a lógica é a mesma de quando buscamos no repositório, basta omitir o parâmetro **“-remote”**

Para listar todos instalados:
**PM> Get-Package**

Para buscar algum especifico:
**PM> Get-Package nhibernate**

![nuget package manager](/img/posts/pm-nuget-2.jpg)

A documentação completa em inglês pode ser encontrada [aqui](https://docs.microsoft.com/pt-br/nuget/).

## Dica

O NuGet possui AutoComplete para auxiliar na digitação dos comandos e nomes de pacotes, basta pressionar a tecla Tab depois de digitar o inicio do comando.
