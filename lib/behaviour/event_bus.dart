import 'dart:async';

class EventBus {
  StreamController _streamController;

  /// Controller for the event bus stream.
  StreamController get streamController => _streamController;

  EventBus({bool sync = false}) : _streamController = StreamController.broadcast(sync: sync);

  EventBus.customController(StreamController controller) : _streamController = controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  void fire(event) {
    streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  ///
  void destroy() {
    _streamController.close();
  }
}
