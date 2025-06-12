<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Acervo Livre</title>
    <link href="{{ asset('css/app.css') }}" rel="stylesheet" />
</head>
<body class="bg-gray-100 text-gray-800 p-6">
    <h1 class="text-3xl font-bold mb-6">Acervo Livre</h1>

    <section>
        <h2 class="text-2xl font-semibold mb-4">Pastas</h2>
        <ul class="list-disc list-inside mb-6">
            @foreach ($dirs as $dir)
                <li>{{ $dir['path'] }}</li>
            @endforeach
        </ul>
    </section>

    <section>
        <h2 class="text-2xl font-semibold mb-4">Arquivos</h2>
        <ul class="list-disc list-inside">
            @foreach ($files as $file)
                <li>
                    <a href="{{ url('/acervo/file/' . urlencode($file['path'])) }}" class="text-blue-600 hover:underline">
                        {{ $file['path'] }}
                    </a>
                </li>
            @endforeach
        </ul>
    </section>
</body>
</html>
