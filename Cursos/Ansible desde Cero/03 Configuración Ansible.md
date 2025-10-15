# Formas de configurar Ansible
#### Formas de configurar su funcionamiento:
- ##### Ficheros de configuración [más utilizada]
- ##### Variables de entorno
- ##### Opciones de línea de comando
- ##### Opciones y variable en los play books

### Ficheros de configuración 
###### Ansible tiene el **fichero** `ansible.cfg` dónde ponemos los valores por defecto de nuestro ansible.
###### Formado por un **conjunto de opciones** con un valor predefinido dónde cambiar a través de este fichero.

> Solo es necesario modificar el fichero para cambiar algún valor

#### El fichero se puede encontrar en los siguientes sitios:
- ##### **ANSIBLE_CONFIG**. variable de entorno
- ##### **Ansible.cfg**. directorio actual
- ##### **~/.ansible.cfg**. directorio home del user
- ##### **/etc/ansible/ansible.cfg**.

> Orden en el que Ansible busca el fichero de configuración

#### Ver donde se encuetnra este fichero:
```bash
ansible@node1:~$ ansible --version

ansible 2.10.8
  config file = None
  configured module search path = ['/home/ansible/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ...
```

> En este caso, no tiene fichero de configuración

---
# Inventarios
#### Introducción:
- ##### Permite indicar los servidores a los que queremos conectarnos
- ##### Un único fichero, una lista o plugins más avanzados.
- ##### Se pueden usar distintos formatos, YAML, INI...
```bash
ansible -i [fichero_inventario]
```

#### Ejemplos:
##### INI:
```INI
datos1 

[servidores_aplicaciones] 
tomcat1 
tomcat2 

[servidores_datos] 
datos1.empresa.com 
datos2.empresa.com 

[desarrollo]
tomcat2
```
##### YAML:
```YAML
all: 
	hosts: 
		datos1: 
	children: 
		servidores_aplicaciones: 
			hosts: 
				tomcat1: 
				tomcat2: 
		servidores_datos: 
			hosts: 
				datos1.empresa.com 
				datos2.empresa.com
```

---

[🔙 Volver al índice](00%20Índice.md)
