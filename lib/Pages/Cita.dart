import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appwear/Utils/Ambiente.dart';
import 'package:appwear/Models/CitaResponse.dart';
import 'CitaDetailPage.dart';
import 'package:appwear/Utils/globals.dart' as globals;

class Cita extends StatefulWidget {
  final int idPaciente;

  const Cita({Key? key, required this.idPaciente}) : super(key: key);

  @override
  State<Cita> createState() => _CitaState();
}

class _CitaState extends State<Cita> {
  List<CitaResponse> citas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    obtenerCitas();
  }

  Future<void> obtenerCitas() async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.urlServer}/api/citas/paciente/${widget.idPaciente}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<CitaResponse> citasTemp = [];

        for (var json in data) {
          CitaResponse cita = CitaResponse.fromJson(json);
          // Obtener el nombre de la especialidad para cada cita
          cita.especialidadNombre = await obtenerNombreEspecialidad(cita.idEspecialidad);
          citasTemp.add(cita);
        }

        setState(() {
          citas = citasTemp;
          isLoading = false;
        });
      } else {
        throw Exception('Error al obtener las citas: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  Future<String> obtenerNombreEspecialidad(int idEspecialidad) async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.urlServer}/api/especialidad/$idEspecialidad'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['nombre'];
      } else {
        throw Exception('Error al obtener el nombre de la especialidad: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return 'Especialidad desconocida';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Color de fondo azul
        flexibleSpace: Center(
          child: Text(
            "MIS CITAS",
            style: TextStyle(
              fontSize: 16, // Tamaño de fuente
              fontWeight: FontWeight.bold, // Negritas
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Bienvenid@, ${globals.nombreUsuario}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : citas.isEmpty
                ? const Center(child: Text('No tienes citas'))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0), // Añadir márgenes laterales
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0), // Espacio al final de la lista
                    child: ListView.separated(
                      itemCount: citas.length,
                      separatorBuilder: (context, index) => Divider(color: Colors.grey[300]), // Línea divisora
                      itemBuilder: (context, index) {
                        final cita = citas[index];
                        return ListTile(
                          title: Text(
                            'Especialidad: ${cita.especialidadNombre}',
                            style: TextStyle(fontSize: 12), // Tamaño del texto
                          ),
                          subtitle: Text(
                            'Fecha y Hora: ${cita.fechaHora}',
                            style: TextStyle(fontSize: 12), // Tamaño del texto
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CitaDetailPage(citaId: cita.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // El Padding al final evita que el contenido quede oculto detrás del borde del reloj
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
