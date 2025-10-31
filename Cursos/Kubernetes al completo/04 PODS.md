# Índice de la sección
- [Introducción a los Pods](#introducción-a-los-pods)
- [Pods con varios contenedores](#pods-con-varios-contenedores)
- [Crear un Pod](#crear-un-pod)
- [Propiedades de un Pod](#propiedades-de-un-pod)

---
# Introducción a los Pods
El **objeto más básico de Kubernetes** es el **Pod**.  
Un *Pod* es una especie de **burbuja o contenedor lógico** que encapsula uno o varios contenedores con ciertas características adicionales.

Cuando desplegamos una aplicación en Kubernetes, en realidad la estamos desplegando **dentro de un Pod** definido en un archivo YAML.  
El Pod ofrece funcionalidades extra a los contenedores, como:
- Almacenamiento compartido.  
- Red común.  
- Políticas de reinicio o ciclo de vida.  

Aunque **un solo Pod puede contener varios contenedores**, lo habitual es que **cada contenedor tenga su propio Pod**.  
A su vez, cada Pod se ejecuta dentro de un **nodo del clúster**.

> 💡 Es posible **replicar o clonar Pods** para aumentar la disponibilidad y resiliencia del servicio.

---
# Pods con varios contenedores
Podemos crear Pods con varios contenedores, pero **no es la práctica recomendada**.  
En Kubernetes, la filosofía de los *microservicios* busca que cada componente sea **autónomo e independiente**.

Cada servicio tiene sus propias necesidades:  
- Backups.  
- Ciclo de vida.  
- Reinicios (*rebotes*).  
- Actualizaciones, etc.

Además, **cada Pod tiene su propia dirección IP**, por lo que si queremos que cada servicio sea accesible de forma independiente, conviene separarlos en Pods distintos.

---
# Crear un Pod
En Kubernetes podemos trabajar de dos formas:
- **Modo imperativo:** gestionamos los objetos directamente mediante comandos.
- **Modo declarativo:** describimos el estado deseado en un archivo YAML y Kubernetes lo aplica.

Para crear un Pod de forma **imperativa**, usamos:
```bash
kubectl run nginx1 --image=nginx
```

Este comando crea un Pod con un contenedor basado en la imagen de **nginx**.  
Kubernetes descargará automáticamente la imagen desde el repositorio configurado (por defecto, Docker Hub).

Para listar los Pods en ejecución:
```bash
kubectl get pods
```

> 💡 Añade la opción `-o wide` para mostrar información adicional (nodo, IP, etc.)

---

# Propiedades de un Pod

Para visualizar las propiedades detalladas de un Pod:
```bash
kubectl describe pod/<nombre-pod>
```

> ⚠️ **Importante:** recuerda anteponer la palabra clave `pod/` antes del nombre del Pod.

---
# Ejecutar comandos contra un POD
Para lanzar comandos contra los contenedores que están dentro de los PODS es exactamente igual a los comandos de docker:
```bash
kubectl exec [nombrePOD] [comando]
```
Esta es la forma estándar para lanzar comandos. Aunque ya esta _DEPRECATED_ y en una futura version se eliminará por lo que hay que añadir "--" antes del comando a realizar, este es un ejemplo:
```bash
kubectl exec nginx1 -- ls
```

Para entrar en modo interactivo podemos poner:
```bash
kubectl exec nginx -it --bash
```
De esta forma entramos en una bash dentro de nuestro contenedor y con exit podemos salir y volver a nuestra terminal.

---
# Logs de PODs
Vamos a craer primero un POD basado en apache para poder manejar logs:
```bash
kubectl run apache --image=httpd --port=8080
```

> [!Note] Con `--port` también podemos especificar en que puerto queremos el POD

Ya con el servicio servicio de apache podemos usar el siguente comando para ver los logs:
```bash
kubectl logs apache
```

> [!Note] Si añadimos la flag `-f` los logs se mentienen y se acutalizaran

Kubectl tiene muchas mas opciones para ver los logs, como `--tail=X` para ver ciertas lineas del logs o la flag  `--??` no me se mas

---
