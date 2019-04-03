import 'dart:convert';

import 'package:doggie_app/resources/doggie_network.dart';
import 'package:doggie_app/model/doggie_dog.dart';
import 'package:doggie_app/bloc/doggie_socket_bloc.dart';

class DoggieRepositories {

  DoggieNetwork network;

  DoggieRepositories(): network = new DoggieNetwork();

  void fillRepository({DoggieSocketBloc bloc}) async {
    var response = await network.getNetworkRequest(url: '/pets');
    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      List<Dog> dogs = jsonRes['msg'].map<Dog>((json) => Dog.fromJSON(json)).toList();
      bloc.socketSink.add(dogs);
    }
  }

  void fillAdvertRepository({DoggieSocketBloc bloc}) async {
    var response = await network.getNetworkRequest(url: '/top/10/pets');
    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      List<Dog> dogs = jsonRes['msg'].map<Dog>((json) => Dog.fromJSON(json)).toList();
      bloc.topAdvertSink.add(dogs);
    }
  }
}