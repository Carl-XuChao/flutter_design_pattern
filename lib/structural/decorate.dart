/// 装饰器模式(Decorator Pattern)
/// 装饰器模式主要解决继承关系过于复杂的问题，通过组合来替代继承。它主要的作用是给原始类添加增强功能。这也是判断是否该用装饰器模式的一个重要的依据
/// 第一个比较特殊的地方是：装饰器类和原始类继承同样的父类，这样我们可以对原始类“嵌套”多个装饰器类
/// 第二个比较特殊的地方是：装饰器类是对功能的增强，这也是装饰器模式应用场景的一个重要特点
/// 代理模式中，代理类附加的是跟原始类无关的功能，而在装饰器模式中，装饰器类附加的是跟原始类相关的增强功能。
/// 主要提现： 单一职责、组合优先于继承原则

/// e.g Java IO 类库: InputStream

abstract class InputStream {
  void read(String data) {}
}

/// FileInputStream 作用是实现通用的方法，
/// 其他装饰器子类只需要实现特定功能就好了
class FileInputStream extends InputStream {
  @override
  void read(String data) {
    // TODO: implement read
    print(data);
  }
}

class DataInputStream extends FileInputStream {
  final InputStream input;

  DataInputStream(this.input);

  @override
  void read(String data) {
    print("DataInputStream");
    //TODO： 功能增强
    input.read(data);
    //TODO： 功能增强
  }
}

class BufferedInputStream implements FileInputStream {
  final InputStream input;

  BufferedInputStream(this.input);

  @override
  void read(String data) {
    print("BufferedInputStream");
    //TODO： 功能增强
    input.read(data);
    //TODO： 功能增强
  }
}

void _main() {
  InputStream inputStream = FileInputStream();
  DataInputStream dataIn = DataInputStream(inputStream);
  BufferedInputStream bufferIn = BufferedInputStream(dataIn);

  bufferIn.read('hello, world');
}
