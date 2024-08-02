@extends('adminlte::page')

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title" style="font-family: 'Times New Roman', Times, serif;">Lista de Especialidades</h3>
        </div>
        <div class="card-body">
            <table id="table-data" class="table table-bordered table-hover">
                <thead style="font-family: 'Times New Roman', Times, serif;">
                    <tr>
                        <th>Nombre</th>
                        <th>Acciones</th> <!-- Columna para las acciones -->
                    </tr>
                </thead>
                <tbody>
                    @foreach($especialidades as $especialidad)
                    <tr>
                        <td>{{ $especialidad->nombre }}</td>
                        <td>
                            <div class="btn-group">
                                <a href="{{ route('especialidad.nuevo', ['id' => $especialidad->id]) }}" class="btn btn-success btn-sm">
                                    <span class="far fa-edit"></span> Editar
                                </a>
                                <form action="{{ route('especialidad.borrar', ['id' => $especialidad->id]) }}" method="POST">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <span class="fas fa-trash-alt"></span> Eliminar
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
@endsection

@section('js')
    <script>
        $(document).ready(function() {
            $('#table-data').DataTable({
                "scrollX": true,
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.21/i18n/Spanish.json"
                }
            });
        });
    </script>
@endsection
