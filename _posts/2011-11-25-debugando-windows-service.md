---
layout: post
title: Debugando Windows Service
image:
subtitle:
tags: [windows service, debug]
---


![Debug](/img/posts/debug-150x150.jpg){:align="left"}

Hoje vou ensinar uma forma para debugar windows service.

Ao criarmos um projeto do tipo WindowsService não conseguimos debugar normalmente como qualquer outro tipo de projeto, porem temos uma forma bem simples para contornar esse problema.

Primeiramente devemos criar uma condição na classe Program.cs para identificar se o nosso projeto foi executado em modo de Debug para redirecionarmos a chamada.

**Program.cs**

```Program.cs
  static void Main()
  {

      if (System.Diagnostics.Debugger.IsAttached)
      {
          MeuServico service = new MeuServico();
          service.StartDebug(new string[2]);
          System.Threading.Thread.Sleep(System.Threading.Timeout.Infinite);

      }
      else
      {
          ServiceBase[] ServicesToRun;
          ServicesToRun = new ServiceBase[] { new MeuServico() };
          ServiceBase.Run(ServicesToRun);
      }
  }
```

Apos feito isso, basta editar a classe do nosso serviço e adicionar um método StartDebug como no exemplo abaixo.

**No service:**

```Service
   public void StartDebug(string[] args)
   {
       OnStart(args);
   }
```

Como o Método OnStarde é do tipo protected criamos esse novo método publico para redirecionar a chamada.

Pronto! já podemos debugar nosso projeto normalmente sem nenhum problema.

[]s
