# Índice de la sección
- [Introducción a Jinja2](#introducci%C3%B3n-a-jinja2)
- [Usara Jinja2 En Ansible](#usar-jinja2-en-ansible)
- [Condiciones en Jinja2](#condiciones-en-jinja2)
- [Operadores Lógicos](#operadores-l%C3%B3gicos)
- [Bucles](#bucles)
- [Filtros](#filtros)


- [Otros Conceptos](#otros-conceptos)
- [ejemplo](#ejemplo)

---
# Introducción a Jinja2
- Los **tags** permiten **controlar qué tareas se ejecutan o se omiten** dentro de un playbook.    
- Son una forma **más sencilla y directa que `when`** para segmentar tareas por tipo, entorno o propósito.
- Se pueden aplicar a **tareas, plays o roles completos**.
---
# Usar Jinja2 en Ansible
- Se definen dentro de cada tarea, bajo la clave `tags`.
- Puedes asignar **una o varias etiquetas** a cada tarea.
### Ejemplo de playbook con Tags
```YAML
--- 
- name: Trabajar con TAGS   
  hosts: debian1    
  
  tasks:   
  - name: Preparar desarrollo     
    debug:       
      msg: "Preparar el entorno de desarrollo"     
    tags:
      - desarrollo

   - name: Preparar producción
    debug:
      msg: "Preparar el entorno de producción"
    tags:
      - produccion

   - name: Instalar MySQL
    debug:
      msg: "Instalando MySQL"
    tags:
      - desarrollo       
      - produccion

   - name: Instalar herramientas de desarrollo
    debug:
      msg: "Instalar herramientas de desarrollo"
    tags:
      - desarrollo  

   - name: Configurar seguridad de producción     
    debug:       
      msg: "Instalar el entorno de seguridad"     
    tags:       
      - produccion    

   - name: Desplegar aplicación
    debug:
      msg: "Desplegar aplicación"
    tags:
      - desarrollo       
      - produccion
```
Para ejecutar solo las tareas con una etiqueta concreta:
```BASH
ansible-playbook main.yaml -t desarrollo
```

---
# Condiciones en Jinja2
Ver todas las **etiquetas disponibles** en un playbook:
```BASH
ansible-playbook main.yaml --list-tasks -t desarrollo
```
Ver qué tareas se ejecutarían con una **etiqueta concreta**:
```BASH
ansible-playbook main.yaml --list-tasks -t desarrollo
```

---
# Operadores Lógicos
- Puedes **excluir tareas** con ciertas etiquetas usando `--skip-tags`:    
```BASH
ansible-playbook main.yaml --skip-tags desarrollo
```

- También puedes omitir varias etiquetas:
```BASH
ansible-playbook main.yaml --skip-tags desarrollo
```

---
# Bucles
- `never`: la tarea **no se ejecutará nunca**, salvo que se llame explícitamente con `-t nombre_tag`.
- `always`: la tarea **se ejecutará siempre**, sin importar las etiquetas seleccionadas.
```YAML
- name: Tarea con never
  debug:
    msg: "Esta tarea solo se ejecuta si se invoca explícitamente"
  tags:
    - never

- name: Tarea con always
  debug:
    msg: "Esta tarea se ejecuta siempre"
  tags:
    - always
```

---
# Filtros
### En Plays
- Puedes aplicar etiquetas a un **play completo**, para ejecutar o saltar todas sus tareas:
```YAML
---
- name: Configurar entorno de desarrollo
  hosts: debian1
  tags:
    - desarrollo

  tasks:
  - name: Instalar paquetes base
    apt:
      name: git
      state: present
```
### En Roles
- También es posible etiquetar un **rol entero** dentro del playbook:
```YAML
---
- name: Desplegar aplicación
  hosts: all
  roles:
    - role: mariadb
      tags: ['db', 'produccion']
    - role: nginx
      tags: ['web']
```

---






# Otros Conceptos
- Las etiquetas se pueden **combinar con `when`** para mayor flexibilidad.
- Es buena práctica usar nombres de tag **coherentes y cortos** (`web`, `db`, `test`, `prod`, etc.).
- Puedes aplicar **múltiples etiquetas en cascada** para entornos complejos.

---

[🔙 Volver al índice](00%20Índice.md)
