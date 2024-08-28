# Flutter App Ecommerce

Repositório referente a um ecommerce feito com flutter e node para o desafio técnico da IN8.


# Decisões arquiteturais
  
  Optei por uma arquitetura Clean Code para o front da aplicação, pois estar mais habituado com esse tipo de arquitetura e considero essencial para tornar o código mais legível, mais fácil de ser mantido e mais compreensível, além de facilitar a implementação de testes em cada funcionalidade do sistema pelo fato de isolar a aplicação em diferentes camadas.
  
  Há basicamente quatro camadas:

  Data Layer: Camada responsável pelo recebimento de dados de várias fontes, sejam elas remotas, como uma API remota, ou locais, como um banco de dados local. Nessa camada, é inserida a implementação do repositório e de serviços que se comunicam com as fontes de dados.

  Domain Layer: Camada responsável pela lógica de negócios da aplicação. Em suma, essa camada abstrai as implementações do repositório, dos casos de uso em diferentes interfaces que apenas definem o comportamento das implementações concretas, onde cada uma possui uma única atribuição. Essa ideia segue os princípios da responsabilidade única e da inversão de dependências do S.O.L.I.D. Além diso, nessa camada, é inserido as Entities, que são entidades responsáveis por encapsular todas as regras de negócio da aplicação. Por isso, não é recomendável mudanças nelas, pois haverá dessa forma impactos em várias partes da aplicação que as utilizam.

  Presentation Layer: Camada responsável pela exibição das diferentes páginas, widgets e lógica de estados que compõe a interface de usuário e as interações com a tela.

  Core Layer: Essa é uma camada adicional, que possui recursos importantes da aplicação, como métodos utils, constantes, padronização de textos e cores, injeção de dependências e abstração para lidar com o retorno dos dados.

# Conceitos e premissas

  A arquitetura Clean Code foi implementada para reduzir o acoplamento entre os objetos, o que vai de encontro a alguns princípios do SOLID, como o da responsabilidade única, dessa forma, cada camada será responsável apenas por uma função. Percebemos a divisão do sistema em features, auth e produtos, nesse último há 3 domínios diferentes relacionados (products, cart e purchases). Dessa forma, a estrutura do código fica bem organizada e fácil de implementar alterações em features existentes ou novas features. Cada feature é implementada seguindo um padrão de camadas bem delimitadas. Data, Domain e Presentation. 

  Na parte de Autenticação, foram implementados alguns testes unitários usando Mocktail e Flutter Test, para reproduzir o comportamento esperado pela implementação do repositório e do datasource.

  Para a lógica de estados, foi utilizado o gerenciamento de estados com Provider, para isso, no arquivo router.dart foram inseridos os providers que seriam utilizados em cada tela, repassando o estado para cada view. Estado esse gerenciado dentro de cada controller, que será responsável por chamar cada caso de uso, atualizar o estado e alterar a interface de usuário de acordo com tais mudanças. Outra opção seria o bloc, principalmente para a parte de Autenticação, como há a chamada de eventos para cada estado, seria bastante útil nesse caso, pois bastaria chamar o evento de Login passando um estado de usuário logado

  A técnica de Dependecy Injection foi aplicada e nesse caso todas as dependências da aplicação, como repository, usecase e provider foram injetadas em um container separado atráves de instâncias do [GetIt](https://pub.dev/packages/get_it) que inicializa todas essas dependências no método void da main (initDependecies), para que possam ser acessadas pela árvore de widgets da aplicação. Assim toda vez que eu utilizar qualquer dependência interligada ao controller, é preciso instanciar todas elas antes.
  
  Grande parte dos elementos que compõem a interface de usuário foram separados em diferentes componentes ou widgets, para que sejam reutilizados no sistema, o que também facilita os testes de widgets e a manutenção da aplicação.
  
  No caso da API, apenas a rota que chama os produtos foi utilizada, para retornar numa listagem de produtos e posteriormente repassar para o carrinho, caso o usuário adicione produtos nele. Para o carrinho, foi utilizado o banco de dados local SQLite, dessa forma, quando o usuário sai do aplicativo, reinicia o dispositivo ou limpa o cache, ocorre a persistência dos dados e os produtos anteriormente adicionados ao carrinho, continuam la.

  Se tratando da navegação, utilizei apenas o Navigator para administrar a pilha de widgets e para navegar entre as telas internas (Login, Products, Cart). A geração de rotas nomeadas foi utilizada para cada tela e cada rota é separada dentro do arquivo router.dart, que define as condições de chamada de cada rota.

  No Backend foi utilizado Node e Express junto com o Typeorm para abstrair a comunicação com banco de dados, utilizando métodos para consultar e inserir informações no banco de dados Postgresql. A estrutura é definida basicamente em Routes, Controller, Entities e Repositories. No caso de Repositories, eles são inseridos dentro do próprio controller a partir do método getRepository do TypeORM, que retorna o repositório a partir da entidade definida no data source. Além disso foram criados alguns Middlewares que intermediam a autenticação do usuários com JWT, a partir de mecanismos de comparação de senha, criptografia e geração de token.

# Backend da aplicação

 [Ecommerce Backend](https://github.com/renanmdreis45/backend_app_ecommerce)
  
 # Como rodar a aplicação
  
  - É necessário instalar o [Dart SDK](https://dart.dev/get-dart) e  o [Flutter SDK](https://docs.flutter.dev/get-started/install)
  - Utilizei a seguinte versão do Flutter e do Dart:
        
        Dart SDK version: 3.6 
        Flutter 3.24.0 

  - É preciso instalar o [Android Studio](https://developer.android.com/studio) também, onde a versão do Flutter deve suportar a versão do Java e do Gradle no sistema.
  - Após instalação dos SDKs e ajuste das configurações de build para que as versões estejam competíveis, basta executar o seguinte comando para instalar todas as dependências e bibliotecas utilizadas.

```
flutter pub get
```

- Rodar a aplicação: 

```
flutter run
```

- Acessar a aplicação

```
Utilizei um emulador do Android Studio para buildar e exibir a aplicação
```

  Para o Backend, basta executar npm install seguido com npm start. Antes é preciso configurar um novo banco de dados Postgresql, usando as informações do datasource. São elas: host (localhost), database (postgres), user(postgres), password(postgres) e port (5432). Isso pode ser feito adicionando-se um novor server no PgAdmin. Como synchronize:true,
  haverá a sincronização entre mudanças nas entidades e modificações no banco de dados. Logo, as tabelas serão geradas automaticamente após configuração do banco e ao rodar o comando npm start.


```
npm install
```

- Rodar o servidor: 

```
npm start
```

- Acessar a aplicação

# Rodando a aplicação



# Melhorias futuras
  
  Pretendo adicionar a funcionalidade de logout, filtrar o carrinho de produtos para cada usuário, fazer uma tela de detalhes de cada produto e uma tela com a listagem de compras de cada usuário.

