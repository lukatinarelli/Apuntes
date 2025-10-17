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
	  tasks:
	  - name: Ejemplo de rol en un tasks
	    include_role:
	      name: role1
	```
#### A nivel de `tasks` (uso estático)
- **Import_role**: ejecuta el rol como si estuviera definido a nivel de play, siguiendo el orden de definición.
	```YAML
	  tasks:
	  - name: Ejemplo de rol en un tasks
	    import_role:
	      name: role1
	```

> [!Note]
> Se puede crear la estructura de un rol automáticamente con:
> `ansible-galaxy init [nombre_rol]`
# Creación de Roles
- Para crear un role usamos el comando:
	```Bash
	ansible-galaxy init desarrollo
	```
- Este comando creara un directorio llamado desarrollo con la misma [estructura](###Estructura-de-los-Roles) vista anteriormente.


































# Variables y Roles

# Handlers en Roles|

# Pre y Post Tasks

# Otros Conceptos

[^1]: HOla
