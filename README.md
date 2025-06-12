# Acervo Livre Laravel + Samba
## Projeto Laravel simples para listar e servir arquivos de um compartilhamento Samba montado no host.

Requisitos
- Docker instalado no host

- Compartilhamento Samba já montado no host (ex: /mnt/samba)


Rodar o container Docker Laravel
```bash
docker run -d \
  -p 8000:80 \
  -v $(pwd):/var/www/html \
  -v /mnt/samba:/mnt/samba \
  --name acervo-server \
  acervo-senac
 
```
# acervo-senac
