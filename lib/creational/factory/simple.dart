/// 简单工厂方法
/*
在下面这段代码中，我们根据配置文件的后缀（json、xml、yaml、properties），
选择不同的解析器（JsonRuleConfigParser、XmlRuleConfigParser……），
将存储在文件中的配置解析成内存对象 RuleConfig。
* */

class RuleConfigSource {
  RuleConfig load(String ruleConfigFilePath) {
    IRuleConfigParser parser = RuleConfigParserFactory.createParser(ruleConfigFilePath);
    String configText = '';
    RuleConfig config = parser.parse(configText);
    return config;
  }
}

class RuleConfig {
  final String configText;

  RuleConfig(String config) : configText = config;
}

class RuleConfigParserFactory {
  /// 方法一： if 分支匹配
  static IRuleConfigParser createParser(String configFormat) {
    IRuleConfigParser parser = DefaultRuleConfigParser();
    switch (configFormat) {
      case 'json':
        parser = JsonRuleConfigParser();
        break;
      case 'xml':
        parser = XmlRuleConfigParser();
        break;
      case 'yaml':
        parser = YamlRuleConfigParser();
        break;
      case 'properties':
        parser = PropertiesRuleConfigParser();
        break;
    }
    return parser;
  }

  /// 方法二： 事先创建好缓存起来使用
  // static IRuleConfigParser? createParser(String configFormat) {
  //   return _cashedParsers[configFormat];
  // }

  static final Map<String, IRuleConfigParser> _cashedParsers = {
    'json': JsonRuleConfigParser(),
    'xml': XmlRuleConfigParser(),
    'yaml': YamlRuleConfigParser(),
    'properties': PropertiesRuleConfigParser(),
  };
}

class IRuleConfigParser {
  RuleConfig parse(String config) => RuleConfig(config);
}

class DefaultRuleConfigParser extends IRuleConfigParser {
  @override
  RuleConfig parse(String config) {
    // TODO: implement parse
    return super.parse(config);
  }
}

class JsonRuleConfigParser extends IRuleConfigParser {
  @override
  RuleConfig parse(String config) {
    // TODO: implement parse
    return super.parse(config);
  }
}

class XmlRuleConfigParser extends IRuleConfigParser {
  @override
  RuleConfig parse(String config) {
    // TODO: implement parse
    return super.parse(config);
  }
}

class YamlRuleConfigParser extends IRuleConfigParser {
  @override
  RuleConfig parse(String config) {
    // TODO: implement parse
    return super.parse(config);
  }
}

class PropertiesRuleConfigParser extends IRuleConfigParser {
  @override
  RuleConfig parse(String config) {
    // TODO: implement parse
    return super.parse(config);
  }
}
