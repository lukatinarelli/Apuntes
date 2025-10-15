##### Los **comandos ad-hoc** permiten ejecutar tareas puntuales en uno o varios hosts sin necesidad de escribir un playbook completo.

##### Se usan con la sintaxis básica:

```bash
ansible <hosts> -m <módulo> -a "<argumentos>"
```

---
# 1️⃣ Módulo `command`
#### Ejecuta comandos en los nodos remotos.
- ##### **No** ejecuta interpretaciones del shell, por ejemplo redirecciones o pipes (`|`, `>`) no funcionan.
- ##### Sintaxis:

	```bash
	ansible all -m command -a "uptime"
	```

> [!Note]
> Este módulo es seguro y predecible porque no invoca el shell.

---
# 2️⃣ Módulo `shell`
#### Ejecuta comandos **a través del shell** del sistema remoto.
- ##### Permite usar pipes, redirecciones, variables del shell, etc.

	```bash
	ansible all -m shell -a "echo $HOME > /tmp/mi_home.txt"
	```

> [!Note]
> Úsalo cuando necesites funcionalidades del shell que `command` no soporta.

---
# 3️⃣ Módulo `copy`
#### Copia archivos desde el control node al host remoto
- ##### Argumentos principales:
	```bash
	src=<ruta_local> dest=<ruta_remota> mode=<permisos>
	```
- ##### Ejemplo:
	```bash
	ansible all -m copy -a "src=archivo.txt dest=/tmp/archivo.txt mode=777"
	```

> [!Note]
> Permite establecer permisos directamente con `mode`. Ideal para desplegar configuraciones simples.

---
# 4️⃣ Módulo `yum` (para sistemas basados en RedHat/CentOS)
#### Administra paquetes con el gestor de paquetes `yum`
- ##### Instala, elimina o actualiza paquetes de forma idempotente
- ##### Argumentos principales:
	```bash
	name=<paquete> state=<present|absent|latest>
	```
 - ##### Ejemplo:
	```bash
	ansible all -m yum -a "name=httpd state=present"
	```

---
# 5️⃣ Módulo `apt` (Debian)
#### El módulo `apt` permite **gestionar paquetes en sistemas basados en Debian/Ubuntu** (`apt` o `apt-get`)
#### Equivalente a `yum`
### ⚙️ Sintaxis básica
- ##### Es recomendable usar el parámetro `-b` (become) para ejecutar con privilegios de administrador
	```bash
	ansible [grupo|host] -m apt -a "name=<paquete> state=<estado>" [-b]
	```
### 📦 Parámetros principales

| Parámetro        | Descripción                                      | Ejemplo                        |
| ---------------- | ------------------------------------------------ | ------------------------------ |
| **name**         | Nombre del paquete que queremos gestionar        | `name=apache2`                 |
| **state**        | Estado deseado del paquete                       | `state=present`                |
|                  | `present` → Instalar (si no está)                |                                |
|                  | `absent` → Desinstalar                           |                                |
|                  | `latest` → Actualizar a la última versión        |                                |
|                  | `fixed` → Mantener versión actual                |                                |
| **update_cache** | Actualiza la lista de paquetes antes de instalar | `update_cache=yes`             |
| **upgrade**      | Actualiza todos los paquetes del sistema         | `upgrade=dist` o `upgrade=yes` |
### 💡 Ejemplos prácticos

#### 1️⃣ Instalar un paquete
```bash
ansible all -m apt -a "name=apache2 state=present" -b
```
#### 2️⃣ Desinstalar un paquete
```bash
ansible all -m apt -a "name=apache2 state=absent" -b
```
#### 3️⃣ Actualizar todos los paquetes del sistema
```bash
ansible all -m apt -a "upgrade=yes" -b
```
#### 4️⃣ Actualizar el índice antes de instalar
```bash
ansible all -m apt -a "name=nginx state=present update_cache=yes" -b
```

> [!Warning]
> Siempre que uses apt, asegúrate de añadir -b si el usuario remoto no es root.
> 
> Se recomienda usar state=latest con precaución en entornos de producción (puede romper dependencias).

---

[🔙 Volver al índice](00%20Índice.md)
