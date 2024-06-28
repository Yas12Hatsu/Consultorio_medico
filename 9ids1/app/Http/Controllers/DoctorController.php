<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;

class DoctorController extends Controller
{
    public function index(Request $req)
    {
        if ($req->id) {
            $doctor = Doctor::find($req->id);
        } else {
            $doctor = new Doctor();
        }

        if ($req->expectsJson()) {
            return response()->json($doctor);
        }

        return view('doctor', compact('doctor'));
    }

    public function store(Request $req)
    {
        if ($req->id != 0) {
            $doctor = Doctor::find($req->id);
        } else {
            $doctor = new Doctor();
        }

        $doctor->nombre = $req->nombre;
        $doctor->cedula = $req->cedula;
        $doctor->telefono = $req->telefono;
        $doctor->correo = $req->correo;

        $doctor->save(); // insert o update

        return 'Ok';
    }

    public function list()
    {
        $doctores = Doctor::all();
        return response()->json($doctores);

        return view('doctores', compact('doctores'));
    }

    public function delete($id)
    {
        $doctor = Doctor::find($id);
        $doctor->delete();

        return 'Ok';

    }
    
    public function show($id)
    {
        $doctor = Doctor::find($id);

        return response()->json($doctor);
        
    }

}
