/// 依赖注入框架，或者叫依赖注入容器（Dependency Injection Container），简称 DI 容器。
/// DI 容器底层最基本的设计思路就是基于工厂模式的。
/// DI 容器相当于一个大的工厂类，负责在程序启动的时候，
/// 根据配置（要创建哪些类对象，每个类对象的创建需要依赖哪些其他类对象）事先创建好对象。
/// 当应用程序需要使用某个类对象的时候，直接从容器中获取即可。
/// 正是因为它持有一堆对象，所以这个框架才被称为“容器”。

/// 1. 配置解析
/// 容器读取配置文件，根据配置文件提供的信息来创建对象。

// json配置文件
const configData = {
  {
    "id": "rateLimiter",
    "class": "com.xzg.RateLimiter",
    "arg": [
      {"ref": "redisCounter"}
    ],
  },
  {
    "id": "redisCounter",
    "class": "com.xzg.redisCounter",
    "arg": [
      {
        "type": "int",
        "value": 1234,
      },
      {
        "type": "String",
        "value": "127.0.0.1",
      },
    ],
  }
};

void _main() {
  ApplicationContext applicationContext = ClassPathXmlApplicationContext("beans.json");
  RateLimiter rateLimiter = applicationContext.getBean('rateLimiter') as RateLimiter;
  rateLimiter.test();
}

class RateLimiter {
  final RedisCounter redisCounter;

  RateLimiter(RedisCounter counter) : redisCounter = counter;

  void test() {}
}

class RedisCounter {
  final String ipAddress;

  final int port;

  RedisCounter(this.ipAddress, this.port);
}

/// 2. 对象创建
/// 我们只需要将所有类对象的创建都放到一个工厂类中完成就可以了，比如 BeansFactory。

class BeansFactory {
  /*
  * DI 容器的具体实现的时候，我们会讲“反射”这种机制，
  * 它能在程序运行的过程中，动态地加载类、创建对象，
  * 不需要事先在代码中写死要创建哪些对象。
  * 所以，不管是创建一个对象还是十个对象，
  * BeansFactory 工厂类代码都是一样的。
  * */

  Map<String, Object> _singletonObjects = {};

  Map<String, BeanDefinition> _beanDefinitions = {};

  void addBeanDefinitions(List<BeanDefinition> beanDefinitionList) {
    for (var e in beanDefinitionList) {
      _beanDefinitions.putIfAbsent(e.id, () => e);
    }
    for (var e in beanDefinitionList) {
      if (!e.lazyInit && e.isSingleton) {
        createBean(e);
      }
    }
  }

  Object createBean(BeanDefinition beanDefinition) {
    // TODO: implement createBean
    if (beanDefinition.isSingleton && _singletonObjects[beanDefinition.id] != null) {
      return _singletonObjects[beanDefinition.id]!;
    }

    // 使用反射创建对象和属性
    throw UnimplementedError();
  }

  Object getBean(String beanId) {
    BeanDefinition? beanDefinition = _beanDefinitions[beanId];
    if (beanDefinition == null) throw UnimplementedError();
    return createBean(beanDefinition);
  }
}

/// 3. 生命周期
/// 配置对象是否支持懒加载
/// 配置对象的 init-method 和 destroy-method 方法

/// 4. 如何实现一个简单的DI容器

abstract class ApplicationContext {
  Object getBean(String beanId);
}

class ClassPathXmlApplicationContext implements ApplicationContext {
  final BeansFactory _beansFactory;

  final BeanConfigParser _beanConfigParser;

  ClassPathXmlApplicationContext(String configLocation)
      : _beansFactory = BeansFactory(),
        _beanConfigParser = BeanConfigParser() {
    loadBeanDefinitions(configLocation);
  }

  void loadBeanDefinitions(String configLocation) {
    List<BeanDefinition> beanDefinition = _beanConfigParser.parse(configLocation);
    _beansFactory.addBeanDefinitions(beanDefinition);
  }

  @override
  Object getBean(String beanId) {
    return _beansFactory.getBean(beanId);
  }
}

class BeanConfigParser {
  List<BeanDefinition> parse(String configContent) {
    return <BeanDefinition>[];
  }
}

class BeanDefinition {
  final String id;

  final String className;

  bool lazyInit = false;

  bool isSingleton = false;

  final List<ConstructorArg> constructorArgs;

  BeanDefinition(
    this.id,
    this.className,
    this.constructorArgs,
    this.lazyInit,
    this.isSingleton,
  );
}

class ConstructorArg {
  final bool isRef;
  final Object type;
  final Object value;

  ConstructorArg(this.type, this.value, this.isRef);
}
