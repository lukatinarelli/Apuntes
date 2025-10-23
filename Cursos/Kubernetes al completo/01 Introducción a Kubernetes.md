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

---
# Introducción a Kubernetes
Kubernetes comenzó en **julio de 2015** y fue donado a la **Cloud Native Computing Foundation (CNCF)**.

Kubernetes es un **orquestador de contenedores**, que permite crear un cluster de nodos con funcionalidades avanzadas sobre los contenedores:
- Tolerancia a fallos
- Alta disponibilidad
- Escalabilidad automática
- Gestión eficiente de recursos
- Operaciones en caliente (actualizaciones sin downtime)
- Y más...

Una abreviada para referirse a Kubernetes es **k8s**, el “8” representa las letras entre la “k” y la “s”.  

> [🔗 Documentación oficial de Kubernetes](https://kubernetes.io/)
### Alternativas a Kubernetes
Aunque Kubernetes es el líder del mercado, existen otros orquestadores de contenedores:
- **Docker Swarm**
- **Mesos Marathon**
- **Nomad**
- **Shipyard**  

---
# Estándares de contenedores
Kubernetes acepta cualquier **container runtime**.
### OCI (Open Container Initiative)
OCI es una iniciativa de estandarización de los contenedores, creada en **2015**, que busca que los contenedores puedan ejecutarse en cualquier hardware o sistema operativo.

OCI define dos estándares principales:
1. **Runtime Specification (runtime-spec)**: cómo se ejecutan los contenedores.  
2. **Image Specification (image-spec)**: cómo deben ser las imágenes de los contenedores.

	![Esquema OCI](Imágenes/Esquema%20OCI.png)

### OCI Image Specification
Define cómo se estructura una imagen de contenedor:
- **Sistema de archivos en capas**: las capas se van agregando para construir la imagen final.
- **Archivo de configuración**: guarda la información de ejecución, variables de entorno y parámetros.
- **Archivos de manifiesto y de índice**.
### OCI Runtime Specification
Define los **estados de un contenedor** y cómo se ejecuta:
```
[Creación] --> [Creado] --> [En ejecución] --> [Parado] --> [Borrado]
```
#### runC
- Runtime ligero que cumple la especificación OCI.
- Donado por Docker.
- Es utilizado por **containerd** para ejecutar contenedores siguiendo la especificación OCI.
### Alternativas a Docker
Red Hat, como competidor de Docker, ha creado varias alternativas:
- Podman
- CRI-O
- Buildah
- rkt
- Kata Containers
- Skopeo

---
# Cloud Native Computing Foundation (CNCF)
Organización neutral encargada de coordinar y mantener proyectos de código abierto para ejecutar aplicaciones en la nube.  

Pertenece a la **Linux Foundation**.

---
# Arquitectura de Kubernetes
- **Control Plane (Master)**: gestiona el cluster.
- **Nodos (Nodes)**: ejecutan los contenedores.  
- Componentes clave del Control Plane: **API Server**, **Scheduler**, **Controller Manager**, **etcd**, etc.

---

[🔙 Volver al índice](00%20Índice.md)
