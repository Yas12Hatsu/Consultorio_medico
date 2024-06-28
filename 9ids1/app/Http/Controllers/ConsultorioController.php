<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Consultorio;

class ConsultorioController extends Controller
{
    public function index(Request $req)
    {
        if($req->id){
            $consultorio = Consultorio::find($req->id);
        }else{
            $consultorio = new Consultorio();
        }

        if ($req->expectsJson()) {
            return response()->json($consultorio);
        }

        return view('consultorio', compact('consultorio'));
    }

    public function store(Request $req)
    {
        if($req->id !=0){
            $consultorio = Consultorio::find($req->id);
        }else{
            $consultorio = new Consultorio();
        }

        $consultorio->numero = $req->numero;
        $consultorio->edificio = $req->edificio;
        $consultorio->nivel = $req->nivel;

        $consultorio->save();//insert
        return response()->json(["message" => "Ok"], 200);
    }

    public function list()
    {
        $consultorios = Consultorio::all();
        return response()->json($consultorios);


        return view('consultorios', compact('consultorios'));
    }

    public function delete($id){
        $consultorio = Consultorio::find($id);
        $consultorio->delete();

        return 'Ok';
    }

    public function show($id)
    {
        $consultorio = Consultorio::find($id);

            return response()->json($consultorio);
    }

    /*public function update(Request $req, $id)
    {
        $consultorio = Consultorio::find($id);
        $consultorio->numero = $req->numero;
        $consultorio->edificio = $req->edificio;
        $consultorio->nivel = $req->nivel;
        $consultorio->save();

        if ($req->expectsJson()) {
            return response()->json([
                $consultorio,
                ]);
        }

        return redirect()->route('consultorio.lista');
    }*/
}
