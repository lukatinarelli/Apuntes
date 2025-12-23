# 🧩 Clases y Objetos en Python (POO)

La **Programación Orientada a Objetos (POO)** es un paradigma que nos permite organizar el código modelando cosas del mundo real (o conceptos abstractos) como "entidades" propias. En lugar de tener funciones sueltas y variables dispersas, agrupamos todo en **Objetos**.

Python es un lenguaje **multiparadigma**, pero su corazón es orientado a objetos. De hecho, **en Python, absolutamente todo es un objeto**: los números, las listas, las funciones e incluso los errores.

### ¿Por qué es importante?

Entender la POO es la diferencia entre escribir scripts "desechables" y construir **herramientas profesionales**.

- **Modularidad:** Si algo falla, sabes exactamente en qué objeto buscar.

- **Reutilización:** Escribes el código de un objeto (ej. una conexión SSH) una vez y creas 50 conexiones usándolo.

- **Escalabilidad:** Permite que tus proyectos crezcan sin volverse un caos de código espagueti.

## 🧱 1. Clases: La plantilla del diseño

Una **clase** es el modelo, plano o molde a partir del cual crearemos objetos. Es una estructura abstracta: define **cómo deben ser** los objetos, pero no contiene datos concretos todavía.

Piensa en una clase como **el plano de un edificio**:

* El plano dice dónde van las ventanas y puertas (**Atributos**).

* El plano dice cómo funcionan los ascensores (**Métodos**).

* Pero **nadie puede vivir en el plano**. Necesitas construir el edificio (el objeto) para usarlo.

En Python, la estructura mínima es:

```python
class Persona:
    pass  # 'pass' es una instrucción nula, se usa cuando la clase está vacía por ahora.

```

> [!Note]
> Por convención (PEP 8), los nombres de las clases en Python usan **CamelCase** (primera letra mayúscula, sin guiones bajos). Ej: `MiClase`, `UsuarioAdmin`.

## 🧍 2. Objetos e Instanciación

Un **objeto** es una "instancia" concreta de una clase. Es cuando cogemos ese molde y creamos algo real en la memoria del ordenador. Cada objeto es independiente: si cambias el nombre de uno, no afecta a los demás.

Para crear objetos útiles, necesitamos el **Constructor (`__init__`)**.

### El método `__init__` y el misterioso `self`

```python
class Persona:
    # El constructor: se ejecuta automáticamente al crear el objeto
    def __init__(self, nombre, edad):
        self.nombre = nombre    # Atributo: Variable que pertenece al objeto
        self.edad = edad        # Atributo: Variable que pertenece al objeto

```

**🔍 Desglosando el código:**

1. **`__init__`**: Es un método especial (mágico). Se llama automáticamente cada vez que escribes `Persona()`. Su trabajo es **inicializar** los datos del objeto.
2. **`self`**: **¡Concepto clave!** Representa al **propio objeto** que se está creando.
* Cuando dices `self.nombre = nombre`, estás diciendo: *"Guarda el valor 'nombre' dentro DE MÍ (de este objeto específico)"*.

> [!Note]
> El concepto de `self` es tan importante (y a veces confuso) que tiene su propia nota dedicada. Profundizaremos en él aquí: **[03 - Comprendiendo self](03%20Comprendiendo%20self.md)**.

### Creando (Instanciando) los objetos

Una vez definida la clase con su `__init__`, podemos crear tantos objetos como queramos:

```python
# Instanciamos dos objetos diferentes usando la misma clase
hacker1 = Persona("Elliot", 28)
hacker2 = Persona("Darlene", 25)

# Cada uno tiene sus propios datos (Estado)
print(hacker1.nombre)  # Salida: Elliot
print(hacker2.nombre)  # Salida: Darlene

```

## ⚙️ 3. Inicialización y atributos de instancia

Aunque ya hemos visto el `__init__`, es crucial entender que los atributos definidos con `self.variable` son la **memoria** del objeto. Persisten mientras el objeto exista.

A diferencia de las variables normales en una función (que mueren cuando la función termina), los **atributos de instancia** recuerdan su valor.

Podemos acceder a ellos y modificarlos desde fuera de la clase:

```python
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

p = Persona("Mr. Robot", 30)

# 1. Acceder al atributo
print(p.nombre)  # Imprime: Mr. Robot

# 2. Modificar el atributo (Mutabilidad)
p.edad = 31      # Ha pasado un año
print(p.edad)    # Imprime: 31

```

> [!Tip]
> En hacking, esto es útil. Imagina un objeto `Target`. Al principio tiene `self.scanned = False`. Después de ejecutar un escaneo, actualizas su estado a `self.scanned = True`.

## 📦 4. Métodos de instancia (Comportamiento)

Los métodos son las **acciones** que pueden realizar nuestros objetos. Técnicamente son funciones dentro de la clase, pero con una regla de oro: **su primer parámetro debe ser `self**`.

### ¿Por qué `self` está en la definición pero no en la llamada?

Cuando defines el método, pones `def saludar(self):`.
Pero cuando lo usas, escribes `p.saludar()`. **¿Dónde está el argumento self?**

**Python lo pasa automáticamente**.
Cuando llamas a `objeto.metodo()`, Python lo traduce internamente a: `Clase.metodo(objeto)`.

```python
class Persona:
    def __init__(self, nombre):
        self.nombre = nombre

    # Método de instancia
    def saludar(self):
        return f"Hola, soy {self.nombre} y estoy listo."

    # Método que recibe parámetros adicionales
    def atacar(self, objetivo):
        print(f"{self.nombre} está atacando a {objetivo}...")

# Uso
hacker = Persona("Neo")

# Llamada simple (Python inyecta 'hacker' en 'self')
print(hacker.saludar())  

# Llamada con argumentos
hacker.atacar("Servidor Corp") 
# self -> hacker
# objetivo -> "Servidor Corp"

```

---

# 🧰 Métodos especiales de POO

Hasta ahora hemos usado métodos que reciben `self`, pero Python es flexible y permite otros tipos según lo que necesites hacer.

## 🏷️ 5. Métodos de clase (`@classmethod`)

* **No** operan sobre una instancia (un objeto creado), sino sobre la **clase misma**.
* Reciben `cls` (la clase) en vez de `self`.

Sirven mucho como **"Métodos Fábrica"**: formas alternativas de crear objetos cuando los datos vienen en un formato sucio (como un log o un string).

```python
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    @classmethod
    def desde_cadena(cls, texto):
        # Imaginemos que recibimos "Lucía-30" de una base de datos o archivo
        nombre, edad = texto.split("-")
        # 'cls' es 'Persona', así que esto equivale a Persona(nombre, int(edad))
        return cls(nombre, int(edad))

# Uso: Creamos el objeto procesando el string directamente
p = Persona.desde_cadena("Lucía-30")
print(p.nombre)  # Salida: Lucía

```

## 🔧 6. Métodos estáticos (`@staticmethod`)

* No reciben ni `self` ni `cls`.
* Son funciones normales que se colocan **dentro** de la clase solo por organización y limpieza.

Son útiles cuando tienes una función que tiene lógica relacionada con la clase (ej: validar un dato), pero que no necesita acceder a la información interna del objeto.

```python
class HerramientaRed:
    @staticmethod
    def validar_ip(ip):
        # Lógica simple para ver si parece una IP (esto no necesita 'self')
        return ip.count(".") == 3 and all(p.isdigit() for p in ip.split("."))

# Uso: Se puede llamar sin crear un objeto
print(HerramientaRed.validar_ip("192.168.1.1"))  # True

```

## 🎀 7. Decoradores: Modificar comportamiento

Un **decorador** es un patrón que permite añadir funcionalidad "alrededor" de un método (antes o después de su ejecución) sin tocar su código interno.

> [!Note]
> Verás muchos decoradores (`@property`, `@staticmethod`) ya incluidos en Python, pero también puedes crear los tuyos.

Ejemplo básico de un decorador de "debug" (muy útil para rastrear qué hacen tus herramientas):

```python
# Definimos el decorador
def debug(func):
    def wrapper(*args, **kwargs):
        print(f"🔴 [DEBUG] Llamando a la función: {func.__name__}")
        resultado = func(*args, **kwargs) # Ejecuta la función original
        print(f"✅ [DEBUG] {func.__name__} finalizada.")
        return resultado
    return wrapper

class Persona:
    def __init__(self, nombre):
        self.nombre = nombre

    @debug  # Aplicamos el decorador
    def hablar(self):
        print(f"{self.nombre} dice: Hola mundo.")

# Al llamar al método, el decorador toma el control
p = Persona("Alice")
p.hablar()

```

**En Hacking/POO se usan para:**

* Validación de permisos (¿Es admin?).
* Logs (Registrar cada vez que se lanza un exploit).
* Control de errores (Reintentar si falla la conexión).

---

# 🧠 Resumen visual

| Concepto | Recibe | ¿Para qué sirve? |
| --- | --- | --- |
| **Método de instancia** | `self` | Lo estándar. Acceder/modificar datos de **un** objeto concreto. |
| **Método de clase** | `cls` | Fábricas de objetos o lógica que afecta a toda la clase. |
| **Método estático** | Nada | Función utilitaria (validaciones, cálculos) guardada dentro de la clase por orden. |
| **Decorador** | Función | "Envolver" métodos para añadir extras (logs, checks) sin ensuciar el código. |

---

# 📌 En pocas palabras

La POO en Python es el estándar de la industria porque te permite:

1. **Modelar la realidad:** Pasar de conceptos abstractos a código estructurado.
2. **Organizar:** Evitar scripts kilométricos imposibles de leer.
3. **Reutilizar:** Escribir un componente una vez y usarlo en 10 herramientas distintas.
4. **Escalar:** Mantener proyectos grandes sin caos.

Es uno de los pilares fundamentales para programar **herramientas ofensivas avanzadas**, frameworks de C2 (Command & Control) y automatizaciones complejas.

---

🔙 [Volver al índice](../00%20Índice.md)
