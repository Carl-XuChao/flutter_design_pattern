/// 职责链模式 Chain Of Responsibility Design Pattern
/// 将请求的发送和接收解耦，让多个接收对象都有机会处理这个请求。
/// 将这些接收对象串成一条链，并沿着这条链传递这个请求，直到链上的某个接收对象能够处理它为止。

/*
* 在职责链模式中，多个处理器（也就是刚刚定义中说的“接收对象”）依次处理同一个请求。
* 一个请求先经过 A 处理器处理，然后再把请求传递给 B 处理器，B 处理器处理完后再传递给 C 处理器，
* 以此类推，形成一个链条。链条上的每个处理器各自承担各自的处理职责，所以叫作职责链模式。
* */

/// 1. 链表的方式实现
abstract class Handler {
  Handler? successor;

  void handle() {
    bool handled = doHandle();
    if (!handled && successor != null) {
      successor?.handle();
    }
  }

  /// 控制是否中断响应链的传递
  bool doHandle();
}

class HandleA extends Handler {
  @override
  void handle() {
    bool handled = doHandle();
    // ...
    if (!handled && successor != null) {
      successor?.handle();
    }
  }

  @override
  bool doHandle() {
    // TODO: implement doHandle
    throw UnimplementedError();
  }
}

class HandleB extends Handler {
  @override
  void handle() {
    bool handled = doHandle();
    // ...
    if (!handled && successor != null) {
      successor?.handle();
    }
  }

  @override
  bool doHandle() {
    // TODO: implement doHandle
    throw UnimplementedError();
  }
}

class HandlerChainLink {
  Handler? _head;
  Handler? _tail;

  void addHandler(Handler handler) {
    if (_head == null) {
      _head = handler;
      _tail = handler;
      return;
    }
    _tail?.successor = handler;
    _tail = handler;
  }

  void handle() => _head?.handle();
}

void _main() {
  HandlerChainLink chain = HandlerChainLink();
  chain.addHandler(HandleA());
  chain.addHandler(HandleB());
  chain.handle();
}

/// 2. 使用数组的方式处理
class HandlerChainArray {
  final List<Handler> _handler = [];

  void addHandler(Handler handler) {
    _handler.add(handler);
  }

  void handler() {
    for (Handler handler in _handler) {
      handler.handle();
    }
  }
}

/*
* 实际上，职责链模式还有一种变体，那就是请求会被所有的处理器都处理一遍，不存在中途终止的情况。
* 这种变体也有两种实现方式：用链表存储处理器和用数组存储处理器，跟上面的两种实现方式类似，只需要稍微修改即可。
* */

/// e.g 对于支持 UGC（User Generated Content，用户生成内容）的应用（比如论坛）来说，用户生成的内容（比如，在论坛中发表的帖子）可能会包含一些敏感词（比如涉黄、广告、反动等词汇）。
/// 针对这个应用场景，我们就可以利用职责链模式来过滤这些敏感词。

abstract class SensitiveWordFilter {
  bool doFilter(String content);
}

class SexyWordFilter implements SensitiveWordFilter {
  @override
  bool doFilter(String content) {
    bool legal = true;
    // TODO: implement doFilter
    return legal;
  }
}

class PoliticalWordFilter implements SensitiveWordFilter {
  @override
  bool doFilter(String content) {
    bool legal = true;
    // TODO: implement doFilter
    return legal;
  }
}

class AdsWordFilter implements SensitiveWordFilter {
  @override
  bool doFilter(String content) {
    bool legal = true;
    // TODO: implement doFilter
    return legal;
  }
}

class SensitiveWordFilterChain {
  final List<SensitiveWordFilter> _filters = [];

  void addFilter(SensitiveWordFilter filter) {
    _filters.add(filter);
  }

  bool filter(String content) {
    for (SensitiveWordFilter filter in _filters) {
      if (!filter.doFilter(content)) {
        return false;
      }
    }
    return true;
  }
}

void _applicationDemo() {
  SensitiveWordFilterChain chain = SensitiveWordFilterChain();
  chain.addFilter(SexyWordFilter());
  chain.addFilter(AdsWordFilter());
  chain.addFilter(PoliticalWordFilter());

  bool legal = chain.filter('fuck your');
  if (!legal) {
    // 不发表
  } else {
    //  发表
  }
}

/* 职责链模式如何让代码满足开闭原则，提高代码的扩展性。
* 假设敏感词过滤框架并不是我们开发维护的，而是我们引入的一个第三方框架，我们要扩展一个新的过滤算法，不可能直接去修改框架的源码。
* 这个时候，利用职责链模式就能达到开篇所说的，在不修改框架源码的情况下，基于职责链模式提供的扩展点，来扩展新的功能。
* 换句话说，我们在框架这个代码范围内实现了开闭原则。
* */

/// 职责链模式最常用来开发框架的过滤器和拦截器。
