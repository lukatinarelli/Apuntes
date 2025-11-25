# 🔐 Encapsulamiento y Métodos Especiales en Python

El **encapsulamiento** y los **métodos especiales** son pilares de la POO que permiten controlar el acceso a los datos de una clase y personalizar el comportamiento de los objetos en Python.

## 🏷️ 1. Encapsulamiento: control de visibilidad de atributos y métodos

El encapsulamiento define **qué se puede ver y modificar desde fuera de la clase**. En Python, se implementa mediante convenciones:

### Atributos Públicos

- Accesibles desde cualquier parte del programa.
- No llevan prefijo especial.

```python
class Persona:
    def __init__(self, nombre):
        self.nombre = nombre  # público
```

### Atributos Protegidos

- Prefijo `_atributo`.
- Convención: “no tocar desde fuera, salvo subclases”.
- Python **no impide** el acceso, es solo un acuerdo de buenas prácticas.

```python
class Persona:
    def __init__(self, nombre):
        self._edad = 30  # protegido
```

### Atributos Privados

- Prefijo `__atributo`.
- Python aplica **name mangling** para dificultar el acceso externo.

```python
class Persona:
    def __init__(self, nombre):
        self.__dni = "12345678A"  # privado

p = Persona("Lucía")
# p.__dni  # ERROR
# Acceso "forzado": p._Persona__dni
```

## 🛠️ 2. Métodos Especiales (mágicos)

Los métodos especiales permiten que tus clases respondan a **operadores y funciones internas de Python**. Siempre con doble guion bajo al inicio y al final (`__metodo__`).

### Métodos importantes:

|Método|Descripción|Ejemplo|
|---|---|---|
|`__init__(self, …)`|Inicializa la instancia|`p = Persona("Lucía")`|
|`__str__(self)`|Representación legible para `print()`|`print(p)`|
|`__repr__(self)`|Representación “oficial”, útil en debugging|`repr(p)`|
|`__eq__(self, other)`|Define `==`|`p1 == p2`|
|`__lt__`, `__le__`, `__gt__`, `__ge__`|Comparaciones `<, <=, >, >=`|`p1 < p2`|
|`__add__`, `__sub__`, `__mul__`|Operadores aritméticos `+, -, *`|`obj1 + obj2`|

### Ejemplo práctico:

```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)

    def __str__(self):
        return f"Vector({self.x}, {self.y})"

v1 = Vector(2, 3)
v2 = Vector(1, 5)
print(v1 + v2)  # Vector(3, 8)
```

## 💡 3. Buenas prácticas

- Usa atributos **privados** solo cuando quieras proteger datos críticos.
- Prefiere **métodos públicos** para la interacción con objetos.
- Documenta métodos especiales para que otros desarrolladores sepan cómo interactuar con tu clase.
- Evita romper las convenciones de nombre (`_` y `__`) salvo que tengas un motivo muy concreto.

---

# 🧠 Resumen visual

|Concepto|Qué es|Cómo se indica|
|---|---|---|
|Atributo público|Accesible desde fuera|`self.atributo`|
|Atributo protegido|Convención: “no tocar fuera”|`self._atributo`|
|Atributo privado|Dificulta el acceso externo|`self.__atributo`|
|Método especial|Personaliza operadores y funciones internas|`__init__, __str__, __add__`|

---

# 📌 En pocas palabras

- El **encapsulamiento** protege la integridad del objeto y organiza la visibilidad de atributos y métodos.
- Los **métodos especiales** permiten que las clases interactúen de forma natural con Python y hagan que los objetos se comporten como tipos nativos.
- Usar ambos correctamente resulta en **clases robustas, mantenibles y seguras**. 

---

🔙 [Volver al índice](../00%20Índice.md)