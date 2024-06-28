@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
<center>
    <h1 style="font-family: 'Times New Roman', Times, serif;">Consultorio</h1>
</center>
@stop

@section('content')
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form action="{{ route('consultorio.guardar') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{$consultorio->id}}">
                            
                            
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Numero:</label>
                                <input type="number" id="numero" name="numero" class="form-control" value="{{$consultorio->numero}}" required>
                            </div>

                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Edificio:</label>
                                <input type="text" id="edificio" name="edificio" class="form-control" value="{{$consultorio->edificio}}" required>
                            </div>
                            <div class="form-group">
                                <label for="nombre" style="font-family: 'Times New Roman', Times, serif;">Nivel:</label>
                                <input type="number" id="nivel" name="nivel" class="form-control" value="{{$consultorio->nivel}}" required>
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