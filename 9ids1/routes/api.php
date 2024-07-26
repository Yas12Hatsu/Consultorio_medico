<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\EspecialidadController;
use App\Http\Controllers\ConsultorioController;
use App\Http\Controllers\MedicamentoController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PacienteController;
use App\Http\Controllers\CitaController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//APIS DE DOCTOR
//Route::prefix('doctores')->group(function() {
Route::get('doctores/', [DoctorController::class, 'list']); // Lista doctores
Route::post('doctor/crear', [DoctorController::class, 'store']); // Crear nuevo doctor
//Route::put('doctor/editar/{id}', [DoctorController::class, 'update']); // Actualizar doctor con parametros
Route::post('doctor/borrar/', [DoctorController::class, 'delete']); // Eliminar doctor
Route::post('doctor/', [DoctorController::class, 'show']); // Mostrar 1 doc

//APIS DE ESPECIALIDAD
Route::get('especialidades/', [EspecialidadController::class, 'list']); 
Route::post('especialidad/crear', [EspecialidadController::class, 'store']); 
Route::post('especialidad/borrar', [EspecialidadController::class, 'delete']);
Route::post('especialidad/', [EspecialidadController::class, 'show']);

//APIS DE CONSULTORIO
Route::get('consultorios/', [ConsultorioController::class, 'list']);
Route::post('consultorio/crear', [ConsultorioController::class, 'store']); 
Route::post('consultorio/borrar', [ConsultorioController::class, 'delete']);
Route::post('consultorio/', [ConsultorioController::class, 'show']); 

//APIS DE MEDICAMENTO
Route::get('medicamentos/', [MedicamentoController::class, 'list']); // Lista doctores
Route::post('medicamento/crear', [MedicamentoController::class, 'store']); // Crear nuevo doctor
//Route::put('medicamento/editar/{id}', [MedicamentoController::class, 'update']); // Actualizar doctor con parametros
Route::post('medicamento/borrar/{id}', [MedicamentoController::class, 'delete']); // Eliminar doctor
Route::post('medicamento/{id}', [MedicamentoController::class, 'show']); // Mostrar 1 doc

Route::post('login', [LoginController::class, 'login']); 

Route::post('paciente/crear', [PacienteController::class, 'storeUserPaciente']); 
Route::post('cita/crear', [CitaController::class, 'store']); 
Route::get('citas/{id}', [CitaController::class, 'show']); 
Route::get('citas/list', [CitaController::class, 'list']);

// Ruta para obtener citas por ID del paciente
//Route::get('citas/paciente{id_paciente}', [CitaController::class, 'getCitasPorPaciente']);
// Ruta para obtener citas por ID del paciente
Route::get('citas/paciente/{idPaciente}', [CitaController::class, 'getCitasPorPaciente']);

Route::get('especialidad/{idEspecialidad}', [EspecialidadController::class, 'getEspecialidadNombre']);

Route::get('doctor/{idDoctor}', [DoctorController::class, 'getDoctorNombre']);

//Route::get('api/especialidades/{id}', [EspecialidadController::class, 'getEspecialidadPorId']);

