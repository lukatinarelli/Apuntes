# 👤 Identificación y Gestión de Usuarios

### 🔐 El Sistema de Usuarios en Linux
El acceso y los **permisos** en Linux se rigen por un estricto modelo de identidad numérica.
- **Identidades Numéricas**: Los nombres amigables (**Usuarios** y **Grupos**) se traducen internamente a números:
    - **UID** (User ID): Identificador único de cada usuario.
    - **GID** (Group ID): Identificador único de cada grupo.
- **Permisos**: El sistema utiliza estos números (**UID/GID**) para determinar a qué archivos y recursos tiene acceso un proceso o usuario.
- **Grupos**: Permiten asignar permisos a múltiples usuarios a la vez. Cada usuario pertenece al menos a un grupo.
### 👑 El Superusuario (`root`)
| **Concepto**           | **Descripción**                                                                    |
| ---------------------- | ---------------------------------------------------------------------------------- |
| **`root`**             | El **Superusuario** del sistema (UID 0). Tiene **control total** sobre el sistema. |
| **Usuarios Regulares** | Tienen permisos limitados y no pueden afectar archivos críticos del sistema.       |
### 💻 Comandos de Identidad y Privilegios
| **Comando**   | **Función**                                                                                               |
| ------------- | --------------------------------------------------------------------------------------------------------- |
| **`whoami`**  | Muestra el **nombre de usuario** con el que estás interactuando en la _shell_.                            |
| **`id`**      | Muestra tu **UID**, **GID principal** y todos los **grupos secundarios** a los que perteneces.            |
| **`sudo su`** | Ejecuta el comando `su` (Switch User) con privilegios de `sudo`, convirtiéndote en el usuario **`root`**. |
| **`exit`**    | Sale del usuario actual (o de la _shell_) y regresa al usuario anterior.                                  |
### 🚨 Nota de Seguridad: Escalada de Privilegios
La gestión de usuarios es crítica en seguridad (Pentesting):
- **Grupo `sudo`**: Cualquier usuario que pertenezca a este grupo tiene la capacidad de ejecutar comandos como **`root`** usando `sudo`.
- **Vectores de Abuso**: Buscar usuarios o grupos con privilegios innecesarios es una vía común para que un atacante pueda **escalar privilegios** y tomar control total del sistema.
### 📁 Archivos Clave de Usuarios y Grupos
| **Archivo**       | **Función**                               | **Contenido Almacenado**                                                                                                                                   |
| ----------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`/etc/passwd`** | **Identifica y describe a los usuarios**. | Contiene una línea por usuario con su nombre, UID, GID principal, directorio _home_ y la _shell_ que usa al iniciar sesión. **(No guarda la contraseña)**. |
| **`/etc/group`**  | **Identifica y gestiona a los grupos**.   | Lista todos los grupos del sistema (con su GID) y los usuarios que son **miembros secundarios** de cada grupo.                                             |
>[!Note] 
>Las contraseñas reales (encriptadas) no se guardan en `/etc/passwd` por seguridad; se guardan en el archivo **`/etc/shadow`**, que solo puede ser leído por el usuario `root`.

---
# 🗺️ Navegación y Archivos
| **Comando**  | **Función**                                                                    | **Notas**                                                |
| ------------ | ------------------------------------------------------------------------------ | -------------------------------------------------------- |
| **`pwd`**    | Muestra el **directorio de trabajo actual** (ruta completa).                   | Útil para saber _dónde estás_ en el sistema de archivos. |
| **`ls`**     | Lista el **contenido** del directorio actual.                                  | Equivale a `dir` en Windows.                             |
| **`ls -l`**  | Lista con **detalle** (formato largo).                                         | Muestra tamaño, fecha y hora.                            |
| **`ls -la`** | Lista con detalle, incluyendo archivos **ocultos** (los que empiezan por `.`). | `a` es por _all_.                                        |
| **`cd`**     | Cambia el directorio de trabajo.                                               | `cd ..` (subir un nivel), `cd ~` (ir a _Home_).          |

---
# 📝 Manipulación de Texto y Salida
| **Comando**   | **Función**                                                                                 | **Notas**                                                                                       |
| ------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| **`echo`**    | Imprime un texto o el valor de una variable en la pantalla (salida estándar).               | Útil para mostrar mensajes o verificar variables (ej. `echo $PATH`).                            |
| **`cat`**     | Muestra el **contenido completo** de uno o varios archivos en la terminal.                  | Su alternativa moderna, **`bat`** (a veces `batcat`), añade resaltado de sintaxis y paginación. |
| **`grep`**    | **Busca líneas** que coincidan con un patrón de texto dentro de un archivo o de una salida. | Se usa mucho con _pipes_ (`                                                                     |
| **`grep -n`** | Muestra las líneas encontradas y también el **número de línea** donde aparecen.             | `n` es por _number_.                                                                            |

---
# ⚙️ Entorno de la Shell y Ejecutables

### Shell y `/etc/shells`
- **Shell**: Es el **intérprete de comandos**. Actúa como la interfaz entre el usuario y el núcleo (kernel) de Linux.
- **Zsh (Z Shell)**: Es una _shell_ moderna que usas, popular por su autocompletado avanzado y personalización.
- **`/etc/shells`**: Es un archivo que lista **todas las _shells_ válidas** que pueden ser usadas por los usuarios del sistema.
### Ejecutables y `$PATH`
| **Comando**        | **Función**                                                                                                                                                                               | **Notas**                                                         |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **`which`**        | Muestra la **ruta completa** del archivo ejecutable de un comando.                                                                                                                        | Muestra dónde está el binario que se ejecuta (ej. `/usr/bin/ls`). |
| **`command -v`**   | Alternativa a `which`. Más preciso, muestra cómo será interpretado el comando (si es un _alias_, función o archivo).                                                                      | Es la forma preferida de algunos _scripts_.                       |
| **`$PATH`**        | Es una **variable de entorno** que contiene una lista de directorios separados por dos puntos (`:`).                                                                                      | La _shell_ busca los comandos en estos directorios.               |
| **Path Hijacking** | **(Mención de Seguridad)** Consiste en engañar a la _shell_ para que ejecute un archivo malicioso en un directorio no seguro antes que el comando legítimo, manipulando la lista `$PATH`. |                                                                   

---
