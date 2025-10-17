# Índice de la sección
- [Introducción a los Tags](#introducci%C3%B3n-a-los-tags)
- [Creación de Etiquetas](#creaci%C3%B3n-de-etiquetas)
	- [Ejemplo de playbook con Tags](#ejemplo-de-tags)
- [Trabajar y Listar Etiquetas](#trabajar-y-listar-etiquetas)
- [Saltar Etiquetas](#saltar-etiquetas)
- [Etiquetas especiales](#etiquetas-especiales:-never-y-always)
- [Uso de Etiquetas en Play y Roles](#uso-de-etiquetas-en-play-y-roles)
- [Otros Conceptos](#otros-conceptos)

---
# Introducción a los Tags
- Los **tags** permiten **controlar qué tareas se ejecutan o se omiten** dentro de un playbook.    
- Son una forma **más sencilla y directa que `when`** para segmentar tareas por tipo, entorno o propósito.
- Se pueden aplicar a **tareas, plays o roles completos**.
---
# Creación de Etiquetas
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
# Trabajar y Listar Etiquetas
Ver todas las **etiquetas disponibles** en un playbook:
```BASH
ansible-playbook main.yaml --list-tasks -t desarrollo
```
Ver qué tareas se ejecutarían con una **etiqueta concreta**:
```BASH
ansible-playbook main.yaml --list-tasks -t desarrollo
```

---
# Saltar Etiquetas
- Puedes **excluir tareas** con ciertas etiquetas usando `--skip-tags`:    
```BASH
ansible-playbook main.yaml --skip-tags desarrollo
```

- También puedes omitir varias etiquetas:
```BASH
ansible-playbook main.yaml --skip-tags desarrollo
```

---
# Etiquetas especiales: `never` y `always`
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
# Uso de Etiquetas en Play y Roles
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