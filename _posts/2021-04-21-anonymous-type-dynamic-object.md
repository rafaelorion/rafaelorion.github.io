---
layout: post
title: Anonymous type, Dynamic e Object
image:
subtitle:
tags: [c#,dotnet, microsoft, Anonymous type, tipos anonimos, dynamic, var, object, anonimo]
---

![Anonymous type](../img/posts/anonymous.jpg){:align="left" :height="350px" width="350px"}

## Anonymous Type ## 

Os **Tipos anônimos** são utilizados para encapsular propriedades em um objeto somente leitura.

Introduzidos no **c# 3.0** junto com o **var**, com ele podemos criar um objeto definindo diretamente no construtor as propriedades que queremos, sem precisar usar uma classe já existente.

Para instanciar um objeto do tipo anonimo o processo é similar a de uma classe comum, porem omitimos o tipo do objeto como no exemplo a seguir:

```cs
var produto = new { Nome= "Teclado", Descricao="Keychron K8", Preco = (decimal)69.00 };

Console.WriteLine("Produto " + produto.Nome + " " + produto.Descricao);
```

Bem simples não é verdade?

Note que não temos nenhuma classe com as definições do nosso produto, todos os campos foram definidos e os valores atribuídos diretamente no momento da instância.

Como os tipos anonimos são readonly nao podemos alterar o valor de nenhuma das propriedade, isso resultaria em um erro de compilação.


## Object x Dynamic x var x Anonymous Type ## 

Uma confusão bem comum é com relação aos tipos anonimos, dynamic e object, para quem ainda não tem esses conceitos bem definidos pode parecer que é tudo igual, então vamos tentar esclarecer um pouco.

## Object ##
Introduzido no **c# 1.0**, o tipo **object** pode receber qualquer tipo de valor, já que todas as classes em .Net herdam do tipo object.

Por se tratar de um tipo, pode ser declarado sem receber nenhum valor inicial, porem mesmo aceitando qualquer tipo de valor, quando utilizado precisamos fazer cast para o tipo desejado.

uma variável do tipo object alem de poder receber qualquer valor, também pode alterar entre valores de diferentes tipos a qualquer momento.

exemplo:
```cs
object obj = "Rafael Orion"; //Declarando e iniciando uma variável object recebendo uma string
obj = 35; //sobrescrevendo o valor inicial com um valor do tipo inteiro

int number1 = obj; // compile error
int number2 = (int)obj; // correct
```

Note que apesar da nossa variável estár com um valor inteiro, não é possível utilizar ele como inteiro sem efetuar a conversão antes, isso irá gerar um erro de compilação.

	
## Var ##
Introduzido no **c# 3.0**, o var nada mais é do que uma forma de declarar alguma variável sem informar diretamente o seu tipo, o tipo será deduzido baseado no valor recebido, por conta disso o valor da variável sempre deve ser informado no momento da declaração.

Diferente do object, dynamic e anonymous type, o var não é um tipo de valor, e sim somente uma forma de declarar os objetos, apesar de não obter nenhum ganho de performance na sua utilização ele é considerado por muitos uma boa pratica por deixar o código um pouco mais limpo e menos redundante.
Exemplo:
```cs
Usuario usuario1 = new Usuario();
var usuario2 = new Usuario();
```

Note que em ambos os casos estamos instanciando um objeto do tipo "Usuario", porem utilizamos o var não temos a redundância de informar o nome da classe duas vezes.

Justamente por não ser um tipo, e sim somente um atalho para definir o tipo por Inferência, quando utilizado o var a variável receberá o tipo do valor que está recebendo, e por conta disso não pode ser alterado posteriormente.

exemplo:
```cs
var obj = "Rafael";
obj = "Rafael Orion";
obj = 35; // compile error
```
No exemplo acima nossa variável obj será do tipo string por conta do valor que está sendo atribuído, se tentarmos atribuir um valor de um tipo diferente do inicial teremos um erro de compilação. 
	

## Anonymous Type ##
Introduzido no **c# 3.0**, como explicado anteriormente, podemos criar um objeto dinamicamente sem a necessidade de uma classe prévia que contenha a estrutura desejada.

Para declarar um anonymous type precisamos utilizar o var, já que não temos uma palavra reservada especificamente para esse tipo.

## Dynamic ## 
Introduzido no **c# 4.0**, e similar ao tipo object, com o dynamic podemos receber qualquer valor de forma bem flexível com a vantagem do cast ser feito automaticamente.

```cs
dynamic obj = "Rafael Orion";
obj = 35;
int number1 = obj; // correct
int number2 = (int)obj; // correct
```

Isso só é possível pois diferente do tipo object, dynamic não possui todas as informações sobre o valor recebido, algumas só serão resolvidas em runtime.

O fato de não ser fortemente tipado pode deixar o seu uso mais prático, porem pode ocultar alguns problemas que só iram explodir em runtime. como dizia o tio Ben, “Com grandes poderes vêm grandes responsabilidades” .

	
## Exemplos: ## 
```cs
var usuario = new { Id= 1, Nome = "Rafael", Profissao= "Programador"}; //Anonymous Type 
usuario.Nome = "Orion";  // compile error

//Verificando o tipo da nossa variável
Console.WriteLine(usuario.GetType().Name); //<>f__AnonymousType0`3

Console.WriteLine ("dynamic:");
dynamic obj1 = 1;
dynamic obj2 = "Orion";
dynamic obj3 = usuario;

Console.WriteLine(obj1.GetType().Name); //Int32
Console.WriteLine(obj2.GetType().Name); //String
Console.WriteLine(obj3.GetType().Name); //<>f__AnonymousType0`3

object obj4 = 1;
object obj5 = "Orion";
object obj6 = usuario;

Console.WriteLine("objects:");
Console.WriteLine (obj4.GetType().Name); //Int32
Console.WriteLine (obj5.GetType().Name); //String
Console.WriteLine (obj6.GetType().Name); //<>f__AnonymousType0`3

var obj7 = 1;
var obj8 = "Orion";
var obj9 = usuario;

Console.WriteLine ("var:");
Console.WriteLine (obj7.GetType().Name); //Int32
Console.WriteLine (obj8.GetType().Name); //String
Console.WriteLine (obj9.GetType().Name); //<>f__AnonymousType0`3
		
```

## Como passar um tipo anonimo via parâmetro? ##

Se quisermos passar um tipo anônimo como parâmetro em alguma função precisamos utilizar o tipo dynamic, apesar do tipo object também suportar um tipo anonimo não teremos acesso as propriedades diretamente sem efetuar um cast para dynamic ou utilizando reflection, por conta disso o dynamic se encaixa melhor na situação.

exemplo:
```cs
void Main()
{
  var usuario = new { Id= 1, Nome = "Rafael", Profissao= "Programador"};
  Teste(usuario);
}
public void Teste(dynamic usuario)
{
  Console.WriteLine(usuario.Nome);
}
```

Como podemos ver a união do **var** com **Anonymous Type** e **dynamic** podem formar uma combinação muito poderosa e flexível. =)

Até a próxima.

## Referências: 
 - [Tipos anônimos (Guia de Programação em C#)](https://docs.microsoft.com/pt-br/dotnet/csharp/programming-guide/classes-and-structs/anonymous-types)


{% if page.comments == true %}
  {% include disqus.html %}
{% endif %}