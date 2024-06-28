<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Especialidad;

class EspecialidadController extends Controller
{
    public function index(Request $req)
    {
        if($req->id){
            $especialidad = Especialidad::find($req->id);
        }else{
            $especialidad = new Especialidad();
        }

        if ($req->expectsJson()) {
            return response()->json($especialidad);
        }

        return view('especialidad', compact('especialidad'));
    }

    public function store(Request $req)
    {
        if ($req->id != 0) {
            $especialidad = Especialidad::find($req->id);
        } else {
            $especialidad = new Especialidad();
        }
    
        $especialidad->nombre = $req->nombre;
        $especialidad->save();
    
        if ($req->expectsJson()) {
            return response()->json(["message" => "Ok"], 200); // Cambiar aquí
        }
    
        return redirect()->route('especialidades.lista');
    }


    public function list()
    {
        $especialidades = Especialidad::all();
        return response()->json($especialidades);
        
        return view('especialidades', compact('especialidades'));
    }

    public function delete(Request $request){
        $especialidad = Especialidad::find($request->id);
        $especialidad->delete();

        return 'Ok';

        //return redirect()->route('especialidades.lista');
    }

    public function show(Request $request)
    {
        $especialidad = Especialidad::find($request->id);
        return response()->json($especialidad);
       // return view('especialidad', compact('especialidad'));
    }

}
