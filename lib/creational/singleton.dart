import 'dart:math';

/// 单例设计模式（Singleton Design Pattern）: 一个类只允许创建一个对象（或者叫实例），那这个类就是一个单例类，

/// 1. 懒汉模式： 创建单例，在类加载时，不创建实例。加载时速度较快，运行时获取实例速度较慢。
class LazySingleton {
  factory LazySingleton() => _shareInstance();

  LazySingleton._();

  static LazySingleton? _instance;

  static LazySingleton _shareInstance() {
    _instance ??= LazySingleton._();
    return _instance!;
  }
}

/// 2. 饿汉模式：在类加载时，直接进行实例的创建。加载时获取实例速度较慢，运行时速度较快。
class HungrySingleton {
  factory HungrySingleton() => _shareInstance();

  static final HungrySingleton _instance = HungrySingleton._();

  HungrySingleton._();

  static HungrySingleton _shareInstance() => _instance;
}

/// 单例使用场景
//
// 需要频繁实例化然后销毁的对象。
// 创建对象时耗时过多或者耗资源过多，但又经常用到的对象。
// 有状态的工具类对象。
// 频繁访问数据库或文件的对象。

/// 单例的风险
//
// 由于单例模式中没有抽象的层，因此扩展单例类是一件非常困难的事情。
// 滥用会带来很多负面问题：比如占用运行时资源，导致内存过限引发回收机制；长时间不使用可能会被错误的回收，导致状态丢失等。

/// 1. 处理多线程资源访问冲突

/// 2. 表示全局唯一类

class Logger {
  factory Logger() => _shareInstance();

  static Logger? _instance;

  Logger._();

  static Logger _shareInstance() {
    _instance ??= Logger._();
    return _instance!;
  }
}

/// 3. 双重检查 （futter不需要）
/* 饿汉式不支持延迟加载，懒汉式有性能问题，不支持高并发。
一种既支持延迟加载、又支持高并发的单例实现方式，也就是双重检测实现方式。
在对象创建之前加类锁 synchronized
*
public class IdGenerator {
  private AtomicLong id = new AtomicLong(0);
  private static IdGenerator instance;
  private IdGenerator() {}
  public static IdGenerator getInstance() {
    if (instance == null) {
      synchronized(IdGenerator.class) { // 此处为类级别的锁
        if (instance == null) {
          instance = new IdGenerator();
        }
      }
    }
    return instance;
  }
  public long getId() {
    return id.incrementAndGet();
  }
}
*
* */

/// 4.单例存在哪些问题?
/*
* /// 4.1. 单例对 OOP 特性的支持不友好
  /// 4.2. 单例会隐藏类之间的依赖关系
  /// 4.3. 单例对代码的扩展性不友好
  /// 4.4. 单例对代码的可测试性不友好
  /// 4.5. 单例不支持有参数的构造函数
* */

/// 5.单例有什么替代解决方案？
/*
* 为了保证全局唯一，除了使用单例，我们还可以用静态方法来实现。
* 如果单例类并没有后续扩展的需求，并且不依赖外部系统，那设计成单例类就没有太大问题。
* */

/// 6. 单利作用范围
/*
* 1. 进程内唯一， 进程之间不唯一，因为操作系统在创建一个新的进程时，是fork()创建的，会复制之前进程的所有代码
* 2. 线程内唯一： 可以在单利类新增一个静态字典，保存线程和对象的对应关系
* 3. 集群内唯一： 需要把这个单例对象序列化并存储到外部共享存储区（比如文件）。进程在使用这个单例对象的时候，需要先从外部共享存储区中将它读取到内存，并反序列化成对象，然后再使用，使用完成之后还需要再存储回外部共享存储区。
*
* */

/// 7. 如何实现一个多例模式（一个类可以创建多个对象，但是个数是有限制的）

class BackendServer {
  int _serverNo = 0;

  String _serverAddress = '';

  static final int _serverCount = 3;

  static final Map<int, BackendServer> _serverInstances = {
    1: BackendServer(1, '192.134.22.138:8080'),
    2: BackendServer(2, '192.134.22.139:8080'),
    3: BackendServer(3, '192.134.22.140:8080'),
  };

  BackendServer(int serverNo, String serverAddress) {
    _serverNo = serverNo;
    _serverAddress = serverAddress;
  }

  BackendServer getInstance(int serverNo) {
    return BackendServer._serverInstances[serverNo] ??= BackendServer(1, '192.134.22.138:8080');
  }

  BackendServer getRandomInstance() {
    var serverNo = Random().nextInt(BackendServer._serverCount) + 1;
    return getInstance(serverNo);
  }
}

class Multiton {
  static final Map<String, Multiton> instances = {};

  static Multiton getInstance(String loggerName) => instances[loggerName] ??= Multiton();
}

class Test {
  main() {
    Multiton l1 = Multiton.getInstance('carl');
    Multiton l2 = Multiton.getInstance('tom');
  }
}
