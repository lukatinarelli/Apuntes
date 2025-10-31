# Índice de la sección
- [¿Qué es Minikube?](#qu%C3%A9-es-minikube)
- [Instalación de Minikube](#instalaci%C3%B3n-de-minikube)
    - [Requisitos](#requisitos)
    - [Instalar Minikube en Windows con VirtualBox](#instalar-minikube-en-windows-con-virtualbox)
    - [Instalar Minikube en Linux con Docker](#instalar-minikube-en-linux-con-docker)
- [Comandos básicos de Minikube](#comandos-b%C3%A1sicos-de-minikube)
- [Crear un clúster con múltiples nodos](#crear-un-cl%C3%BAster-con-m%C3%BAltiples-nodos)
- [Cambiar la configuración de un clúster](#cambiar-la-configuraci%C3%B3n-de-un-cl%C3%BAster)
- [Minikube Dashboard](#minikube-dashboard)
- [Cambiar el Container Runtime](#cambiar-el-container-runtime)

---
# ¿Qué es Minikube?
**Minikube** es una herramienta que permite **instalar un clúster de Kubernetes de un solo nodo** dentro de tu ordenador, ideal para **practicar, aprender o realizar pruebas locales**.

Ejecuta Kubernetes en un entorno de **virtualización o de contenedores (Docker)**, sin necesidad de un servidor real ni infraestructura cloud.

> 💡 Perfecto para entornos de desarrollo o formación.

---
# Instalación de Minikube
### Requisitos
#### 🧱 Hardware:
- 2 CPU
- 2 GB de RAM
- 20 GB de disco
- Virtualizador o _container runtime_ (Docker, VirtualBox, etc.)

> [!NOTE]  
> Cuantos más recursos tengas disponibles, **mejor será el rendimiento de Minikube**.
#### 💻 Software:
- `kubectl`
- Hypervisor o container runtime (Docker, VirtualBox, VMware, etc.)
- Si usas un hypervisor, **activa VT-x / AMD-V** en la BIOS
### Instalar Minikube en Windows con VirtualBox
1. Crear el directorio y descargar el instalador:
	```PowerShell
	New-Item -Path 'C:\' -Name 'minikube' -ItemType Directory -Force $ProgressPreference = 'SilentlyContinue'
	
	Invoke-WebRequest -OutFile 'C:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
	```
2. Ejecutar el instalador como administrador:
	```PowerShell
	minikube-installer.exe
	```
3. Añadir Minikube al `PATH` del sistema:
	```PowerShell
	$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
	if ($oldPath.Split(';') -inotcontains 'C:\minikube'){
	  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine)
	}
	```
### Instalar Minikube en Linux con Docker
1. Descargar la última versión:
	```BASH
	curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
	``` 
2. Instalarlo y moverlo al PATH:
    ```BASH
	sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
	``` 
3. Verificar instalación:
    ```BASH
	minikube start --driver=docker
	``` 

> 🔗 [Guía de instalación oficial y detallada](https://minikube.sigs.k8s.io/docs/start)

---
# Comandos básicos de Minikube
| Comando           | Descripción                         |
| ----------------- | ----------------------------------- |
| `minikube status` | Muestra el estado del clúster       |
| `minikube start`  | Inicia un clúster nuevo o existente |
| `minikube stop`   | Detiene el clúster                  |
| `minikube delete` | Elimina un clúster                  |
| `minikube ip`     | Muestra la IP del clúster           |
| `minikube logs`   | Muestra los logs del clúster        |
#### Ejemplo:
```BASH
❯ minikube status minikube type: Control Plane host: Stopped kubelet: Stopped apiserver: Stopped kubeconfig: Stopped
``` 
---
# Crear un clúster con múltiples nodos
Puedes crear un clúster con más de un nodo usando el flag `--nodes`:
```BASH
minikube start --driver=docker -p clusterdev --nodes=2
``` 
Esto creará un clúster llamado `clusterdev` con **1 nodo maestro y 1 nodo worker**.

> ⚠️ Cuantos más nodos crees, más recursos consumirá tu sistema.
### Listar clústeres:
```BASH
minikube profile list
``` 
#### Ejemplo de salida:
```BASH
┌────────────┬────────┬─────────┬──────────────┬─────────┬────────┬───────┐ 
│  PROFILE   │ DRIVER │ RUNTIME │      IP      │ VERSION │ STATUS │ NODES │ 
├────────────┼────────┼─────────┼──────────────┼─────────┼────────┼───────┤ 
│ clusterdev │ docker │ docker  │ 192.168.58.2 │ v1.34.0 │ OK     │ 2     │ 
│ minikube   │ docker │ docker  │ 192.168.49.2 │ v1.34.0 │ OK     │ 1     │ 
└────────────┴────────┴─────────┴──────────────┴─────────┴────────┴───────┘
``` 

---
# Cambiar la configuración de un clúster
Puedes modificar configuraciones de un clúster con `minikube config`.
#### Ejemplo:
```BASH
minikube config set memory 4G -p minikube
``` 
> ⚠️ Los cambios se aplican tras eliminar y volver a iniciar el clúster.

Para ver configuraciones personalizadas:
```BASH
minikube config get memory -p minikube
``` 
> Las configuraciones se guardan en los directorios `~/.kube` y `~/.minikube`.

---
# Minikube Dashboard
Ejecuta:
```BASH
minikube dashboard
``` 
Esto abre una **interfaz web** donde puedes gestionar el clúster visualmente.
#### Salida típica:
```BASH
❯ minikube dashboard
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:34411/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
Se está abriendo en una sesión de navegador existente.
``` 

---
# Cambiar el Container Runtime
Puedes elegir el _runtime_ que usará Minikube al crear el clúster:
```BASH
minikube start --container-runtime=cri-o -p cluster2
``` 
> Los runtimes compatibles incluyen **Docker**, **containerd** y **CRI-O**.

---

🔙 [Volver al índice](Cursos/Kubernetes%20al%20completo/00%20%C3%8Dndice.md)