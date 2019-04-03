import 'package:flutter/material.dart';
import 'package:doggie_app/model/doggie_dog.dart';
import 'package:doggie_app/utils/doggie_bloc_provider.dart';

class DoggieHomePageContentLayout extends StatelessWidget {

  DoggieHomePageContentLayout({@required this.dogs});

  final List<Dog> dogs;
  final List<Container> parentList = [];
  final int numColsInRow = 3;

  @override
  Widget build(BuildContext context) {
    MaterialColor appTheme = DoggieBlocProvider.of(context).appTheme;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: this._buildContentBody(appTheme)
    );
  }


  ///  Creates the scattered gridview on the Dogs Homapage
  /// @Author: Adetunji
  /// @params: MaterialColor appTheme
  /// @return List<Container>

  List<Container> _buildContentBody(MaterialColor appTheme) {

    int numIteration = int.parse((this.dogs.length/this.numColsInRow).ceil().toString());
    int cid = 0;
    int len = dogs.length;

    print("numColsInRow: ${this.numColsInRow}, numIteration: $numIteration");

    for( int i = 0; i < numIteration; i++ ) {

      List<Container> subChildren = [];

      for( int j = 0; j < this.numColsInRow; j++ ) {

        if ( cid >= len ) break;

        if ( j % 2 != 0 ) subChildren.add(this._buildLowerContainer(this.dogs[cid]));
        else subChildren.add(this._buildUpperContainer(this.dogs[cid], appTheme));

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

      this.parentList.add(container);
    }

    return this.parentList.toList();
  }


  Container _buildLowerContainer(Dog dogs) => Container(
    margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
    child: GestureDetector(
      child: Hero(
        tag: dogs.petName,
        transitionOnUserGestures: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 53.0,
              backgroundImage: NetworkImage(dogs.petPicURL),
            ),
            SizedBox(height: 5.0,),
            Align(
              alignment: Alignment.center,
              child: Text(dogs.petName),
            )
          ],
        ),
      ),
      onTap: () => null,
    ),
  );


  Container _buildUpperContainer(Dog dogs, MaterialColor appTheme) => Container(
    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    child: GestureDetector(
      child: Hero(
        tag: dogs.petName,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 53.0,
              backgroundColor: appTheme[800],
              backgroundImage: NetworkImage(dogs.petPicURL),
            ),
            SizedBox(height: 5.0,),
            Align(
              alignment: Alignment.center,
              child: Text(dogs.petName),
            )
          ],
        ),
      ),
      onTap: () => null,
    ),
  );
}