# Índice de la sección
- [¿Qué es Kubectl?](#¿qué-es-kubectl?)
- [Instalar Kubectl](#Instalar-Kubectl)
	- Instalar linux
	- Instalar windows

---
# ¿Qué es Kubectl?
Kubectl es una **herramienta en modo comando** que nos permite trabajar y gestionar clusters de Kubernetes

Es totalmente **agnóstica**, no es un producto que viene con algún fabricante. Es una herramienta promocionada por la comunidad de Kubernetes y se conecta con cualquier distribución del Kubernetes

> 🔗 [Link de instalación](https://kubernetes.io/docs/tasks/tools/)

---
# Instalar Kubectl
Para instalar kubectl se puede descargar a través del anterior enlace pero para agilizar el proceso, podemos usar el comando `curl`.
### Instalar kubectl binario con `curl` en Linux (x86-64)
1. Descarga la última versión con el comando:
	```BASH
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	```
2. Validar el binario (Opcional)
	```BASH
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	```
3. Install kubectl
	```bash
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	```

> 🔗 [Guía de instalación más detallada](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
### Instalar kubectl binario en Windows
En este enlace tienes la guía completa para instalar:
https://kubernetes.io/docs/tasks/tools/install-kubectl-windows

---

[🔙 Volver al índice](Cursos/Kubernetes%20al%20completo/00%20Índice.md)