# Definición 📘

- ##### Son **plantillas YAML** que permiten automatizar **conjuntos de tareas** en uno o varios hosts sin intervención manual.
- ##### Sustituyen el uso de comandos ad-hoc cuando se necesita **persistencia, orden y lógica** en la ejecución.
- ##### Permiten ejecutar **procesos complejos y repetibles** de forma controlada.

---
# Estructura ⚙️
##### Un **Playbook** está compuesto por **uno o varios plays**, y cada _play_ contiene **tareas (tasks)** que se ejecutan en un conjunto de hosts.
#### Jerarquía: 📚
`Playbook → Play(s) → Task(s)`

---
# Elementos principales 🧩
- ##### **hosts:** define en qué máquinas se ejecutará el play.
- ##### **vars:** variables que el play puede usar.
- ##### **tasks:** acciones que se ejecutan (módulos + argumentos).
- ##### **handlers:** tareas especiales que se ejecutan solo cuando son notificadas (ej. reiniciar servicios).
- ##### **roles:** estructura modular para organizar playbooks grandes.

---
# Ejemplo básico 🧠

```YAML
---
- name: Primer play del curso
  hosts: ubuntus
  
  tasks:
  - name: Hacer un ping
    ping:


- name: Instalar Nginx
  hosts: ubuntus, debian1
  
  tasks:
  - name: Instalar Nginx
    apt: 
      name: nginx
      state: latest
      update_cache: true

  - name: Arrancar nginx
    service:
      name: nginx
      state: started

  - name: Copiar index.html
    copy:
      src: recursos/index.html
      dest: /var/www/html
```

---

[🔙 Volver al índice](00%20Índice.md)
