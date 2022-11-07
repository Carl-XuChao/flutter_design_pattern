/// 命令模式 Command Design Pattern
/// 命令模式将请求（命令）封装为一个对象，这样可以使用不同的请求参数化其他对象（将不同请求依赖注入到其他对象），
/// 并且能够支持请求（命令）的排队执行、记录日志、撤销等（附加控制）功能。

abstract class Command {
  void execute();
}

class GotDiamondCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }
}

class GotStartCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }
}

class HitObstacleCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }
}

class ArchiveCommand implements Command {
  @override
  void execute() {
    // TODO: implement execute
  }
}

void _main() {
  List<Command> queue = [];
  List<String> reqests = ['get', 'post', 'put', 'delete', 'head'];
  for (String req in reqests) {
    if (req == 'get') {
      queue.add(GotDiamondCommand());
    } else if (req == 'post') {
      queue.add(GotStartCommand());
    } else if (req == 'put') {
      queue.add(HitObstacleCommand());
    } else if (req == 'delete') {
      queue.add(ArchiveCommand());
    } else {}
  }

  while (queue.isNotEmpty) {
    Command cmd = queue.removeLast();
    cmd.execute();
  }
}

/// 在策略模式中，不同的策略具有相同的目的、不同的实现、互相之间可以替换。
/// 而在命令模式中，不同的命令具有不同的目的，对应不同的处理逻辑，并且互相之间不可替换。
/// 命令模式用到最核心的实现手段，就是将函数封装成对象。
/// 命令模式的主要作用和应用场景，是用来控制命令的执行，比如，异步、延迟、排队执行命令、撤销重做命令、存储命令、给命令记录日志等等，这才是命令模式能发挥独一无二作用的地方。
