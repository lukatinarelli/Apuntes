# Índice de la sección
- [Introducción a Kubernetes](#introducción-a-kubernetes)
	- [Alternativas a Kubernetes](#alternativas-a-kubernetes)
- [Estándares de contenedores](#estándares-de-contenedores)
	- [OCI (Open Container Initiative)](#oci-open-container-initiative)
	- [OCI Image Specification](#oci-image-specification)
	- [OCI Runtime Specification](#oci-runtime-specification)
	- [Alternativas a Docker](#alternativas-a-docker)
- [Cloud Native Computing Foundation (CNCF)](#cloud-native-computing-foundation-cncf)
- [Arquitectura de Kubernetes](#arquitectura-de-kubernetes)
- [Instalación de Kubernetes](#instalación-de-kubernetes)
- [Distribuciones de Kubernetes](#distribuciones-de-kubernetes)
	- [Kubernetes en Cloud](#kubernetes-en-cloud)
- [Opciones para el curso de Kubernetes](#opciones-para-el-curso-de-kubernetes)

---
# Introducción a Kubernetes
Kubernetes comenzó en **julio de 2015** y fue donado a la **Cloud Native Computing Foundation (CNCF)**.

Kubernetes es un **orquestador de contenedores**, que permite crear un *cluster* de nodos con funcionalidades avanzadas sobre los contenedores:
- Tolerancia a fallos  
- Alta disponibilidad  
- Escalabilidad automática  
- Gestión eficiente de recursos  
- Operaciones en caliente (*actualizaciones sin downtime*)  
- Y más...

Una forma abreviada de referirse a Kubernetes es **k8s**, donde el “8” representa las letras entre la “k” y la “s”.

> 🔗 [Documentación oficial de Kubernetes](https://kubernetes.io/)
### Alternativas a Kubernetes
Aunque Kubernetes es el líder del mercado, existen otros orquestadores de contenedores:

- **Docker Swarm**  
- **Mesos Marathon**  
- **Nomad**  
- **Shipyard**

---
# Estándares de contenedores
Kubernetes acepta cualquier **container runtime** compatible.
### OCI (Open Container Initiative)
**OCI** es una iniciativa creada en **2015** para estandarizar los contenedores, de forma que puedan ejecutarse en cualquier hardware o sistema operativo.

OCI define dos estándares principales:
1. **Runtime Specification (runtime-spec)**: define cómo se ejecutan los contenedores.  
2. **Image Specification (image-spec)**: define cómo deben ser las imágenes de los contenedores.

![Esquema OCI](Imágenes/Esquema%20OCI.png)
### OCI Image Specification
Define cómo se estructura una imagen de contenedor:

- **Sistema de archivos en capas**: las capas se agregan para construir la imagen final.  
- **Archivo de configuración**: almacena la información de ejecución, variables de entorno y parámetros.  
- **Archivos de manifiesto e índice**.
### OCI Runtime Specification
Define los **estados de un contenedor** y cómo se ejecuta:

```
[Creación] --> [Creado] --> [En ejecución] --> [Parado] --> [Borrado]
```

#### runC
- Runtime ligero que cumple la especificación OCI.  
- Donado por Docker.  
- Utilizado por **containerd** para ejecutar contenedores según las especificaciones OCI.
### Alternativas a Docker
**Red Hat**, como competidor de Docker, ha desarrollado diversas alternativas:

- **Podman**  
- **CRI-O**  
- **Buildah**  
- **rkt**  
- **Kata Containers**  
- **Skopeo**

---

# Cloud Native Computing Foundation (CNCF)
La **CNCF** es una organización neutral encargada de coordinar y mantener proyectos de código abierto orientados a la ejecución de aplicaciones en la nube.  

Pertenece a la **Linux Foundation**.

---
# Arquitectura de Kubernetes
- **Control Plane (Master)**: gestiona y coordina el *cluster*.  
- **Nodos (Nodes)**: ejecutan los contenedores.  
- Componentes clave del Control Plane:  
  - **API Server**  
  - **Scheduler**  
  - **Controller Manager**  
  - **etcd**

---
# Instalación de Kubernetes
Kubernetes ofrece diversas formas de instalación, dependiendo del entorno y del propósito.
### 1. Local o de un solo nodo
Útil para pruebas o aprendizaje.

- **Minikube** → la más conocida y recomendada para entornos locales.  
- **kind** → permite crear un *cluster* dentro de Docker.  
- **K3s** → creada por *Rancher*, enfocada en entornos ligeros (IoT, edge computing).  
- **MicroK8s** → ideal para entornos locales o *clusters* pequeños.  
- **Kubernetes en Docker Desktop** → permite arrancar un Kubernetes integrado de un solo uso.
### 2. Instalación manual mediante herramientas
Permite implementar un *cluster* de forma controlada y educativa.  
La más usada es **kubeadm**, ideal para aprender cómo se forma un *cluster* paso a paso.
### 3. Instalación automatizada
Permite desplegar un *cluster* completo de forma más sencilla y reproducible.

- **Kubespray** → una de las herramientas más conocidas, con múltiples *plugins*.  
- **Kops** → facilita el despliegue en entornos *cloud*.  
- **RKE** → creada por *Rancher*, ideal si usas su plataforma.
### 4. Servicios gestionados por proveedores Cloud
El proveedor gestiona la infraestructura y el *Control Plane*, facilitando el despliegue y mantenimiento.

Ideal si no tienes servidores propios o quieres concentrarte en las aplicaciones.

Ejemplos:  
- **AWS EKS** (Elastic Kubernetes Service)  
- **Azure AKS** (Azure Kubernetes Service)  
- **Google GKE** (Google Kubernetes Engine)

---
# Distribuciones de Kubernetes
Existen múltiples distribuciones de Kubernetes, y aunque el ecosistema es muy dinámico, algunas se han consolidado como líderes:
- **Red Hat OpenShift**  
- **SUSE Rancher**  
- **Canonical Kubernetes**  
- **VMware Tanzu** (anteriormente *Pivotal*)  
- **Platform9 Managed Kubernetes**  
- **Giant Swarm**  
- **Portainer**
### Kubernetes en Cloud
Además, existen versiones adaptadas por los principales proveedores *cloud*:
- **Amazon EKS** (Elastic Kubernetes Service)  
- **Azure AKS** (Azure Kubernetes Service)  
- **Google GKE** (Google Kubernetes Engine)  
- **IBM IKS** (IBM Kubernetes Service)  
- **Oracle Kubernetes Service**  
- **Alibaba Kubernetes Service**

---
# Opciones para el curso de Kubernetes
Para seguir el curso, las opciones más recomendadas son:

- **Minikube** ✅ (recomendada para entorno local).  
- **Docker Desktop** (rápido y sencillo).  
- **Tu propio entorno en la nube** (AWS, GCP, etc.).

---

🔙 [Volver al índice](00%20Índice.md)
