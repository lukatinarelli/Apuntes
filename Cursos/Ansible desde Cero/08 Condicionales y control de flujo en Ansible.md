# Índice de la sección
- [Condiciones `when`](#condiciones-when)
- [Bucles `loop` y `until`](#bucles%20loop%20y%20until)
- [Handlers](#handlers)
- [Bloques](#bloques)
- [Otros conceptos](#otros%20conceptos)

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
