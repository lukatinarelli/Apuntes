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
# Ejecutar comandos en un Pod
Para ejecutar comandos dentro de los contenedores que están dentro de los **Pods**, el procedimiento es muy similar al de Docker:

```bash
kubectl exec <nombre-pod> <comando>
```

Esta era la forma estándar de ejecutar comandos, pero ha quedado obsoleta (deprecated). En las versiones más recientes de Kubernetes es necesario añadir -- antes del comando a ejecutar:

```bash
kubectl exec nginx1 -- ls
```

Para entrar en modo interactivo dentro del contenedor (por ejemplo, una consola Bash), usamos:
```bash
kubectl exec -it nginx1 -- bash
```

De esta forma accedemos a una bash dentro del contenedor.
Para salir, simplemente usamos el comando exit y regresamos a nuestra terminal local.

---
# Logs de Pods
Podemos crear un Pod basado en Apache para practicar con los logs:

```bash
kubectl run apache --image=httpd --port=8080
```

>💡 Con la opción --port indicamos el puerto en el que el contenedor expondrá su servicio.

Una vez creado, podemos ver los logs del Pod con:

```bash
kubectl logs apache
```

>💡 Si añadimos la flag -f, los logs se mostrarán en tiempo real (modo follow):

```bash
kubectl logs -f apache
```

Kubernetes ofrece otras opciones útiles para trabajar con logs:
- **--tail=N** → muestra solo las **últimas N líneas**.
- **--since=10m** → muestra los logs generados en los **últimos 10 minutos**.
- **-c [nombre-contenedor]** → en Pods con varios contenedores, permite seleccionar **de cuál obtener los logs**.
#### Ejemplo:
```bash
kubectl logs apache --tail=20
```

---
# Kubectl proxy
