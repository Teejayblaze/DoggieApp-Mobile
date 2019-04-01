import 'dart:async';

import 'package:doggie_app/model/doggie_dog.dart';

class DoggieBloc {
  
  final StreamController<List<Dog>> _dogStreamController = new StreamController<List<Dog>>.broadcast();

  Stream<List<Dog>> get getDogStream => _dogStreamController.stream;
  StreamSink<List<Dog>> get getDogStreamSink => _dogStreamController.sink;

  DoggieBloc() {
    this._dogStreamController.stream.listen(_onData);
  }

  _onData(List<Dog> dog) {}  

  dispose() {
    this._dogStreamController.close();
  }
}