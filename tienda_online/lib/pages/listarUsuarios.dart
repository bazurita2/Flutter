import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_online/pages/detail.dart';

import 'dart:async';
import 'dart:convert';

import 'package:tienda_online/pages/addData.dart';

class ListarUsuarios extends StatefulWidget {
  @override
  _ListarUsuariosState createState() => new _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/getdata.php');

  Future<List> getData() async {
    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CLIENTES"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddData(),
        )),
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
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['username'],
                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                ),
                leading: new Icon(
                  Icons.person_pin_rounded,
                  size: 60.0,
                  color: Colors.orangeAccent,
                ),
                subtitle: new Text(
                  "Rol : ${list[i]['nivel']}",
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
