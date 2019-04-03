import 'dart:async';

import 'package:doggie_app/model/doggie_dog.dart';

class DoggieBloc {
  
  final StreamController _dogStreamController = new StreamController.broadcast();

  Stream<List<Dog>> get getDogStream => _dogStreamController.stream;
  StreamSink<Dog> get getDogStreamSink => _dogStreamController.sink;

  DoggieBloc() {
    this._dogStreamController.stream.listen(_onData);
  }

  _onData(Dog dog) {}

  dispose() {
    this._dogStreamController.close();
  }
}