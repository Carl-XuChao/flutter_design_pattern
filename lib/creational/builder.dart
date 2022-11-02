import 'dart:math';

/// 建造者模式

/* 应用场景
* 如果一个类中有很多属性，为了避免构造函数的参数列表过长，影响代码的可读性和易用性，
* 我们可以通过构造函数配合 set() 方法来解决。但是，如果存在下面情况中的任意一种，我们就要考虑使用建造者模式了。
* 1.如果必填的配置项有很多，把这些必填配置项都放到构造函数中设置，那构造函数就又会出现参数列表很长的问题
* 2.假设配置项之间有一定的依赖关系，比如，如果用户设置了 maxTotal、maxIdle、minIdle 其中一个，就必须显式地设置另外两个；或者配置项之间有一定的约束条件，
* 3.希望创建类对象是不可变对象，也就是说，对象在创建好之后，就不能再修改内部的属性值。
* */

class ResourcePoolConfig {
  final String name;

  final int maxTotal;

  final int maxIdle;

  final int minIdle;

  /// 构造函数方法创建对象
  ResourcePoolConfig(
    this.name,
    this.maxIdle,
    this.maxTotal,
    this.minIdle,
  );

  /// 建造者模式
  static ResourcePoolConfig builder(Builder builder) {
    return ResourcePoolConfig(
      builder.name,
      builder.maxIdle,
      builder.maxTotal,
      builder.minIdle,
    );
  }
}

class Builder {
  String _name = '';

  String get name => _name;

  set name(String value) {
    if (value.isEmpty) {
      _name = value;
    }
  }

  int _maxTotal = 8;

  int get maxTotal => _maxTotal;

  set maxTotal(int value) {
    _maxTotal = min(value, _maxIdle);
  }

  int _maxIdle = 8;

  int get maxIdle => _maxIdle;

  set maxIdle(value) => _maxIdle = value;

  int _minIdle = 0;

  int get minIdle => _minIdle;

  set minIdle(value) => _minIdle = value;

  ResourcePoolConfig build() {
    // TODO: 必要的参数校验和依赖工作
    // set方法做了部分校验依赖逻辑
    return ResourcePoolConfig.builder(this);
  }
}

void _main() {
  Builder builder = Builder()
    ..name = 'carl'
    ..maxTotal = 15;
  ResourcePoolConfig config = builder.build();
}

/// 总结
/// 与工厂模式有何区别？
/*
* 1.工厂模式是用来创建不同但是相关类型的对象（继承同一父类或者接口的一组子类），由给定的参数来决定创建哪种类型的对象。
* 2.建造者模式是用来创建一种类型的复杂对象，通过设置不同的可选参数，“定制化”地创建不同的对象。
* */
