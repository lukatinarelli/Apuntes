# 🧩 Orgranización y módulos en Python 

La **Programación Orientada a Objetos (POO)** es un enfoque para organizar código basándose en entidades que combinan datos y comportamiento. 

Python soporta este paradigma de forma muy flexible, y entenderlo es clave para construir programas grandes, mantenibles y escalables. 

## 🧱 1. Clases: plantillas para crear objetos 

Una **clase** es un molde del que derivan los objetos. Define:

- **Atributos** → datos que guardará cada objeto.
- **Métodos** → funciones que operan sobre esos datos.

```python
class Persona:
	pass
```

Esto solo define la estructura básica, pero aún no tenemos objetos. 

## 🧍 2. Objetos: instancias de una clase 

Un **objeto** (o instancia) es una copia concreta de la clase, con su propio estado.

```python
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre    # atributo de instancia
        self.edad = edad
```

Cada objeto tiene sus propios valores de atributos, aunque compartan la clase que los define. 

## ⚙️ 3. Inicialización y atributos de instancia 

El método `__init__()` se ejecuta automáticamente al crear una instancia.

```python
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre    # atributo de instancia
        self.edad = edad
```

`self` siempre apunta al propio objeto. 

## 📦 4. Métodos de instancia (los que se usan el 90% del tiempo) 

Son funciones que reciben `self` y trabajan con el estado del objeto.

```python
class Persona:
    def saludar(self):
        print(f"Hola, soy {self.nombre}")
```

--- 

# 🧰 Métodos especiales de POO 

Python permite varios tipos de métodos, según lo que necesites hacer. 

## 🏷️ 5. Métodos de clase (`@classmethod`) 

- Se llaman desde la **clase**, no desde un objeto.
- Reciben `cls` (la clase) en vez de `self`. 

Sirven mucho para _métodos fábrica_, es decir, formas alternativas de crear objetos.

```python
class Persona:
    @classmethod
    def desde_cadena(cls, texto):
        nombre, edad = texto.split("-")
        return cls(nombre, int(edad))

p = Persona.desde_cadena("Lucía-30")
```

## 🔧 6. Métodos estáticos (`@staticmethod`)
- No reciben ni `self` ni `cls`.
- Son funciones normales que se colocan dentro de la clase solo por organización.

```python
class Calculadora:
    @staticmethod
    def sumar(a, b):
        return a + b
```

Útiles para lógica relacionada con la clase, pero que no depende de ella. 

## 🎀 7. Decoradores: modificar el comportamiento sin tocar el código interno 

Un **decorador** añade funcionalidad alrededor de un método —antes, después, o ambas cosas— sin reescribirlo. 

Ejemplo básico:

```python
def debug(func):
    def wrapper(*args, **kwargs):
        print(f"Llamando a {func.__name__}")
        return func(*args, **kwargs)
    return wrapper

class Persona:
    @debug
    def hablar(self):
        print("Estoy hablando...")
```

En POO se usan para: 
- validación de permisos
- logs
- sincronización de hilos
- caching
- control de acceso

---

# 🧠 Resumen visual

|Concepto|Qué es|Cuándo se usa|
|---|---|---|
|**Método de instancia**|Recibe `self`|Acceder/modificar atributos del objeto|
|**Método de clase**|Recibe `cls`|Crear objetos de formas alternativas; lógica que afecta a la clase|
|**Método estático**|No recibe nada|Función útil, pero sin acceso a la clase ni a instancias|
|**Decorador**|Función que envuelve otra|Añadir funcionalidad sin modificar el código original|

---

# 📌 En pocas palabras

La POO en Python te permite:

- modelar entidades del mundo real,
- organizar mejor el código,
- reutilizar comportamientos,
- mantener proyectos grandes sin caos,
- y extender funcionalidades sin romper nada.

Es uno de los pilares para programar herramientas ofensivas, automatizaciones y proyectos de software complejos.

---

🔙 [Volver al índice](../00%20Índice.md)