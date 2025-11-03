# Índice de la sección
- [Introducción a los Pods](#introducci%C3%B3n-a-los-pods)
- [Pods con varios contenedores](#pods-con-varios-contenedores)
- [Crear un Pod](#crear-un-pod)
- [Propiedades de un Pod](#propiedades-de-un-pod)
- [Ejecutar comandos en un Pod](#ejecutar-comandos-en-un-pod)
- [Logs de Pods](#logs-de-pods)
- [kubectl proxy](#kubectl-proxy)
- [POD con un Servicio](#pod-con-un-servicio)
- [Port-Forwarding](#port-forwarding)
- [Minikube SSH](#minikube-ssh)

---
# 🚀 Introducción a los Pods
El **objeto más básico de Kubernetes** es el **Pod**.  
Un _Pod_ es una especie de **burbuja o contenedor lógico** que encapsula uno o varios contenedores con ciertas características adicionales.

Cuando desplegamos una aplicación en Kubernetes, en realidad la estamos desplegando **dentro de un Pod**, definido en un archivo YAML.  
El Pod ofrece funcionalidades extra a los contenedores, como:
- Almacenamiento compartido
- Red común
- Políticas de reinicio o ciclo de vida

Aunque **un Pod puede contener varios contenedores**, lo habitual es que **cada contenedor tenga su propio Pod**.  
A su vez, cada Pod se ejecuta dentro de un **nodo del clúster**.

> 💡 Es posible **replicar o clonar Pods** para aumentar la disponibilidad y resiliencia del servicio.

---
# 🧩 Pods con varios contenedores
Podemos crear Pods con varios contenedores, pero **no es la práctica recomendada**.  
En Kubernetes, la filosofía de los _microservicios_ busca que cada componente sea **autónomo e independiente**.

Cada servicio tiene sus propias necesidades:
- Backups
- Ciclo de vida
- Reinicios (_rebotes_)
- Actualizaciones

Además, **cada Pod tiene su propia dirección IP**, por lo que si queremos que cada servicio sea accesible de forma independiente, conviene separarlos en Pods distintos.

---
# 🏗️ Crear un Pod
En Kubernetes podemos trabajar de dos formas:
- **Modo imperativo:** gestionamos los objetos directamente mediante comandos.
- **Modo declarativo:** describimos el estado deseado en un archivo YAML y Kubernetes lo aplica.

Para crear un Pod de forma imperativa:
```bash
kubectl run nginx1 --image=nginx
```

Este comando crea un Pod con un contenedor basado en la imagen de **nginx**.  
Kubernetes descargará automáticamente la imagen desde el repositorio configurado (por defecto, Docker Hub).

Para listar los Pods en ejecución:
```bash
kubectl get pods
```

> [!Note] Añade la opción `-o wide` para mostrar información adicional (nodo, IP, etc.)

---
# 🔍 Propiedades de un Pod
Para visualizar las propiedades detalladas de un Pod:
```bash
kubectl describe pod/<nombre-pod>
```

> [!Warning] Recuerda anteponer la palabra clave `pod/` antes del nombre del Pod.

---
# 🧠 Ejecutar comandos en un Pod
Para ejecutar comandos dentro de los contenedores que están dentro de los **Pods**, el procedimiento es similar a Docker:
```bash
kubectl exec <nombre-pod> <comando>
```

Esta sintaxis antigua ha quedado obsoleta.  
En versiones recientes de Kubernetes es necesario añadir `--` antes del comando:
```bash
kubectl exec nginx1 -- ls
```

Para entrar en modo interactivo dentro del contenedor (por ejemplo, una consola Bash):
```bash
kubectl exec -it nginx1 -- bash
```

De esta forma accedemos a una shell dentro del contenedor.  
Para salir, simplemente usamos:
```bash
exit
```

---
# 🧾 Logs de Pods
Podemos crear un Pod basado en Apache para practicar con los logs:
```bash
kubectl run apache --image=httpd --port=8080
```

> [!Note] Con la opción `--port` indicamos el puerto en el que el contenedor expondrá su servicio.

Ver los logs del Pod:
```bash
kubectl logs apache
```

Con la flag `-f`, los logs se muestran en tiempo real:
```bash
kubectl logs -f apache
```


Opciones útiles:

- `--tail=N` → muestra solo las **últimas N líneas**
    
- `--since=10m` → logs de los **últimos 10 minutos**
    
- `-c [nombre-contenedor]` → especifica el contenedor si hay varios
    

#### Ejemplo:
```bash
kubectl get pods
```
`kubectl logs apache --tail=20`

---

## 🌐 kubectl proxy

El comando `kubectl proxy` crea un **proxy HTTP** que permite acceder a la API de Kubernetes de forma segura desde tu máquina local.

#### Ejemplo:
```bash
kubectl get pods
```
`kubectl proxy`

Esto abre un proxy local en `http://127.0.0.1:8001`, a través del cual puedes acceder a recursos del clúster:
```bash
kubectl get pods
```
`http://127.0.0.1:8001/api/v1/namespaces/default/pods`

> 💡 **Uso típico:** conectar herramientas o paneles web locales con la API de Kubernetes sin exponerla públicamente.

---

## 🌍 POD con un Servicio

Para exponer un **Pod** y hacerlo accesible desde fuera del clúster, usamos:
```bash
kubectl get pods
```
`kubectl expose pod nginx1 --port=80 --name=nginx1-svc --type=LoadBalancer`

### 🔍 Explicación

- `nginx1` → nombre del Pod a exponer
    
- `--port=80` → puerto interno del servicio
    
- `--name=nginx1-svc` → nombre del nuevo servicio
    
- `--type=LoadBalancer` → expone el servicio hacia fuera del clúster
    

Listar los servicios activos:
```bash
kubectl get pods
```
`kubectl get svc`

> [!NOTE]  
> Para conocer la IP externa en Minikube:
> 
> `minikube ip`

---

## 🔄 Port-Forwarding

Permite **mapear un puerto local** de tu máquina a un puerto de un Pod dentro del clúster.

#### Ejemplo:
```bash
kubectl get pods
```
`kubectl port-forward pod/nginx 9999:80`

Acceso desde el navegador:
```bash
kubectl get pods
```
`http://localhost:9999`

> 💡 **Ventajas:** rápido, seguro y sin exponer el servicio públicamente.  
> ⚠️ **Limitación:** solo accesible desde tu equipo local.

---

## 🖥️ Minikube SSH

Con `minikube ssh` puedes **acceder directamente a la máquina virtual** donde se ejecuta tu clúster Minikube.
```bash
kubectl get pods
```
`minikube ssh`

Una vez dentro, tendrás acceso a un entorno Linux minimalista que actúa como **nodo del clúster**.  
Desde ahí puedes inspeccionar procesos, archivos, o el runtime de contenedores (`containerd` o `docker` según la configuración).

#### Ejemplos útiles:
```bash
kubectl get pods
```
`docker ps`

Lista los contenedores en ejecución dentro del nodo Minikube.
```bash
kubectl get pods
```
`exit`

Para salir y volver a tu terminal local.

> 💡 Ideal para tareas de depuración o para entender cómo Kubernetes ejecuta internamente los Pods.

---

🔙 [Volver al índice](00%20Índice.md)
