# ¿Qué es DevOps?
<img src="../imágenes/Devops.png" width="400" align="right">

_DevOps_ es un conjunto de prácticas que integran el **desarrollo de software (Dev)** con las **operaciones de TI (Ops)**. Su objetivo es **acelerar el ciclo de vida del desarrollo de software** y permitir una **entrega continua de alta calidad**. Muchas de sus prácticas provienen de la **metodología Agile**, enfocándose en la colaboración, la transparencia y la mejora continua.

La característica central de _DevOps_ es la **automatización y el monitoreo** en todos los pasos de la construcción del software, desde la **integración**, las **pruebas**, el **despliegue**, hasta la **implementación** y la **gestión de la infraestructura**.

# Condiciones de DevOps

- Se entregará **código todos los días** o **varias veces al día**.
- Se debe **compilar** y **desplegar** en los servidores de **pruebas** y **producción**.
- Los servidores de **producción** son utilizados por los **clientes**, por lo que deben estar **siempre disponibles** y en funcionamiento [^1].

# Pipeline de entrega automatizada en DevOps

La entrega de software en DevOps se realiza mediante un **pipeline de entrega automatizada**, que sugiere pasos estructurados para garantizar calidad, rapidez y control. Los pasos típicos son:

1. **Ingeniería de requisitos**
    - Gestión de proyectos y tareas → _Jira, Trello_	
    - Desarrollo y configuración → _Visual Studio, Eclipse_	
    - Repositorio de código fuente → _Git, Bitbucket_	
2. **Etapa de Commit**    
    - Compilación del código → _Maven, Gradle_	
    - Pruebas unitarias → _JUnit, NUnit_	
    - Análisis estático de código → _SonarQube, ESLint_	
    - Empaquetado del software → _Docker, Maven_	
3. **Etapa de Aceptación**
    - Provisionamiento de entornos → _Terraform, Ansible_
    - Virtualización de servicios y sistemas de registro → _WireMock, MockServer_
    - Pruebas de aceptación → _Selenium, Cucumber_
4. **Etapa de Carga y Rendimiento**
    - Despliegue del software en entornos de prueba → _Kubernetes, Docker Compose_
    - Pruebas de carga → _JMeter, Gatling_
    - Pruebas de rendimiento → _New Relic, Prometheus_
    - Software listo para liberación
5. **Etapa de Liberación**
    - Despliegue final en producción → _AWS, Azure, Jenkins_

Esto es lo que se conoce como **“DevOps Delivery Pipeline”**, que permite entregar software de forma continua y segura.

# Ciclo de vida DevOps

## Desarrollo Continuo (Continuous Development)

En esta fase, los desarrolladores crean el código utilizando diversas herramientas de desarrollo y luego lo suben a un **sistema de control de versiones** (Source Code Management).
- Herramientas típicas: _Visual Studio, Eclipse, IntelliJ_
- Los ingenieros DevOps generalmente **no escriben código de aplicación**, pero son responsables de **mantener el código**, asegurando que se gestione correctamente mediante herramientas de control de versiones [^2].

## Continuous Integration






























## Continuous Deployment






## Continuous Testing






## Continuous Monitoring





[^1]: Mantener alta disponibilidad es uno de los principios clave de DevOps, ya que cualquier caída en producción afecta directamente a los usuarios.

[^2]: El control de versiones es fundamental en DevOps, ya que permite **seguimiento, colaboración y recuperación** de versiones anteriores de manera eficiente.
