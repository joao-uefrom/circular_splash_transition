# circular_splash_transition

A simple page transition with a circle that opens from the middle of the screen until it completely fills it and then closes back to the middle with the page altered.

Uma simples transição de tela com um circulo que se abre do meio da tela até preencher completamente ela e, depois, se fecha de volta para o meio apresentando a tela alterada.


![In action](https://raw.githubusercontent.com/joao-uefrom/circular_splash_transition/master/transition.gif)

## Usage
To use this package, add `circular_splash_transition` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Please, excuse the google translator :)

Import Circular Splash Transition:
```dart
import 'package:circular_splash_transition/circular_splash_transition.dart';
```

Create a controller for the transition within your state:
```dart
CircularSplashController _controller = CircularSplashController(
  color: Colors.white, //optional, default is White.
  duration: Duration(millisecons: 300), //optional. 
);
```
Now add the `CircularSplash()` at the top of your widget tree:
```dart
@override
Widget build(BuildContext context) {
  return CircularSplash(
    controller: _controller,
      child: Container(),
  );
}
```

Finally, use `_controller.push(context, nextPage);` to call the next page:
```dart
Future<Object> push() async {
  Object object = await _controller.push(context, nextPage);
  print(object);
  return object;
}
```

Remember to close your controller:
```dart
@override
void dispose(){
  _controller.dispose();
  super.dispose();
}
```

If you need to use a WillPopScope in the state, it is highly recommended to use the onWillPop that CircularSplash already implements. It works the same way and avoids any problems:
```dart
@override
Widget build(BuildContext context) {
  return CircularSplash(
    onWillPop: _onWillPop(),
    controller: _controller,
      child: Container(),
  );
}
```

If you want to use named routes:
```dart
import 'package:circular_splash_transition/circular_splash_transition.dart';

MaterialApp(
  onGenerateRoute: (RouteSettings route) {
    switch (route.name) {
      case "/nextPage":
        return CircularSplashRoute(
          builder: NextPage(), //named route
          color: Colors.blue, //optional
          duration: Duration(milliseconds: 300), //optional
          );
        }
      },
    );


@override
Widget build(BuildContext context) {
  return CircularSplash(
    onWillPop: _onWillPop,
    controller: _controller,
      child: GestureDetector(
        child: Container(),
        onTap: () async {
          Object object = await _controller.pushNamed(context, "/nextPage");
          print(object);
        },
      ),
  );
}
```
For a better experience, I recommend using the same color and duration in the `CircularSplashController` and` CircularSplashRoute` when going from one screen to another:

 ```dart
CircularSplashRoute(
  builder: NextPage(),
  color: Colors.blue,
  duration: Duration(milliseconds: 300));
 
CiruclarSplashController(
  color: Colors.blue,
  duration: Duration(milliseconds: 300));
```

## Modo de usar
Para usar este pacote, adicione `circular_splash_transition` como uma [dependência em seu pubspec.yaml](https://flutter.io/platform-plugins/).

Importe Circular Splash Transition:
```dart
import 'package:circular_splash_transition/circular_splash_transition.dart';
```

Crie um controlador para a transição dentro do seu estado
```dart
CircularSplashController _controller = CircularSplashController(
  color: Colors.white, //opicional, o padrão é branco.
  duration: Duration(millisecons: 300), //opicional, o padrão é 300 milisegundos. 
);
```
Agora adicione o `CircularSplash()` no topo da sua árvore de widgets:
```dart
@override
Widget build(BuildContext context) {
  return CircularSplash(
    controller: _controller,
      child: Container(),
  );
}
```

Finalmente, use `_controller.push(context, nextPage);` para chamar a próxima tela:
```dart
Future<Object> push() async {
  Object object = await _controller.push(context, nextPage);
  print(object);
  return object;
}
```

Lembre-se de fechar o controlador:
```dart
@override
void dispose(){
  _controller.dispose();
  super.dispose();
}
```

Se você precisar usar um WillPopScope no estado, é altamente recomendável usar o onWillPop que o CircularSplash já implementa. Funciona da mesma maneira e evita quaisquer problemas:
```dart
@override
Widget build(BuildContext context) {
  return CircularSplash(
    onWillPop: _onWillPop(),
    controller: _controller,
      child: Container(),
  );
}
```

Se você quiser usar rotas nomeadas:
```dart
import 'package:circular_splash_transition/route.dart';

MaterialApp(
  onGenerateRoute: (RouteSettings route) {
    switch (route.name) {
      case "/nextPage":
        return CircularSplashRoute(
          builder: NextPage(), //nome da rota
          color: Colors.blue, //opicional
          duration: Duration(milliseconds: 300), //opicional
          );
        }
      },
    );


@override
Widget build(BuildContext context) {
  return CircularSplash(
    onWillPop: _onWillPop,
    controller: _controller,
      child: GestureDetector(
        child: Container(),
        onTap: () async {
          Object object = await _controller.pushNamed(context, "/nextPage");
          print(object);
        },
      ),
  );
}
```

Para uma melhor experiencia, recomendo utilizar a mesma cor e duração no `CircularSplashController()` e `CircularSplashRoute()` quando for de uma tela para outra:
 ```dart
CircularSplashRoute(
  builder: ProximaTela(),
  color: Colors.blue,
  duration: Duration(milliseconds: 300));
 
CiruclarSplashController(
  color: Colors.blue,
  duration: Duration(milliseconds: 300));
```