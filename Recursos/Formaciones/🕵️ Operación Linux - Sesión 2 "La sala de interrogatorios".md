# 📚 Contexto

Esta nota detalla los puntos clave de una **formación interna** recibida en el entorno laboral. Cubre los fundamentos de la administración de sistemas Linux, incluyendo la gestión de software (Java/Python), la monitorización de recursos (`top`, `ps`, `df`), y la introducción a la tecnología de contenedores (Docker).

---

# 💻 Entornos de Desarrollo: Java y Python

## 📚 Explicación teórica

En entornos de ciberseguridad y desarrollo, es fundamental entender cómo se gestionan las dependencias y la estructura de los proyectos. Tanto Java como Python utilizan convenciones para organizar el código, gestionar las bibliotecas externas y preparar artefactos (ejecutables o paquetes).

### ☕ Java y el Compilador Maven

**Maven** no es solo un compilador; es una potente herramienta de automatización de la construcción de proyectos (build automation tool) utilizada principalmente para proyectos Java. Su función es gestionar el ciclo de vida de la construcción del proyecto (compilación, pruebas, empaquetado) y, lo más importante, la **gestión de dependencias**.

* **Archivo central (`pom.xml`):** Este es el corazón de un proyecto Maven. Define la configuración del proyecto, las librerías necesarias (`<dependencies>`), los plugins y la estructura del build.
* **Repositorio Local (`~/.m2/repository`):** Maven descarga todas las dependencias definidas en el `pom.xml` y las almacena localmente en esta carpeta. Esto acelera futuros builds y permite trabajar sin conexión.

### 🐍 Python y la Gestión de Dependencias

Python utiliza un enfoque más ligero para la gestión de dependencias a través de archivos de texto simple y módulos de empaquetado.

* **Dependencias (`requirements.txt`):** Este archivo lista las bibliotecas de terceros y sus versiones específicas que el proyecto necesita. Se usa junto con `pip` (el gestor de paquetes estándar de Python) para instalar el entorno.
* **Módulos (`__init__.py`):** La presencia de un archivo (incluso vacío) llamado `__init__.py` dentro de un directorio indica a Python que ese directorio debe ser tratado como un **módulo** o paquete (package). Esto es esencial para poder importar código de ese directorio desde otras partes del proyecto.

## 🛠️ Alternando Versiones de Software

En Linux, especialmente en servidores o máquinas de pentesting donde coexisten múltiples herramientas y versiones de lenguajes, la herramienta `update-alternatives` es crucial para la gestión centralizada de ejecutables.

Esta herramienta administra los **enlaces simbólicos** (symlinks) a programas en directorios comunes (como `/usr/bin`), permitiendo al administrador cambiar qué versión de un programa se ejecuta por defecto al invocar su nombre genérico (ej. `java`, `python`).

## 💻 Comandos de Versiones

```bash
# 1. Muestra las opciones disponibles y te permite seleccionar la versión activa.
update-alternatives --config java

# Ejemplo de instalación/registro de una nueva versión de Python
# Sintaxis: --install <link> <name> <path> <priority>
# Donde:
#   <link>: Enlace simbólico principal que queremos gestionar (/usr/bin/python)
#   <name>: Nombre de la alternativa (python)
#   <path>: Ruta real del ejecutable a enlazar (/opt/python/...)
#   <priority>: Prioridad. Un número más alto será seleccionado por defecto en modo 'auto'.
update-alternatives --install /usr/bin/python python /opt/python/python-3.13.0/bin/python 10

# 2. Después de instalar, se puede alternar con el comando config
update-alternatives --config python

# Alternativa simple: Invocar el ejecutable específico si está en el PATH
python3.10 --version
python3.12 --version
```

---

# 📊 Gestión de Procesos y Recursos del Sistema

## 📚 Explicación teórica

La monitorización y la gestión de procesos son tareas vitales en la administración de un sistema, permitiendo identificar cuellos de botella, consumo excesivo de recursos o procesos maliciosos/zombies.

### ➡️ Monitorización en Tiempo Real: `top`

El comando `top` (Table of Processes) proporciona una vista dinámica y en tiempo real de los procesos en ejecución. Ordena por defecto los procesos por **uso de CPU** (`%CPU`), siendo la herramienta de elección para identificar procesos que están acaparando recursos inmediatamente. También muestra información crítica sobre memoria (física y swap).

### ➡️ Instantánea de Procesos: `ps aux`

El comando `ps` (Process Status) toma una instantánea estática (no en tiempo real) de los procesos en el momento de su ejecución.

- **a:** Muestra procesos de todos los usuarios.
- **u:** Proporciona un formato de salida detallado y legible por el usuario (User, %CPU, %MEM, PID, etc.).
- **x:** Incluye procesos que no tienen un terminal de control (daemons, servicios del sistema).

### ➡️ Gestión de Memoria: `free`

El comando `free` muestra la cantidad total de memoria física y swap utilizada y disponible en el sistema. El flag `-m` es el más común para mostrar los valores en **megabytes (MiB)**, facilitando la lectura.

## 💻 Comandos de Procesos

```Bash
# Vista dinámica y ordenada por consumo de CPU
top

# Muestra la memoria del sistema en formato legible (Megabytes)
free -m

# Vista estática de todos los procesos detallados
ps aux

# Terminación forzada (kill) de un proceso por su ID (PID)
kill -9 <PID>

# Terminación de todos los procesos con un nombre específico (por ejemplo, todos los Firefox)
killall firefox
```

> [!IMPORTANT] 
> La señal `-9` (SIGKILL) es la señal más agresiva y no permite que el proceso realice una limpieza de recursos. Es el último recurso. Otras señales comunes incluyen:
>   - **`-15` (SIGTERM):** Pide al proceso que termine "amablemente" (cierre de archivos, etc.). Es la señal por defecto.

---

# 💾 Dimensionamiento y Espacio en Disco

## 📚 Explicación teórica

Comprender el uso del espacio en el disco es esencial para la prevención de fallos del sistema o para la auditoría de espacio. Dos comandos fundamentales proporcionan información a distintos niveles.

### ➡️ Uso del Sistema de Archivos: `df -h`

El comando `df` (Disk Filesystem) reporta el espacio libre y usado de todo el sistema de archivos (particiones o discos montados). Muestra dónde están montados los discos y su porcentaje de uso a nivel de **partición**.

### ➡️ Uso a Nivel de Directorio: `du -hs`

El comando `du` (Disk Usage) muestra la cantidad de espacio en disco que consume un archivo o, más comúnmente, un directorio.

- **-h:** Formato legible por humanos (MB, GB).
- **-s:** Resumen (solo muestra el total para el argumento).

## 💻 Comandos de Disco

```Bash
# Reporta el espacio de todas las particiones montadas en formato legible
df -h

# Muestra el tamaño total del directorio actual
du -hs .

# Muestra el tamaño total de todos los archivos y carpetas en el directorio actual
du -hs *
```

---

# 🐳 Docker: Aislamiento y Contenedores

## 📚 Explicación teórica

**Docker** es una tecnología clave en ciberseguridad para el desarrollo de herramientas, el despliegue de honeypots o la creación de entornos de prueba controlados y desechables. Permite empaquetar una aplicación con todas sus dependencias en una unidad estándar llamada **contenedor**.

Un contenedor es un proceso aislado que comparte el kernel del sistema operativo host, pero está separado del resto del sistema. Esto permite una gran eficiencia y portabilidad.

- **Docker Hub:** Es el repositorio público central donde se alojan millones de imágenes pre-compiladas (ej. `python:3.14.2-alpine3.22`).
- **Dockerfile:** Es un archivo de texto con instrucciones que definen cómo construir una imagen de Docker. Documenta de forma programática el entorno (sistema operativo base, instalación de paquetes, copia de archivos, comandos de inicio).

## 🛠️ Uso práctico

El comando `docker run` es la forma más rápida de obtener un shell en un entorno limpio.
- `docker run`: Crea y ejecuta un contenedor a partir de una imagen.
- `-it`: Combina `-i` (modo interactivo) y `-t` (asigna un pseudo-TTY), esencial para una sesión de terminal.
- `--entrypoint sh`: Sobreescribe el comando por defecto de la imagen para forzar la ejecución del shell (`sh` o `/bin/bash`). Esto es común en imágenes de ciberseguridad para inspeccionar el contenedor.

## 💻 Comandos de Docker

```Bash
# Ejecuta un contenedor con una imagen de Python Alpine, 
# asigna un TTY interactivo y fuerza la entrada al shell 'sh'
docker run -it --entrypoint sh python:3.14.2-alpine3.22

# Muestra una lista de las imágenes de Docker descargadas localmente
docker images

# Muestra una lista de los contenedores en ejecución (y los que han terminado con el flag -a)
docker ps -a
```

## ⚠️ Advertencias

> [!WARNING] 
> La gestión de versiones con `update-alternatives` es potente, pero requiere permisos de superusuario (`sudo`). Un mal uso puede romper enlaces simbólicos críticos del sistema. **Siempre verifica el `PATH`** de los ejecutables antes de instalarlos.

```Bash
# Ejemplo de Dockerfile simple
FROM debian:latest  # Define la imagen base
LABEL maintainer="tu_usuario@ejemplo.com"

# Ejecuta comandos en la construcción de la imagen
RUN apt update && apt install -y nmap python3

# Define el comando que se ejecuta cuando el contenedor inicia
CMD ["/bin/bash"]
```

---

