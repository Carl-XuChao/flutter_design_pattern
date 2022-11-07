/// 备忘录模式，Memento Design Pattern
/// 在不违背封装原则的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态，以便之后恢复对象为先前的状态。
///

class InputText {
  String _text = '';

  void append(String input) {
    _text += input;
  }

  /// 创建备份
  Snapshot createSnapshot() {
    return Snapshot(_text);
  }

  /// 从备份中恢复
  void restoreSnapshot(Snapshot snapshot) {
    _text = snapshot.text;
  }
}

class Snapshot {
  String text = '';

  Snapshot(this.text);
}

class SnapshotHolder {
  final List<Snapshot> stack = [];

  Snapshot popSnapShot() {
    return stack.removeLast();
  }

  void pushSnapshot(Snapshot snapshot) {
    stack.add(snapshot);
  }
}

void _main() {
  InputText inputText = InputText();
  SnapshotHolder snapshotHolder = SnapshotHolder();
  Scanner scanner = Scanner();
  while (scanner.hasNext()) {
    String input = scanner.next();
    if (input == 'show') {
      print(inputText._text);
    } else if (input == 'undo') {
      Snapshot snapshot = snapshotHolder.popSnapShot();
      inputText.restoreSnapshot(snapshot);
    } else {
      snapshotHolder.pushSnapshot(inputText.createSnapshot());
      inputText.append(input);
    }
  }
}

/// mock 用户输入数据类
class Scanner {
  String next() {
    return '1';
  }

  bool hasNext() {
    return true;
  }
}

/*
* 对于大对象的备份来说，备份占用的存储空间会比较大，备份和恢复的耗时会比较长。
* 针对这个问题，不同的业务场景有不同的处理方式。比如，只备份必要的恢复信息，结合最新的数据来恢复；
* 再比如，全量备份和增量备份相结合，低频全量备份，高频增量备份，两者结合来做恢复。
* */

/// 增量备份实现方式
/*
* 可以用两个栈来记录操作， 一个是正向操作栈， 一个是撤销操作栈
* */
