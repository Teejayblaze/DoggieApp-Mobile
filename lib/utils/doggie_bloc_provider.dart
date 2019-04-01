import 'package:flutter/material.dart';
import 'package:doggie_app/bloc/doggie_bloc.dart';

class DoggieBlocProvider extends InheritedWidget {
  DoggieBlocProvider({Key key, this.child, this.bloc, this.appTheme}) : super(key: key, child: child);

  final Widget child;
  final DoggieBloc bloc;
  final MaterialColor appTheme;

  static DoggieBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DoggieBlocProvider)as DoggieBlocProvider);
  }

  @override
  bool updateShouldNotify( DoggieBlocProvider oldWidget) => true;
}