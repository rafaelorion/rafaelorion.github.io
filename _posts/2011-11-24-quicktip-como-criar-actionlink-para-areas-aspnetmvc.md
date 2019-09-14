---
layout: post
title: Como criar um actionLink para outra Area no Asp.Net MVC3
image:
subtitle: Quick Tip
tags: [asp.net,mvc]
---


![Quick tip](/img/posts/quicktip.jpg){:align="left"}

Fala ae galera.

Quando comecei a trabalhar com áreas no asp.net MVC3 me deparei com essa situação de criar um link que aponte para uma área diferente.
Apesar de ser algo simples fica a dica.

**<%= Html.ActionLink("Descrição do Link", "NomeDaPagina", new { area="NomeDaArea", controller="NomeDoController" } )%>**

Ou na sintaxe do Razor:

**@Html.ActionLink("Descrição do Link", "NomeDaPagina", new { area="NomeDaArea", controller="NomeDoController" } )**



Abraços,
