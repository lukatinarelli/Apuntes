# 🏛️ Herencia y Polimorfismo en Python

La **herencia** y el **polimorfismo** son pilares de la Programación Orientada a Objetos (POO) que permiten crear jerarquías de clases flexibles, reutilizar código y diseñar sistemas extensibles.

## 🔹 1. Herencia: reutilización de código

La herencia permite que una **subclase** reciba atributos y métodos de una **superclase**.

### Sintaxis básica:

```python
class Animal:
    def __init__(self, nombre):
        self.nombre = nombre

    def hablar(self):
        pass

class Perro(Animal):
    def hablar(self):
        return "Guau!"

class Gato(Animal):
    def hablar(self):
        return "Miau!"
```

- `Perro` y `Gato` **heredan** de `Animal`.    
- Pueden **modificar** o **extender** métodos de la superclase (`hablar`).

### Beneficios de la herencia:

- Evita duplicar código.
- Permite **especialización** de clases.
- Facilita la **mantenibilidad** y **extensión** del software.

## 🔹 2. Polimorfismo: mismo método, diferentes comportamientos

El polimorfismo permite que objetos de distintas clases sean tratados como instancias de una clase común, **siempre que compartan la misma interfaz**.

```python
animales = [Perro("Rex"), Gato("Michi")]

for animal in animales:
    print(f"{animal.nombre} dice {animal.hablar()}")
```

**Salida:**

```
Rex dice Guau! 
Michi dice Miau!
```

- Ambos objetos responden al mismo método `hablar()`, pero cada uno tiene su comportamiento propio. 

### Tipos de polimorfismo en Python

1. **Polimorfismo de inclusión**: métodos de una subclase que reemplazan a los de la superclase.
2. **Polimorfismo paramétrico**: funciones que trabajan con objetos de distintas clases mientras cumplan la misma interfaz.

## 🔹 3. `super()` para acceder a la superclase

`super()` permite llamar métodos de la clase base desde la subclase.

```python
class Perro(Animal):
    def __init__(self, nombre, raza):
        super().__init__(nombre)
        self.raza = raza

    def hablar(self):
        return f"{self.nombre} dice Guau!"
```

- Mantiene la lógica de la superclase (`Animal.__init__`) y añade nuevos atributos (`raza`).

## 🔹 4. Herencia múltiple

Python permite que una clase herede de varias clases:

```python
class Volador:
    def volar(self):
        return "Estoy volando"

class Pajaro(Animal, Volador):
    pass

p = Pajaro("Piolín")
print(p.volar())
```

- Se recomienda usar herencia múltiple con cuidado.
- Python usa **MRO (Method Resolution Order)** para decidir qué método ejecutar.

## 🔹 5. Buenas prácticas

- Usa herencia solo cuando haya **una relación natural “es un”**.
- Prefiere **composición** cuando quieras reutilizar comportamiento sin acoplar clases.
- Evita sobrescribir métodos sin llamar a `super()` si la superclase tiene lógica importante.

---

# 🧠 Resumen visual

|Concepto|Qué es|Ejemplo|
|---|---|---|
|Herencia|Subclase obtiene atributos y métodos de superclase|`class Perro(Animal)`|
|Polimorfismo|Mismo método, diferentes comportamientos|`animal.hablar()` para Perro/Gato|
|super()|Accede a métodos de la superclase|`super().__init__(nombre)`|
|Herencia múltiple|Clase puede heredar de varias clases|`class Pajaro(Animal, Volador)`|

---

# 📌 En pocas palabras

- **Herencia**: reutiliza y especializa código.
- **Polimorfismo**: permite que distintos objetos se comporten de manera uniforme según su interfaz.
- Son herramientas clave para escribir código **flexible, modular y escalable** en Python.

---

🔙 [Volver al índice](../00%20Índice.md)