/// 代理模式：在不改变原始类（或叫被代理类）代码的情况下，通过引入代理类来给原始类附加功能。
///

/*
* 开发了一个 MetricsCollector 类，用来收集接口请求的原始数据，
* 比如访问时间、处理时长等。在业务系统中，
* 我们采用如下方式来使用这个 MetricsCollector 类：
* */

/// 统计请求响应时间功能
class MetricsCollector {
  void recordRequest(double responseTime) {
    print("记录请求信息");
  }
}

/// 1. 原始业务与其他功能耦合的代码
class DefaultUserController {
  /// 这种写法存在两个问题：
  ///
  /// 第一，性能计数器框架代码侵入到业务代码中，跟业务代码高度耦合。如果未来需要替换这个框架，那替换的成本会比较大。
  ///
  /// 第二，收集接口请求的代码跟业务代码无关，本就不应该放到一个类中。业务类最好职责更加单一，只聚焦业务处理。

  final MetricsCollector metricsCollector;

  DefaultUserController(this.metricsCollector);

  void login() {
    double startTimestamp = 0;

    //TODO: ... 省略login逻辑...

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }

  void register() {
    double startTimestamp = 0;

    //TODO: ... register...

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }
}

abstract class IUserController {
  void login();

  void register();
}

class UserController implements IUserController {
  @override
  void login() {
    // TODO: implement login
  }

  @override
  void register() {
    // TODO: implement register
  }
}

/// 2. 方法一： 基于组合的方式实现代理
/// 参照基于接口而非实现编程的设计思想，将原始类对象替换为代理类对象的时候，
/// 为了让代码改动尽量少，在刚刚的代理模式的代码实现中，代理类和原始类需要实现相同的接口。
class UserControllerProxy implements IUserController {
  final MetricsCollector metricsCollector;

  final UserController userController;

  UserControllerProxy(this.metricsCollector, this.userController);

  @override
  void login() {
    double startTimestamp = 0;

    /// 登录业务实现方法
    userController.login();

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }

  @override
  void register() {
    double startTimestamp = 0;

    /// 注册业务实现方法
    userController.register();

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }
}

/// 3. 方法二： 基于继承方式来实现代理
/// 对于这种外部类的扩展，我们一般都是采用继承的方式。这里也不例外。
/// 我们让代理类继承原始类，然后扩展附加功能。

class UserControllerProxyByInherit extends UserController {
  final MetricsCollector metricsCollector;

  UserControllerProxyByInherit(this.metricsCollector);

  @override
  void login() {
    double startTimestamp = 0;

    /// 登录业务实现方法
    super.login();

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }

  @override
  void register() {
    double startTimestamp = 0;

    /// 注册业务实现方法
    super.register();

    double endTimeStamp = 1000;
    double responseTime = endTimeStamp - startTimestamp;
    metricsCollector.recordRequest(responseTime);
  }
}

/// 4. 动态代理（flutter不支持）
/// swift的kvo就是典型的动态代理实现，系统对被观察对象创建代理对象， 在代理对象中做监听逻辑
/*
* 所谓动态代理（Dynamic Proxy），就是我们不事先为每个原始类编写代理类，
* 而是在运行的时候，动态地创建原始类对应的代理类，然后在系统中用代理类替换掉原始类。
* */

/// 5. 代理模式的应用场景
/*
*代理模式常用在业务系统中开发一些非功能性需求，比如：监控、统计、鉴权、限流、事务、幂等、日志。
* 我们将这些附加功能与业务功能解耦，放到代理类统一处理，让程序员只需要关注业务方面的开发。
* 除此之外，代理模式还可以用在 RPC、缓存等应用场景中。
* */
