# ➡️ Ejecución Secuencial

### Concatenación Simple (`;`)
| **Símbolo** | **Nombre**                | **Comportamiento**                                                                      |
| ----------- | ------------------------- | --------------------------------------------------------------------------------------- |
| **`;`**     | **Separador de Comandos** | Ejecuta los comandos **uno tras otro**, sin importar si el anterior falló o tuvo éxito. |
#### Ejemplo:
```BASH
whoami; ls /ruta_falsa; date
```

> **Resultado**: `whoami` se ejecuta, el `ls` falla (porque la ruta es falsa), pero **`date` se ejecuta igualmente**.
# 🚦 Operadores Lógicos (Control de Flujo)
Estos operadores permiten que la _shell_ tome decisiones basadas en el **código de salida** del comando anterior (donde `0` es éxito y cualquier otro número es fallo).
### 1. AND Lógico (`&&`)
| **Símbolo** | **Comportamiento**                                                                  |
| ----------- | ----------------------------------------------------------------------------------- |
| **`&&`**    | Ejecuta el segundo comando **SOLO si el primero tiene éxito** (código de salida 0). |
```BASH
whoami && date
```

> **Resultado**: Si `whoami` es exitoso, **`date` se ejecuta**. Si `whoami` fallara (nunca pasa en este ejemplo), `date` no se ejecutaría.

> [!WARNING]
> 
> El operador && no es lo mismo que ;. Con &&, el flujo se detiene si un comando falla; con ;, la ejecución continúa.
### 2. OR Lógico (`||`)
| **Símbolo** | **Nombre** | **Comportamiento** |
| ----------- | ---------- | ------------------ |
| **`         |            | `**                |

```Bash
ls /ruta_falsa || echo "El directorio no existe. Pasamos a otra cosa."
```

> **Resultado**: Como `ls /ruta_falsa` falla, el mensaje **`echo` se ejecuta**. Si el `ls` hubiera tenido éxito, el `echo` se omitiría.

### 3. NOT Lógico (`!`)
| **Símbolo** | **Comportamiento**                        |
| ----------- | ----------------------------------------- |
| **`!`**     | Invierte el código de salida del comando. |

```Bash
! grep 'root' /etc/passwd
```

> **Resultado**: Si `grep` encuentra 'root' (éxito, código 0), el **`!`** lo convierte en fallo (código > 0). Útil para estructuras de control avanzadas o para ejecutar el siguiente comando solo si el primero **no se cumple**.
---
# ↪️ Redireccionamiento de Flujo (I/O)
El redireccionamiento permite cambiar la **Salida Estándar** (`stdout`) o la **Salida de Error Estándar** (`stderr`) de un comando para enviarla a un archivo o a otro flujo, en lugar de a la terminal.
### ➡️ Canales de Flujo (File Descriptors)
En Linux, cada comando maneja tres canales de comunicación identificados por números:

| **Descriptor** | **Nombre** | **Descripción**                                                     |
| -------------- | ---------- | ------------------------------------------------------------------- |
| **0**          | `stdin`    | Entrada Estándar (lo que el comando lee, usualmente el teclado).    |
| **1**          | `stdout`   | **Salida Estándar** (el resultado exitoso del comando).             |
| **2**          | `stderr`   | **Salida de Error Estándar** (los mensajes de fallo o advertencia). |

---
### 💾 Redirección de Salida (`stdout`)
| **Operador** | **Nombre**        | **Función**                                                                                                            |
| ------------ | ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **`>`**      | **Sobreescribir** | Envía la **Salida Estándar** (`stdout`, canal 1) a un archivo, **borrando** el contenido previo del archivo si existe. |
| **`>>`**     | **Añadir**        | Envía la **Salida Estándar** (`stdout`, canal 1) a un archivo, **añadiendo** el contenido al final del archivo.        |
#### Ejemplo:
```Bash
ls -l > lista.txt    # Crea/sobrescribe lista.txt con el resultado de ls
echo "Nueva línea" >> lista.txt # Añade esta línea al final
```
### ❌ Redirección de Errores (`stderr`)
| **Operador** | **Función**                                       | **Notas**                                                                                                                   |
| ------------ | ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| **`2>`**     | Redirecciona el canal **2** (`stderr`).           | Envía solo los **mensajes de error** a un archivo.                                                                          |
| **`&>`**     | Redirecciona **ambos** canales (stdout y stderr). | Envía tanto el resultado normal (1) como los errores (2) al mismo archivo. Es la forma moderna de `comando > archivo 2>&1`. |
#### Ejemplo:
```Bash
ls /dir_existe /dir_no_existe 2> errores.log
# Solo los mensajes de error de /dir_no_existe irán a errores.log
```

### 🗑️ El Agujero Negro (`/dev/null`)
| **Ruta**        | **Concepto**                               | **Uso Principal**                                                   |
| --------------- | ------------------------------------------ | ------------------------------------------------------------------- |
| **`/dev/null`** | Es un archivo especial (dispositivo nulo). | Cualquier cosa que se redirige aquí se **descarta inmediatamente**. |
> **Uso:** Se utiliza para **silenciar** la salida o los errores de un comando que no te interesa ver ni guardar.
```Bash
comando_ruidoso > /dev/null 2>&1
# Silencia tanto la salida normal (>) como los errores (2>&1), logrando una ejecución limpia.
```

---
