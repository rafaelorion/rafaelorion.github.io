---
layout: post
title: Acessando propriedades de uma master page através de uma content page
subtitle: Quick Tip
image:
tags: [c#]
---


![Quick tip](/img/posts/quicktip.jpg){:align="left"}

Agora vou dar uma dica bem simples de como acessar propriedades que estão em uma master page por uma de suas paginas filho.
Primeiramente vamos declarar uma propriedade publica na MasterPage:

<br/>

```
Public String PropriedadePublica
{
       get { return (String)Session["PropriedadePublica"]; }
       set { Session["PropriedadePublica"] = value; }
}
```

Estou utilizando sessions para que os valores da propriedade não sejão perdidos a cada postback.
Já na pagina filha para que possamos enchergar a propriedade da masterPage é preciso adicionar uma diretiva no aspx.

```
<% @MasterType VirtualPath="~/Site.master" %>
```

Lembrando que o caminho informado deve ser o mesmo que na propriedade MasterPageFile.
Com isso já é possível acessar as propriedades de uma master page da seguinte forma:

```
lblTeste.Text = Master.PropriedadePublica;
```

Outra forma de acessar dados da Masterpage é atavéz de seus componentes;
Para isso basta usar o comando FindControl como no exemplo:

```
var teste = ((Label)Master.FindControl("lblTeste")).Text
```

Até a próxima.
