@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
<center>
    <h1 style="font-family: 'Times New Roman', Times, serif;">Medicamento</h1>
</center>
@stop

@section('content')
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form action="{{ route('medicamento.guardar') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{$medicamento->id}}">
                            
                            
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$medicamento->nombre}}" required>
                            </div>

                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Marca:</label>
                                <input type="text" id="marca" name="marca" class="form-control" value="{{$medicamento->marca}}" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Tipo:</label>
                                <input type="text" id="tipo" name="tipo" class="form-control" value="{{$medicamento->tipo}}" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Presentacion:</label>
                                <input type="text" id="presentacion" name="presentacion" class="form-control" value="{{$medicamento->presentacion}}" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Fecha de caducidad:</label>
                                <input type="date" id="fechaCaducidad" name="fechaCaducidad" class="form-control" value="{{$medicamento->fechaCaducidad}}" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Lote:</label>
                                <input type="text" id="lote" name="lote" class="form-control" value="{{$medicamento->lote}}" required>
                            </div>
                           

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary" style="font-family: 'Times New Roman', Times, serif;">Enviar</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection