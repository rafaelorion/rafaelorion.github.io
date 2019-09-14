---
layout: post
title: Como adicionar confirmação de exclusão em um ActionLink
subtitle: Quick Tip
image:
tags: [c#]
---


![Quick tip](/img/posts/quicktip.jpg){:align="left"}

Para adicionar uma confirmação de exclusão ou qualquer alerta em um ActionLink do asp.Net MVC é muito simples.

<br/><br/>
Segue um exemplo abaixo:


```
@Html.ActionLink(“Excluir”, “Delete”, new { id = item.Id }, new { @onClick =  “javascript:return ” + “confirm(‘Confirma a exclusão?’)”})
```

Em algumas sobrecargas o ActionLink recebe um Object para htmlAttributes, e é nele que colocamos o nosso javascript para o atributo onClick.

Lembrando que também podemos setar qualquer atributo html para o ActionLink dessa mesma forma.

Até a próxima.
