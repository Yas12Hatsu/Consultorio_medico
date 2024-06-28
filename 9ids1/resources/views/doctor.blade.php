@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
<center>
    <h1 style="font-family: 'Times New Roman', Times, serif;">Doctores</h1>
</center>
@stop

@section('content')
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form action="{{ route('doctor.guardar') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{$doctor->id}}">
                            
                            
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$doctor->nombre}}" required>
                            </div>

                            <div class="form-group">
                                <label for="cedula" style="font-family: 'Times New Roman', Times, serif;">Cedula:</label>
                                <input type="number" id="cedula" name="cedula" class="form-control" value="{{$doctor->cedula}}" required>
                            </div>

                            <div class="form-group">
                                <label for="telefono" style="font-family: 'Times New Roman', Times, serif;">Telefono:</label>
                                <input type="telephone" id="telefono" name="telefono" class="form-control" value="{{$doctor->telefono}}" required>
                            </div>

                            <div class="form-group">
                                <label for="correo" style="font-family: 'Times New Roman', Times, serif;">Correo: </label>
                                <input name="correo" class="form-control" value="{{$doctor->correo}}">
                                </input>
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