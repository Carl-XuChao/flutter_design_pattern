/// 迭代器模式（Iterator Design Pattern）
/// 迭代器中需要定义 hasNext()、currentItem()、next() 三个最基本的方法。待遍历的容器对象通过依赖注入传递到迭代器类中。容器通过 iterator() 方法来创建迭代器。
/// 迭代器模式主要作用是解耦容器代码和遍历代码

abstract class Iterator<E> {
  bool hasNext();

  void next();

  E currentItem();
}

class ArrayIterator<E> implements Iterator<E> {
  int _cursor = 0;

  final List<E> arrayList;

  /// 依赖注入容器对象
  ArrayIterator(this.arrayList);

  @override
  currentItem() {
    if (_cursor >= arrayList.length) {
      throw UnimplementedError();
    }
    return arrayList[_cursor];
  }

  @override
  bool hasNext() {
    //注意这里，cursor在指向最后一个元素的时候，hasNext()仍旧返回true。
    return _cursor != arrayList.length;
  }

  @override
  void next() {
    _cursor++;
  }
}

void _main() {
  Iterator<String> iterator = ArrayIterator(["a", "b", "c"]);

  while (iterator.hasNext()) {
    print(iterator.currentItem());
    iterator.next();
  }

  Iterator<int> myIterator = [1, 2, 3].myIterator();
  while (myIterator.hasNext()) {
    print(myIterator.currentItem());
    iterator.next();
  }
}

/// 实际上，为了封装迭代器的创建细节，我们可以在容器中定义一个 iterator() 方法，
/// 来创建对应的迭代器。为了能实现基于接口而非实现编程，我们还需要将这个方法定义在 List 接口中。
extension MyList<E> on List<E> {
  Iterator<E> myIterator() {
    return ArrayIterator<E>(this);
  }
}

/* 利用迭代器来遍历有下面三个优势：
* 1. 迭代器模式封装集合内部的复杂数据结构，开发者不需要了解如何遍历，直接使用容器提供的迭代器即可；
* 2. 迭代器模式将集合对象的遍历操作从集合类中拆分出来，放到迭代器类中，让两者的职责更加单一；
* 3. 迭代器模式让添加新的遍历算法更加容易，更符合开闭原则。除此之外，因为迭代器都实现自相同的接口，在开发中，基于接口而非实现编程，替换迭代器也变得更加容易。
* */

/// 如何应对遍历时改变集合导致的未决行为？
/*
* 当通过迭代器来遍历集合的时候，增加、删除集合元素会导致不可预期的遍历结果。
* 一种是遍历的时候不允许增删元素，另一种是增删元素之后让遍历报错。
* 新增一个标记字段，在构造迭代器的时候从容器对象中传入， 后续容器对象调用修改元素方法之后， 字段自增，
* 如果迭代器字段值与容器值不相等，说明迭代过程中，容器对象有修改， 抛出错误
* */

abstract class IList<E> {
  /// 记录修改集合元素次数
  int modCount = 0;

  void add(E element);

  void remove(E element);

  void update(E element);
}

class CustomList<E> implements IList<E> {
  final List<E> data = [];

  CustomArrayIterator<E> myIterator() {
    return CustomArrayIterator<E>(this, modCount);
  }

  @override
  int modCount = 0;

  @override
  void add(E element) {
    modCount += 1;
    data.add(element);
  }

  @override
  void remove(E element) {
    modCount += 1;
    data.remove(element);
  }

  @override
  void update(E element) {
    modCount += 1;
  }
}

class CustomArrayIterator<E> implements Iterator<E> {
  int _cursor = 0;

  final CustomList<E> customArray;

  final int expectedModCount;

  /// 依赖注入容器对象
  CustomArrayIterator(this.customArray, this.expectedModCount);

  @override
  currentItem() {
    checkForComodification();
    if (_cursor >= customArray.data.length) {
      throw UnimplementedError();
    }
    return customArray.data[_cursor];
  }

  @override
  bool hasNext() {
    checkForComodification();
    //注意这里，cursor在指向最后一个元素的时候，hasNext()仍旧返回true。
    return _cursor != customArray.data.length;
  }

  @override
  void next() {
    checkForComodification();
    _cursor++;
  }

  void checkForComodification() {
    if (customArray.modCount != expectedModCount) {
      throw UnsupportedError('message');
    }
  }
}

/// 如何实现一个支持“快照”功能的迭代器？

/* 方案一： 拷贝容器对象到迭代器中， 缺点是增加内存消耗
* 在迭代器类中定义一个成员变量 snapshot 来存储快照。每当创建迭代器的时候，
* 都拷贝一份容器中的元素到快照中，后续的遍历操作都基于这个迭代器自己持有的快照来进行。
* */

/* 方案二：软删除。
*  在容器中，为每个元素保存两个时间戳，一个是添加时间戳 addTimestamp，一个是删除时间戳 delTimestamp。
* 当元素被加入到集合中的时候，我们将 addTimestamp 设置为当前时间，将 delTimestamp 设置成最大长整型值（Long.MAX_VALUE）。
* 当元素被删除时，我们将 delTimestamp 更新为当前时间，表示已经被删除。
* */
