
import 'dart:async';

class DoggieSocketBloc<T> {

  StreamController<List<T>> socketStreamController = new StreamController<List<T>>.broadcast();
  StreamController<List<T>> advertStreamController = new StreamController<List<T>>.broadcast();

  StreamSink<List<T>> get socketSink => socketStreamController.sink;
  Stream<List<T>> get socketStream => socketStreamController.stream;

  StreamSink<List<T>> get topAdvertSink => advertStreamController.sink;
  Stream<List<T>> get topAdvertStream => advertStreamController.stream;

  DoggieSocketBloc() {}

  void dispose() {
    socketStreamController.close();
    advertStreamController.close();
  }
}