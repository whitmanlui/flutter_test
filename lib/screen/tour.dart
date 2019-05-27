import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../component/card.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import 'dart:async';
import 'dart:convert';

import './searchExp.dart';
/* class CardList {
  String title;
  String image;

  CardList ( this.title, this.image);
} */
class TourTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TourTab();
  }
}

class _TourTab extends State<TourTab> {
  List<CardList> liteems = [];
  List<ListCardWidget> listCard = [];
  final String api =
      'https://15j0dj94zk.execute-api.ap-east-1.amazonaws.com/dev';
  Map config;
  List configData;
  Map cardData;
  final List<String> images = [
    "https://www.expeditecommerce.com/hubfs/Expedite/images/demo/online-college-header.jpg",
    "http://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg"
  ];
  Future fetchConfig() async {
    try {
      http.Response res = await http.get('${api}/getConfig');
      debugPrint(res.body);
      config = json.decode(res.body);
      debugPrint(config.toString());
      if (config != null) {
        List a = config['layout']['exp']['row'];
        //ListCardWidget lists;

        for (int i = 0; i < a.length; i++) {
          http.Response resCard = await http.get(a[i]['endpoint']);
          cardData = json.decode(resCard.body);

          List<CardList> b = [];
          for (int y = 0; y < cardData['data'].length; y++) {
            b.add(CardList.fromJson(cardData['data'][y]));
          }

          setState(() {
            listCard.add(new ListCardWidget(
                title: a[i]['title'], image: b, type: a[i]['type']));
          });
        }
      }
    } catch (e) {
      print('Err: ${e}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchConfig();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOrder = [];
    List<Widget> dot = [];
    int _current = 0;
    double width = MediaQuery.of(context).size.width;
    for (int i = 0; i < images.length; i++) {
      dot.add(new Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == i ? Colors.green : Color.fromRGBO(0, 0, 0, 0.4)),
      ));
    }

    listOrder.add(new Stack(children: [
      CarouselSlider(
        height: 300,
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
        autoPlay: true,
        viewportFraction: 1.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: dot))
    ]));

    for (int i = 0; i < listCard.length; i++) {
      listOrder.add(new ListCardWidget(
          title: listCard[i].title,
          image: listCard[i].image,
          type: listCard[i].type));
    }

    return new Scaffold(
      body: new Stack( //backgroundColor: Colors.red,
        children: <Widget>[
          new ListView(
            children: listOrder,
          ),
          new Positioned(
              left: 15.0,
              right: 15.0,
              top: 50.0,
              child: new Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ]),
                //padd
                //decoration: new BoxDecoration(color: Colors.red),
                child: Center(
                  child: FlatButton(
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * .75,
                            child: Center(
                              child: Text("探索失戀旅程",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )),
                        Icon(Icons.send),
                      ],
                    ),
                    //icon: Icon(Icons.add_a_photo), //`Icon` to display
                    //label: Text('探索失戀旅程'), //`Text` to display
                    onPressed: () {
                      //Code to execute when Floating Action Button is clicked
                      //...
                      //Navigator.of(context).push(new MaterialPageRoute(builder: (context) => LoginPage()));
                      Navigator.push(context, PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return SearchExpPage();
                        },
                        transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: RotationTransition(
                              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                              child: child,
                            ),
                          );
                        }
                      ));
                    },
                  ),
                ),
              )),
        ]
        ));
  }
}
