/// 工厂方法（Factory Method）
///
import 'simple.dart';

class _RuleConfigSource {
  RuleConfig? load(String ruleConfigFilePath) {
    /// 方法一： if匹配创建工厂对象
    // IRuleConfigParserFactory parserFactory = JsonRuleConfigParserFactory();
    // switch (ruleConfigFilePath) {
    //   case 'json':
    //     parserFactory = JsonRuleConfigParserFactory();
    //     break;
    //   case 'xml':
    //     parserFactory = XmlRuleConfigParserFactory();
    //     break;
    //   case 'yaml':
    //     parserFactory = YamlRuleConfigParserFactory();
    //     break;
    //   case 'properties':
    //     parserFactory = PropertiesRuleConfigParserFactory();
    //     break;
    // }

    /// 方法二： 缓存工厂对象
    IRuleConfigParserFactory? parserFactory =
        _RuleConfigParserFactoryMap.getParseFactory(ruleConfigFilePath);
    if (parserFactory == null) return null;

    IRuleConfigParser parser = parserFactory.createParser();

    String configText = '';
    RuleConfig config = parser.parse(configText);
    return config;
  }
}

class _RuleConfigParserFactoryMap {
  static final Map<String, IRuleConfigParserFactory> cachedFactories = {
    'json': JsonRuleConfigParserFactory(),
    'xml': XmlRuleConfigParserFactory(),
    'yaml': YamlRuleConfigParserFactory(),
    'properties': PropertiesRuleConfigParserFactory(),
  };

  static IRuleConfigParserFactory? getParseFactory(String type) {
    if (type.isEmpty) return null;
    return cachedFactories[type];
  }
}

abstract class IRuleConfigParserFactory {
  IRuleConfigParser createParser();
}

class JsonRuleConfigParserFactory extends IRuleConfigParserFactory {
  @override
  IRuleConfigParser createParser() {
    return JsonRuleConfigParser();
  }
}

class XmlRuleConfigParserFactory extends IRuleConfigParserFactory {
  @override
  IRuleConfigParser createParser() {
    return XmlRuleConfigParser();
  }
}

class YamlRuleConfigParserFactory extends IRuleConfigParserFactory {
  @override
  IRuleConfigParser createParser() {
    return YamlRuleConfigParser();
  }
}

class PropertiesRuleConfigParserFactory extends IRuleConfigParserFactory {
  @override
  IRuleConfigParser createParser() {
    return PropertiesRuleConfigParser();
  }
}

/// 那什么时候该用工厂方法模式，而非简单工厂模式呢？
/*
* 基于这个设计思想，当对象的创建逻辑比较复杂，不只是简单的 new 一下就可以，
* 而是要组合其他类对象，做各种初始化操作的时候，我们推荐使用工厂方法模式，
* 将复杂的创建逻辑拆分到多个工厂类中，让每个工厂类都不至于过于复杂。
* 而使用简单工厂模式，将所有的创建逻辑都放到一个工厂类中，会导致这个工厂类变得很复杂。
* */
