import 'package:flutter/material.dart';
import 'package:doggie_app/utils/doggie_bloc_provider.dart';
import 'package:doggie_app/screens/doggie_splashscreen.dart';
import 'package:doggie_app/utils/doggie_socketIO_impl.dart';
import 'package:doggie_app/bloc/doggie_socket_bloc.dart';
import 'package:doggie_app/model/doggie_dog.dart';
import 'package:doggie_app/constant/doggie_ipconfig_constant.dart';

class DoggieApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DoggieAppState();
}

class _DoggieAppState extends State<DoggieApp> {

  DoggieSocketBloc<Dog> bloc;
  DoggieSocketIOImpl socketIOImpl;
  final String socketUrl = IP;

  MaterialColor get appTheme => const MaterialColor(0xffFF3D7F, {
    50: const Color(0xffdbf0fc),
    100: const Color(0xffdbf0fc),
    200: const Color(0xffedf8ff),
    300: const Color(0xffedf8ff),
    400: const Color(0xffae194b),
    500: const Color(0xff3FB8AF),
    600: const Color(0xff7FC7AF),
    700: const Color(0xffDAD8A7),
    800: const Color(0xffFF9E9D),
    900: const Color(0xffFF3D7F),
  });

  @override
  Widget build(BuildContext context){
    bloc = new DoggieSocketBloc<Dog>();
    socketIOImpl = new DoggieSocketIOImpl(domain: socketUrl, streamSinkCallback: bloc.socketSink);
    return DoggieBlocProvider(
      bloc: bloc,
      socketIOImpl: socketIOImpl,
      appTheme: this.appTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(primarySwatch: appTheme, accentColor: appTheme[500],),
        home: DoggieSplashScreen(),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.bloc.dispose();
  }
}