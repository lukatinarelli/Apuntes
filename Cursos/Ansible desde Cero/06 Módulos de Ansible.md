# Módulo `file`
El módulo `file` permite gestionar **ficheros, directorios y enlaces** en los sistemas remotos. Pertenece a la colección `ansible.builtin`, es decir, viene con todas las instalaciones de Ansible.

Es uno de los módulos más versátiles para operaciones básicas sobre el sistema de ficheros.
### Parámetros principales
| Parámetro | Descripción                                                                                                                                                                          |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **path**  | Ruta del fichero o directorio a gestionar                                                                                                                                            |
| **state** | Estado del objeto:  <br>- `absent` = borrar  <br>- `directory` = crear directorio  <br>- `file` = crear fichero  <br>- `hard` = crear hard link  <br>- `touch` = crear fichero vacío |
| **owner** | Propietario del fichero/directorio                                                                                                                                                   |
| **group** | Grupo propietario                                                                                                                                                                    |
| **mode**  | Permisos del fichero/directorio, ejemplo `0755`                                                                                                                                      |
### Ejemplo práctico
```YAML
---
- name: Trabajar con ficheros
  hosts: ubuntus
  vars:
    fichero: /tmp/prueba.txt
  
  tasks:
  - name: Crear un fichero vacío
    file:
      path: "{{ fichero }}"
      state: touch

  - name: Cambiar permisos y propietario
    file:
      path: "{{ fichero }}"
      owner: ansible
      group: ansible
      mode: 0777

- name: Trabajar con directorios
  hosts: debians
  vars:
    directorio: /tmp/dir1

  tasks:
  - name: Crear directorio
    file:
      path: "{{ directorio }}"
      state: directory
      mode: 0755
  
  - name: Crear fichero dentro del directorio
    file:
      path: "{{ directorio }}/p1.txt"
      state: touch
      owner: ansible
      group: ansible
      mode: 0755

- name: Borrar ficheros y directorios
  hosts: all
  vars:
    fichero: /tmp/prueba.txt
    directorio: /tmp/dir1

  tasks:
  - name: Borrar fichero en Ubuntu
    file:
      path: "{{ fichero }}"
      state: absent
    when: ansible_facts['distribution'] == "Ubuntu"

  - name: Borrar directorio en Debian
    file:
      path: "{{ directorio }}"
      state: absent
    when: ansible_facts['distribution'] == "Debian"
```

---
# Módulos `user` y `group`
Permiten **gestionar usuarios y grupos** en los sistemas remotos.
### Parámetros importantes
#### user:
- `name`: nombre del usuario
- `state`: `present` o `absent`
- `group`: grupo principal del usuario
- `shell`: shell por defecto
- `home`: directorio home
#### group:
- `name`: nombre del grupo
- `state`: `present` o `absent`
### Ejemplo práctico
```YAML
---
- name: Crear usuarios y grupos
  hosts: ubuntus

  tasks:
  - name: Crear un usuario simple
    user:
      name: usu1
      state: present

  - name: Crear un grupo
    group:
      name: grupo1
      state: present

  - name: Crear un usuario y asignarlo al grupo1
    user:
      name: user2
      group: grupo1
      shell: /bin/bash
      state: present

- name: Eliminar usuarios y grupos
  hosts: ubuntus

  tasks:
  - name: Eliminar usu1
    user:
      name: usu1
      state: absent
    
  - name: Cambiar grupo principal de user2 antes de eliminar
    user:
      name: user2
      group: users

  - name: Eliminar usu2
    user:
      name: usu2
      state: absent

  - name: Eliminar grupo1
    group:
      name: grupo1
      state: absent
```

---
# Módulo `lineinfile` 📝
Permite **añadir, modificar o eliminar líneas en un fichero** de forma idempotente. Es muy útil para configurar archivos de configuración sin reemplazarlos completamente.
### Parámetros importantes:
| Parámetro       | Descripción                                             |
| --------------- | ------------------------------------------------------- |
| `path`          | Ruta del archivo a modificar                            |
| `line`          | Línea que se quiere insertar o reemplazar               |
| `search_string` | Texto que se busca para reemplazarlo o eliminarlo       |
| `regexp`        | Expresión regular para buscar la línea a reemplazar     |
| `state`         | `present` (por defecto) o `absent` para borrar la línea |
### Ejemplo práctico
```YAML
---
- name: Trabajar con lineinfile
  hosts: ubuntu1
      
  tasks:
  - name: Copiar un fichero sencillo de ejemplo
    copy:
      src: ejemplo.txt
      dest: /tmp/ejemplo.txt

  - name: Añadir una línea al fichero
    lineinfile:
      path: /tmp/ejemplo.txt
      line: linea 4

  - name: Cambiar la línea1
    lineinfile:
      path: /tmp/ejemplo.txt
      search_string: linea 1
      line: He cambiado la linea 1

  - name: Borrar la línea 2
    lineinfile:
      path: /tmp/ejemplo.txt
      search_string: linea 2
      state: absent

  - name: Reemplazar la línea 4 usando regexp
    lineinfile:
      path: /tmp/ejemplo.txt
      regexp: '^linea 4'
      line: "Cambiado con REGEX"
```

---
# Módulo `set_fact` 🔧
Permite **crear variables dinámicas durante la ejecución del playbook**. Estas variables son temporales y existen solo durante la ejecución del playbook, pero pueden ser usadas en tasks posteriores.
### Parámetros importantes:
| Parámetro  | Descripción                             |
| ---------- | --------------------------------------- |
| `var_name` | Nombre de la variable que quieres crear |
| `value`    | Valor que le asignas a la variable      |
### Ejemplo práctico
```YAML
---
- name: Probar con set_fact
  hosts: debian1
  
  tasks:
  - name: Crear una variable dinámica
    set_fact:
      fichero: desarrollo.txt
	
  - name: Crear el fichero en la máquina remota usando la variable
    file:
      path: /tmp/{{ fichero }}
      state: touch

  - name: Crear una variable con una expresion
    set_fact:
	    nombre: "{{ansible_facts["hostname"] | upper}}"

  - name: Visualizar el nombre de la máquina
    debug:
	    msg: El nombre en mayúsculas es {{nombre}}
```
>🔹 **Explicación**: Primero creamos la variable `fichero` con `set_fact` y luego la usamos en la tarea de `file` para crear el archivo. Esto permite usar valores calculados o dinámicos dentro del playbook.

---

[🔙 Volver al índice](Cursos/Ansible%20desde%20Cero/00%20Índice.md)
