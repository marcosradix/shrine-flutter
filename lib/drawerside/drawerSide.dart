import 'package:flutter/material.dart';

const String _image = 'assets/diamond.png';

class DrawerSide extends StatefulWidget {
  @override
  _DrawerSideState createState() => new _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  final snackBar = new SnackBar(
    content: new Text("Texto copiado com sucesso!"),
  );
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Marcos Ferreira'),
            accountEmail: const Text('marcosradix@gmail.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: const AssetImage(_image),
            ),
            otherAccountsPictures: <Widget>[
              new GestureDetector(
                onTap: () {/* alguma ação aqui */},
                child: new Semantics(
                  label: 'Mudar de conta',
                  child: const CircleAvatar(
                    backgroundImage: const AssetImage(_image),
                  ),
                ),
              ),
            ],
          ),
          new ListTile(
            title: new Text("Cadastro"),
            onTap: () {
              //this.actionTile("Cadastro");
              Navigator.of(context).pop();
              alertDialogFull("Cadastro");
            },
          ),
          new ListTile(
            title: new Text("Edição"),
            onTap: () {
              //this.actionTile("Edição");
              Navigator.of(context).pop();
              alertDialogFull("Edição");
            },
          ),
        ],
      ),
    );
  }

  alertDialogFull(String value) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Informação"),
            content: new Text(value),
            actions: <Widget>[
              new FlatButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(_).pop();
                },
              ),
            ],
          ),
    );
  }
}
