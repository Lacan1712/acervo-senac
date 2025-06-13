<?php

namespace App\Http\Controllers\index;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class Principal extends Controller
{
    //

    public function index(){
        $dirs = Storage::disk('samba')->allDirectories('acervo');


    
        return view('layout.app', compact('dirs'));
    }
}
