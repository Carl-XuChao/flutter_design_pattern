/// （Prototype Design Pattern），简称原型模式。
/*
* 如果对象的创建成本比较大，而同一个类的不同对象之间差别不大（大部分字段都相同），在这种情况下，
* 我们可以利用对已有对象（原型）进行复制（或者叫拷贝）的方式来创建新对象，以达到节省创建时间的目的。
* 这种基于原型来创建对象的方式就叫作原型设计模式
* */

/// 那何为“对象的创建成本比较大”？
/*
* 如果对象中的数据需要经过复杂的计算才能得到（比如排序、计算哈希值），
* 或者需要从 RPC、网络、数据库、文件系统等非常慢速的 IO 中读取，这种情况下，
* 我们就可以利用原型模式，从其他已有对象中直接拷贝得到，而不用每次在创建新对象的时候，都重复执行这些耗时的操作。
*  */

/// 原型模式的两种实现方法
/// 浅拷贝只会复制对象中基本数据类型数据和引用对象的内存地址，不会递归地复制引用对象，以及引用对象的引用对象……
/// 而深拷贝得到的是一份完完全全独立的对象。
/// 所以，深拷贝比起浅拷贝来说，更加耗时，更加耗内存空间。

/// 主要应用策略：拷贝对现有的对象， 对新增的数据进行赋值，避免了重新创新所有数据的时间浪费。

void _main() {
  a() {
    /// 数组的赋值操作只是浅拷贝，改变其中一个元素其他引用都会变化。
    final myList = ['sheep', 'cow'];
    final yourCopy = myList;
    yourCopy.remove('cow');
    print(myList); // [sheep]
    print(yourCopy); // [sheep]
  }

  b() {
    /// 不可变对象赋值时，只向了新的内存地址
    final myString = 'goat';
    var yourCopy = myString;
    yourCopy = 'camel';
    print(myString); // goat
    print(yourCopy); // camel
  }

  c() {
    /// toList() 只是深拷贝了数组，但是数组元素还是持有的引用对象地址。
    final myList = [
      ['sheep'],
      ['cow'],
    ];
    final yourCopy = myList.toList();
    yourCopy.removeLast();
    print(myList); // [[sheep], [cow]]
    print(yourCopy); // [[sheep]]

    yourCopy.first.first = 'goat';
    print(myList); // [[goat], [cow]]
    print(yourCopy); // [[goat]]
  }

  d() {
    /// 自定义深拷贝
    List<List<String>> deepCopy(List<List<String>> source) {
      return source.map((e) => e.toList()).toList();
    }

    final myList = [
      ['sheep'],
      ['cow'],
    ];
    final yourCopy = deepCopy(myList);
    yourCopy.removeLast();
    yourCopy.first.first = 'goat';
    print(myList); // [[sheep], [cow]]
    print(yourCopy); // [[goat]]
  }

  e() {
    /// 递归遍历对不可变对象（非基本数据类型）进行重新创建， 从而实现深拷贝
    final myList = [
      Person('Bob', 10),
      Person('Mary', 20),
    ];
    final yourCopy = myList.map((p) => Person.clone(p)).toList();
  }

  f() {
    /// Serializing and deserializing
    /// final yourCopy = jsonDecode(jsonEncode(myList));
    /// 本质上是从新生产的所有对象。所有类和属性都重新赋值了一遍。
  }
}

class Person {
  String? name;
  int? age;
  Person(this.name, this.age);
  factory Person.clone(Person source) {
    return Person(source.name, source.age);
  }
}
