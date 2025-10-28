#### La **escalada de privilegios** permite ejecutar tareas como **otro usuario** (por ejemplo, `root`), incluso si el usuario remoto no tiene permisos administrativos.

---
# ⚙️ Directivas principales

| Directiva           | Descripción                                                              | Ejemplo                |
| ------------------- | ------------------------------------------------------------------------ | ---------------------- |
| **become**          | Activa o desactiva la escalada de privilegios                            | `become: yes`          |
| **become_user**     | Usuario al que queremos cambiar para ejecutar la tarea                   | `become_user: root`    |
| **become_method**   | Método usado para la escalada (`sudo`, `su`, `pbrun`, etc.)              | `become_method: sudo`  |
| **become_flags**    | Permite especificar opciones adicionales al comando de escalada          | `become_flags: "-H"`   |
| **ask-become-pass** | Si se activa, Ansible pedirá la contraseña sudo antes de ejecutar tareas | `ask_become_pass: yes` |
# 💡 Ejemplo práctico

### 🧾 En un _playbook_

```yaml
- hosts: all   
  become: yes   
  become_user: root   
  tasks:     
	  - name: Instalar Apache       
		  apt:         
		  name: apache2         
		  state: present
```
### 💬 En un comando _ad-hoc_
```bash
ansible all -m apt -a "name=nginx state=present" -b
```

> [!Note] 
> El parámetro `-b` es un **atajo de línea de comandos para `become: yes`**.

> [!Warning]
> - Si el usuario tiene permiso `NOPASSWD` en `/etc/sudoers`, Ansible no pedirá contraseña.
> - Si el comando falla con “permission denied”, revisa que el usuario esté autorizado en el archivo `sudoers`.

---

[🔙 Volver al índice](Cursos/Ansible%20desde%20Cero/00%20Índice.md)
