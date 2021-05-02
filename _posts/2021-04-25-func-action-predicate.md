---
layout: post
title: Func, Action e Predicate
image:
subtitle:
tags: [c#,dotnet, microsoft, func, function, action, predicate]
---

![C sharp](../img/posts/csharp.png){:align="left" :height="350px" width="350px"}

Agora que já entendemos o funcionamento de um [**delegate**](https://rafaelorion.github.io/2021-04-12-delegates), chegou a hora de falar dos seus irmãos mais novos.

Com o objetivo de ser um tipo especifico de delegate pré moldados para as situações mais comuns o .net criou esses tres tipos, **Action**, **Func** e **Predicate**, 
apesar de serem baseados no **delegate**, eles são especializações focadas em diferentes situações.

## Action ##

Introduzido no **Framework 2.0**, Action é uma especialização do **delegate** focada em funções sem retorno com até **16 parâmetros**.

O objetivo é poupar de criar um delegate especifico para essas situações, com isso em vez de ter que compartilhar a assinatura do nosso delegate com todos os pontos do sistema podemos simplesmente trabalhar com uma action de forma genérica.

Situado dentro da namespace System, a classe Action possui 17 sobrecargas diferentes, que vão de zero a 16 parâmetros, cobrindo a maioria das situações! (se a sua função tiver mais que 16 parâmetros provavelmente você tem sérios problemas de arquitetura ;) )


Exemplo:
```cs
public void ShowMessageInPortuguese(string s1, string s2)
{
  Console.WriteLine("Bem vindo " + s1 + " e " + s2);
}

public void Main()
{
  //Declaração de um Action que espere 2 parâmetros do tipo string
  Action<string, string> actionShowMessage;
	
  //Podemos declarar essa função utilizando lambda
  actionShowMessage = (s1, s2) => {Console.WriteLine("Hello " + s1 + " and " + s2);}; 
	
  //Ou usando um método concreto com a assinatura compatível
  actionShowMessage += ShowMessageInPortuguese;
	
  //Executando as 2 actions atribuídas ao mesmo tempo
  actionShowMessage("Rafael","Orion"); 
  /*Resultado:
    Hello Rafael and Orion
    Bem vindo Rafael e Orion
  */

  //Declarando uma action sem parâmetros
  Action welcomeAction;

  //Atribuindo um comportamento à action
  welcomeAction = () => Console.WriteLine("Welcome!");

  //Executando a action
  welcomeAction(); //Welcome!
}
```

Assim como um **Multicast Delegate** (delegate sem retorno), podemos encadear múltiplos métodos na mesma action como vimos no exemplo acima. 


## Predicate ##

Introduzido no **Framework 2.0**, O predicate, é uma especialização do delegate focada em funções com retorno booleano e que pode receber somente 1 valor como parâmetro, geralmente utilizado para critérios de validação.

Exemplo:
```cs
class Usuario
{
	public int Id { get; set; }
	public string Nome { get; set; }
	public string Email { get; set; }
	public bool Ativo { get; set; }
}

public void Main()
{
  var lista = new List<Usuario>(){
    new Usuario(){Id=1, Nome="Usuario 1", Email="u1@teste.com", Ativo=true},
    new Usuario(){Id=2, Nome="Usuario 2", Email="u2@teste.com", Ativo=false},
    new Usuario(){Id=3, Nome="Usuario 3", Email="u3@teste.com", Ativo=true},
    new Usuario(){Id=4, Nome="Usuario 4", Email="u4@teste.com", Ativo=false},
    new Usuario(){Id=5, Nome="Usuario 5", Email="u5@teste.com", Ativo=true},
    new Usuario(){Id=6, Nome="Usuario 6", Email="", Ativo=true},
    new Usuario(){Id=7, Nome="", Email="Usuario 7", Ativo=true},
    new Usuario(),
    new Usuario(){Id=-2, Nome="Usuario -2", Email="aaa", Ativo=true},
    null
  };

 //Criando um predicate que recebe um usuário como parâmetro e retorna um bool informando se é valido ou não
 var predicateValidUser = new Predicate<Usuario> (u =>
		u != null &&
		u.Id > 0 &&
		!string.IsNullOrEmpty(u.Nome) &&
		!string.IsNullOrEmpty(u.Email)
	);

	//Aplicando 0 predicate para filtrar os dados
	var usuariosFiltrados = lista.Where(usuario => predicateValidUser(usuario)).ToList();
	
	//Utilizando uma action para exibir o resultado
	usuariosFiltrados.ForEach (ShowActiveUsers);
	
  //ou
	usuariosFiltrados.ForEach (usuario =>
	{
		if (usuario.Ativo)
		{
			Console.WriteLine ($"({usuario.Id}) {usuario.Nome} <{usuario.Email}>");
		}
	});

}

void ShowActiveUsers (Usuario usuario)
{
	if (usuario.Ativo)
	{
		Console.WriteLine ($"({usuario.Id}) {usuario.Nome} <{usuario.Email}>");
	}
}
```

## Func ##

Introduzido no **Framework 3.5**, Func é uma especialização do delegate focada em funções com retorno e até 16 parâmetros.

Assim como o **Action** e o **Predicate** os parâmetros não necessariamente precisam ser todos do mesmo tipo.

No caso da Func, o primeiro tipos especificado obrigatoriamente será o retorno da função, e os demais os parâmetros que serão recebidos, no exemplo abaixo nossa func irá retornar um valor do tipo **int** e irá receber 2 valores, sendo o primeiro do tipo **string** e o segundo do tipo **bool**.

```cs
Func<int, string, bool> myFunc;
```

Exemplo:
```cs
void Main()
{
  //Declara uma func que recebe 2 strings e retorna uma string
  Func<string,string, string> funcComparation;
	
  //Atribui um método concreto a func
  funcComparation = ShowLongest;
	
  //executa a func
  var result = funcComparation("Rafael", "Orion");
	
  Console.WriteLine(result); //Rafael
}

string ShowLongest(string value1, string value2)
{
  return value1.Length > value2.Length? value1: value2;
}

```

## Delegate, Action, Func, Predicate ... Qual devo usar? ##

Como podemos ver os quatro são bem parecidos, basicamente o delegate seria a forma mais genérica e abrangente, ja o action, func e predicate seriam um delegate pronto, cada um focado em uma situação especifica.

 - **Delegate:** É a assinatura de uma função que pode receber diferentes implementações, podendo receber parâmetros e retornar ou não valores. 
 - **Func:** É um tipo de delegate, obrigatoriamente retornando algum valor e podendo ter de 0 a 16 parâmetros
 - **Action:** Seria equivalente a uma Func porém obrigatoriamente sem retorno
 - **Predicate:** Seria equivalente a uma Func mas que recebe somente um parâmetro e obrigatoriamente deve retornar um valor booleano


Ok, mas se o delegate já pode fazer tudo isso, porque utilizar **func**, **action** ou **predicate**?

Assim como podemos somente usar um if comum em vez de um if ternário, array em vez de list ou ate mesmo usar um while em vez de for, o que nos leva a fazer essas escolhas seria deixar o nosso código mais claro e objetivo.

Func, Action e Predicate são especializações do delegate para fins específicos.

Se eu tenho uma função que irá receber um delegate para executar uma validação e sei que o resultado sera true ou false, porque não usar direto o predicate, isso já comunica de cara a nossa intenção, alem de poupar algumas linhas declarando a estrutura do nosso delegate.

O mesmo vale para func e action, sem falar que muitas partes do framework como um simples foreach esperam esses tipos de dados, isso já seria um bom motivo para aprender seu funcionamento. ;) 

O intuito é deixar os delegates para as situações mais especificas que não podem ser resolvidas utilizando action, func e predicate.

Espero que tenha ficado claro, sei que de cara não parece muito simples, mas recomendo fazer alguns testes com eles que garanto que irão facilitar muito sua vida. =)

Até a próxima.

{% if page.comments == true %}
  {% include disqus.html %}
{% endif %}