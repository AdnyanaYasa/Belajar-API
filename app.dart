import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/penulis.dart';
import 'from_add_screen.dart';
import 'home_screen.dart';
import 'penulis.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black38,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return penulis();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.account_box,
                  color: Colors.white,

                ),
              ),
            ),

          title: Text(
            "Flutter CRUD",
            style: TextStyle(
              color: Colors.white,
            ),
          ),

        ),
        body: Container(
          color: Colors.orange,
          child: HomeScreen(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              _scaffoldState.currentContext,
              MaterialPageRoute(builder: (BuildContext context) {

                return FormAddScreen();
              }),
            );
          },

          child: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(
              Icons.add,
              color: Colors.orange,
            ),
          ),

        ),
      ),
    );
  }
}
