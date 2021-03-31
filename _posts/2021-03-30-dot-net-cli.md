---
layout: post
title: .Net CLI
image:
subtitle:
tags: [cli,dotnet, microsoft, core]
---


![.Net CLI](../img/posts/dotnetcore.png){:align="left"}

Depois dessa pequena pausa, que tal voltar falando um pouco sobre o CLI do .NET

Junto com a vinda do .NET Core ganhamos de brinde o CLI (**Command Line Interface**), a nova ferramenta cross-platform que nos permite criar, compilar, publicar e manipular packages das nossas aplicações feitas com .net core.

Com o CLI fica mais fácil automatizar algumas tarefas de devops, desenvolver utilizando outros sistemas operacionais como Mac/Linux ou até mesmo migrar do VisualStudio para o VsCode ;)


Para utilizar os comandos do CLI basta ter o .Net Core instalado e usar o terminal de sua preferência.

**A estrutura dos comandos segue o seguinte padrão:**
```
 dotnet <command> <argument> <option>
``` 
 
**Alguns exemplos:**
* Para criar uma nova aplicação Console chamada "NewConsole"
```
dotnet new console -n NewConsole
```
* para criar uma nova aplicação web mvc
```
dotnet new mvc
```
* Adiciona referência do Newtonsoft.json no projeto
```
dotnet add package Newtonsoft.json
```


## Alguns comandos básicos são:

* **dotnet new** = Cria um novo projeto ou solution baseado em algum template específico
* **dotnet restore** = Restaura as dependências do projeto
* **dotnet build** = Compila a aplicação
* **dotnet Run** = Executa a aplicação
* **dotnet publish** = Efetuar o deploy da aplicação
* **dotnet test** = Executa os testes unitários
* **dotnet vtest** = Executa os testes unitários de um arquivo específico
* **dotnet pack** = Gera um pacote do nuget com o código 
* **dotnet clean** = Limpa o output do projeto
* **dotnet sln** = Modifica o .NET Core solution file.
* **dotnet add package** = Adiciona a referência de um pacote do nuget no projeto
* **dotnet add reference** = Adiciona referência de um outro projeto
* **dotnet remove package** = Remove a referência de um pacote do nuget
* **dotnet remove reference** =	Remove a referência de um projeto
* **dotnet list reference** = Lista todas as referências


## Referências: 
 - [docs.microsoft.com/pt-br/dotnet/core/tools](https://docs.microsoft.com/pt-br/dotnet/core/tools)
 - [docs.microsoft.com/pt-br/dotnet/core/tools/dotnet](https://docs.microsoft.com/pt-br/dotnet/core/tools/dotnet)


Até a próxima.

{% if page.comments == true %}
  {% include disqus.html %}
{% endif %}
