<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Medicamento;

class MedicamentoController extends Controller
{
    public function index(Request $req)
    {
        if($req->id){
            $medicamento = Medicamento::find($req->id);
        }else{
            $medicamento = new Medicamento();
        }

        if ($req->expectsJson()) {
            return response()->json($medicamento);
        }

        return view('medicamento', compact('medicamento'));
    }

    public function store(Request $req)
    {
        if($req->id !=0){
            $medicamento = Medicamento::find($req->id);
        }else{
            $medicamento = new Medicamento();
        }

        $medicamento->nombre = $req->nombre;
        $medicamento->marca = $req->marca;
        $medicamento->tipo = $req->tipo;
        $medicamento->presentacion = $req->presentacion;
        $medicamento->fechaCaducidad = $req->fechaCaducidad;
        $medicamento->lote = $req->lote;
        $medicamento->save();//insert

        if ($req->expectsJson()) {
            return response()->json([
                $medicamento
                ]);
        }

        return redirect()->route('medicamentos.lista');
    }

    public function list()
    {
        $medicamentos = Medicamento::all();
        if (request()->expectsJson()) {
            return response()->json([
                $medicamentos
            ]);
        }

        return view('medicamentos', compact('medicamentos'));
    }

    public function delete($id){
        $medicamento = Medicamento::find($id);
        $medicamento->delete();

        if (request()->expectsJson()) {
            return response()->json([
                'status' => 'MEDICAMENTO ELIMINADO CORRECTAMENTE']);
        }

        return redirect()->route('medicamentos.lista');
    }

    public function show($id)
    {
        $medicamento = Medicamento::find($id);

        if (request()->expectsJson()) {
            return response()->json([
                $medicamento,
                ]);
        }

        return view('doctor', compact('doctor'));
    }

    public function update(Request $req, $id)
    {
        $medicamento = Medicamento::find($id);
        $medicamento->nombre = $req->nombre;
        $medicamento->marca = $req->marca;
        $medicamento->tipo = $req->tipo;
        $medicamento->presentacion = $req->presentacion;
        $medicamento->fechaCaducidad = $req->fechaCaducidad;
        $medicamento->lote = $req->lote;
        $medicamento->save();

        if ($req->expectsJson()) {
            return response()->json([
                $medicamento,
                ]);
        }

        return redirect()->route('doctores.lista');
    }
}
