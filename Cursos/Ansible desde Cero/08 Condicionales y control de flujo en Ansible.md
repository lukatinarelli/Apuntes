# Índice de la sección
- [Condiciones `when`](#condiciones-when)
- [Bucles `loop` y `until`](#bucles-loop-y-until)
- [Handlers](#handlers)
- [Bloques](#bloques)
- [Otros conceptos](#otros-conceptos)

---
# Condiciones `when`
### Introducción
- Permiten ejecutar tareas **solo si se cumple una condición**.
- La condición es una **expresión Jinja2**.    
- No se usan doble llaves `{{ }}` dentro de `when`.
- Operadores disponibles: `<`, `>`, `>=`, `<=`, `!=`, `==`. 
- `is defined`: verifica si una variable existe.
- `not`: permite negar condiciones.    
- `in`: comprueba si un valor está en un array o lista.
### Ejemplo básico con `when`
```YAML
---
- name: Prueba con WHEN. Visualizar la fecha en los Debian
  hosts: all

  tasks:
  - name: Capturar fecha
    shell:
      cmd: date
    register: fecha
    when: ansible_distribution == 'Debian'

  - name: Visualizar fecha
    ansible.builtin.debug:
      msg: "{{ fecha.stdout }}"
    when: ansible_distribution == 'Debian' or ansible_distribution == 'Ubuntu'
```

### `when` con variables registradas
```YAML
---
- name: Verificar si el directorio está vacío
  hosts: all

  tasks:
  - name: Listar archivos del directorio
    command: ls /tmp/dir1
    register: resultado

  - name: Crear un fichero si el directorio está vacío
    file:
      path: /tmp/dir1/fichero.txt
      state: touch
    when: resultado.stdout == ""
```
### Ejemplo de `when` para actualización condicional
```YAML
---
- name: Actualizar PHP solo si la versión es menor a 8.1
  hosts: ubuntu1

  tasks:
  - name: Comprobar versión de PHP
    shell: php -v | head -n 1 | cut -c 5-10
    register: resultado
    
  - name: Mostrar resultado (solo ejemplo)
    debug:
      msg: "{{ resultado.stdout }}"
    when: resultado.stdout <= "8.1.17"
    
  - name: Actualizar PHP
    apt:
      name: php8.1
      state: present
    when: resultado.stdout <= "8.1.17"
```

---
# Cláusula `ignore_errors`
- Permite **ignorar errores de una tarea sin detener el playbook**.
- Sintaxis:
```YAML
tasks:
  - name: Tarea que podría fallar
    command: /bin/false
    ignore_errors: yes
```

- Útil en tareas donde un fallo no es crítico.

---



# Ignorar servidores parados
- Cuando en un Playbook hay una servidor parado y no puede acceder podemos especificar la clausula `ignore_unraechable` ....
```YAML
---
- name: Práctica con variables
  hosts: all
  ignore_unreachable: true

  tasks:
  - name: Mensaje de prueba
    debug:
      msg: "Mensaje de prueba"

  - name: Visualizar directorio principal
    command: 
      cmd: "ls -l /"
```

- Puedes poner la clausula `ignore_unreachable` a nivel de tarea
# `failed_whenp`
- ....
```YAML
---
- name: Práctica con variables
  hosts: all
  ignore_unreachable: true

  tasks:
  - name: Localizar directorio temporal
    command: 
      cmd: "ls -l /tmp"
    register: resultado
    failed_when: resultado.rc != 0
    
  - name: Visualizar salida
    debug: 
      var: resultado
```
# LOGs de Ansible
- ...

v = visualiza los datos de salida
vv = datos de salida y de entrada
vvv = información sobre conexiones
vvvv = añade mucha más información, usuarios, scripts, etc...

```YAML
[defaults]
log_path = /temp/ansible.log
```
# Bucles
### Bucles `loop`
```YAML
---
- name: Práctica con LOOP
  hosts: ubuntu1

  tasks:
  - name: Visualizar contenido con loop
    debug:
      msg: "Elemento actual: {{ item }}"
    loop:
      - elemento1
      - elemento2
      - elemento3
```

#### Ejemplo práctico
```YYAML
---
- name: Práctica con LOOP
  hosts: ubuntu1

  tasks:
  - name: Crear varios grupos
    ansible.builtin.group:
      name: "{{ item }}"
      state: present
    loop:
      - grupo1
      - grupo2
      - grupo3

  - name: Crear varios grupos con loop y variable
    vars:
      grupos:
        - grupoX
        - grupoY
        - grupoZ
    group:
      name: "{{ item }}"
      state: present
    loop: "{{ grupos }}"
```


### Bucles `with..`





### Bucles `until`
...




# Handlers
explciaicon...
```
---
- name: Ejemplo con un handler
  hosts: debian1

  tasks:
  - name: Copiar index.html a /var/www/html
    copy:
      src: index.html
      dest: /var/www/html
    notify:
      - rebotar_apache

  handlers:
  - name: rebotar_apache
    service:
      nmae: apache2
      state: restarted
```

### Backup con handlers
...

```



```

# Bloques
- un bloque es...
```YAML
---
- name: Ejemplo de bloques
  hosts: all
  
  tasks:
  #### PRIMER BLOQUE
  - name: Instalar y arrancar  MariaDB en Debian
    block:
      - name: Instalar MariaDB
        ansible.builtin.apt: 
          name: mariadb-server
          state: present
       
      - name: arrancar MariaDB
        ansible.builtin.service:
          name: mariadb
          state: started
    when: ansible_facts['distribution'] | lower =='debian'     
    ignore_errors: true
  
  #### SEGUNDO BLOQUE
  - name: Instalar y arrancar  MySQL en Rocky Linux
    block:
      - name: Instalar mysql
        ansible.builtin.yum: 
          name: mysql-server
          state: present
       
      - name: arrancar Mysql
        ansible.builtin.service:
          name: mysqld
          state: started
    when: ansible_facts['distribution'] | lower =='rocky'     
    ignore_errors: true
```

### Control de errores en bloques