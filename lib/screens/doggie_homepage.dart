import 'package:flutter/material.dart';
import 'package:doggie_app/utils/doggie_curvededged_rect.dart';
import 'package:doggie_app/utils/doggie_bloc_provider.dart';
import 'package:doggie_app/animations/doggie_homepage_animation.dart';
import 'package:doggie_app/utils/doggie_custom_textformfield.dart';
import 'package:doggie_app/bloc/doggie_search_bloc.dart';
import 'package:doggie_app/bloc/doggie_homepage_bloc.dart';

class DoggieHomePage extends StatefulWidget {
  @override
  _DoggieHomePageState createState() => _DoggieHomePageState();
}

// I had to deprecate the enumeration used to check the status of the animation and
// setState() for the page but this lack optimization and utilize so much resources
// by redrawing or repainting the entire widget tree.
// However, we can achieve same goal by using a Stream with a better performance and optimization :)
//enum SearchStatus {
//  is_open,
//  is_closed
//}

class _DoggieHomePageState extends State<DoggieHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DoggieHomepageAnimation _dhpa;
  MaterialColor appTheme;
  TextEditingController _searchTextEditingController = new TextEditingController();
  List<String> content = new List<String>();
  DoggieSearchBloc searchBloc;
  DoggieHomePageBloc homePageBloc;
  DoggieBlocProvider appContext;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    content.addAll(generateItems(100));
    searchBloc = new DoggieSearchBloc();
    homePageBloc = new DoggieHomePageBloc();
    searchBloc.searchSink.add(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appContext = DoggieBlocProvider.of(context);
    appTheme = appContext.appTheme;
    this._buildScatteredList(appTheme);
  }

  @override
  void dispose() {
    _controller.dispose();
    searchBloc.disposed();
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
    );
  }

  List<Widget> _buildWidgets(Size size, MaterialColor appTheme) => [
    _buildAppBar(size, appTheme),
    _buildContentBody(size),
  ];

  Positioned _buildAppBar(Size size, MaterialColor appTheme) => Positioned(
    top: 0.0,
    width: size.width,
    child: ClipPath(
      clipper: DoggieCurvedEdgedRect(),
      child: Container(
        height: this._dhpa.growAppBar.value,
        padding: EdgeInsets.only(top: 30.0),
        decoration: BoxDecoration(color: appTheme[900]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu),
//                  AnimatedIcon(icon: AnimatedIcons.close_menu, progress: null),
                      onPressed: (){},
                      color: appTheme[50],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text("Doggie", style: TextStyle(fontWeight: FontWeight.bold, color: appTheme[50], fontSize: 38.0),),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _animateSearchTextField,
                      color: appTheme[50],),
//                    searchBloc.searchStream ? appTheme[800] :
                  ),
                ],
              ),
            ),
            Container(
//              width: size.width,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.diagonal3Values(this._dhpa.searchIn.value, this._dhpa.searchIn.value, 1.0),
                child:DoggieCustomTextFormField.createCapsuleTextField(
                    controller: _searchTextEditingController,
                    onSaved: _onSaveSearch,
                    validator: null,
                    icon: Icons.search,
                    hintText: "Smart DOG Search...",
                    appTheme: appTheme
                ),
              ) ,
            )
          ],
        )
      ),
    ),
  );

  void _onSaveSearch(String text) {

  }

  void _animateSearchTextField() {

//    bool isOpen = await searchBloc.searchStream.;

    if (!isOpen) {
      _controller.forward();
      this._dhpa.searchIn.addListener((){});
      isOpen = true;
    } else {
      _controller.reverse();
      isOpen = false;
    }

    print("searchBloc.searchStream: ${searchBloc.searchStream}, isOpen: $isOpen");

//    searchBloc.searchStream.listen((bool isOpen) {
//      print("isOpen: $isOpen");
//        if (!isOpen) {
//          _controller.forward();
//          searchBloc.searchSink.add(true);
//        } else {
//          _controller.reverse();
//          searchBloc.searchSink.add(false);
//        }
//    });

//    if ( searchBloc.searchStream. ) {
//
//      this._dhpa.searchIn.addListener((){});
//
////      this.setState(() { searchStatus = SearchStatus.is_open; });
//    } else if ( searchStatus == SearchStatus.is_open ) {
//
//
////      this.setState(() { searchStatus = SearchStatus.is_closed; });
//    }
  }


  Positioned _buildContentBody(Size size) => Positioned(
    width: size.width,
    top: 150.0,
    height: (size.height - 150.0),
    child: Container(
      child: SingleChildScrollView(
        child: StreamBuilder<List<Widget>>(
            initialData: [],
            stream: homePageBloc.homepageStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: snapshot.data
              );
              return Center(child: CircularProgressIndicator(),);
            },
          ),
      )
    )
  );

  List<String> generateItems(int len) => List<String>.generate(len, (int index) => "$index - Dog" ).toList();

  void _buildScatteredList(MaterialColor appTheme) {

    int numColsInRow = 3;
    int numIteration = int.parse((content.length/numColsInRow).ceil().toString());
    int cid = 0;
    int len = content.length;

    print("numColsInRow: $numColsInRow, numIteration: $numIteration");
    List<Container> parentList = [];

    for( int i = 0; i < numIteration; i++ ) {

      List<Container> subChildren = [];

      for( int j = 0; j < numColsInRow; j++ ) {
        if ( cid >= len ) break;
        if ( j % 2 != 0 ) {
          subChildren.add(
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
              child: GestureDetector(
                child: Hero(
                  tag: content[cid],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 53.0,
                        backgroundColor: appTheme[800],
                        child: Text(content[cid][0] + content[cid][1], style: TextStyle(fontWeight: FontWeight.bold,),),
                      ),
                      SizedBox(height: 5.0,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(content[cid]),
                      )
                    ],
                  ),
                ),
                onTap: () => null,
              ),
            ),
          );
        } else {
          subChildren.add(
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: GestureDetector(
                child: Hero(
                    tag: content[cid],
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 53.0,
                            backgroundColor: appTheme[800],
                            child: Text(content[cid][0] + content[cid][1], style: TextStyle(fontWeight: FontWeight.bold,),),
                          ),
                          SizedBox(height: 5.0,),
                          Align(
                            alignment: Alignment.center,
                            child: Text(content[cid]),
                          )
                        ],
                      ),
                ),
                onTap: () => null,
              ),
            ),
          );
        }

        cid++;
      }

      Container container = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subChildren.toList(),
        ),
      );

      parentList.add(container);
    }
    homePageBloc.homepageSink.add(parentList.toList());
  }
}