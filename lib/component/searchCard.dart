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

class SearchCard {
  int id;
  String thumbnail, name;

  SearchCard ({this.id, this.thumbnail, this.name});

  factory SearchCard.fromJson(Map<String, dynamic> json) {
    return SearchCard(
        id: json['id'],
        thumbnail: json['thumbnail'],
        name: json['name']
      );
  } 
}

class SearchCardWidget extends StatelessWidget {
  SearchCardWidget({this.id, this.thumbnail, this.name, this.onTap});

  /// Title to show
  final int id;
  final String thumbnail, name;

  final VoidCallback onTap;
  /// Callback that fires when the user taps on this widget

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Row(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: Image.network(
                  thumbnail==null?"http://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg":thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              new Flexible(
                child: new Text(name)
              )
            ]
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      )
    );
  }
}
