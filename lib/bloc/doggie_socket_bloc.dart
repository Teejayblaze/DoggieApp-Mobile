
import 'dart:async';

class DoggieSocketBloc {

  StreamController seocketStreamController = new StreamController();

  StreamSink get socketSink => seocketStreamController.sink;
  Stream get socketStream => seocketStreamController.stream;

  void disposed() {
    seocketStreamController.close();
  }
}