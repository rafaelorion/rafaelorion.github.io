---
layout: post
title: Consultando desempenho da maquina com o PerformanceCounter
image:
subtitle:
tags: [PerformanceCounter]
---


![Gerenciador de tarefas](/img/posts/Gerenciador-de-Tarefas-Windows.png){:align="left"}

Com o PerformanceCounter podemos obter diversas informações sobre o desempenho atual da maquina, como por exemplo quantidade de memória em uso, espaço livre no HD, processamento, etc.

Quando precisamos rodar um processo muito pesado em um servidor  através de um serviço  periódico muitas vezes vale a pena conferir a situação da maquina antes de iniciar o processo para evitar travamento do sistema. Ou ate mesmo utilizar essas  informações para criar um monitorador dos recursos, vai da sua necessidade e criatividade.

Vamos para o que interessa.

Para pegar informações básicas sobre o uso de memória, hd e processador é muito simples, basta utilizar os seguintes comandos:


```
var cpu = new System.Diagnostics.PerformanceCounter("Processor", "% Processor Time", "_Total");
var memory = new System.Diagnostics.PerformanceCounter("Memory", "% Committed Bytes In Use");
var hd = new System.Diagnostics.PerformanceCounter("PhysicalDisk", "% Disk Time", "_Total");

Console.WriteLine(" % Uso do Processador: {0}", cpu.NextValue());
Console.WriteLine(" % Uso de Memória: {0}", memory.NextValue());
Console.WriteLine(" % Acesso ao HD: {0}", hd.NextValue());
```

[Para mais informações clique aqui](http://msdn.microsoft.com/pt-br/library/system.diagnostics.performancecounter.aspx)


Até a próxima.
[]s

{% if page.comments == true %}
  {% include disqus.html %}
{% endif %}
