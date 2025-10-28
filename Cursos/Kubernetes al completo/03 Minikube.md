# Índice de la sección
- [¿Qué es Minikube?](#¿qué-es-minikube?)
- [Como se instala Minikube](#como-se-nstala-minikube)
	- [Requisitos](#requisitos)
- [Como se instala Minikube](#como-se-nstala-Kubectl)
- [Trabajar con Minikube](#como-se-nstala-Kubectl)

---
# ¿Qué es Minikube?
Minikube es una herramienta que nos permite **instalar un cluster de un solo nodo** dentro de un ordenador, para practicar o para formarse.

Permite aprender y conocer Kubernetes en un entorno sencillo y sin necesidad de recursos. Funciona dentro de un **entorno d virtualización o de contenedores**.

---
# Instalar Minikube
Para instalar Minikube ...
### Requisitos
#### Hardware:
- 2 CPus
- 2 Gigas de RAM
- 20 Gigas de disco
- Virtualizador o Container Runtime

> [!Note] 
> Cuantos más recursos tengamos, mucho mejor funcionará minikube.
#### Software:
- Kubectl
- Hypervisor o un Container Runtime (ej. Docker, VirtualBox, VMware...)
- En caso de usar Hypervisor, activar VT-x/AMD-v en la BIOS
### Instalar minikube en Windows con VirtualBox
1. Descargar la última version del instalador
	```PowerShell
	New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
	$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
	```
2. Corremos el instalador (asegúrate de ejecutarlo como administrador)
	```PowerShell 
	minikube-installer.exe
	```
3. Sigue las indicaciones de la instalación
4. Añade minikube.exe a tu PATH
	```PowerShell
	$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
	if ($oldPath.Split(';') -inotcontains 'C:\minikube'){
	  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine)
	}
	```
### Instalar minikube en Linux con Docker
1. Descargar la última version del instalador
	```shell
	curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
	```
2. Usamos el comando install para que le cambie los permisos y lo mueve a un directorio del PATH
	```PowerShell 
	sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
	```
3. Asegura tener permisos para usar docker y tener docker instalado
	```Bash
	minikube start --driver=docker
	```

> 🔗 [Guía de instalación más detallada](https://minikube.sigs.k8s.io/docs/start)

---

[🔙 Volver al índice](Cursos/Kubernetes%20al%20completo/00%20Índice.md)