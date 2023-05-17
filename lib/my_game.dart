import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'figuras.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tap_button.dart';
import 'my_game.dart';


import 'drag_component.dart';
import 'flower_player.dart';
import 'dart:async';

class MyGame extends FlameGame with KeyboardEvents {
  final sizeOfPlayer = Vector2(80, 180);
  int score = 0;
  int vel = 2;
  double TiempoGenerarFigura = 0;
  late final FlowerPlayer player;
  late final JoystickComponent joystick;

  // PARA ACTIVAR EL DEBUG
  @override
  bool get debugMode => true;

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 113, 164, 207);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  Future<void> onLoad() async {
    children.register<Flower>();

    final image = await images.load('joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );

    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: sheet.getSpriteById(1),
        size: Vector2.all(100),
      ),
      background: SpriteComponent(
        sprite: sheet.getSpriteById(0),
        size: Vector2.all(150),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 120),
      position: Vector2(0, 0),
    );

    player = FlowerPlayer(
      position: Vector2(size.x / 2, size.y - sizeOfPlayer.y),
      paint: Paint()..color = Color.fromARGB(255, 112, 100, 104),
      size: sizeOfPlayer,
      joystick: joystick,
    );

    await add(player);
    await add(DragComponent(moverIzquierda, moverDerecha)
      ..position = Vector2(0, size.y - 100)
      ..size = Vector2(size.x, 100));
  }

  @override
  void update(double dt) {
    if (children.isNotEmpty) {
      final Flower flower = children.query<Flower>().first;
      flower.position = Vector2(flower.position.x, size.y - sizeOfPlayer.y);
    }

    TiempoGenerarFigura += dt;

    if (TiempoGenerarFigura > 2) {
      var RanPos = Random();
      var RanFig = Random();

      switch (RanFig.nextInt(11)) {
        case 0:
          add(Proyector(
              position: Vector2(RanPos.nextDouble() * (size.x - 140), -80),
              size: Vector2(140, 80),
              paint: Paint()..color = Color.fromARGB(255, 138, 144, 138)));
          break;
        case 1:
          add(Pinguino(
              position: Vector2(RanPos.nextDouble() * (size.x - 40), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 2, 115, 195)));
          break;
        case 2:
          add(Caballito(
              position: Vector2(RanPos.nextDouble() * (size.x - 40), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Colors.brown));
          break;
        case 3:
          add(Libreta(
              position: Vector2(RanPos.nextDouble() * (size.x - 40), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 78, 0, 26)));
          break;
        case 4:
          add(Tractor(
              position: Vector2(RanPos.nextDouble() * (size.x - 120), -80),
              size: Vector2(120, 80),
              paint: Paint()..color = Color.fromARGB(255, 6, 142, 49)));
          break;
        case 5:
          add(Puerta(
              position: Vector2(RanPos.nextDouble() * (size.x - 140), -80),
              size: Vector2(140, 80),
              paint: Paint()..color = Color.fromARGB(255, 194, 151, 10)));
          break;
        case 6:
          add(Elefante(
              position: Vector2(RanPos.nextDouble() * (size.x - 140), -80),
              size: Vector2(140, 80),
              paint: Paint()..color = Color.fromARGB(255, 112, 112, 111)));
          break;
        case 7:
          add(Grillo(
              position: Vector2(RanPos.nextDouble() * (size.x - 40), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 23, 103, 23)));
          break;
          case 8:
          add(Mouse(
              position: Vector2(RanPos.nextDouble() * (size.x - 40), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 131, 102, 23)));
          break;
        case 9:
          add(Tree(
              position: Vector2(RanPos.nextDouble() * (size.x - 140), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 8, 161, 46)));
          break;
        case 10:
          add(Mochila(
              position: Vector2(RanPos.nextDouble() * (size.x - 140), -80),
              size: Vector2(40, 80),
              paint: Paint()..color = Color.fromARGB(255, 181, 8, 8)));
          break;
      }

      TiempoGenerarFigura = 0;
    }


    bool colProyector(FlowerPlayer player, Proyector figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool colPinguino(FlowerPlayer player, Pinguino figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool colCaballito(FlowerPlayer player, Caballito figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool colElefante(FlowerPlayer player, Elefante figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }

    bool colTractor(FlowerPlayer player, Tractor figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    
    bool colLibreta(FlowerPlayer player, Libreta figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    bool colPuerta(FlowerPlayer player, Puerta figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    bool colGrillo(FlowerPlayer player, Grillo figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    bool colMouse(FlowerPlayer player, Mouse figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    bool colTree(FlowerPlayer player, Tree figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }
    bool colMochila(FlowerPlayer player, Mochila figura) {
      Rect rectPlayer = Rect.fromLTWH(
          player.position.x, player.position.y, player.size.x, player.size.y);

      Rect rectFigura = Rect.fromLTWH(
          figura.position.x, figura.position.y, figura.size.x, figura.size.y);

      return rectPlayer.overlaps(rectFigura);
    }


    for (var figura in children.query<Proyector>()) {
      if (colProyector(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }

    for (var figura in children.query<Pinguino>()) {
      if (colPinguino(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }

    for (var figura in children.query<Caballito>()) {
      if (colCaballito(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }

    for (var figura in children.query<Elefante>()) {
      if (colElefante(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }

    for (var figura in children.query<Tractor>()) {
      if (colTractor(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
     for (var figura in children.query<Libreta>()) {
      if (colLibreta(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
     for (var figura in children.query<Puerta>()) {
      if (colPuerta(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
    for (var figura in children.query<Grillo>()) {
      if (colGrillo(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
    for (var figura in children.query<Mouse>()) {
      if (colMouse(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
    for (var figura in children.query<Tree>()) {
      if (colTree(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }
    for (var figura in children.query<Mochila>()) {
      if (colMochila(player, figura)) {
        children.remove(figura);
        score += 1;
        print(score);
      } else {
        figura.y += vel;
        if (figura.y > size.y) {
          children.remove(figura);
        }
      }
    }



    super.update(dt);
  }

 
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moverIzquierda();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moverDerecha();
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void moverIzquierda() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x -= 5;
    if (flower.position.x + flower.width < 0) {
      flower.position.x = size.x;
    }
  }

  void moverDerecha() {
    final Flower flower = children.query<Flower>().first;
    flower.position.x += 5;
    if (flower.position.x > size.x) {
      flower.position.x = -flower.size.x;
    }
  }
}