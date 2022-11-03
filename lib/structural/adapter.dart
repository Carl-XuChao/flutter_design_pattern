/// 适配器模式(Adapter Design Pattern)
/// 它将不兼容的接口转换为可兼容的接口，让原本由于接口不兼容而不能一起工作的类可以一起工作。
/// 适配器模式有两种实现方式：类适配器和对象适配器。其中，类适配器使用继承关系来实现，对象适配器使用组合关系来实现。
///

/// 5 种使用场景：
/// 封装有缺陷的接口设计
/// 统一多个类的接口设计
/// 替换依赖的外部系统
/// 兼容老版本接口
/// 适配不同格式的数据

abstract class ITarget {
  void f1();
  void f2();
  void f3();
}

class Adaptee {
  void fa() {}

  void fb() {}

  void fc() {}
}

/// 类适配器: 基于继承
class Adaptor extends Adaptee implements ITarget {
  @override
  void f1() {
    super.fa();
  }

  @override
  void f2() {
    //...重新实现f2()...
  }

  @override
  void f3() {
    // 这里f3()不需要实现，直接继承自Adaptee，这是跟对象适配器最大的不同点
  }
}

/// 对象适配器：基于组合
class ObjAdaptor implements ITarget {
  final Adaptee adaptee;

  ObjAdaptor(this.adaptee);

  @override
  void f1() {
    adaptee.fa();
  }

  @override
  void f2() {
    // TODO: implement f2
  }

  @override
  void f3() {
    // TODO: 其他
    adaptee.fc();
  }
}
