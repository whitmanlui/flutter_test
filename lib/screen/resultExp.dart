import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../component/searchCard.dart';
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

class ResultExpTab extends StatefulWidget {
  final int exp_id;
  final String exp, tags;
  ResultExpTab({Key key, this.exp_id, this.exp, this.tags})  : super(key: key) ;
  @override
  State<StatefulWidget> createState() {
    return _ResultExpTab();
  }
}

class _ResultExpTab extends State<ResultExpTab> {
  
  
  //List<CardList> liteems = [];
  List<SearchCard> listCard = [];
  final String api =
      'https://15j0dj94zk.execute-api.ap-east-1.amazonaws.com/dev';
  List cardDataList;
  Map cardData;
  final List<String> images = [
    "https://www.expeditecommerce.com/hubfs/Expedite/images/demo/online-college-header.jpg",
    "http://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg"
  ];
  Future fetchConfig() async {
    try {
      print("hi ${widget.exp_id.toString()} ${widget.exp} ${widget.tags} ");
      http.Response res = await http.get('${api}/searchExp?city_id=${widget.exp_id.toString()}&tags=${widget.tags}');
      debugPrint(res.body);

      var map = new Map<String, dynamic>();
      map["test"] = "test";
      http.Response test = await http.post('${api}/postTest', body: map);
      debugPrint(test.body);
      
      
      cardData = json.decode(res.body);
      debugPrint(cardData.toString());
      if (cardData != null) {
        cardDataList = cardData['data'];
        //ListCardWidget lists;
        //listCard = cardDataList.map((Map<String, dynamic> v)=>SearchCard.fromJson(v)).toList();
        print(cardDataList.toString());
        for (int y = 0; y < cardData['data'].length; y++) {
          setState(()=>listCard.add(SearchCard.fromJson(cardDataList[y])));
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
    listOrder.add(new SizedBox(
      height: 60.0,
    ));
    for (int i = 0; i < listCard.length; i++) {
      listOrder.add(new SearchCardWidget(
          id: listCard[i].id,
          thumbnail: listCard[i].thumbnail,
          name: listCard[i].name,
          onTap: ()=>print(listCard[i].name.toString())));
      //listOrder.add(new Text(listCard[i].name));
    }

    return new Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: new Stack( //backgroundColor: Colors.red,
        children: <Widget>[
          new ListView(
            children: listOrder,
          ),
          new Positioned(
              left: 15.0,
              right: 15.0,
              top: 0.0,
              child: new Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ]),
                child: Center(
                  child: FlatButton(
                    child: Row(
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
                    onPressed: () {
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
        )
      );
  }
}
