import 'dart:async';

import 'package:flutter/material.dart';

mixin EventMixin<UIEvent extends dynamic> {
  final _eventController = StreamController<UIEvent>();

  Stream<UIEvent> get $eventStream => _eventController.stream;

  void addEvent(UIEvent event) {
    _eventController.sink.add(event);
  }

  @mustCallSuper
  void dispose() {
    debugPrint("[$runtimeType]: onDispose");
    _eventController.close();
  }
}

mixin EventStateMixin<T extends StatefulWidget, E extends dynamic> on State<T> {
  late StreamSubscription<E> _streamSubscription;

  Stream<E> get eventStream;

  @override
  void initState() {
    super.initState();
    _streamSubscription = eventStream.listen((event) => eventListener(event));
  }

  void eventListener(E event) {}

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
