import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Login'),
        /* actions: [
          new FlatButton(
              onPressed: () {
                Navigator
                    .of(context)
                    .pop();
              },
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],*/
      ), 
      body: new Text("This is login page"),
    );
  }
}