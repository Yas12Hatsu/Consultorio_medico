import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:apptv/Models/LoginResponse.dart';
import 'package:apptv/Pages/Cita.dart';
import 'package:apptv/Utils/Ambiente.dart';
import 'package:apptv/Utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'Paciente.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Color de fondo azul
        title: const Text(
          "Iniciar Sesión",
          style: TextStyle(
            fontSize: 32, // Tamaño de fuente aumentado para TV
            fontWeight: FontWeight.bold, // Negritas
          ),
        ),
        centerTitle: true, // Centrar el título
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0), // Márgenes laterales aumentados para TV
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Espaciado vertical aumentado para TV
                  child: TextField(
                    controller: txtUser,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Padding aumentado para TV
                    ),
                    style: const TextStyle(fontSize: 24), // Tamaño del texto aumentado para TV
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Espaciado vertical aumentado para TV
                  child: TextField(
                    controller: txtPassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Padding aumentado para TV
                    ),
                    obscureText: true,
                    style: const TextStyle(fontSize: 24), // Tamaño del texto aumentado para TV
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Espaciado vertical aumentado para TV
                  child: ElevatedButton(
                    onPressed: () async {
                      final response = await http.post(
                        Uri.parse('${Ambiente.urlServer}/api/login'),
                        body: jsonEncode(<String, dynamic>{
                          'email': txtUser.text,
                          'password': txtPassword.text,
                        }),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                      );

                      print(response.body);

                      Map<String, dynamic> responseJson = jsonDecode(response.body);
                      final loginResponse = LoginResponse.fromJson(responseJson);

                      if (loginResponse.acceso == "OK") {
                        globals.nombreUsuario = loginResponse.nombreUsuario;
                        if (loginResponse.role == "Paciente") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cita(idPaciente: loginResponse.idUsuario),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Acceso denegado'),
                                content: const Text('Este usuario no tiene permisos de paciente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Oops..'),
                              content: Text(loginResponse.error),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color de fondo del botón
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Ajuste del padding para TV
                      textStyle: const TextStyle(color: Colors.white, fontSize: 24), // Tamaño del texto aumentado para TV
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Espaciado vertical aumentado para TV
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Paciente(idPaciente: 0),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue, // Color del texto
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Ajuste del padding para TV
                      textStyle: const TextStyle(fontSize: 24), // Tamaño del texto aumentado para TV
                    ),
                    child: const Text('Registrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
