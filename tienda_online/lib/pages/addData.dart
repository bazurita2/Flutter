import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/adddata.php');

  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void addData() {
    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": dropdownValue.toString(),
    });
  }

  List<String> list = <String>['cliente', 'admin'];
  String dropdownValue = 'cliente';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("AGREGAR"),
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: new TextFormField(
                      controller: controllerUsername,
                      validator: (value) {
                        if (value!.isEmpty) return "INGRESAR USUARIO";
                      },
                      decoration: new InputDecoration(
                        hintText: "Usuario",
                        labelText: "Usuario",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.vpn_key, color: Colors.black),
                    title: new TextFormField(
                      controller: controllerPassword,
                      validator: (value) {
                        if (value!.isEmpty) return "INGRESAR CONTRASEÑA";
                      },
                      decoration: new InputDecoration(
                        hintText: "Contraseña",
                        labelText: "Contraseña",
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.lock),
                      ),
                      VerticalDivider(
                        width: 40.0,
                      ),
                      new Container(
                        height: 50.0,
                        width: 100.0,
                        child: DropdownButton<String>(
                          isDense: true,
                          hint: new Text("Rol"),
                          iconSize: 40.0,
                          elevation: 10,
                          value: dropdownValue,
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(30.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new RaisedButton(
                        child: new Text("AGREGAR"),
                        color: Colors.green,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addData();
                            Navigator.pushReplacementNamed(context, '/listar');
                          }
                        },
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
