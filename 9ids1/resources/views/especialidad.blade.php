@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
<center>
    <h1 style="font-family: 'Times New Roman', Times, serif;">Especialidad</h1>
</center>
@stop

@section('content')
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form action="{{ route('especialidad.guardar') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{$especialidad->id}}">
                            
                            
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" class="form-control" value="{{$especialidad->nombre}}" required>
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