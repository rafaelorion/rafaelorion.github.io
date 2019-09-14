---
layout: post
title: Utilizando Tipos Nulos em c# (Nullable Types)
image:
subtitle:
tags: [c#]
---


![Nulos](/img/posts/Nulo2B-150x150.jpg){:align="left"}

Em alguns casos precisamos trabalhar com tipos nulos, mas por padrão nem todos os tipos de variáveis aceitam, porem em c# é muito simples criarmos variáveis que possam assumir valores nulos.

**Nullable**
Qualquer tipo pode passar a ser nullable , por exemplo uma variável do tipo int por padrão não pode receber null, para resolver isso basta adicionar o operador ? logo depois do tipo desejado.
Declararmos da seguinte forma:


```
int? numero;
numero = null;

//ou

Nullable numero2;
numero2 = null;
```

Com isso criamos uma variável do tipo int nullable.

Utilizo bastante variáveis nullables  por exemplo quando quero passar um parametro bool? ativo em uma funçao onde quando o valor  for True trarei todos os registros ativos, False todos os Inativos e Null para trazer todos os ativos e inativos.

**Operador ??**
O operador ?? apesar de pouco conhecido é muito útil, com ele podemos verificar de forma rápida e elegante se uma variável possui valor nulo;

**Exemplo:**
```
int? numero = null;
int numero2 = numero??99;

string mensagem = null;
string mensagem2 = mensagem??"Mensagem Nula";
```

Com isso caso o valor da variável que  antecede o operador ?? for nulo, será atribuido o valor que está posterior ao operador ??, caso contrario será atribuido o valor da variável em questão.

Ele trabalha de forma bem parecida a um if ternário:

```
int? numero = null;
int numero2 = numero == null ? 99 : numero;
```

Esse operador pode ser muito útil por exemplo em Getters para evitar retorno de um objeto não instanciado:

```
private IList empresas;
public IList Empresas
{
    get { return empresas = empresas ?? new List(); }
    set { empresas = value; }
}
```

Ou quando precisamos reistanciar algum objeto caso esteja nulo.

```
repositorio = repositorio ?? new Repositorio();
//Somente será reinstanciada caso sejá nulo.
```

Até a próxima.

[]s
