import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  Menu({required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('MENU - ADMINISTRADOR'),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.amber,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
      body: new Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 150),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new RawMaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/listar');
                      },
                      child: new Icon(
                        Icons.people,
                        color: Colors.blueAccent,
                        size: 63.0,
                      ),
                      shape: new CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                    ),
                    Text(
                      "CRUD - CLIENTES",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                )),
          ],
        ),
      ]),
    );
  }
}
