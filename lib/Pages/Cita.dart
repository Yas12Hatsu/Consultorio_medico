import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyectos_flutter/Utils/Ambiente.dart';
import 'package:proyectos_flutter/Utils/globals.dart' as globals;
import 'package:quickalert/quickalert.dart';

class Cita extends StatefulWidget {
  final int idPaciente;

  const Cita({Key? key, required this.idPaciente}) : super(key: key);

  @override
  State<Cita> createState() => _CitaState();
}

class _CitaState extends State<Cita> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtFechaHora = TextEditingController();
  int? selectedDoctor;
  int? selectedEspecialidad;
  int? selectedConsultorio;
  String? selectedEstado;

  List<dynamic> especialidades = [];
  List<dynamic> doctores = [];
  List<dynamic> consultorios = [];
  List<String> estados = ['Pendiente', 'Aceptado'];

  @override
  void initState() {
    super.initState();
    obtenerEspecialidades();
    obtenerDoctores();
    obtenerConsultorios();
  }

  void obtenerEspecialidades() async {
    final response = await http.get(Uri.parse('${Ambiente.urlServer}/api/especialidades'));
    if (response.statusCode == 200) {
      setState(() {
        especialidades = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener la lista de especialidades');
    }
  }

  void obtenerDoctores() async {
    final response = await http.get(Uri.parse('${Ambiente.urlServer}/api/doctores'));
    if (response.statusCode == 200) {
      setState(() {
        doctores = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener la lista de doctores');
    }
  }

  void obtenerConsultorios() async {
    final response = await http.get(Uri.parse('${Ambiente.urlServer}/api/consultorios'));
    if (response.statusCode == 200) {
      setState(() {
        consultorios = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener la lista de consultorios');
    }
  }

  Future<void> generarCita() async {
    if (_formKey.currentState!.validate()) {
      try {
        print(jsonEncode({
          'id_paciente': widget.idPaciente,
          'id_especialidad': selectedEspecialidad,
          'id_doc': selectedDoctor,
          'id_consultorio': selectedConsultorio,
          'FechaHora': txtFechaHora.text,
          'estado': selectedEstado,
        }));

        final response = await http.post(
          Uri.parse('${Ambiente.urlServer}/api/cita/crear'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'id_paciente': widget.idPaciente,
            'id_especialidad': selectedEspecialidad,
            'id_doc': selectedDoctor,
            'id_consultorio': selectedConsultorio,
            'FechaHora': txtFechaHora.text,
            'estado': selectedEstado,
          }),
        );

        if (response.statusCode == 200) {
          // La cita se guardó correctamente
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse == 'Ok') {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Éxito',
              text: 'Cita creada exitosamente',
            );
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: 'No se pudo crear la cita',
            );
          }
        } else {
          // Error al conectar con el servidor
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Error en la solicitud HTTP',
          );
        }
      } catch (e) {
        // Error de red u otro tipo de error
        print('Error en la solicitud HTTP: $e');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Error en la solicitud HTTP',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Generar Cita",
        style: TextStyle(fontSize: 24),
    ),
    ),
    drawer: Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
    children: [
    DrawerHeader(
    decoration: BoxDecoration(
    color: Colors.blue,
    ),
    child: Column(
    children: [
    Expanded(
    child: Image(
    image: AssetImage('assets/images/bot-conversacional.png'),
    ),
    ),
    Text(
    globals.nombreUsuario,
    style: TextStyle(color: Colors.white),
    ),
    ],
    ),
    ),
    ListTile(
    leading: Icon(Icons.person_pin_rounded),
    title: Text('Clientes'),
    onTap: () {
    // Acción para clientes
    },
    ),
    ListTile(
    leading: Icon(Icons.login),
    title: Text('Cerrar Sesión'),
    onTap: () async {
    // Acción para cerrar sesión
    },
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
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: TextFormField(
    initialValue: globals.nombreUsuario,
    decoration: InputDecoration(
    labelText: 'Nombre del Paciente',
    border: OutlineInputBorder(),
    ),
    readOnly: true,
    ),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: DropdownButtonFormField<int>(
    value: selectedEspecialidad,
    onChanged: (value) {
    setState(() {
    selectedEspecialidad = value;
    });
    },
    items: especialidades.map<DropdownMenuItem<int>>((especialidad) {
    return DropdownMenuItem<int>(
    value: especialidad['id'],
    child: Text(especialidad['nombre']),
    );
    }).toList(),
    decoration: InputDecoration(labelText: 'Especialidad'),
    validator: (value) {
    if (value == null) {
    return 'Favor de seleccionar la especialidad';
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: DropdownButtonFormField<int>(
    value: selectedDoctor,
    onChanged: (value) {
    setState(() {
    selectedDoctor = value;
    });
    },
    items: doctores.map<DropdownMenuItem<int>>((doctor) {
    return DropdownMenuItem<int>(
    value: doctor['id'],
    child: Text(doctor['nombre']),
    );
    }).toList(),
    decoration: InputDecoration(labelText: 'Doctor'),
    validator: (value) {
    if (value == null) {
    return 'Favor de seleccionar el doctor';
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: DropdownButtonFormField<int>(
    value: selectedConsultorio,
    onChanged: (value) {
    setState(() {
    selectedConsultorio = value;
    });
    },
    items: consultorios.map<DropdownMenuItem<int>>((consultorio) {
    return DropdownMenuItem<int>(
    value: consultorio['id'],
    child: Text(consultorio['edificio']),
    );
    }).toList(),
    decoration: InputDecoration(labelText: 'Consultorio'),
    validator: (value) {
    if (value == null) {
    return 'Favor de seleccionar el consultorio';
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: DropdownButtonFormField<String>(
    value: selectedEstado,
    onChanged: (value) {
    setState(() {
    selectedEstado = value;
    });
    },
    items: estados.map<DropdownMenuItem<String>>((estado) {
    return DropdownMenuItem<String>(
    value: estado,
    child: Text(estado),
    );
    }).toList(),
    decoration: InputDecoration(labelText: 'Estado'),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Favor de seleccionar el estado';
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
    child: TextFormField(
    controller: txtFechaHora,
    readOnly: true,
    onTap: () async {
    DateTime? fechaSeleccionada = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (fechaSeleccionada != null) {
    TimeOfDay? horaSeleccionada = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    );
    if (horaSeleccionada != null) {
    setState(() {
    txtFechaHora.text = DateTime(
    fechaSeleccionada.year,
    fechaSeleccionada.month,
    fechaSeleccionada.day,
    horaSeleccionada.hour,
    horaSeleccionada.minute,
    ).toString();
    });
    }
    }
    },
    decoration: InputDecoration(
      labelText: 'Fecha y Hora',
      border: OutlineInputBorder(),
    ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Favor de seleccionar la fecha y hora';
        }
        return null;
      },
    ),
    ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ElevatedButton(
          onPressed: () async {
            await generarCita();
          },
          child: Text('Generar Cita'),
        ),
      ),
    ],
    ),
    ),
    ),
    );
  }
}
