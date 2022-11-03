/// 享元模式（Flyweight Design Pattern）
/// 享元模式的意图是复用对象，节省内存，前提是享元对象是不可变对象。
///

/* e.g
* 假设我们在开发一个棋牌游戏（比如象棋）。一个游戏厅中有成千上万个“房间”，每个房间对应一个棋局。
* 棋局要保存每个棋子的数据，比如：棋子类型（将、相、士、炮等）、棋子颜色（红方、黑方）、
* 棋子在棋局中的位置。利用这些数据，我们就能显示一个完整的棋盘给玩家。
* 具体的代码如下所示。其中，ChessPiece 类表示棋子，ChessBoard 类表示一个棋局，
* 里面保存了象棋中 30 个棋子的信息。
* */

enum Color {
  red,
  black,
}

/// 棋子
class MyChessPiece {
  final int id;

  final String text;

  final Color color;

  final int positionX;

  final int positionY;

  MyChessPiece(this.id, this.text, this.color, this.positionX, this.positionY);
}

/// 棋盘
class MyChessBoard {
  final Map<int, MyChessPiece> chessPieces = {};

  MyChessBoard() {
    init();
  }

  void init() {
    // TODO: 初始化摆默认棋子, 省略其他棋子创建过程。。。
    chessPieces.putIfAbsent(1, () => MyChessPiece(1, "车", Color.black, 0, 0));
    chessPieces.putIfAbsent(2, () => MyChessPiece(2, "马", Color.black, 0, 1));
  }
}

/// ，在内存中会有大量的相似对象。这些相似对象的 id、text、color 都是相同的，唯独 positionX、positionY 不同。
/// 实际上，我们可以将棋子的 id、text、color 属性拆分出来，设计成独立的类，并且作为享元供多个棋盘复用。

/// 棋子享元类
class ChessPieceUnit {
  final int id;

  final String text;

  final Color color;

  ChessPieceUnit(this.id, this.text, this.color);
}

/// 享元工厂类，通过缓存复用享元棋子类
class ChessPieceUnitFactory {
  static final Map<int, ChessPieceUnit> pieces = {
    1: ChessPieceUnit(1, "车", Color.black),
    2: ChessPieceUnit(1, "马", Color.black),
    // TODO: 省略其他棋子创建过程。。。
  };

  static ChessPieceUnit getChess(int chessPieceId) {
    return pieces[chessPieceId]!;
  }
}

class ChessPiece {
  final ChessPieceUnit chessPieceUnit;

  final int positionX;

  final int positionY;

  ChessPiece(this.chessPieceUnit, this.positionX, this.positionY);
}

class ChessBoard {
  final Map<int, ChessPiece> chessPieces = {};

  ChessBoard() {
    init();
  }

  void init() {
    chessPieces[1] = ChessPiece(ChessPieceUnitFactory.getChess(1), 0, 0);
    chessPieces[2] = ChessPiece(ChessPieceUnitFactory.getChess(2), 0, 1);

    ///TODO: ...省略摆放其他棋子的代码...
  }

  void move(int chessPieceId, int toPositionX, int toPositionY) {
    ///TODO: ...省略
  }
}

/// 上面的代码实现中，我们利用工厂类来缓存 ChessPieceUnit 信息（也就是 id、text、color）。
/// 通过工厂类获取到的 ChessPieceUnit 就是享元。所有的 ChessBoard 对象共享这 30 个 ChessPieceUnit 对象（因为象棋中只有 30 个棋子）。
/// 在使用享元模式之前，记录 1 万个棋局，我们要创建 30 万（30*1 万）个棋子的 ChessPieceUnit 对象。
/// 利用享元模式，我们只需要创建 30 个享元对象供所有棋局共享使用即可，大大节省了内存。

/*
* 实际上，它的代码实现非常简单，主要是通过工厂模式，
* 在工厂类中，通过一个 Map 来缓存已经创建过的享元对象，来达到复用的目的。
* */

/// e.g 文本编辑器
///
class CharacterStyle {
  final double fontSize;

  final int colorRgb;

  final double fontWeight;

  CharacterStyle(this.fontSize, this.colorRgb, this.fontWeight);
}

class CharacterStyleFactory {
  static final List<CharacterStyle> styles = [];

  static CharacterStyle getStyle(double fontSize, int colorRgb, double fontWeight) {
    CharacterStyle newStyle = CharacterStyle(fontSize, colorRgb, fontWeight);
    if (styles.contains(newStyle)) {
      return newStyle;
    }
    styles.add(newStyle);
    return newStyle;
  }
}

class Character {
  final CharacterStyle style;

  final String c;

  Character(this.style, this.c);
}

class Editor {
  final List<Character> chars = [];

  void appendCharacter(String c, double fontSize, double fontWeight, int colorRgb) {
    Character character = Character(
        CharacterStyleFactory.getStyle(
          fontSize,
          colorRgb,
          fontWeight,
        ),
        c);
    chars.add(character);
  }
}

/* 我们先来看享元模式跟单例的区别。
* 应用享元模式是为了对象复用，节省内存
* 而应用多例模式是为了限制对象的个数。
* */

/* 享元模式跟缓存的区别
* 通过工厂类来“缓存”已经创建好的对象。这里的“缓存”实际上是“存储”的意思，
* 跟我们平时所说的“数据库缓存”“CPU 缓存”“MemCache 缓存”是两回事。
* 我们平时所讲的缓存，主要是为了提高访问效率，而非复用。
* */

/// 1. 享元模式的原理
/* 将对象设计成享元，在内存中只保留一份实例，供多处代码引用，这样可以减少内存中对象的数量，
* 以起到节省内存的目的。实际上，不仅仅相同对象可以设计成享元，对于相似对象，
* 我们也可以将这些对象中相同的部分（字段），提取出来设计成享元，让这些大量相似对象引用这些享元。
* */

/// 2. 享元模式的实现
/*
* 享元模式的代码实现非常简单，主要是通过工厂模式，在工厂类中，
* 通过一个 Map 或者 List 来缓存已经创建好的享元对象，以达到复用的目的。
* */

/// 3.享元模式 VS 单例、缓存、对象池
/*
*  区别两种设计模式，不能光看代码实现，而是要看设计意图，也就是要解决的问题。这里的区别也不例外。
*  应用单例模式是为了保证对象全局唯一。
*  应用享元模式是为了实现对象复用，节省内存。缓存是为了提高访问效率，而非复用。
*  池化技术中的“复用”理解为“重复使用”，主要是为了节省时间。
* */

/// 4. JAVA中享元模式使用
/*
* 在 Java Integer 的实现中，-128 到 127 之间的整型对象会被事先创建好，缓存在 IntegerCache 类中。
* 当我们使用自动装箱或者 valueOf() 来创建这个数值区间的整型对象时，会复用 IntegerCache 类事先创建好的对象。
* 这里的 IntegerCache 类就是享元工厂类，事先创建好的整型对象就是享元对象。
* */

/*
* 在 Java String 类的实现中，JVM 开辟一块存储区专门存储字符串常量，这块存储区叫作字符串常量池，
* 类似于 Integer 中的 IntegerCache。不过，跟 IntegerCache 不同的是，它并非事先创建好需要共享的对象，
* 而是在程序的运行期间，根据需要来创建和缓存字符串常量。
* */
