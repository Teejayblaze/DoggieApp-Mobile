import 'package:flutter/material.dart';
import 'package:doggie_app/bloc/doggie_socket_bloc.dart';
import 'package:doggie_app/utils/doggie_socketIO_impl.dart';
import 'package:doggie_app/model/doggie_dog.dart';

class DoggieBlocProvider extends InheritedWidget {
  DoggieBlocProvider({Key key, @required this.child, @required this.bloc, @required this.appTheme, @required this.socketIOImpl}):
        super(key: key, child: child);

  final Widget child;
  final DoggieSocketBloc<Dog> bloc;
  final MaterialColor appTheme;
  final DoggieSocketIOImpl socketIOImpl;

  static DoggieBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DoggieBlocProvider)as DoggieBlocProvider);
  }

  @override
  bool updateShouldNotify( DoggieBlocProvider oldWidget) => true;
}