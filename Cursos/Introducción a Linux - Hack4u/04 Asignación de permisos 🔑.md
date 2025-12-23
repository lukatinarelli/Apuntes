# 🛡️ Permisos de Archivos

### I. Modelo Básico de Permisos
Linux aplica permisos a cada archivo y directorio usando un sistema de **9 bits** que se divide en tres grupos:

| **Grupo**      | **Descripción**                                                             |
| -------------- | --------------------------------------------------------------------------- |
| **u** (User)   | **Dueño** del archivo.                                                      |
| **g** (Group)  | **Grupo** al que pertenece el archivo.                                      |
| **o** (Others) | **Otros** usuarios (cualquiera que no sea el dueño ni pertenezca al grupo). |
| **a** (All)    | Se refiere a **todos** (u, g, y o).                                         |

Cada uno de estos grupos puede tener tres tipos de permisos:

| **Permiso**   | **Letra** | **Valor Octal** | **Función**                                                                      |
| ------------- | --------- | --------------- | -------------------------------------------------------------------------------- |
| **Lectura**   | `r`       | **4**           | Permite ver el contenido del archivo o listar un directorio.                     |
| **Escritura** | `w`       | **2**           | Permite modificar o borrar el archivo, o crear/borrar archivos en un directorio. |
| **Ejecución** | `x`       | **1**           | Permite ejecutar un archivo (script) o entrar a un directorio.                   |
### II. Comandos de Permisos y Propiedad

#### A. **`chmod`** (Cambiar Permisos)
Cambia los permisos de lectura, escritura y ejecución de un archivo o directorio.


|**Método**|**Sintaxis y Notas**|
|---|---|
|**Simbólico** (Letras)|Usa letras (`u`, `g`, `o`, `a`) y operadores (`+`, `-`, `=`).|
||**Ejemplo:** `chmod u+x mi_script.sh` (Añade permiso de ejecución al dueño).|
|**Numérico** (Octal)|Combina los valores octales (4, 2, 1) en un código de 3 dígitos (Dueño, Grupo, Otros).|
||**Ejemplo:** `chmod 755 mi_script.sh`|

> [!NOTE]
> 
> El Octal 755 es común: rwx (7) para el dueño, y r-x (5) para el grupo y otros.
#### B. **`chown`** (Cambiar Dueño)
Cambia el **Dueño** (`user`) y/o el **Grupo** (`group`) primario de un archivo.

| **Sintaxis**                  | **Función**                                      |
| ----------------------------- | ------------------------------------------------ |
| `chown usuario archivo`       | Cambia solo el dueño del archivo.                |
| `chown :grupo archivo`        | Cambia solo el grupo del archivo.                |
| `chown usuario:grupo archivo` | Cambia tanto el dueño como el grupo del archivo. |
#### C. **`chgrp`** (Cambiar Grupo)
Es el comando específico para cambiar solo el **Grupo** del archivo. Es menos común que `chown :grupo`.

| **Sintaxis**                | **Función**                                  |
| --------------------------- | -------------------------------------------- |
| `chgrp nuevo_grupo archivo` | Cambia el grupo al que pertenece el archivo. |
### III. Permisos Especiales
Estos permisos se colocan en la cuarta posición del modo octal (**4xxx** o **2xxx**) y se usan para alterar la forma en que se ejecuta un archivo o se accede a un directorio.
#### A. SUID (Set User ID)
| **Permiso** | **Valor Octal** | **Muestra**                          | **Función**                                                                                           |
| ----------- | --------------- | ------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| **SUID**    | **4000**        | `s` en la posición del Dueño (`rws`) | Permite que el usuario que **ejecuta** el archivo lo haga con los **permisos del Dueño** del archivo. |
> [!CAUTION]
> 
> Es muy peligroso. Si un archivo es propiedad de root y tiene SUID, cualquier usuario puede ejecutarlo con permisos de root. Ejemplo clásico: el comando passwd.

#### B. SGID (Set Group ID)
| **Permiso** | **Valor Octal** | **Muestra**                          | **Función**                                                                                                      |
| ----------- | --------------- | ------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| **SGID**    | **2000**        | `s` en la posición del Grupo (`rws`) | Permite que el usuario que ejecuta el archivo lo haga con los **permisos del Grupo** dueño del archivo.          |
|             |                 |                                      | Si se aplica a un **directorio**, los archivos creados dentro heredarán automáticamente el grupo del directorio. |
#### C. Sticky Bit
El Sticky Bit es un permiso especial que se aplica solo a **directorios** y previene que usuarios eliminen archivos dentro de ese directorio aunque tengan permisos de escritura.

| **Permiso**    | **Valor Octal** | **Muestra**                         | **Función**                                                                                                                                               |
| -------------- | --------------- | ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sticky Bit** | **1000**        | `t` en la posición de Otros (`rwt`) | **Solo en directorios**. Previene que usuarios eliminen o renombren archivos de otros, aunque tengan permisos de escritura en el directorio (ej. `/tmp`). |
> [!NOTE]
> 
> El uso más común del Sticky Bit es en el directorio /tmp, donde cualquier usuario puede crear archivos, pero no puede borrarlos ni modificarlos si fueron creados por otro.
##### Ejemplo:
```Bash
chmod +t /tmp # Aplica el Sticky Bit
# La salida de ls -l mostrará una 't' minúscula al final: drwxrwxrwt
```

---
### IV. Atributos de Archivo Extendidos (`chattr` / `lsattr`)
Estos comandos permiten aplicar un nivel extra de protección y control que va más allá de los permisos rwx. Solo el usuario **`root`** puede modificar estos atributos.

| **Comando**  | **Función**                                         | **Atributo Clave**                                                                                                                                     |
| ------------ | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`chattr`** | **Cambia los Atributos** extendidos de un archivo.  | **`+i`** (Immutable) - Hace que el archivo sea **inmutable**. No puede ser modificado, borrado, renombrado ni enlazado, incluso por el usuario `root`. |
| **`lsattr`** | **Muestra los Atributos** extendidos de un archivo. | Confirma si el archivo tiene un atributo especial, como `i` (inmutable) o `a` (solo añadir).                                                           |
#### Ejemplo:
```Bash
# Proteger (hacer inmutable) un archivo:
sudo chattr +i /etc/passwd

# Verificar el atributo:
lsattr /etc/passwd
# Resultado: ----i--------- /etc/passwd
```

### V. Privilegios Especiales: Capabilities 
| **Concepto**     | **Descripción**                                                                                                                                                                  |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Capabilities** | Un sistema de seguridad moderno (sustituto de SUID/SGID) que permite dividir los súper-privilegios de **`root`** en paquetes pequeños y granulares (ej. `CAP_NET_BIND_SERVICE`). |
| **Ventaja**      | Un programa solo obtiene el **privilegio mínimo** que necesita (ej. solo el permiso para abrir un puerto bajo el 1024), en lugar de obtener todos los permisos de `root`.        |
| **Comando**      | **`getcap`** muestra las capacidades de un archivo y **`setcap`** las asigna.                                                                                                    |
> [!CAUTION]
> 
> Riesgo de Seguridad: Las capacidades mal configuradas (especialmente CAP_SETUID o CAP_DAC_OVERRIDE) son vectores comunes de escalada de privilegios.
> 
> **Recurso Útil:** Consulta [gtfobins.github.io/#+capabilities](https://gtfobins.github.io/#+capabilities) para ver _binarios_ comunes con capacidades peligrosas.

---

🔙 [Volver al índice](00%20Índice.md)
