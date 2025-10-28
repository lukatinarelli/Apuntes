# Definición 📘 
##### Las **variables** en Ansible permiten **parametrizar tareas** y **reutilizar configuraciones** sin tener que modificar el código.  
##### Pueden definirse en **diferentes niveles**: entorno, inventario, playbooks, roles o incluso dentro de tareas.

---
# Tipos de variables 🧱

### Variables de entorno 🌍
- ##### Se definen en el sistema operativo donde se ejecuta Ansible.
- ##### Permiten modificar el comportamiento global de la herramienta.
#### Ejemplo: 📌
```BASH
export ANSIBLE_CONFIG=/home/ansible/ansible.cfg
```
### Variables de inventario 📁
- ##### Se declaran en los **ficheros de inventario** (`hosts`, `maquinas`, etc.).  
- ##### Pueden aplicarse **a nivel de host individual o de grupo**.
#### Ejemplo (inventario.ini): 📌
```INI
[web] 
ubuntu1 ansible_user=ansible puerto: 9000

[db] 
debian2 ansible_user=ansible entorno: desarrollo
```
### Variables de playbook 📜

Se definen **dentro del propio playbook**, a nivel de _play_ o incluso _task_.

📌 **Ejemplo:**
```YAML
all:
  children:
    web:
      hosts:
        ubuntu1:
          ansible_user: ansible
          puerto: 9000
    db:
      hosts:
        debian2:
          ansible_user: ansible
          entorno: desarrollo	
```
### Variables de role 🧩
- ##### Se utilizan dentro de un **Role** para definir parámetros propios del rol.  
- ##### Pueden almacenarse en:
	- `defaults/main.yml` → valores por defecto
	- `vars/main.yml` → valores que no deben ser sobreescritos
### Variables especiales 🧠
- ##### **Magic:** reflejan el estado interno de Ansible (no modificables).  
    #### Ejemplo: `inventory_hostname`, `hostvars`, `groups`.
- ##### **Facts:** contienen información del sistema remoto (`ansible_facts`).  
    #### Ejemplo: `ansible_distribution`, `ansible_hostname`.
- ##### **Conexión:** controlan cómo se ejecutan las acciones.  
    #### Ejemplo: `ansible_become_user`, `ansible_ssh_user`.
---
# Llamar variables en Ansible

### 1️⃣ Variables simples y listas (arrays)

```YAML
--- 
- name: Prueba con variables simples y listas   
  hosts: all   
  vars:     
	  mensaje: "Esto es un mensaje de Ansible"     
	  entorno: "este entorno es el mejor: "      
	  
	  entornos:       
	  - desarrollo       
	  - testing       
	  - producción      
	  
	  responsables: ["pepe", "juan", "Rosa"]    
	  
  tasks:     
  - name: Ver variables       
    debug:         
	    msg: >           
		    {{ mensaje }}. 
	        Entornos: {{ entornos }} y {{ entorno }} {{ entornos[0] }}. 
            Los responsables de cada entorno son: {{ responsables }}
  ```
#### Explicación: 💡
- ##### `mensaje` y `entorno` → variables simples de texto.
- ##### `entornos` → lista (array) de strings.
- ##### `responsables` → otra lista declarada en línea.
- ##### Para acceder a un elemento de la lista: `{{ entornos[0] }}` → "desarrollo".

---
### 2️⃣ Diccionarios (hashes)
```YAML
---
- name: Prueba con variables tipo diccionario
  hosts: all
  vars:
    desarrollo: 
      tipo: linux
      memoria: 4GB
      disco: 500GB

  tasks:
    - name: Ver variables del diccionario
      debug:
        msg: >
          Los ordenadores de desarrollo son: {{ desarrollo }}.
          No superar el limite del disco: {{ desarrollo.disco }}

  ```

---
### 3️⃣ Acceso a elementos de diccionarios y listas combinadas

##### Si quisieras acceder a algo como `"memoria"` del diccionario dentro de una lista, sería así:

```
hosts_info:   
- name: node1     
  memoria: 8GB   
  - name: node2     
    memoria: 16GB  # Para acceder a la memoria del primer 
    host: {{ hosts_info[0].memoria }}  # "8GB"
```

---

[🔙 Volver al índice](Cursos/Ansible%20desde%20Cero/00%20Índice.md)
