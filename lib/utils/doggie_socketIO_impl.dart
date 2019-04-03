import 'dart:async';

import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:flutter/material.dart';
import 'package:doggie_app/model/doggie_dog.dart';

class DoggieSocketIOImpl {

  DoggieSocketIOImpl({@required this.domain, @required this.streamSinkCallback}){
    socketIO = SocketIOManager().createSocketIO(domain, '/doggie', socketStatusCallback: _socketStatus);
    socketIO.init();
    socketIO.connect();
  }

  SocketIO socketIO;
  final String domain;
  StreamSink streamSinkCallback;
  String channel;

  static void _socketStatus(dynamic data) {
//    for debugging sake, let's know if our socket handshake with the server is successful.
    print("handshake with serve, data: $data");
  }

  void subscribe({@required String channel}) {
    if (this.socketIO != null) {
      this.channel = channel;
      this.socketIO.subscribe(channel, this._callback);
    }
  }

  void _callback(dynamic receivedData) {
    print("Transmitting received data $receivedData");
    this.streamSinkCallback.add(receivedData);
  }

  void sendSocketServerMessage({@required dynamic message}) async {
    if (this.socketIO != null) {
      this.socketIO.sendMessage(this.channel, message, this._callback);
    }
  }

  void dispose() {
    if (this.socketIO != null) {
      SocketIOManager().destroySocket(this.socketIO);
    }
  }
}