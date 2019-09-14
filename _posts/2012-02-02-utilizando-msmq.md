---
layout: post
title: Utilizando MSMQ (Microsoft Message Queue) no C#
image:
subtitle:
tags: [MSMQ]
---


![MSMQ](/img/posts/fila.gif){:align="left"}

O MSMQ (Microsoft Message Queue) é uma implementaçao da Microsoft presente desde o windows 95 para  o enfileiramento de Mensagens.

As filas trabalham com a politica  [FIFO](https://pt.wikipedia.org/wiki/FIFO) (First In First Out), ou seja, em uma fila podemos empilhar uma serie de mensagens, e sempre sera recuperado uma a uma começando pela ultima que foi inserida.

O MSMQ trabalha de forma assincrona, possibilitando que diferentes aplicaçoes comuniquem-se por meio de mensagens, o software envia as mensagens que serão empilhadas em uma fila gerenciada pelo proprio windows até que o programa receptor va até la pegar as mensagens.

**Tipos de Filas**

No MSMQ podemos criar filas Publicas ou Privadas. As filas publicas podem ser acessadas apartir de qualquer computador que faça parte do mesmo Dominio atravez do Active Directory, já as filas privadas são compartilhadas somente com os programas rodando na mesma maquina.

**Transacional**

Tambem podemos definir a fila como transacional ou não, protegendo a inserçao e remoçao de mensagens em casos de erros.


**Instalando o MSMQ**

Para começao a utilizar o MSMQ precisamos ir no “painel de controle” > “Programas e Recursos” > “Ativar ou desativar recursos do Windows” e marcar o checkbox “Serviços do MSMQ (Microsoft Message Queue)” como na imagem abaixo.

![Quick tip](/img/posts/MMQ.jpg)

**Mãos a Obra**

Primeiramente é necessário adicionar a referencia para o  “System.Messaging ” no projeto.

Como o MSMQ pode gerenciar varias filas quando formos criar/utilizar uma fila precisaremos dar um nome e caminho a ela.

Como no exemplo vou utilizar uma lista privada o caminho da lista deve ser “.\Private$\”, caso estivese criando uma lista Publica o caminho seria o o nome do dominio da Rede. O caminho deve ser passado junto com o nome da nossa lista.

Criando/Abrindo uma lista

```
MessageQueue msg;
var qName = @".\Private$\teste_app";
if (MessageQueue.Exists(qName))
    msg = new MessageQueue(qName);
else
    msg = MessageQueue.Create(qName);
```

Essa lista pode receber qualquer tipo de objeto, porem devemos escolher entre 2 tipos de formato, pode ser uma classe serializada ou binario.
Lembrando que se optarmos pelo formato em binario tanto o programa que envia qnt o receptor deve fazer referencia para a mesma dll que contem o objeto.

No exemplo vou passar o seguinte objeto serializado.

```
[Serializable]
public class Job
{
    public int ID { get; set; }
    public String Nome { get; set; }
}
```

Vamos configurar o formato:

```
msg.Formatter = new XmlMessageFormatter(new Type[] { typeof(Job) });
```

Agora basta enviar o objeto para a fila

```
var obj = new CommomLib.Job(){ ID = 10 ,  Nome = "Processo 1" };
msg.Send(obj);
```

Para pegar um item da Lista a outra aplicaçao devera primeiramente abrir a lista da mesma forma utilizada anteriormente, em seguida utilizar o seguinte código:

```
var myMessage = msg.Receive();
Job myJob = (Job)myMessage.Body;
```

Pronto! simples, agora vamos parar de utilizar banco de dados para gerenciar filas ok 😉

Até a próxima. []s
