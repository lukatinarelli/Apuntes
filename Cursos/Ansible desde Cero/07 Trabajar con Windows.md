# Introducción
- Interactuar con Windows requiere un enfoque distinto al de Linux.    
- **Requisitos** y **configuración** cambian respecto a Linux.
- Muchos módulos de Ansible son distintos.
- En lugar de SSH, Windows utiliza **WinRM** (_Windows Remote Management_).

---
# ¿Qué es WinRM?
- WinRM es la implementación de Microsoft del protocolo **WS-Management**, basado en **SOAP**.   
- Permite gestionar versiones soportadas de Windows, tanto Desktop como Server.
### Requisitos:
- **PowerShell 3.0** o superior.
- **.NET Framework 4.0** o superior.
- **WinRM Listener** configurado y activado.
- Acceso con un **usuario administrador**.

---
# WinRM Listener
- WinRM utiliza un **listener** que escucha en los puertos:
    - **HTTP:** 5985
    - **HTTPS:** 5986
- Comandos de configuración rápida:
	```PowerShell
	# Configuración HTTP
	winrm quickconfig

	# Configuración HTTPS
	winrm quickconfig -transport:https
	```

### Ejemplo de listeners configurados
```
winrm enumerate winrm/config/Listener

Listener
  Address = *
  Transport = HTTP
  Port = 5985
  Enabled = true
  ListeningOn = 127.0.0.1, 192.168.27.129, ::1, fe80::d6:6d63:4fec:d439%3

Listener
  Address = *
  Transport = HTTPS
  Port = 5986
  Enabled = true
  CertificateThumbprint = 06E5D389026A0942E54D74885BE8D27D3B789CF5
  ListeningOn = 127.0.0.1, 192.168.27.129, ::1, fe80::d6:6d63:4fec:d439%3
```

---
# Configuración del inventario en Ansible
Para conectarse a Windows es necesario especificar algunos parámetros extra:
```INI
[windows]
win1
win2

[windows:vars]
ansible_user=administrador
ansible_password="password"
ansible_port=5986
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore

```
- `ansible_user` → usuario administrador de Windows.
- `ansible_password` → contraseña del usuario.
- `ansible_connection` → **winrm** para conexión remota.
- `ansible_winrm_server_cert_validation` → ignorar validación de certificado si usamos HTTPS.

---

# Módulos de Windows en Ansible

- Para Windows se usan módulos de la colección `ansible.windows`.
- Algunos ejemplos importantes:

| Módulo        | Función                                                                  |
| ------------- | ------------------------------------------------------------------------ |
| `win_acl`     | Gestionar permisos de archivos, carpetas o registros (ACL).              |
| `win_service` | Iniciar, detener o reiniciar servicios.                                  |
| `win_copy`    | Copiar archivos desde el controlador a la máquina Windows.               |
| `win_file`    | Gestionar archivos y directorios (crear, eliminar, modificar atributos). |
| `win_command` | Ejecutar comandos en Windows.                                            |
| `win_shell`   | Ejecutar scripts de PowerShell o shell de Windows.                       |
















### Ejemplo práctico: crear un directorio y dar permisos
```YAML
- name: Crear carpeta en Windows
  ansible.windows.win_file:
    path: C:\temp\ejemplo
    state: directory

- name: Dar permisos a un usuario
  ansible.windows.win_acl:
    path: C:\temp\ejemplo
    user: Administrador
    permission: FullControl
    state: present
```

