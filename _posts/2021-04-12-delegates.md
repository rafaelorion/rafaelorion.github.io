---
layout: post
title: Delegates em C#
image:
subtitle:
tags: [c#,dotnet, microsoft, delegates, anonymous function]
---

![Delegate](../img/posts/delegate.png){:align="left"}

Hoje vamos falar um pouco sobre Delegates, o próprio nome já passa uma ideia do seu propósito.

Delegates são formas de delegar funções para outros métodos, um delegate representa uma referencia para um método que pode ser passado via parâmetro.

Com isso abrimos um leque de possibilidades, como escolher o comportamento de uma funcionalidade em runtime, definir o callback para uma função e até mesmo extender o comportamento de alguma classe externa sem a necessidade de mudança direta no código original.

Delegates são semelhantes a ponteiros de função do C++, a referência da chamada de um método é enviada ou atribuída a um delegate em vez da função concreta, tornando assim os delegates ferramentas tão flexíveis no desenvolvimento de uma aplicação.

Um delegate é declarado utilizando a palavra reservada **delegate** como no exemplo a seguir:
```cs
public delegate string MeuDelegate(string nome);
``` 

Um delegate pode ser atribuído de diversas formas, utilizando um **método nomeado**, **anonymous function** ou até mesmo uma **Lambda expression**.

```cs
//Inicializando com um método já existente
MeuDelegate meuDelegate = FuncaoTeste; 

//Inicializando com uma anonymous function
MeuDelegate meuDelegate2 = delegate(string nome) { return $"Bem vindo {nome}!"; };

//Inicializando com uma Lambda expression
MeuDelegate meuDelegate3 = (nome) => ($"Bem vindo {nome}!");
``` 


## Delegate ou MulticastDelegate?

Um delegate pode possuir retorno ou ser void, se um delegate não tiver nenhum retorno (void) ele automaticamente será do tipo System.MulticastDelegate, por conta disso, suportando o agrupamento com outras funções usando o operador "+=" 

```cs
public delegate void Del(string message);

public static void DelegateMethod1(string message) => Console.WriteLine("DelegateMethod1 " + message);
public static void DelegateMethod2(string message) => Console.WriteLine("DelegateMethod2 " + message);
public static void DelegateMethod3(string message) => Console.WriteLine("DelegateMethod3 " + message);

void Main()
{
  Del d1 = DelegateMethod1;
  Del d2 = DelegateMethod2;
  Del d3 = DelegateMethod3;

  Del allMethodsDelegate = d1 + d2;
  allMethodsDelegate += d3;

  allMethodsDelegate("Rafael Orion"); //Os 3 métodos serão executados
}
``` 

Se o delegate tiver algum retorno, nesse caso ele será do tipo System.Delegate e não suporta agrupamento de  métodos como o caso anterior.


## Colocando a mão na massa!

Vamos montar um exemplo um pouco mais prático, imagine que temos uma função externa para fazer um processamento dos dados de uma lista, mas queremos a possibilidade de injetar alguns filtros quando necessário.

**Aqui temos nossa classe do tipo Usuario:**
```cs
public enum Sexo { Masculino, Feminino }

public class Usuario
{
  public int Id { get; set; }
  public string Nome { get; set; }
  public int Idade { get; set; }
  public Sexo Sexo { get; set; }
  public string Estado { get; set; }

  public Usuario(int id, string nome, int idade, Sexo sexo, string estado)
  {
    Id = id;
    Nome = nome;
    Idade = idade;
    Sexo = sexo;
    Estado = estado;
  }
  public override string ToString() => return $"Id:{Id} - {Nome}, {Sexo} ,{Idade} anos de {Estado}";
}
``` 

**Aqui nosso delegate chamado "Filtro" que pode receber qualquer método com mesmos parâmetros e retorno:**
``` cs
public delegate List<Usuario> Filtro(List<Usuario> usuarios);
``` 

**Aqui temos uma função que irá receber uma lista de Usuários, ordenar e exibir:**
```cs
public void ExibirUsuariosOrdenados(List<Usuario> usuarios, Filtro filtros = null)
{
  //Efetua a ordenação
  var usuariosOrdenados = usuarios.OrderBy(_ => _.Nome).ToList();

  //Verifica se o delegate foi atribuído ou não
  if(filtros != null)
  {
    usuariosOrdenados = filtros(usuariosOrdenados); //Executa o delegate enviado
  }

  //Exibe o resultado no console da aplicação
  foreach(var usuario in usuariosOrdenados)
  {
    Console.WriteLine(usuario.ToString());
  }
}
``` 

Se chamarmos a nossa função ExibirUsuariosOrdenados sem passar nenhum delegate de filtro o resultado será somente nossa lista de nomes ordenada.

``` cs
void Main()
{
  var usuarios = new List<Usuario>()
  {
    new Usuario(6,"Usuario 6", 18, Sexo.Feminino, "rio de janeiro"),
    new Usuario(4,"Usuario 4", 41, Sexo.Masculino, "minas gerais"),
    new Usuario(3,"Usuario 3", 12, Sexo.Masculino, "rio de janeiro"),
    new Usuario(8,"Usuario 8", 12, Sexo.Masculino, "sao paulo"),
    new Usuario(5,"Usuario 5", 34, Sexo.Feminino, "sao paulo"),
    new Usuario(7,"Usuario 7", 19, Sexo.Feminino, "sao paulo"),
    new Usuario(1,"Usuario 1", 15, Sexo.Masculino, "sao paulo"),
    new Usuario(9,"Usuario 9", 23, Sexo.Masculino, "rio de janeiro"),
    new Usuario(2,"Usuario 2", 29, Sexo.Feminino, "sao paulo"),
  };

  Console.WriteLine("Exibindo todos sem filtro");
  ExibirUsuariosOrdenados(usuarios);
}
``` 

nesse caso o resultado seria:
``` 
Exibindo todos sem filtro
Id:1 - Usuario 1, Masculino ,15 anos de sao paulo
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:3 - Usuario 3, Masculino ,12 anos de rio de janeiro
Id:4 - Usuario 4, Masculino ,41 anos de minas gerais
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:6 - Usuario 6, Feminino ,18 anos de rio de janeiro
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
Id:8 - Usuario 8, Masculino ,12 anos de sao paulo
Id:9 - Usuario 9, Masculino ,23 anos de rio de janeiro
``` 


 **Criando um método para usar no delegate**
```cs
public List<Usuario> FiltroMaioresDeIdade(List<Usuario> usuarios)
{
  return usuarios.Where(_ => _.Idade > 18).ToList();
}
```

**Se passarmos o nosso método FiltroMaioresDeIdade para o delegate o resultado será:**
```cs
Console.WriteLine("Exibindo com filtro de idade");
ExibirUsuariosOrdenados(usuarios, FiltroMaioresDeIdade);
```

Resultado:
```
Exibindo com filtro de idade
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:4 - Usuario 4, Masculino ,41 anos de minas gerais
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
Id:9 - Usuario 9, Masculino ,23 anos de rio de janeiro
``` 

**Também podemos definir atribuir um delegate usando lambda:**
```cs
Console.WriteLine("Exibindo com filtro de cidade usando Lambda");
Filtro filtroPaulistas = (lista) => (lista.Where(_ => _.Estado.Equals("sao paulo")).ToList());
ExibirUsuariosOrdenados(usuarios, filtroPaulistas);
```

Resultado:
``` 
Exibindo com filtro de cidade usando Lambda
Id:1 - Usuario 1, Masculino ,15 anos de sao paulo
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
Id:8 - Usuario 8, Masculino ,12 anos de sao paulo
``` 

## Ok, mas posso executar mais de uma função ao mesmo tempo usando o mesmo delegate?

A resposta para essa pergunta é **depende**.
Se o seu delegate tiver um retorno assim como no exemplo anterior não será possível encadear mais de uma função, isso só é possível para métodos void.

Então seguindo a lógica do nosso exemplo, se quisermos enviar mais de um filtro ao mesmo tempo temos que fazer algumas alterações:

**Primeiramente nosso delegate não pode mais ter um retorno, para continuar alterando nossa lista sem um retorno vamos apelar para a mágica da passagem de parâmetro por referência, possibilitando que nosso método altere a lista original**
```cs
public delegate void Filtro(ref List<Usuario> usuarios);
```

**Os métodos dos filtros também precisam ser alterados:**
```cs
public void FiltroMaioresDeIdade(ref List<Usuario> usuarios)
{
  usuarios = usuarios.Where(_ => _.Idade > 18).ToList();
}

public void FiltroPaulistas(ref List<Usuario> usuarios)
{
  usuarios = usuarios.Where(_ => _.Estado.Equals("sao paulo")).ToList();
}
```

**Agora já podemos trabalhar com um ou mais filtros**
```cs
  Console.WriteLine("Exibindo com filtro de idade");
  ExibirUsuariosOrdenados(usuarios, FiltroMaioresDeIdade);
  Console.WriteLine("\n");

  Console.WriteLine("Exibindo com filtro de cidade");
  ExibirUsuariosOrdenados(usuarios, FiltroPaulistas);
  Console.WriteLine("\n");

  Console.WriteLine("Exibindo com filtro de idade e cidade");
  Filtro multiplosFiltros = FiltroMaioresDeIdade;
  multiplosFiltros+= FiltroPaulistas; //Atribuindo um segundo método por meio do operador +
  ExibirUsuariosOrdenados(usuarios, multiplosFiltros);
  Console.WriteLine("\n");
```

Resultado:
``` 
Exibindo com filtro de idade
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:4 - Usuario 4, Masculino ,41 anos de minas gerais
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
Id:9 - Usuario 9, Masculino ,23 anos de rio de janeiro

Exibindo com filtro de cidade
Id:1 - Usuario 1, Masculino ,15 anos de sao paulo
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
Id:8 - Usuario 8, Masculino ,12 anos de sao paulo

Exibindo com filtro de idade e cidade
Id:2 - Usuario 2, Feminino ,29 anos de sao paulo
Id:5 - Usuario 5, Feminino ,34 anos de sao paulo
Id:7 - Usuario 7, Feminino ,19 anos de sao paulo
``` 


Como podem ver no exemplo é possível passar diversos métodos para o mesmo delegate, todos serão executados quando o delegate for executado.

Lembrando que esse problema apresentado poderia ser feito de diversas outras formas muito melhores, a ideia aqui é somente exemplificar o uso de um delegate de uma maneira simples, garanto que irá se deparar com diversas possibilidade no seu dia a dia. ;)


## Referências: 
 - [Delegados (Guia de Programação em C#)](https://docs.microsoft.com/pt-br/dotnet/csharp/programming-guide/delegates/)
 - [Delegates and Events](https://docs.microsoft.com/pt-br/previous-versions/visualstudio/visual-studio-2008/ff652490(v=orm.10))



Até a próxima.

{% if page.comments == true %}
  {% include disqus.html %}
{% endif %}
