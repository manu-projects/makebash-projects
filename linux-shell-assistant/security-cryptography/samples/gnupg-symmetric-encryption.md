# Cifrado Simétrico
## 1. creamos un archivo y le agregamos contenido
```shell
echo "texto a cifrar" > secretos.txt
```
> en realidad redireccionamos con el operador > una cadena de texto, a un archivo regular que aún no existe
## 2. ENCRIPTAMOS el contenido del archivo
```shell
# gpg utilizará por default el algoritmo AES-128 (128 bits)
gpg --symetric secretos.txt

# aumentamos el tamaño de .. por AES-256 (256 bits = 32 Bytes)
gpg --symetric \
    --cipher-algo AES256 \
    secretos.txt

# cambiamos el nombre del archivo cifrado
gpg --output secretos-divertidos.gpg \
    --symetric \
    --cipher-algo AES256 \
    secretos.txt
```
> se creará el archivo cifrado como secretos.txt.gpg
## 3. borramos el archivo (de forma segura)
```shell
shred -zu secretos.txt # borramos el archivo de forma segura

# rm --verbose secretos.txt # borramos el archivo de forma insegura
```
> la idea sería sólo desencriptar su contenido, el archivo no encriptado es inseguro
> el comando `shred` elimina archivos de manera segura, contrario a `rm` que podría recuperarse
## 4. DESENCRIPTAMOS el contenido de archivo
```shell
gpg --decrypt secretos.txt.gpg
```
