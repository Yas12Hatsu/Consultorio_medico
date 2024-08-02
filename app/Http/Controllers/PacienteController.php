<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Paciente;
use App\Models\Users;

class PacienteController extends Controller
{
    public function store(Request $req)
    {
        if ($req->id != 0) {
            $paciente = Paciente::find($req->id);
        } else {
            $paciente = new Paciente();
        }
    
        $paciente->nombre = $req->nombre;
        $paciente->edad = $req->edad;
        $paciente->telefono = $req->telefono;
        $paciente->peso = $req->peso;
        $paciente->altura = $req->altura;
        $paciente->direccion = $req->direccion;
        $paciente->correo = $req->correo;
        $paciente->tipo_sangre = $req->tipo_sangre;
        
        $paciente->save();
        return "Ok";
    }

    public function storeUserPaciente(Request $req)
     {
     if ($req->id != 0) {
         $paciente = Paciente::find($req->id);
         $user = Users::find($req->id);
     } else {
         $paciente = new Paciente();
         $user = new Users();
     }

     // Datos del paciente
     $paciente->nombre = $req->nombre;
     $paciente->edad = $req->edad;
     $paciente->telefono = $req->telefono;
     $paciente->peso = $req->peso;
     $paciente->altura = $req->altura;
     $paciente->direccion = $req->direccion;
     $paciente->correo = $req->correo;
     $paciente->tipo_sangre = $req->tipo_sangre;

     // Guardar el paciente
     $paciente->save();
     

     $user->name = $req->name;
     $user->email = $req->email;
     $user->password = bcrypt($req->password);
     $user->role = $req->role;

     $user->save();

     return "Ok";
     }
}
