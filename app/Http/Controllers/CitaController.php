<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cita;

class CitaController extends Controller
{
    public function store(Request $request)
    {
        if ($request->id != 0) {
            $cita = Cita::find($request->id);
        } else {
            $cita = new Cita();
        }
            $cita = new Cita();
            $cita->id_paciente = $request->id_paciente;
            $cita->id_especialidad = $request->id_especialidad;
            $cita->FechaHora = $request->FechaHora;
            $cita->id_doc = $request->id_doc;
            $cita->id_consultorio = $request->id_consultorio;
            $cita->estado = $request->estado;
            $cita->save();

            return response()->json('Ok', 200);
    }

    public function show(Request $request)
    {
        $cita = Cita::find($request->id);
        return response()->json($cita);
    }

    public function list(Request $request)
    {
        $idPaciente = $request->input('id');
        $citas = Cita::where('id_paciente', $idPaciente)->get();
        return response()->json($citas);
    }

    public function getCitasPorPaciente($idPaciente)
    {
        // Obtener todas las citas asociadas con el ID del paciente
        $citas = Cita::where('id_paciente', $idPaciente)->get();

        // Verificar si se encontraron citas
        if ($citas->isEmpty()) {
            return response()->json(['message' => 'No se encontraron citas para este paciente'], 404);
        }

        return response()->json($citas);
    }
    
}
