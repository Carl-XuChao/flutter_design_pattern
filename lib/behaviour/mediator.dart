import 'package:flutter/material.dart';

/// 中介模式 Mediator Design Pattern
/// 中介模式定义了一个单独的（中介）对象，来封装一组对象之间的交互。将这组对象之间的交互委派给与中介对象交互，来避免对象之间的直接交互。
///

/*
* 中介模式的设计思想跟中间层很像，通过引入中介这个中间层，将一组对象之间的交互关系（或者依赖关系）从多对多（网状关系）
* 转换为一对多（星状关系）。原来一个对象要跟 n 个对象交互，现在只需要跟一个中介对象交互，
* 从而最小化对象之间的交互关系，降低了代码的复杂度，提高了代码的可读性和可维护性。
* */

abstract class Mediator {
  void handleEvent(String event);
}

class LandingPageDialog implements Mediator {
  final TextButton loginButton;
  final TextButton regButton;
  final TextField usernameInput;
  final TextField passwordInput;

  LandingPageDialog(
    this.loginButton,
    this.regButton,
    this.usernameInput,
    this.passwordInput,
  );

  @override
  void handleEvent(String event) {
    if (event == 'login') {
    } else if (event == 'register') {}
  }
}

void _main() {}

/// 优点：原本业务逻辑会分散在各个控件中，现在都集中到了中介类中
/// 缺点：中介类有可能会变成大而复杂的“上帝类”（God Class）
