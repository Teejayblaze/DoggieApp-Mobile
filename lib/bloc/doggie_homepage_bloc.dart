
import 'dart:async';

import 'package:flutter/material.dart';

class DoggieHomePageBloc {

  StreamController<List<Widget>> homepageStreamController = new StreamController<List<Widget>>();

  StreamSink<List<Widget>> get homepageSink => homepageStreamController.sink;
  Stream<List<Widget>> get homepageStream => homepageStreamController.stream;

  void disposed() {
    homepageStreamController.close();
  }
}