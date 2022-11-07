/// 状态模式
/// 状态模式一般用来实现状态机，而状态机常用在游戏、工作流引擎等系统开发中。不过，状态机的实现方式有多种，除了状态模式，比较常用的还有分支逻辑法和查表法。
/// TODO: https://bloclibrary.dev/#/coreconcepts

/* 什么是有限状态机？
*  状态机有 3 个组成部分：状态（State）、事件（Event）、动作（Action）。其中，事件也称为转移条件（Transition Condition）。
*  事件触发状态的转移及动作的执行。
* */

/// e.g
/*
*   在游戏中，马里奥可以变身为多种形态，比如小马里奥（Small Mario）、超级马里奥（Super Mario）、火焰马里奥（Fire Mario）、斗篷马里奥（Cape Mario）等等。在不同的游戏情节下，各个形态会互相转化，并相应的增减积分。比如，初始形态是小马里奥，吃了蘑菇之后就会变成超级马里奥，并且增加 100 积分。
* */

/// 第一种实现方式叫分支逻辑法。利用 if-else 或者 switch-case 分支逻辑，参照状态转移图，将每一个状态转移原模原样地直译成代码。
/// 对于简单的状态机来说，这种实现方式最简单、最直接，是首选。

enum MaliAoState {
  small,
  big,
  fire,
  cape,
}

class State {
  final MaliAoState state;
  final int score;

  State(this.state, this.score);
}

class MarioStateMachine {
  MaliAoState currentState;
  int score;

  MarioStateMachine(this.currentState, this.score);

  /// 获得蘑菇
  void obtainMushRoom() {
    if (currentState == MaliAoState.small) {
      currentState = MaliAoState.big;
      score += 100;
    }
  }

  void obtainFireFlower() {
    if (currentState == MaliAoState.small || currentState == MaliAoState.big) {
      currentState = MaliAoState.fire;
      score += 300;
    }
  }

  /// 获得水仙花
  void obtainCape() {
    if (currentState == MaliAoState.small || currentState == MaliAoState.big) {
      currentState = MaliAoState.fire;
      score += 300;
    }
  }

  /// 遇到怪兽
  void meetMonster() {
    if (currentState == MaliAoState.big) {
      currentState = MaliAoState.small;
      score -= 100;
      return;
    }

    if (currentState == MaliAoState.cape) {
      currentState = MaliAoState.small;
      score -= 200;
    }

    if (currentState == MaliAoState.fire) {
      currentState = MaliAoState.small;
      score -= 300;
    }
  }
}

/// 第二种实现方式叫查表法。对于状态很多、状态转移比较复杂的状态机来说，查表法比较合适。
/// 通过二维数组来表示状态转移图，能极大地提高代码的可读性和可维护性。

enum MaliAoEvent {
  obtainMushRoom,
  obtainCape,
  obtFire,
  meetMonster,
}

class MarioStateMachineOne {
  MaliAoState currentState;
  int score;

  MarioStateMachineOne(this.currentState, this.score);

  List<List<MaliAoState>> transitionTable = [
    [MaliAoState.big, MaliAoState.cape, MaliAoState.fire, MaliAoState.small],
    [MaliAoState.big, MaliAoState.cape, MaliAoState.fire, MaliAoState.small],
    [MaliAoState.cape, MaliAoState.cape, MaliAoState.cape, MaliAoState.small],
    [MaliAoState.fire, MaliAoState.fire, MaliAoState.fire, MaliAoState.small],
  ];

  List<List<int>> actionTable = [
    [100, 200, 300, 0],
    [0, 200, 300, -100],
    [0, 0, 0, -200],
    [0, 0, 0, -300],
  ];

  void obtainMushRoom() {
    executeEvent(MaliAoEvent.obtainMushRoom);
  }

  void obtainCape() {
    executeEvent(MaliAoEvent.obtainCape);
  }

  void obtainFireFlower() {
    executeEvent(MaliAoEvent.obtFire);
  }

  void meetMonster() {
    executeEvent(MaliAoEvent.meetMonster);
  }

  void executeEvent(MaliAoEvent event) {
    int stateValue = MaliAoState.values.indexOf(currentState);
    int eventValue = MaliAoEvent.values.indexOf(event);

    currentState = transitionTable[stateValue][eventValue];
    score += actionTable[stateValue][eventValue];
  }
}

/// 第三种实现方式叫状态模式。对于状态并不多、状态转移也比较简单，
/// 但事件触发执行的动作包含的业务逻辑可能比较复杂的状态机来说，我们首选这种实现方式。

abstract class IMario {
  MaliAoState state();
  //以下是定义的事件
  void obtainMushRoom(MarioStateMachineTwo stateMachine);
  void obtainCape(MarioStateMachineTwo stateMachine);
  void obtainFireFlower(MarioStateMachineTwo stateMachine);
  void meetMonster(MarioStateMachineTwo stateMachine);
}

class MarioFactory {
  static final Map<MaliAoState, IMario> _marioInstances = {
    MaliAoState.small: SmallMario(),
    MaliAoState.big: SuperMario(),

    /// ...
  };

  static IMario getMario(MaliAoState state) {
    return _marioInstances[state] ?? _marioInstances[MaliAoState.small]!;
  }
}

class SmallMario implements IMario {
  @override
  MaliAoState state() {
    return MaliAoState.small;
  }

  @override
  void meetMonster(MarioStateMachineTwo stateMachine) {
    stateMachine.currentState = MarioFactory.getMario(MaliAoState.big);
    stateMachine.score += 100;
  }

  @override
  void obtainCape(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainCape
  }

  @override
  void obtainFireFlower(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainFireFlower
  }

  @override
  void obtainMushRoom(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainMushRoom
  }
}

class SuperMario implements IMario {
  @override
  void meetMonster(MarioStateMachineTwo stateMachine) {
    // TODO: implement meetMonster
  }

  @override
  void obtainCape(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainCape
  }

  @override
  void obtainFireFlower(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainFireFlower
  }

  @override
  void obtainMushRoom(MarioStateMachineTwo stateMachine) {
    // TODO: implement obtainMushRoom
  }

  @override
  MaliAoState state() {
    return MaliAoState.big;
  }
}

class MarioStateMachineTwo {
  IMario currentState;
  int score;

  MarioStateMachineTwo(this.currentState, this.score);

  void obtainMushRoom() {
    currentState.obtainMushRoom(this);
  }

  void obtainCape() {
    currentState.obtainCape(this);
  }

  void obtainFireFlower() {
    currentState.obtainFireFlower(this);
  }

  void meetMonster() {
    currentState.meetMonster(this);
  }
}
