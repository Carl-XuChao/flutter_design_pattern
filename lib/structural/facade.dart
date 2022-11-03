/// 门面模式，也叫外观模式(Facade Design Pattern)
/// 门面模式为子系统提供一组统一的接口，定义一组高层接口让子系统更易用。

/// 主要在接口设计方面使用。
/*
*  1. 如果接口的粒度过小，在接口的使用者开发一个业务功能时，就会导致需要调用 n 多细粒度的接口才能完成。调用者肯定会抱怨接口不好用。
*  2. 如果接口粒度设计得太大，一个接口返回 n 多数据，要做 n 多事情，就会导致接口不够通用、可复用性不好。
* */

/// e.g 假设，完成某个业务功能（比如显示某个页面信息）需要“依次”调用 a、b、d 三个接口，因自身业务的特点，不支持并发调用这三个接口。
/*
*  如果我们现在发现 App 客户端的响应速度比较慢，排查之后发现，是因为过多的接口调用过多的网络通信。针对这种情况，我们就可以利用门面模式，
* 让后端服务器提供一个包裹 a、b、d 三个接口调用的接口 x。
* App 客户端调用一次接口 x，来获取到所有想要的数据，
* 将网络通信的次数从 3 次减少到 1 次，也就提高了 App 的响应速度。
* */

/// 完成接口设计，就相当于完成了一半的开发任务。只要接口设计得好，那代码就差不到哪里去。
///
/// 尽量保持接口的可复用性，但针对特殊情况，允许提供冗余的门面接口，来提供更易用的接口。
