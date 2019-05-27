import 'package:flutter/material.dart';
import 'login.dart';
import '../translations.dart';

class MeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Tour Tab",
                style: new TextStyle(color: Colors.white),
              ),
              new FlatButton.icon(
                color: Colors.red,
                icon: Icon(Icons.lock), //`Icon` to display
                label: Text('Login'), //`Text` to display
                onPressed: () {
                  //Code to execute when Floating Action Button is clicked
                  //...
                  //Navigator.of(context).pushNamed('/firstpage');
                    Navigator.of(context).push(new MaterialPageRoute<Null>(
                        builder: (BuildContext context) {
                          return new LoginPage();
                        },
                      fullscreenDialog: true
                    ));
                },
              ),
              new FlatButton.icon(
                color: Colors.red,
                icon: Icon(Icons.lock), //`Icon` to display
                label: Text('Login'), //`Text` to display
                onPressed: () {
                  TranslationsDelegate(
                    
                  );
                  applic.onLocaleChanged(new Locale('zh',''));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}