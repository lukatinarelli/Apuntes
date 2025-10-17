# Índice de la sección
- [Introducción a los Roles](#introducción-a-los-roles)
- [Creación de Roles](#creación-de-roles)
- [Variables y Roles](#variables-y-roles)
- [Handlers en Roles](#handlers-en-roles)
- [Pre y Post Tasks](#pre-y-post-tasks)
- [Otros Conceptos](#otros-conceptos)

---
# Introducción a los Roles
- Los **roles** son un conjunto de archivos donde se guardan variables, tareas, handlers, plantillas, archivos estáticos y otros artefactos en Ansible.
- Pueden ser **reutilizados fácilmente** y compartidos con otros usuarios y proyectos.
- Permiten dividir el trabajo en **archivos separados** para facilitar su mantenimiento y organización.
- Se pueden considerar como una **librería de automatización** modular.
### Estructura de los Roles
- Los roles tienen una estructura de archivos **estándar** con 8 directorios principales:
```bash
role1/
├── defaults/
│   └── main.yml
├── files/
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── README.md
├── tasks/
│   └── main.yml
├── templates/
├── tests/
│   ├── inventory
│   └── test.yml
└── vars/
    └── main.yml
```

| **Carpeta**  | **Descripción**                                                    |
| ------------ | ------------------------------------------------------------------ |
| `defaults/`  | Variables por defecto del rol. **Prioridad más baja**.             |
| `vars/`      | Variables del rol con **prioridad superior** a las de `defaults/`. |
| `tasks/`     | Define las **tareas** que ejecuta el rol.                          |
| `files/`     | Contiene **archivos estáticos** que se copiarán al host remoto.    |
| `handlers/`  | Handlers que se pueden invocar desde tareas.                       |
| `templates/` | Plantillas `Jinja2` para generar archivos dinámicos.               |
| `meta/`      | Metadatos del rol: dependencias, autor, licencia, etc.             |
| `tests/`     | Para **probar el rol** antes de usarlo en producción.              |
### ¿Dónde incluir los Roles?
Se pueden usar en **plays** o dentro de **tasks**, de forma estática o dinámica.
#### A nivel de `play` (uso estático)
- Se usa la cláusula `roles`.
- Se cargan y **ejecutan antes** que el resto de tareas del play.
	```YAML
	---
	- name: Ejemplo en un play
	  hosts: desarrollo
	  roles:
	  - entorno
	  - software
	```
#### A nivel de `tasks` (uso dinámico)
- **Include_role**: ejecuta el rol en el **orden definido** dentro de las tasks.
	```YAML
	  - name: Ejemplo de rol en un tasks
	    include_role:
	      name: role1
	```
#### A nivel de `tasks` (uso estático)
- **Import_role**: ejecuta el rol como si estuviera definido a nivel de play, siguiendo el orden de definición.
	```YAML
	  - name: Ejemplo de rol en un tasks
	    import_role:
	      name: role1
	```

> [!Note]
> Se puede crear la estructura de un rol automáticamente con:
> `ansible-galaxy init [nombre_rol]`

---
# Creación de Roles
- Para crear un role usamos el comando:
	```BASH
	ansible-galaxy init desarrollo
	```
- Este comando creará un directorio llamado `desarrollo` con la [estructura de roles](#estructura-de-los-roles) vista anteriormente.
### Ejemplo básico de un Role
1. Primero creamos el rol, en este ejemplo usaremos el rol llamado `mariadb`:
	```BASH
	ansible-galaxy init mariadb
	```
2. Después creamos las tareas que se ejecutarán dentro del archivo `tasks/main.yml` de nuestro rol (`mariadb`).  
    En este caso, queremos instalar MariaDB y arrancarlo:
	```BASH
	--- 
	# tasks file for mariadb 
	- name: Instalamos MariaDB   
	  apt:     
		name: mariadb-server     
		state: present   
	when: ansible_distribution | lower == 'debian'  
	
	- name: Arrancar MariaDB   
	  service:     
		name: mariadb     
		state: started   
	when: ansible_distribution | lower == 'debian'
	```
3. Ya creadas las tareas, creamos el archivo `play.yaml` que será nuestro _playbook_:
	```BASH
	--- 
	- name: Ejemplo de un role   
	  hosts: debian1   
	  roles:     
	    - mariadb    
		
	  tasks:   
	  - name: Última tarea     
	    debug:       
		  msg: "Primero se ejecutan las tareas del role"
	```

> Recuerda que siempre se ejecutan primero las tareas del rol, salvo que sean tareas incluidas de forma dinámica.

4. Ejecutamos el playbook con:
	```BASH
	ansible-playbook play.yaml
	```

---
# Variables y Roles
### Precedencia de las variables (de menor a mayor prioridad):
1. Variables en **defaults** del role
2. Variables en **group_vars**
3. Variables en **host_vars**
4. Variables en el **play**
5. Variables en **vars** del role
6. Variables desde **línea de comandos**

---
# Handlers en Roles
- Los **handlers** son tareas especiales que se ejecutan **solo cuando son notificadas** por otras tareas usando `notify`.
- Se definen en `handlers/main.yml` dentro del role.
- Ejemplo en un rol `mariadb`:
	```BASH
	--- 
	# handlers file for mariadb 
	- name: reiniciar mariadb   
	    service:     
		  name: mariadb     
		  state: restarted
	```
- En las tareas del rol:
	```BASH
	- name: Cambiar configuración de MariaDB   
	    template:     
		  src: my.cnf.j2     
		  dest: /etc/mysql/my.cnf   
	    notify:     
		  - reiniciar mariadb
	```

> Solo se ejecutará el handler si la tarea que lo notifica **realmente hace un cambio** (change=1).

---
# Pre y Post Tasks
- Permiten ejecutar tareas **antes o después** de cargar los roles y sus plays.
- **Pre-tasks**: se ejecutan antes de los roles:
	```BASH
	pre_tasks: 
	- name: Hacer un upgrade del sistema   
	  apt:     
	    update_cache: true
	```

- **Post-tasks**: se ejecutan después de los roles y tareas del playbook:
	```BASH
	post_tasks: 
	- name: Mensaje final   
	  debug:     
		msg: "Proceso finalizado"
	```

---
# Otros Conceptos
- Roles también se pueden incluir **de forma dinámica** dentro de un playbook usando `include_role` o `import_role`.
	```BASH
	--- 
	- name: Ejemplo de roles a nivel de tarea   
	  hosts: debian1    
	  
	  tasks:   
	  - name: Primera tarea del play     
	    debug:       
	      msg: "Comienzo del play"    
	
	  - name: Incluir el role     
	    include_role:       
	      name: mariadb    
	      
	  - name: Última tarea del play     
		debug:      
		   msg: "Se ha terminado el proceso"
	```

- En este caso, las tareas **antes del include** se ejecutan primero, luego se ejecutan **todas las tareas del role**, y finalmente las tareas posteriores al include.
- Si se incluye el role de forma dinámica, **las variables solo existen dentro de esa tarea**, y otras tareas fuera del include no tendrán acceso a ellas.

---

[🔙 Volver al índice](00%20Índice.md)
