# Índice de la sección
- [Introducción a Jinja2](#introducci%C3%B3n-a-jinja2)
- [Usar Jinja2 en Ansible](#usar-jinja2-en-ansible)
- [Condiciones en Jinja2](#condiciones-en-jinja2)
- [Operadores Lógicos](#operadores-l%C3%B3gicos)
- [Bucles](#bucles)
- [Filtros](#filtros)
- [Otros Conceptos](#otros-conceptos)
	- [Ejemplo](#ejemplo)

---
# Introducción a Jinja2
- **Jinja2** es un **motor de plantillas** usado en Ansible.
- Rápido, eficiente y muy potente.
- Permite usar **placeholders**, condicionales, bucles y expresiones similares a Python.
- Se utiliza para **generar dinámicamente archivos de texto** (configuraciones, páginas, scripts...).
### Plantillas Jinja2
- Funciona como cualquier motor de plantillas:  
    ![[Plantillas Jinja2.png]]
- Jinja2 recibe datos de Ansible mediante **doble llave**:
	```Jinja2
	{{ ansible_distribution }}
	```
- Comentarios dentro de plantillas:
	```Jinja2
	{# Esto es un comentario #}
	```
- Comandos de control (condicionales, bucles, etc.):
	```Jinja2
	{% comando %}
	```

---
# Usar Jinja2 en Ansible
- Creamos un archivo `.j2` con la plantilla. Ejemplo: `plantilla.j2`:
	```Jinja2
	Hola {{ ansible_hostname }} 
	Hoy es {{ ansible_date_time.date }}
	```
- En el playbook usamos el módulo `template`:
	```YAML
	---
	- name: Trabajar con Jinja2
	  hosts: debian1
	
	  tasks:
	  - name: Generar salida desde plantilla
	    template:
	      src: plantilla.j2
	      dest: /tmp/salida.txt

	```
- Resultado en `/tmp/salida.txt`:
	```/tmp/salida.txt
	Hola debian1 
	Hoy es 2025-10-20
	```

---
# Condiciones en Jinja2
- Los condicionales son equivalentes a los de Ansible:  
    `==`, `!=`, `>`, `<`, `>=`, `<=`
- Sintaxis:
	```Jinja2
	{% if condicion %}
	  ...
	{% elif otra_condicion %}
	  ...
	{% else %}
	  ...
	{% endif %}
	```
### Ejemplo: página web según sistema operativo
#### Playbook:
```YAML
---
- name: Configurar página web según OS
  hosts:
    - debian1
    - rocky1

  tasks:
  - name: Instalar Apache en Debian
    apt:
      name: apache2
      state: present
    when: ansible_distribution == 'Debian'

  - name: Instalar Apache en Rocky
    dnf:
      name: httpd
      state: present
    when: ansible_distribution == 'Rocky'

  - name: Copiar página web
    template:
      src: condicionales.j2
      dest: /var/www/html/index.html

  - name: Arrancar Apache en Debian
    service:
      name: apache2
      state: started
    when: ansible_distribution == 'Debian'

  - name: Arrancar Apache en Rocky
    service:
      name: httpd
      state: started
    when: ansible_distribution == 'Rocky'
```
#### Plantilla `condicionales.j2`:
```Jinja2
<h1>Bienvenido a mi página WEB en Ansible</h1>

{% if ansible_distribution == 'Debian' %}
  <h2>Estoy en una máquina Debian</h2>
{% endif %}

{% if ansible_distribution == 'Rocky' %}
  <h2>Estoy en una máquina Rocky</h2>
{% endif %}
```

---
# Operadores Lógicos
Jinja2 usa los habituales operadores lógicos como:
- AND
- NOT
- OR...

```

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
