<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctor_Especialidad extends Model
{
    use HasFactory;
    protected $table = "doctor_especialidad";
    public function especialidad()
    {
        return $this->belongsTo(Especialidad::class, 'id_especialidad');
    }

    public function doctor()
    {
        return $this->belongsTo(Doctor::class, 'id_doc');
    }
}
