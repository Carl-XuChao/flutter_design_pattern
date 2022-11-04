/// 观察者模式（Observer Design Pattern）也被称为发布订阅模式（Publish-Subscribe Design Pattern）。
///

abstract class Subject {
  void registerObserver(Observer observer);
  void removeObserver(Observer observer);
  void notifyObservers(String message);
}

abstract class Observer {
  void update(String message);
}

class ConcreteSubject implements Subject {
  final List<Observer> observers = [];

  @override
  void registerObserver(Observer observer) {
    observers.add(observer);
  }

  @override
  void removeObserver(Observer observer) {
    observers.remove(observer);
  }

  @override
  void notifyObservers(String message) {
    for (Observer ob in observers) {
      ob.update(message);
    }
  }
}

class ConcreteObserverOne implements Observer {
  @override
  void update(String message) {
    print("ConcreteObserverOne");
  }
}

class ConcreteObserverTwo implements Observer {
  @override
  void update(String message) {
    print("ConcreteObserverTwo");
  }
}

void _main() {
  ConcreteSubject subject = ConcreteSubject();
  subject.registerObserver(ConcreteObserverOne());
  subject.registerObserver(ConcreteObserverTwo());

  subject.notifyObservers("hello");
}

/// e.g 假设我们在开发一个 P2P 投资理财系统，用户注册成功之后，我们会给用户发放投资体验金。
///

class UserController {
  final UserService userService;

  final PromotionService promotionService;

  UserController(this.userService, this.promotionService);

  /*
  * 虽然注册接口做了两件事情，注册和发放体验金，违反单一职责原则，
  * 但是，如果没有扩展和修改的需求，现在的代码实现是可以接受的。
  * */
  void register() {
    // 注册服务
    String id = userService.register();
    // 发放优惠卷
    promotionService.sendCoupon(id);
  }
}

/// 用户服务
class UserService {
  String register() {
    String id = '111';
    return id;
  }
}

/// 营销服务
class PromotionService {
  void sendCoupon(String userId) {}
}

abstract class RegisterObserver {
  void handleRegSuccess(String userId);
}

class RegPromotionObserver implements RegisterObserver {
  final PromotionService promotionService;

  RegPromotionObserver(this.promotionService);

  @override
  void handleRegSuccess(String userId) {
    promotionService.sendCoupon(userId);
  }
}

/// 依赖注册注册成功的观察者，解耦用户注册逻辑和其他业务，准守单一职责原则
class NewUserController {
  final UserService userService;

  final List<RegisterObserver> regObservers = [];

  NewUserController(this.userService);

  void register() {
    String userId = userService.register();
    for (RegisterObserver ob in regObservers) {
      ob.handleRegSuccess(userId);
    }
  }
}
