import 'package:flutter/material.dart';
import 'package:tienda_online/pages/editData.dart';
import 'package:tienda_online/pages/listarUsuarios.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({required this.index, required this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/deleteData.php');

  void deleteData() {
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      title: new Text("ELIMINAR"),
      content: new Text(
          "¿ESTÁ SEGURO DE ELIMINAR '${widget.list[widget.index]['username']}'?"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "SI",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.pushReplacementNamed(context, '/listar');
          },
        ),
        new RaisedButton(
          child: new Text("NO", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("DETALLE")),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.amber,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          }),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['username'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Text(
                  "Rol : ${widget.list[widget.index]['nivel']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDITAR"),
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    VerticalDivider(),
                    new RaisedButton(
                      child: new Text("ELIMINAR"),
                      color: Colors.redAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () => confirm(),
                    ),
                    VerticalDivider(),
                    new RaisedButton(
                      child: new Text("REGRESAR"),
                      color: Colors.amber,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/listar');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
