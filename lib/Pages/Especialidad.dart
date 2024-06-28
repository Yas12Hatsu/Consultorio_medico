import 'package:flutter/material.dart';
import 'package:proyectos_flutter/Models/EspecialidadResponse.dart';
import 'package:proyectos_flutter/Pages/Especialidades.dart';
import 'package:http/http.dart' as http;
import 'package:proyectos_flutter/Utils/Ambiente.dart';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';

class Especialidad extends StatefulWidget {
  final int idEspecialidad;
  const Especialidad({super.key, required this.idEspecialidad});

  @override
  State<Especialidad> createState() => _EspecialidadState();
}

class _EspecialidadState extends State<Especialidad> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtNom = new TextEditingController();

  void fnEspecialidad() async {
    final response = await http.post(
        Uri.parse('${Ambiente.urlServer}/api/especialidad'),
        body: jsonEncode(<String, dynamic>{
          'id': widget.idEspecialidad,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        } //
    );

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    final especialidadResponse = EspecialidadResponse.fromJson(responseJson);
    txtNom.text = especialidadResponse.nombre;
  }

  void fnEspecialidadEliminar() async {
    final response = await http.post(
        Uri.parse('${Ambiente.urlServer}/api/especialidad/borrar'),
        body: jsonEncode(<String, dynamic>{
          'id': widget.idEspecialidad,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        } //
    );

    if (response.body == 'Ok'){
      Navigator.pop(context);
    } else{
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops..',
        text: response.body,
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.idEspecialidad !=0){
      fnEspecialidad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar especialidad"),
      ),

      drawer: Drawer(
        child: ListView(
// Important: Remove any padding from the ListView.
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person_pin_rounded),
              title: const Text('Clientes'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Cerrar Sesión'),
              onTap: () async {

              },
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: Column(
                children: [
                  TextFormField(
                    controller: txtNom,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Favor de ingresar el nombre';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final response = await http.post(
                    Uri.parse('${Ambiente.urlServer}/api/especialidad/crear'),
                    body: jsonEncode(<String, dynamic>{
                      'id': widget.idEspecialidad,
                      'nombre': txtNom.text,
                    }),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Accept': 'application/json',
                    },
                  );

                  print('Response status: ${response.statusCode}');
                  print('Response body: "${response.body}"');

                  final responseData = jsonDecode(response.body);

                  if (response.statusCode == 200 && responseData['message'] == "Ok") {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: 'Éxito',
                      text: 'Especialidad registrada correctamente',
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops..',
                      text: "Error al registrar",
                    );
                  }
                }
              },
              child: Text('Aceptar'),
            ),
            Visibility(
                visible: widget.idEspecialidad != 0,
                child: TextButton(onPressed: () {
                  fnEspecialidadEliminar();
                },
                child: Text('Eliminar'))),
          ],
        ),
      ),
    );
  }
}