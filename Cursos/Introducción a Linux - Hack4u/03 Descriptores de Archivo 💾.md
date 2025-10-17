# 📑 Concepto de Descriptor de Archivo (FD)
Un **Descriptor de Archivo** (**File Descriptor** o **FD**) es un identificador numérico entero que el **kernel** de Linux utiliza para referirse a un **archivo abierto**.
En Linux, casi todo es tratado como un archivo (archivos de disco, dispositivos de hardware, _sockets_, _pipes_), por lo que un FD es la forma principal en que los programas interactúan con los datos.
### FDs Estándar Predefinidos
Vimos estos en la nota anterior, son los tres descriptores que se abren por defecto para cada proceso:

| **Descriptor** | **Número (FD)** | **Canal**                | **Descripción**                                          |
| -------------- | --------------- | ------------------------ | -------------------------------------------------------- |
| **`stdin`**    | **0**           | Entrada Estándar         | Usualmente, el teclado (lo que el programa lee).         |
| **`stdout`**   | **1**           | Salida Estándar          | Usualmente, la terminal (la salida normal del programa). |
| **`stderr`**   | **2**           | Salida de Error Estándar | Usualmente, la terminal (los mensajes de error).         |
Cuando abres un archivo o un _socket_, el kernel asigna el siguiente número FD disponible, comenzando por el **3**.

---
# ⚙️ El Comando `exec` y Redirección Persistente

El comando **`exec`** se utiliza para manipular los FDs de la _shell_ actual, permitiendo crear redirecciones **permanentes** que afectan a múltiples comandos sin tener que usar los operadores `>` o `>>` repetidamente.
### 📝 Abrir un Descriptor Personalizado
Utilizamos `exec` para abrir un archivo y asociarlo a un FD que no sea el 0, 1 o 2 (usualmente el **3**).

| **Comando**            | **Función**                                                                 | **Notas**                                                                          |
| ---------------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| **`exec 3<> archivo`** | Abre `archivo` para **lectura y escritura** (`<>`) y le asigna el FD **3**. | Si el archivo no existe, lo crea. Si existe, no lo trunca (no borra su contenido). |
| **`exec 3> archivo`**  | Abre `archivo` solo para **escritura** (`>`) y lo asigna al FD **3**.       | **Trunca** (borra) el contenido si ya existe.                                      |
### ➡️ Redirección a Descriptores Abiertos
Una vez que el FD 3 está abierto, podemos enviar la salida de cualquier comando a este descriptor usando la sintaxis de redirección numérica.

|**Comando**|**Función**|**Explicación**|
|---|---|---|
|**`comando >&3`**|Redirecciona la **salida estándar** (`stdout`, canal 1) al **FD 3**.|El `>` indica redirección de _stdout_. El `&3` indica que el destino no es un archivo de nombre '3', sino el **descriptor de archivo** con ese número.|
|**`comando 2>&3`**|Redirecciona la **salida de error** (`stderr`, canal 2) al **FD 3**.||
### Cierre del Descriptor
Es una buena práctica cerrar los FDs personalizados cuando ya no se necesitan, liberando el recurso.

|**Comando**|**Función**|**Explicación**|
|---|---|---|
|**`exec 3>&-`**|Cierra el descriptor de archivo **3** para la salida.|El `&-` indica que el descriptor debe cerrarse.|
|**`exec 3<&-`**|Cierra el descriptor de archivo **3** para la entrada.||

---
# 🧑‍💻 Ejemplo Práctico (Traza de Comandos)
Este es un ejemplo de cómo se usa esta técnica para escribir de forma secuencial en un archivo, sin tener que nombrar el archivo cada vez.
```Bash
# 1. Abrimos 'mi_log.txt' para lectura/escritura y lo asociamos al FD 3.
exec 3<> mi_log.txt 

# 2. El comando 'whoami' escribe su salida (lukatinarelli) en el FD 3.
whoami >&3 

# 3. El comando 'pwd' escribe su salida (la ruta) en el FD 3, AÑADIENDO el contenido.
#    (El comportamiento de 'añadir' lo da el descriptor abierto, no el operador >>).
pwd >&3

# 4. Cerramos el descriptor 3.
exec 3>&-

# Resultado: 'mi_log.txt' contiene el nombre de usuario y la ruta.
```

> [!NOTE] Utilidad
> 
> El manejo de FDs más allá de 0, 1 y 2 es común en scripts de shell complejos (Bash scripting) para tareas como:
> 
> 1. **Registrar Loggings:** Escribir mensajes de registro en un archivo sin interferir con la salida estándar del _script_.
>     
> 2. **Manejo de Errores:** Separar la salida normal del proceso de los mensajes de error en diferentes archivos.
>     
> 3. **Comunicación entre procesos:** Utilizar FDs para _pipes_ nombrados o _sockets_ abiertos.

