/// 解释器模式 Interpreter Design Pattern
/// 解释器模式为某个语言定义它的语法（或者叫文法）表示，并定义一个解释器用来处理这个语法。
/// 它的代码实现的核心思想，就是将语法解析的工作拆分到各个小类中，以此来避免大而全的解析类。一般的做法是，
/// 将语法规则拆分一些小的独立的单元，然后对每个单元进行解析，最终合并为对整个语法规则的解析。

/* e.g 假设我们定义了一个新的加减乘除计算“语言”，语法规则如下：
* 运算符只包含加、减、乘、除，并且没有优先级的概念；
* 表达式（也就是前面提到的“句子”）中，先书写数字，后书写运算符，空格隔开；
* 按照先后顺序，取出两个数字和一个运算符计算结果，结果重新放入数字的最头部位置，循环上述过程，
* 直到只剩下一个数字，这个数字就是表达式最终的计算结果。
*  比如“ 8 3 2 4 - + * ”这样一个表达式
* */

class ExpressionInterpreter {
  final List<NumberExpression> numbers = [];

  int interpret(String expression) {
    List<String> elements = expression.split(' ');
    int length = elements.length;
    for (var i = 0; i < (length + 1) / 2; i++) {
      numbers.add(NumberExpression(int.parse(elements[i])));
    }

    for (var i = (length + 1) ~/ 2; i < length; i++) {
      String operator = elements[i];
      bool isValid = "+" == operator || "-" == operator || "*" == operator || "/" == operator;
      if (!isValid) {
        throw UnsupportedError('运算符不支持 $operator');
      }

      Expression exp1 = numbers.removeAt(0);
      Expression exp2 = numbers.removeAt(0);
      Expression? combinedExp = null;

      if (operator == "+") {
        combinedExp = AdditionExpression(exp1, exp2);
      } else if (operator == '-') {
        combinedExp = SubstractionExpression(exp1, exp2);
      } else if (operator == '*') {
        combinedExp = MultiplicationExpression(exp1, exp2);
      } else if (operator == '-') {
        combinedExp = DivisionExpression(exp1, exp2);
      }

      int? result = combinedExp?.interpret();
      if (result != null) {
        numbers.insert(0, NumberExpression(result));
      }

      if (numbers.length != 1) {
        throw UnsupportedError("Expression is invalid: $expression");
      }
    }

    return numbers.last.interpret();
  }
}

abstract class Expression {
  int interpret();
}

class NumberExpression implements Expression {
  final int number;

  NumberExpression(this.number);

  @override
  int interpret() {
    return number;
  }
}

class AdditionExpression extends Expression {
  final Expression exp1;

  final Expression exp2;

  AdditionExpression(this.exp1, this.exp2);

  @override
  int interpret() {
    return exp1.interpret() + exp2.interpret();
  }
}

class SubstractionExpression extends Expression {
  final Expression exp1;

  final Expression exp2;

  SubstractionExpression(this.exp1, this.exp2);

  @override
  int interpret() {
    return exp1.interpret() - exp2.interpret();
  }
}

class MultiplicationExpression extends Expression {
  final Expression exp1;

  final Expression exp2;

  MultiplicationExpression(this.exp1, this.exp2);

  @override
  int interpret() {
    return exp1.interpret() * exp2.interpret();
  }
}

class DivisionExpression extends Expression {
  final Expression exp1;

  final Expression exp2;

  DivisionExpression(this.exp1, this.exp2);

  @override
  int interpret() {
    final res = exp2.interpret();
    if (res == 0) {
      throw UnsupportedError("0");
    }
    return exp1.interpret() ~/ res;
  }
}
