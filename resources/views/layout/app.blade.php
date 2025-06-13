<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Acervo Livre - Senac</title>
    @vite('resources/css/app.css')
</head>

<body class="bg-gray-100 text-gray-800 min-h-screen flex flex-col">

    <!-- Header -->
    <header class="sticky top-0 z-50 backdrop-blur bg-white/80 border-b border-gray-200 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <div class="flex items-center space-x-3">
                <div
                    class="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl flex items-center justify-center shadow">
                    <span class="text-white font-bold text-lg">S</span>
                </div>
                <span
                    class="text-xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600">
                    Acervo Livre
                </span>
            </div>
        </div>
    </header>
    
    <!-- Layout com conteúdo principal vazio e menu lateral à direita -->
    <div class="flex-1 flex">

        <!-- Menu lateral fixo à esquerda -->
        <aside class="w-64 bg-white shadow-lg border-l border-gray-200 h-screen sticky top-16 overflow-y-auto p-6">
            <h2 class="text-xl font-semibold text-gray-700 mb-4">📁 Categorias</h2>
            <ul class="space-y-2">
                @forelse ($dirs as $dir)
                    <a class="p-2 rounded hover:bg-blue-100 cursor-pointer transition">
                        {{ basename($dir) }}
                    </a {{route('acervo.show', ['categoria' => basename($dir)])}}>
                @empty
                    <li class="text-gray-500">Nenhuma pasta encontrada.</li>
                @endforelse
            </ul>
        </aside>
    </div>

</body>
</html>
