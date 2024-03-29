import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_online/pages/listarUsuarios.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({required this.list, required this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/editdata.php');

  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerNivel = new TextEditingController();

  void editData() {
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "nivel": controllerNivel.text
    });
  }

  @override
  void initState() {
    controllerUsername =
        new TextEditingController(text: widget.list[widget.index]['username']);
    controllerPassword =
        new TextEditingController(text: widget.list[widget.index]['password']);
    controllerNivel =
        new TextEditingController(text: widget.list[widget.index]['nivel']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDITAR"),
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
        child: ListView(
          padding: const EdgeInsets.all(10.0),
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
                new ListTile(
                  leading: const Icon(Icons.lock, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerNivel,
                    validator: (value) {
                      if (value!.isEmpty) return "INGRESAR ROL";
                    },
                    decoration: new InputDecoration(
                      hintText: "Rol",
                      labelText: "Rol",
                    ),
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new RaisedButton(
                      child: new Text("GUARDAR"),
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        editData();
                        Navigator.pushReplacementNamed(context, '/listar');
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
    );
  }
}
