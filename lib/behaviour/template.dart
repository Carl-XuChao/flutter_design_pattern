/// 模板方法设计模式，英文是 Template Method Design Pattern
/// 模板方法模式在一个方法中定义一个算法骨架，并将某些步骤推迟到子类中实现。
/// 模板方法模式可以让子类在不改变算法整体结构的情况下，重新定义算法中的某些步骤。

abstract class AbstractClass {
  void templateMethod() {
    // ...
    method1();
    // ...
    method2();
    // ...
  }

  void method1();

  void method2();
}

class ConcreteClass1 extends AbstractClass {
  @override
  void method1() {
    // TODO: implement method1
  }

  @override
  void method2() {
    // TODO: implement method2
  }
}

void _main() {
  AbstractClass demo = ConcreteClass1();
  demo.templateMethod();
}

/// 模板模式作用一：复用
/// 所有的子类可以复用父类中提供的模板方法的代码
/*
* 在 Java AbstractList 类中，addAll() 函数可以看作模板方法，add() 是子类需要重写的方法，
* 尽管没有声明为 abstract 的，但函数实现直接抛出了 UnsupportedOperationException 异常。
* 前提是，如果子类不重写是不能使用的。
* */

/// 模板模式作用二：扩展
/// 框架通过模板模式提供功能扩展点，让框架用户可以在不修改框架源码的情况下，基于扩展点定制化框架的功能
/*
*  这里所说的扩展，并不是指代码的扩展性，而是指框架的扩展性，有点类似我们之前讲到的控制反转
*  模板模式常用在框架的开发中，让框架用户可以在不修改框架源码的情况下，定制化框架的功能。
* */

/// 回调： 回调是一种双向调用关系。
/// A 类事先注册某个函数 F 到 B 类，A 类在调用 B 类的 P 函数的时候，B 类反过来调用 A 类注册给它的 F 函数。
/// 这里的 F 函数就是“回调函数”。A 调用 B，B 反过来又调用 A，这种调用机制就叫作“回调”。

class AClass {
  void _main() {
    callback(String res) {
      print("callback: $res");
    }

    BClass b = BClass();

    b.process(callback);
  }
}

class BClass {
  void process(Function(String) callback) {
    callback.call("success");
  }
}

/// 模板模式 VS 回调

/*
* 1.从应用场景上来看，同步回调跟模板模式几乎一致。
*  它们都是在一个大的算法骨架中，自由替换其中的某个步骤，起到代码复用和扩展的目的。
*  而异步回调跟模板模式有较大差别，更像是观察者模式。
* */

/*
* 从代码实现上来看，回调和模板模式完全不同。回调基于组合关系来实现，把一个对象传递给另一个对象，是一种对象之间的关系；
* 模板模式基于继承关系来实现，子类重写父类的抽象方法，是一种类之间的关系。
* */
