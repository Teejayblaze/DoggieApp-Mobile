import 'package:flutter/material.dart';

import 'package:doggie_app/animations/doggie_homepage_animation.dart';
import 'package:doggie_app/model/doggie_dog.dart';
import 'package:doggie_app/resources/doggie_repositories.dart';

import 'package:doggie_app/utils/doggie_curvededged_rect.dart';
import 'package:doggie_app/utils/doggie_bloc_provider.dart';
import 'package:doggie_app/utils/doggie_custom_textformfield.dart';
import 'package:doggie_app/utils/doggie_socketIO_impl.dart';
import 'package:doggie_app/utils/doggie_homepage_content_layout.dart';

import 'package:doggie_app/bloc/doggie_search_bloc.dart';
import 'package:doggie_app/bloc/doggie_socket_bloc.dart';

class DoggieHomePage extends StatefulWidget {
  @override
  _DoggieHomePageState createState() => _DoggieHomePageState();
}

class _DoggieHomePageState extends State<DoggieHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DoggieHomepageAnimation _dhpa;
  MaterialColor appTheme;
  TextEditingController _searchTextEditingController = new TextEditingController();
  DoggieSearchBloc searchBloc;
  DoggieBlocProvider appContext;
  DoggieSocketBloc<Dog> doggieSocketBloc;
  DoggieSocketIOImpl doggieSocketIOImpl;
  DoggieRepositories repositories;


  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    searchBloc = new DoggieSearchBloc();
    searchBloc.searchSink.add(false);
    this.repositories = new DoggieRepositories();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appContext = DoggieBlocProvider.of(context);
    appTheme = appContext.appTheme;
    this.doggieSocketBloc = appContext.bloc;
    this.doggieSocketIOImpl = appContext.socketIOImpl;
    this.doggieSocketIOImpl.subscribe(channel: 'pets');
    this.repositories.fillRepository(bloc: appContext.bloc);
    this.repositories.fillAdvertRepository(bloc: appContext.bloc);
  }

  @override
  void dispose() {
    _controller.dispose();
    searchBloc.disposed();
    doggieSocketBloc.dispose();
    this.doggieSocketIOImpl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _dhpa = new DoggieHomepageAnimation(_controller, size);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: _buildWidgets(size, appTheme),
      ),
      bottomNavigationBar: BottomNavigationBar(items: _buildBottomNavigationItem().toList()),
    );
  }

  List<Widget> _buildWidgets(Size size, MaterialColor appTheme) => [
//    _buildTopAdvert(size),
    _buildContentBody(size),
    _buildAppBar(size, appTheme),
  ];

  Positioned _buildAppBar(Size size, MaterialColor appTheme) => Positioned(
    top: 0.0,
    width: size.width,
    child: ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: DoggieCurvedEdgedRect(),
      child: Container(
        height: 138.0,
        padding: EdgeInsets.only(top: 30.0),
        decoration: BoxDecoration(color: appTheme[900]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildAppBarIconText() + _buildAppBarTextField(),
        )
      ),
    ),
  );

  void _onSaveSearch(String text) {}

  Positioned _buildTopAdvert(Size size) => Positioned(
    width: size.width,
    height: 80,
    top: 150.0,
    child: StreamBuilder<List<Dog>>(
        stream: doggieSocketBloc.topAdvertStream,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => Material(
                elevation: 20.0,
                child: Container(
                  height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: appTheme[200],
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Image.network(snapshot.data[index].petPicURL, fit: BoxFit.cover,),
                ),
              )
          );

          return Container(alignment: Alignment.center, child: CircularProgressIndicator(),);
        }
      ),
  );


  Positioned _buildContentBody(Size size) => Positioned(
    width: size.width,
    top: 130.0,
    height: (size.height - 150.0),
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StreamBuilder<List<Dog>>(
            initialData: null,
            stream: appContext.bloc.socketStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) return DoggieHomePageContentLayout(dogs: snapshot.data);
              return Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20.0),
              );
            },
          ),
      )
    )
  );

  List<Container> _buildAppBarIconText() => [Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(icon: Icon(Icons.menu), onPressed: (){}, color: appTheme[50],),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text("Doggie", style: TextStyle(fontWeight: FontWeight.bold, color: appTheme[50], fontSize: 38.0),),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(icon: Icon(Icons.notifications), onPressed: (){}, color: appTheme[50],),
        ),
      ],
    ),
  )];


  List<Container> _buildAppBarTextField() => [Container(
    padding: EdgeInsets.only(left: 10.0, right: 10.0),
    child: DoggieCustomTextFormField.createCapsuleTextField(
      controller: _searchTextEditingController,
      onSaved: _onSaveSearch,
      validator: null,
      icon: Icons.search,
      hintText: "Smart DOG Search...",
      appTheme: appTheme
    ),
  )];


  List<BottomNavigationBarItem> _buildBottomNavigationItem() => [
    BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        title: Text("Train Pet", style: TextStyle(fontWeight: FontWeight.w600),)
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text("Buy Pet", style: TextStyle(fontWeight: FontWeight.w600),)
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.attach_money),
        title: Text("Sell Pet", style: TextStyle(fontWeight: FontWeight.w600),)
    ),
  ];


//  List<String> generateItems(int len) => List<String>.generate(len, (int index) => "$index - Dog" ).toList();
}