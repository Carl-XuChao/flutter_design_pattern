/// 桥接模式(Bridge Design Pattern)
/// 桥接模式的定义是“将抽象和实现解耦，让它们可以独立变化”。
/// 另外一种更加简单的理解方式：“一个类存在两个（或多个）独立变化的维度，我们通过组合的方式，让这两个（或多个）维度可以独立进行扩展。”

/* e.g
* API 接口监控告警的例子：根据不同的告警规则，触发不同类型的告警。告警支持多种通知渠道，
* 包括：邮件、短信、微信、自动语音电话。通知的紧急程度有多种类型，
* 包括：SEVERE（严重）、URGENCY（紧急）、NORMAL（普通）、TRIVIAL（无关紧要）。
* 不同的紧急程度对应不同的通知渠道。
* 比如，SERVE（严重）级别的消息会通过“自动语音电话”告知相关人员。
* */

enum NotificationEmergencyLevel {
  severe,
  urgency,
  normal,
  trivial,
}

class MyNotification {
  List<String> _emailAddresses = [];

  List<String> _telephones = [];

  List<String> _wechatIds = [];

  void setEmailAddress(List<String> values) {
    _emailAddresses = values;
  }

  void setTelephones(List<String> values) {
    _telephones = values;
  }

  void setWechatIds(List<String> values) {
    _wechatIds = values;
  }

  void notify(NotificationEmergencyLevel level, String message) {
    switch (level) {
      case NotificationEmergencyLevel.severe:
        // TODO: 自动语言电话
        break;
      case NotificationEmergencyLevel.urgency:
        // TODO: 发微信
        break;
      case NotificationEmergencyLevel.normal:
        // TODO: 发邮件
        break;
      case NotificationEmergencyLevel.trivial:
        // TODO: 发邮件
        break;
    }
  }
}

abstract class MsgSender {
  void send(String message);
}

class TelephoneMessageSender implements MsgSender {
  List<String> telephones = [];

  @override
  void send(String message) {
    print("打电话处理告警！");
  }
}

class EmailMessageSender implements MsgSender {
  List<String> emailAddresses = [];

  @override
  void send(String message) {
    print("发邮件处理告警！");
  }
}

abstract class Notification {
  final MsgSender msgSender;

  /// 一种告警对应多种消息转发的情况下使用！
  final List<MsgSender> multiMsgSender = [];

  Notification(this.msgSender);

  void notify(String message);
}

class SevereNotification extends Notification {
  SevereNotification(super.msgSender);

  @override
  void notify(String message) {
    if (multiMsgSender.isEmpty) {
      msgSender.send(message);
    } else {
      for (MsgSender sender in multiMsgSender) {
        sender.send(message);
      }
    }
  }
}

class UrgencyNotification extends Notification {
  UrgencyNotification(super.msgSender);

  @override
  void notify(String message) {
    if (multiMsgSender.isEmpty) {
      msgSender.send(message);
    } else {
      for (MsgSender sender in multiMsgSender) {
        sender.send(message);
      }
    }
  }
}

/* 总得来说，不同的告警通知和触发不同的消息渠道是的可以相互匹配的。
* 设计上可以从下往上思考： 告警（抽象接口）-> 发送消息（抽象接口）
*  告警： 具体的告警去实现接口
*  发送消息： 具体的消息渠道去实现接口
*  告警类要持有一个抽象消息发送类对象， 实现最终的发送消息操作
* */
void _main() {
  String message = "服务器挂了！！！";
  NotificationEmergencyLevel level = NotificationEmergencyLevel.urgency;
  switch (level) {
    case NotificationEmergencyLevel.severe:

      /// 消息抽象类
      MsgSender teleSender = TelephoneMessageSender();
      MsgSender emailSender = EmailMessageSender();

      /// 通知抽象类
      Notification notification = SevereNotification(teleSender);
      notification.multiMsgSender.addAll([teleSender, emailSender]);

      /// 出发桥接方法
      notification.notify(message);
      break;
    case NotificationEmergencyLevel.urgency:

      /// 消息抽象类
      MsgSender sender = EmailMessageSender();

      /// 通知抽象类
      Notification notification = UrgencyNotification(sender);

      /// 出发桥接方法
      notification.notify(message);
      break;
    default:
      break;
  }
}
