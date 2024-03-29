import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Inventario extends StatelessWidget {
  Inventario({required this.username});
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/getdataProductos.php');
  final String username;

  Future<List> getData() async {
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("PRODUCTOS"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data!,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.amberAccent,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['prod_nombre'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 77.0,
                  color: Colors.black,
                ),
                subtitle: new Text(
                  "Cantidad : ${list[i]['prod_cantidad']} \nPrecio : ${list[i]['prod_precio']} \nMarcador : ${list[i]['prod_marcador']}",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
