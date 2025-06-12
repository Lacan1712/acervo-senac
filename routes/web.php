<?php

use App\Http\Controllers\index\Principal;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Response;


Route::get('/', [Principal::class, 'index'])->name('index');

Route::get('/acervo/file/{path}', function ($path) {
    $filePath = urldecode($path);
    if (!Storage::disk('samba')->exists($filePath)) {
        abort(404);
    }
    $mime = Storage::disk('samba')->mimeType($filePath);
    $content = Storage::disk('samba')->get($filePath);
    return Response::make($content, 200, [
        'Content-Type' => $mime,
        'Content-Disposition' => 'inline; filename="' . basename($filePath) . '"',
    ]);
})->where('path', '.*');
