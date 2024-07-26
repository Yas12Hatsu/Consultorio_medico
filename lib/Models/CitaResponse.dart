class CitaResponse {
  final int id;
  final int idPaciente;
  final int idEspecialidad;
  final String fechaHora;
  final int idDoctor;
  final int idConsultorio;
  final String estado;

  // Campo adicional para el nombre de la especialidad
  String especialidadNombre;
  String DoctorNombre;

  CitaResponse({
    required this.id,
    required this.idPaciente,
    required this.idEspecialidad,
    required this.fechaHora,
    required this.idDoctor,
    required this.idConsultorio,
    required this.estado,
    this.especialidadNombre = '',  // Asignar valor predeterminado
    this.DoctorNombre = '',  // Asignar valor predeterminado
  });

  factory CitaResponse.fromJson(Map<String, dynamic> json) {
    return CitaResponse(
      id: json['id'],
      idPaciente: json['id_paciente'],
      idEspecialidad: json['id_especialidad'],
      fechaHora: json['FechaHora'],
      idDoctor: json['id_doc'],
      idConsultorio: json['id_consultorio'],
      estado: json['estado'],
      especialidadNombre: '',  // Inicializar con un valor vacío
      DoctorNombre: '',
    );
  }
}
