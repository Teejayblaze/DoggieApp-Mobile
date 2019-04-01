
import 'dart:async';

class DoggieSearchBloc {

  StreamController<bool> searchStreamController = new StreamController<bool>();

  StreamSink<bool> get searchSink => searchStreamController.sink;
  Stream<bool> get searchStream => searchStreamController.stream;

  void disposed() {
    searchStreamController.close();
  }
}