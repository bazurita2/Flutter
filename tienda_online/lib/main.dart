import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_online/inventario.dart';
import 'package:tienda_online/pages/listarUsuarios.dart';
import 'package:tienda_online/menu.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

String username = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIENDA ONLINE',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/listar': (BuildContext context) => new ListarUsuarios(),
        '/menu': (BuildContext context) => new Menu(
              username: username,
            ),
        '/inventario': (BuildContext context) => new Inventario(
              username: username,
            ),
        '/login': (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url = Uri.parse(
      'https://sitioinvestigacionarquiespe.000webhostapp.com/tienda/login.php');
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';
  Future<List> _login() async {
    final response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    Uri uriMantenimiento =
        Uri.parse("https://localhost:44396/Views/Mantenimiento/ActivoView");
    Uri uriContabilidad =
        Uri.parse("https://localhost:44396/Views/Contabilidad/TipoCuentaView");
    Uri uriBilbioteca =
        Uri.parse("https://localhost:44396/Views/Biblioteca/AutorView");

    if (datauser.length == 0) {
      setState(() {
        msg = "Usuario o contraseña incorrectas";
      });
    } else {
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/menu');
      } else if (datauser[0]['nivel'] == 'cliente') {
        if (datauser[0]['username'] == 'pancho') {
          if (await canLaunchUrl(uriBilbioteca)) {
            await launchUrl(uriBilbioteca);
          } else {
            throw "Could not launch $url";
          }
        } else if (datauser[0]['username'] == 'david') {
          if (await canLaunchUrl(uriContabilidad)) {
            await launchUrl(uriContabilidad);
          } else {
            throw "Could not launch $url";
          }
        } else if (datauser[0]['username'] == 'bryan') {
          if (await canLaunchUrl(uriMantenimiento)) {
            await launchUrl(uriMantenimiento);
          } else {
            throw "Could not launch $url";
          }
        } else {
          if (await canLaunchUrl(uriMantenimiento)) {
            await launchUrl(uriMantenimiento);
          } else {
            throw "Could not launch $url";
          }
        }
        //Navigator.pushReplacementNamed(context, '/inventario');
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 77.0),
              child: new CircleAvatar(
                backgroundColor: Color(0xF81F7F3),
                child: new Image(
                  width: 135,
                  height: 135,
                  image: new AssetImage('assets/images/avatar7.png'),
                ),
              ),
              width: 170.0,
              height: 170.0,
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 93),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: user,
                      decoration: InputDecoration(
                          hintText: 'Usuario',
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Contraseña',
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Iniciar sesión"),
              color: Colors.orangeAccent,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                _login();
              },
            ),
            Text(
              msg,
              style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),
            )
          ],
        ),
      ),
    );
  }
}
