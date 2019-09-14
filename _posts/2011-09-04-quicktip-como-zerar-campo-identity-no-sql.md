---
layout: post
title: Como zerar o valor de um campo Identity
image:
subtitle: Quick Tip
tags: [sql,database,sql server]
---


![Quick tip](/img/posts/quicktip.jpg){:align="left"}

Fala ae Galera.

Vou postar uma dica simples mas útil. Ao Criarmos uma coluna identity no Sql Server, mesmo depois de apagar todos os dados da tabela, ao inserirmos um novo registro ele continuará incrementando o valor desse campo a partir do ultimo valor inserido. Para zerar esse contador basta executar o seguinte script:

<b>DBCC CHECKIDENT( ‘ [NOME_DA_TABELA] ‘ , RESEED, 0)</b>

ex:
<b>DBCC CHECKIDENT(‘Funcionarios’, RESEED, 0)</b>

Também podemos modificar esse valor para que comece a partir de algum numero específico.

Ex:
<b>DBCC CHECKIDENT(‘Funcionarios’, RESEED, 50)</b>

Nesse caso o Próximo registro inserido na tabela Funcionários assumira o valor 51.

Abraços,

Rafael Orion
