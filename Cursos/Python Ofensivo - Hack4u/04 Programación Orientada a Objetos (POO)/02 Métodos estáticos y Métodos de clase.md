# 🛠️ Métodos de Clase y Métodos Estáticos en Python (POO)

En la **Programación Orientada a Objetos** en Python, los **métodos de clase** y los **métodos estáticos** son herramientas que permiten organizar la funcionalidad dentro de las clases de forma más flexible y modular.

## 🏷️ 1. Métodos de Clase (`@classmethod`)

- Se definen con el decorador `@classmethod`.
- Reciben como primer argumento **cls**, que representa la clase.
- Se llaman sobre la **clase**, no sobre una instancia.
- Útiles para métodos “factory”, que crean instancias de la clase de formas específicas, o para acceder/modificar atributos de clase compartidos por todas las instancias.

**Ejemplo:**

```python
class Persona:
    especie = "Humano"  # atributo de clase

    def __init__(self, nombre):
        self.nombre = nombre

    @classmethod
    def cambiar_especie(cls, nueva_especie):
        cls.especie = nueva_especie

    @classmethod
    def crear_desde_cadena(cls, texto):
        nombre = texto.split("-")[0]
        return cls(nombre)

# Usando métodos de clase
Persona.cambiar_especie("Híbrido")
p = Persona.crear_desde_cadena("Lucía")
print(p.nombre)  # Lucía
print(Persona.especie)  # Híbrido
```

> [!Note]
> Los métodos de clase interactúan con la clase misma, permitiendo modificar su estado global o crear objetos de maneras alternativas.

## 🔧 2. Métodos Estáticos (`@staticmethod`)

- Se definen con el decorador `@staticmethod`.
- No reciben `self` ni `cls`.
- Funcionan como **funciones normales dentro de la clase**, solo que organizadas bajo el espacio de nombres de la clase.
- Ideales para funcionalidades relacionadas con la clase, pero que **no requieren acceder ni a atributos de instancia ni de clase**.

**Ejemplo:**

```python
class Calculadora:
    @staticmethod
    def sumar(a, b):
        return a + b

    @staticmethod
    def multiplicar(a, b):
        return a * b

# Usando métodos estáticos
print(Calculadora.sumar(2, 3))  # 5
print(Calculadora.multiplicar(4, 5))  # 20
```

> Mantienen la cohesión del código y permiten agrupar funciones que conceptualmente pertenecen a la clase.

## 🧠 3. Diferencias clave

|Concepto|Recibe|Se llama sobre|Uso principal|
|---|---|---|---|
|Método de instancia|`self`|Instancia|Acceder/modificar atributos de instancia|
|Método de clase|`cls`|Clase|Crear instancias alternativas o modificar atributos de clase|
|Método estático|—|Clase|Funciones relacionadas con la clase, sin acceso a la clase ni a instancias|

---

# 📌 Resumen

- **Método de clase** → interactúa con la **clase**.
- **Método estático** → funciona como una función normal, pero organizada dentro de la clase.
- Ambos contribuyen a un código **más limpio, modular y mantenible**.

---

🔙 [Volver al índice](../00%20Índice.md)