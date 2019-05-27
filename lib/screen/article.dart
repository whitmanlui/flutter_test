import 'package:flutter/material.dart';
import '../component/card.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

/* class CardList {
  String title;
  String image;

  CardList ( this.title, this.image);
} */
class ArticleTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleTab();
  }
}

class _ArticleTab extends State<ArticleTab> {
  List<CardList> liteems = [];
  List<ListCardWidget> listCard = [];
  final String api = 'https://15j0dj94zk.execute-api.ap-east-1.amazonaws.com/dev';
  Map config;
  List configData;
  Map cardData;
  Future fetchConfig() async {
    try{
      http.Response res = await http.get('${api}/getConfig');
      debugPrint(res.body);
      config = json.decode(res.body);
      debugPrint(config.toString());
      if(config != null){
        List a = config['layout']['exp']['row'];
        //ListCardWidget lists;
        
        for(int i = 0; i < a.length; i++){
          http.Response resCard = await http.get(a[i]['endpoint']);
          cardData = json.decode(resCard.body);
          
          List<CardList> b = [];
          for(int y = 0; y < cardData['cardArray'].length; y++){
            //print(cardData['cardArray'][i]['name']);
            //print(CardList.fromJson(cardData['cardArray'][i]).toString());
            b.add(CardList.fromJson(cardData['cardArray'][y]));
            
          }
          //debugPrint(configData.toString());
          //lists = new ListCardWidget(title: a[i]['title'], image: b);
          //listCard.add(new ListCardWidget(title: a[i]['title'], image: b, type: a[i]['type']));
          setState((){
            listCard.add(new ListCardWidget(title: a[i]['title'], image: b, type: a[i]['type']));
          });
        }
      }
      
    } catch (e){
      print('Err: ${e}');
    }

  }
  @override
  void initState() {
    super.initState();
    fetchConfig();
    /* liteems.add(new CardList(name: "title",
        thumbnail: "https://www.expeditecommerce.com/hubfs/Expedite/images/demo/online-college-header.jpg"));
    liteems.add(new CardList(name: "title1",
        thumbnail: "http://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg"));

    listCard.add(new ListCardWidget(title: "Title 1", image: liteems));
    listCard.add(new ListCardWidget(title: "Title 2", image: liteems)); */
    //listCard.add(new ListCardWidget("Title 2", liteems));
  }

  @override
  Widget build(BuildContext context) {
     List<Widget> listOrder = [];
    //if(configData.length > 0){
      /* int len = configData == null ? 0 : configData.length;
      print(len);
      for (int i=0;i< len; i++){
        print(configData[i]["endpoint"]);
        listOrder.add(new CardWidget(
                    title: configData[i]["name"],
                    image: configData[i]["thumbnail"],
                    onTap: () {
                      print('tapping ${configData[i]["name"]}');
                    })
        ); */
      //}
    //}
    print("im here ${listOrder.length} ${listCard.length}");
    for (int i=0;i<listCard.length; i++){
      
      listOrder.add(new ListCardWidget(title: listCard[i].title,
                      image: listCard[i].image, type: listCard[i].type));
    } 

    return new Scaffold(
      backgroundColor: Colors.red,
      body: new ListView(
        //shrinkWrap: true,
        children: listOrder /*<Widget>[
              new Text(
                "Article Tab",
                style: new TextStyle(color: Colors.white),
              ),
              new CardWidget(
                  title: "Test",
                  image:
                      "http://wowslider.com/sliders/demo-31/data1/images/bench560435.jpg",
                  onTap: () {
                    print("taptatpatpatpatp");
                  }),
              /* new ListView.builder(
                  shrinkWrap: true,
                  itemCount: listCard.length,
                  itemBuilder: (context, index) {
                    final item = listCard[index];
                    print(item);
                    return ListCardWidget(
                      title: item.title,
                      image: item.image,
                    );
              }), */
              new Container(
                  //margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 200.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: liteems.length,
                      itemBuilder: (context, index) {
                        final item = liteems[index];
                        return CardWidget(
                            title: item.title,
                            image: item.image,
                            onTap: () {
                              print("tap " + item.title);
                            });
                      }))
            ], */
          ),
      );
  }
}
