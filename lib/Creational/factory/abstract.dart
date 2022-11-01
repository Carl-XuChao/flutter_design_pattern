/// 抽象工厂

abstract class _IConfigParserFactory {
  IRuleConfigParser createRuleParser();
  ISystemConfigParser createSystemParser();
}

class IRuleConfigParser {}

class ISystemConfigParser {}

class JsonConfigParserFactory implements _IConfigParserFactory {
  @override
  IRuleConfigParser createRuleParser() {
    return JsonRuleConfigParser();
  }

  @override
  ISystemConfigParser createSystemParser() {
    return JsonSystemConfigParser();
  }
}

class JsonRuleConfigParser extends IRuleConfigParser {}

class JsonSystemConfigParser extends ISystemConfigParser {}

/// 对象的创建有多个纬度，使用抽象工厂可以减少类的个数
/*
*  如果类有两种分类方式，比如，我们既可以按照配置文件格式来分类，也可以按照解析的对象（Rule 规则配置还是 System 系统配置）来分类，那就会对应下面这 8 个 parser 类。
*  我们可以让一个工厂负责创建多个不同类型的对象（IRuleConfigParser、ISystemConfigParser 等）
* ，而不是只创建一种 parser 对象。这样就可以有效地减少工厂类的个数。
* */

/// 判断要不要使用工厂模式的最本质的参考标准。
/*
*封装变化：创建逻辑有可能变化，封装成工厂类之后，创建逻辑的变更对调用者透明。
* 代码复用:创建代码抽离到独立的工厂类之后可以复用。
* 隔离复杂性：封装复杂的创建逻辑，调用者无需了解如何创建对象。
* 控制复杂度：将创建代码抽离出来，让原本的函数或类职责更单一，代码更简洁。
* */

/// 工厂方法使用区分
/// 1. 当每个类的创建过程比较简单时， 推荐使用工厂模式
/// 2. 当每个对象的创建逻辑都比较复杂的时候，为了避免设计一个过于庞大的简单工厂类，我推荐使用工厂方法模式，将创建逻辑拆分得更细，每个对象的创建逻辑独立到各自的工厂类中。
/// 3. 尽管我们不需要根据不同的类型创建不同的对象，但是，单个对象本身的创建过程比较复杂，比如前面提到的要组合其他类对象，做各种初始化操作。建议使用工厂方法模式。
