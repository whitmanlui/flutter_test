import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({this.title, this.image, this.type, this.onTap});

  final String title;
  final String image;
  final String type;

  /// Callback that fires when the user taps on this widget
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: onTap,
        child: Container(
          //width: 300,
          width: type == 'horizontal_themed_card' ? MediaQuery.of(context).size.width - 30 : MediaQuery.of(context).size.width / 2 - 30,
          //height: 200,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class CardList {
  String name;
  String thumbnail;
  //VoidCallback onTap;
  CardList({this.name, this.thumbnail});

  //convert to json
  factory CardList.fromJson(Map<dynamic, dynamic> json) {
    return CardList(
        name: json['name'],
        thumbnail: json['thumbnail']
      );
  } 

}

class ListCardWidget extends StatelessWidget {
  ListCardWidget({this.title, this.image, this.type});

  /// Title to show
  final String title;
  final String type;
  /// Airport to show
  final List<CardList> image;

  /// Callback that fires when the user taps on this widget

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 200.0,
        //width: screenSize.width,
        //margin: EdgeInsets.symmetric(vertical: 20.0),
        child: new Column(
      // center the children
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            //color: Colors.red,
            child: Text(
              title,
              style: new TextStyle(color: Colors.black),
              textAlign: TextAlign.left
            ),
          ),
        ),
        new Container(
            height: 200.0,
            child: ListView.builder(

                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: image.length,
                itemBuilder: (context, index) {
                  final item = image[index];
                  return CardWidget(
                      title: item.name,
                      image: item.thumbnail,
                      type: type,
                      onTap: () {
                        print('tapping ${item.name}');
                      });
                }))
      ],
    ));
  }
}
