<?php

namespace App\Http\Controllers\index;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class Principal extends Controller
{
    //

    public function index(){
        $contents = Storage::disk('samba')->listContents('/', true);

        
        $files = [];
        $dirs = [];
    
        foreach ($contents as $item) {
            if ($item['type'] === 'file') {
                $files[] = $item;
            } else {
                $dirs[] = $item;
            }
        }
    
        return view('acervo.index', compact('dirs', 'files'));
    }
}
