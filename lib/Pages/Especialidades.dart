import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyectos_flutter/Models/EspecialidadResponse.dart';
import 'package:http/http.dart' as http;
import 'package:proyectos_flutter/Pages/Especialidad.dart';
import 'package:proyectos_flutter/Pages/Paciente.dart';
import 'package:proyectos_flutter/Utils/Ambiente.dart';

class Especialidades extends StatefulWidget {
  const Especialidades({super.key});

  @override
  State<Especialidades> createState() => _EspecialidadesState();
}

class _EspecialidadesState extends State<Especialidades> {

  List<EspecialidadResponse> especialidades = [];

  Widget _listViewEspecialidades(){
    return ListView.builder(
        itemCount: especialidades.length,
        itemBuilder: (context, index){
          var especialidad= especialidades[index];
          return ListTile(
            onTap: () {Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  Especialidad(idEspecialidad: especialidad.id,)
              ),
            );},
            title: Text(especialidad.id.toString()),
            subtitle: Text(especialidad.nombre),
          );
        }
    );
  }

  void fnObtenerEspecialidades() async {
    var response = await http.get(Uri.parse('${Ambiente.urlServer}/api/especialidades'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
        'Accept' : 'application/json'
      }
    );

    print(response.body);

      Iterable mapEspecialidades = jsonDecode(response.body);
      especialidades = List<EspecialidadResponse>
                      .from(
                            mapEspecialidades.map((model)
                            => EspecialidadResponse.fromJson(model))
                      );
    setState((){
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnObtenerEspecialidades();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidades'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              // Acciones a realizar cuando se selecciona una opción
            },
            itemBuilder: (BuildContext context) {
              fnObtenerEspecialidades(); //LO QUE ACTUALIZA LA LISTA
              return {'Actualizar Lista'}.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Paciente(idPaciente: 0),
                  ),
                );
              },
              child: Text('Agregar paciente'),
            ),
          ),
          Expanded(
            child: _listViewEspecialidades(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => const Especialidad(idEspecialidad: 0,)
          ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
