import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptv/Utils/Ambiente.dart';
import 'package:apptv/Models/CitaResponse.dart';

class CitaDetailPage extends StatefulWidget {
  final int citaId;

  const CitaDetailPage({Key? key, required this.citaId}) : super(key: key);

  @override
  State<CitaDetailPage> createState() => _CitaDetailPageState();
}

class _CitaDetailPageState extends State<CitaDetailPage> {
  late Future<CitaResponse> citaDetalle;

  @override
  void initState() {
    super.initState();
    citaDetalle = obtenerCitaDetalle();
  }

  Future<CitaResponse> obtenerCitaDetalle() async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.urlServer}/api/citas/${widget.citaId}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        CitaResponse cita = CitaResponse.fromJson(data);
        cita.DoctorNombre = await obtenerNombreDoctor(cita.idDoctor);
        return cita;
      } else {
        throw Exception('Error al obtener el detalle de la cita: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw e; // Re-throw the exception to be caught by the FutureBuilder
    }
  }

  Future<String> obtenerNombreDoctor(int idDoctor) async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.urlServer}/api/doctor/$idDoctor'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['nombre'];
      } else {
        throw Exception('Error al obtener el nombre del doctor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return 'Nombre desconocido'; // Fallback if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Detalle de Cita",
          style: TextStyle(
            fontSize: 32, // Tamaño de fuente aumentado para TV
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<CitaResponse>(
        future: citaDetalle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final cita = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32.0), // Padding aumentado para TV
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32.0), // Padding aumentado para TV
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Estado de la Cita: ${cita.estado}',
                        style: TextStyle(
                          fontSize: 24, // Tamaño de fuente aumentado para TV
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.0), // Espacio aumentado para TV
                      Text(
                        'Nombre del Doctor: ${cita.DoctorNombre}',
                        style: TextStyle(
                          fontSize: 24, // Tamaño de fuente aumentado para TV
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.0), // Espacio aumentado para TV
                      Text(
                        'Fecha y Hora: ${cita.fechaHora}',
                        style: TextStyle(
                          fontSize: 24, // Tamaño de fuente aumentado para TV
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.0), // Espacio aumentado para TV
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron detalles'));
          }
        },
      ),
    );
  }
}
