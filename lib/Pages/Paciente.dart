import 'package:flutter/material.dart';
import 'package:apptv/Models/PacienteResponse.dart';
import 'package:apptv/Models/LoginResponse.dart';
import 'package:http/http.dart' as http;
import 'package:apptv/Utils/Ambiente.dart';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';

class Paciente extends StatefulWidget {
  final int idPaciente;

  const Paciente({super.key, required this.idPaciente});

  @override
  State<Paciente> createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtNom = new TextEditingController();
  TextEditingController txtEdad = new TextEditingController();
  TextEditingController txtTel = new TextEditingController();
  TextEditingController txtPeso = new TextEditingController();
  TextEditingController txtAltura = new TextEditingController();
  TextEditingController txtDireccion = new TextEditingController();
  TextEditingController txtCorreo = new TextEditingController();
  TextEditingController txtSangre = new TextEditingController();

  // Usuario
  TextEditingController txtRol = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agregar paciente",
          style: TextStyle(fontSize: 32), // Aumentado el tamaño de la fuente
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    const Expanded(
                        child: Image(
                            image: AssetImage(
                                'assets/images/bot-conversacional.png'))),
                    Text(
                      'Nombre del Agente',
                      style: const TextStyle(color: Colors.white, fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person_pin_rounded, size: 32), // Aumentado el tamaño del icono
              title: const Text('Clientes', style: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.login, size: 32), // Aumentado el tamaño del icono
              title: const Text('Cerrar Sesión', style: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
              onTap: () async {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtNom,
                      decoration: InputDecoration(labelText: 'Nombre', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar el nombre';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEdad,
                      decoration: InputDecoration(labelText: 'Edad', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar la edad';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtTel,
                      decoration: InputDecoration(labelText: 'Telefono', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar el telefono';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtPeso,
                      decoration: InputDecoration(labelText: 'Peso', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar el peso';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtAltura,
                      decoration: InputDecoration(labelText: 'Altura', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar la Altura';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtDireccion,
                      decoration: InputDecoration(labelText: 'Direccion', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar la Dirrecion';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtSangre,
                      decoration: InputDecoration(labelText: 'Tipo de Sangre', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar el Tipo de sangre';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtCorreo,
                      decoration: InputDecoration(labelText: 'Correo', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar el correo';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 60), // Aumentado los márgenes
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtPassword,
                      decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Favor de ingresar la Contraseña';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 24), // Aumentado el tamaño de la fuente
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await http.post(
                      Uri.parse('${Ambiente.urlServer}/api/paciente/crear'),
                      body: jsonEncode(<String, dynamic>{
                        'id': widget.idPaciente,
                        'nombre': txtNom.text,
                        'edad': txtEdad.text,
                        'telefono': txtTel.text,
                        'peso': txtPeso.text,
                        'altura': txtAltura.text,
                        'direccion': txtDireccion.text,
                        'correo': txtCorreo.text,
                        'tipo_sangre': txtSangre.text,
                        'name': txtNom.text,
                        'email': txtCorreo.text,
                        'password': txtPassword.text,
                        'role': "Paciente",
                      }),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json',
                      },
                    );
                    if (response.body == "Ok") {
                      Navigator.pop(context);
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops..',
                        text: "Error",
                      );
                    }
                  }
                },
                child: Text('Registrar', style: TextStyle(fontSize: 24)), // Aumentado el tamaño de la fuente
              ),
            ],
          ),
        ),
      ),
    );
  }
}
