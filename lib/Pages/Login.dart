import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyectos_flutter/Models/LoginResponse.dart';
import 'package:proyectos_flutter/Pages/Especialidades.dart';
import 'package:proyectos_flutter/Pages/Paciente.dart';
import 'package:proyectos_flutter/Pages/Cita.dart';
import 'package:proyectos_flutter/Utils/Ambiente.dart';
import 'package:proyectos_flutter/Utils/globals.dart' as globals;
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

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
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://cdn-icons-png.freepik.com/256/12669/12669809.png'),
              TextField(
                controller: txtUser,
                decoration: InputDecoration(
                    labelText: 'Usuario'
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
                child: TextField(
                  controller: txtPassword,
                  decoration: InputDecoration(
                      labelText: 'Contraseña'
                  ),
                  obscureText: true,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final response = await http.post(
                        Uri.parse('${Ambiente.urlServer}/api/login'),
                        body: jsonEncode(<String, dynamic>{
                          'email': txtUser.text,
                          'password': txtPassword.text
                        }),
                        headers: <String, String> {
                          'Content-Type': 'application/json; charset=UTF-8'
                        }
                    );

                    print(response.body);

                    Map<String, dynamic> responseJson = jsonDecode(response.body);
                    final loginResponse = LoginResponse.fromJson(responseJson);

                    if (loginResponse.acceso == "OK") {
                      globals.nombreUsuario = loginResponse.nombreUsuario; // Guardar el nombre del usuario globalmente
                      if (loginResponse.role.isNotEmpty && loginResponse.role == "Paciente") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cita(idPaciente: loginResponse.idUsuario)
                            )
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Especialidades()
                            )
                        );
                      }
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops..',
                        text: loginResponse.error,
                      );
                    }
                  },
                  child: Text('Iniciar Sesion')
              ),
              TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Paciente(idPaciente: 0)
                        )
                    );
                  },
                  child: Text('Registrar')
              ),
            ],
          ),
        )
    );
  }
}

