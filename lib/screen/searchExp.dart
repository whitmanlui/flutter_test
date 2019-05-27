import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import './resultExp.dart';
import '../component/dropdown.dart';
class CityList {
  int id;
  String name;
  int country_id;
  int utc;

  CityList({this.id, this.name, this.country_id, this.utc});

  factory CityList.fromJson(Map<dynamic, dynamic> json) {
    return CityList(
        id: json['id'],
        name: json['name'],
        country_id: json['country_id'],
        utc: json['utc'],
      );
  } 
}

class SearchExpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchExpPage();
  }
}

class _SearchExpPage extends State<SearchExpPage> {
  String searchTxt = "";
  String destinationTxt = "1";
  String _dropdownValue;
  final String api =
      'https://15j0dj94zk.execute-api.ap-east-1.amazonaws.com/dev';

  List<CityList> cityList = [];
  Map citys;

  GlobalKey<AutoCompleteTextFieldState<CityList>> key = new GlobalKey();
  AutoCompleteTextField<CityList> textField;
  CityList selected;
  TextEditingController controller = new TextEditingController();

 //final List<DropdownMenuItem<CityList>> items;

  Future fetchCityList() async {
    try {
      http.Response res = await http.get('${api}/getCity');
      citys = json.decode(res.body);
      debugPrint(citys.toString());
      for(int i = 0 ; i < citys['data'].length; i++){
        setState(() {
          cityList.add(new CityList.fromJson(citys['data'][i]));
        });
      }
      textField = new AutoCompleteTextField<CityList>(
        textInputAction: TextInputAction.send,
        onFocusChanged: (t){},
        decoration: new InputDecoration(
          border:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        clearOnSubmit: false,
        itemSubmitted: (item) {         
          setState(() {
            textField.textField.controller.text = item.name;
            destinationTxt = item.name;
            selected = item;
          });
        },
        textChanged: (text){
          destinationTxt = text;
        },
        key: key,
        suggestions: cityList,
        itemBuilder: (context, suggestion) => new Padding(
            child: new ListTile(
                title: new Text(suggestion.name)),
            padding: EdgeInsets.all(8.0)
        ),
        itemSorter: (a, b) => a.id.compareTo(b.id),
        itemFilter: (suggestion, input) =>
          input == ""? suggestion:suggestion.name.toLowerCase().startsWith(input.toLowerCase()
        )
      );
      //cityList = citys['data'].map((model)=> CityList.fromJson(model)).toList();

      
    } catch (e) {
      print('Err2: ${e}');
    }
  }

  DropdownButton _normalDown() => DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "",
            child: Text(
              "",
            ),
          ),
          DropdownMenuItem(
            value: "1",
            child: Text(
              "First",
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Text(
              "Second",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            destinationTxt = value;
          });
        },
        value: destinationTxt,
        elevation: 2,
        style: TextStyle(color: Colors.black,fontSize: 30),
      );


  @override
  void initState() {
    super.initState();
    fetchCityList();
  }
  //String 
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 15, right: 15),
          child: new Column(
            // center the children
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: new Column(
                  children: <Widget>[
                    new Align(alignment: Alignment.centerLeft, child: new Text(
                      "開始探索",
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    )),
                    new Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: new TextField(
                        onChanged: (text) {
                          searchTxt = text;
                        },
                        textInputAction: TextInputAction.continueAction,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          /* enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ), */
                          hintText: "輸入關鍵字",
                          //add icon outside input field
                          //icon: Icon(Icons.search),
                          //add icon to the beginning of text field
                          prefixIcon: Icon(Icons.search),
                          //can also add icon to the end of the textfiled
                          //suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                      )
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Column(children: <Widget>[
                        new Align(alignment: Alignment.centerLeft, child: new Text(
                          "目的地",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 24.0
                          ),
                        )),
                        new Container(child: textField),
                      ],)
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Column(children: <Widget>[
                        new Align(alignment: Alignment.centerLeft, child: new Text(
                          "目的地",
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 24.0
                          ),
                        )),
                        //_normalDown(),
                        cityList.length > 0 ? ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton<String>(
                            isDense: false,
                            hint: new Text("",
                                textAlign: TextAlign.center),
                            value: destinationTxt,
                            onChanged: (String newValue) {
                              //print(newValue);
                              setState(() {
                                destinationTxt = newValue;   
                              });    
                            },
                            items: cityList.map((item) {
                              return new DropdownMenuItem<String>(
                                child: new Text(item.name),
                                value: item.id.toString(),
                              );
                            }).toList(),
                            isExpanded: true,
                            disabledHint: new Text(""),
                          ),
                       ) : Center(child: CircularProgressIndicator()),
                       //new DropdownWidget(data: cityList.map((item)=>item.name).toList())
                      ],)
                    ),
                    new InputDecorator(
                      decoration: InputDecoration(
                        labelText: "",
                        errorText: "",
                        border:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                      ),
                      isEmpty: _dropdownValue == null,
                      child: new DropdownButton<String>(
                        value: _dropdownValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        items: cityList.map((CityList value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.id.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ]
                )
              ),
              Container(
                // This align moves the children to the bottom
                margin: EdgeInsets.only(bottom: 30),
                color: Colors.transparent,
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: FlatButton(
                      onPressed: (){ 
                        print("${selected.id} ${destinationTxt}"); 
                        Navigator.push(context, PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return ResultExpTab(exp_id: selected.id, exp: destinationTxt, tags: searchTxt);
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
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * .85,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                ),
                              ]),
                              child: Center(
                                child: Text("顯示結果",
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 20.0)
                                  ),
                              )),
                        ],
                      ),
                    )
                )
              )
            ],
          ),
      )

    );
  }
}