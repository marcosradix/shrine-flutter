import 'package:flutter/material.dart';


class DrawerSide extends StatefulWidget {
  @override
  _DrawerSideState createState() => new _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
              child: new Text("Menu Lateral"),
          ),
          new ListTile(
            title: new Text("Cadastro"),
          ),
          new ListTile(
            title: new Text("Edição"),
          ),
        ],
      ),
    );
  }
}
