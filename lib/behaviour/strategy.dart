/// 策略模式，英文全称是 Strategy Design Pattern
/// 定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。
/// 策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。

/* 策略模式用来解耦策略的定义、创建、使用。实际上，一个完整的策略模式就是由这三个部分组成的。
* 策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。
* 策略的创建由工厂类来完成，封装策略创建的细节。
* 策略模式包含一组策略可选，客户端代码如何选择使用哪个策略，有两种确定方法：编译时静态确定和运行时动态确定。其中，“运行时动态确定”才是策略模式最典型的应用场景。
* */

abstract class Strategy {
  void algorithmInterface();
}

class ConcreteStrategyA implements Strategy {
  @override
  void algorithmInterface() {
    // TODO: implement algorithmInterface
  }
}

class ConcreteStrategyB implements Strategy {
  @override
  void algorithmInterface() {
    // TODO: implement algorithmInterface
  }
}

class StrategyFactory {
  static final Map<String, Strategy> strategies = {
    'A': ConcreteStrategyA(),
    'B': ConcreteStrategyB(),
  };

  static Strategy? getStrategy(String type) {
    return strategies[type];
  }
}

void _main() {
  String type = 'A';
  Strategy? strategy = StrategyFactory.getStrategy(type);
  strategy?.algorithmInterface();
}

/// e.g 对文件(只包含数字)内容进行排序
///
///

class Sorter {
  final double gb = 1000 * 1000 * 1000;

  void sortFile(String filePath) {
    double fileSize = 100000;
    if (fileSize < 6 * gb) {
      quickSort(filePath);
    } else if (fileSize < 10 * gb) {
      externalSort(filePath);
    } else if (fileSize < 100 * gb) {
      concurrentExternalSort(filePath);
    } else {
      mapreduceSort(filePath);
    }
  }

  void quickSort(String filePath) {
    // 快速排序
  }

  void externalSort(String filePath) {
    // 外部排序
  }

  void concurrentExternalSort(String filePath) {
    // 多线程外部排序
  }
  void mapreduceSort(String filePath) {
    // 利用MapReduce多机排序
  }
}

/// 优化方案
/// 策略可以使用工厂模式进行创建
/// 策略匹配方法可以采用反射的方式， 去掉一堆if else的匹配
