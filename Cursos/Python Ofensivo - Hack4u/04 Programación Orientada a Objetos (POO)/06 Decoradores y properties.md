# 🧩 Decoradore🔙 ￼￼Volver al índice￼￼￼￼￼￼￼￼s y Properties en Python

Los **decoradores** y **properties** son herramientas avanzadas en Python que permiten modificar y controlar el comportamiento de funciones y atributos de clase de forma elegante y segura.

## 🛠️ 1. Decoradores: modificar funciones y métodos

Un **decorador** es una función que recibe otra función como argumento y devuelve una nueva función con comportamiento extendido.

### Ejemplo básico:

```python
def debug(func):
    def wrapper(*args, **kwargs):
        print(f"Llamando a {func.__name__} con args={args}, kwargs={kwargs}")
        return func(*args, **kwargs)
    return wrapper

@debug
def saludar(nombre):
    print(f"Hola, {nombre}!")

saludar("Lucía")
```

**Salida:**

```
Llamando a saludar con args=('Lucía',), kwargs={}
Hola, Lucía!
```

**Ventajas:**

- Agregar funcionalidad antes o después de ejecutar la función.
- Evitar modificar el código fuente original.
- Reutilizable para varias funciones o métodos.

## 🏷️ 2. Properties: control de acceso a atributos

Las **properties** permiten crear **getter**, **setter** y **deleter** para atributos de forma elegante, manteniendo el **encapsulamiento**.

### Ejemplo con property:

```python
class Persona:
    def __init__(self, nombre):
        self._nombre = nombre  # atributo protegido

    @property
    def nombre(self):
        """Getter: devuelve el nombre"""
        return self._nombre

    @nombre.setter
    def nombre(self, valor):
        """Setter: valida y actualiza el nombre"""
        if not valor:
            raise ValueError("El nombre no puede estar vacío")
        self._nombre = valor

    @nombre.deleter
    def nombre(self):
        print("Eliminando nombre...")
        del self._nombre

p = Persona("Lucía")
print(p.nombre)    # Getter
p.nombre = "Ana"   # Setter
del p.nombre       # Deleter
```

**Ventajas de las properties:**

- Controlar la lectura y escritura de atributos privados/protegidos.
- Validación y procesamiento antes de modificar datos.
- Mantener la interfaz pública limpia y segura.

## 💡 3. Uso combinado: decoradores y methods

- Los decoradores pueden aplicarse a **funciones**, **métodos de instancia**, **métodos de clase** y **métodos estáticos**.
- Las **properties** son decoradores especiales que permiten un **acceso controlado a atributos** como si fueran públicos.

---

# 🧠 Resumen visual

|Concepto|Qué hace|Ejemplo|
|---|---|---|
|Decorador|Modifica el comportamiento de una función/método|`@debug`|
|Property|Convierte métodos en atributos controlados|`@property, @setter, @deleter`|
|Getter|Obtiene valor de atributo con lógica extra|`p.nombre`|
|Setter|Modifica valor de atributo con validación|`p.nombre = "Ana"`|
|Deleter|Define comportamiento al eliminar un atributo|`del p.nombre`|

---

# 📌 En pocas palabras

- **Decoradores**: extensibles y reutilizables, añaden funcionalidad a funciones y métodos sin modificar su código original.
- **Properties**: permiten mantener el encapsulamiento y controlar el acceso a atributos de manera elegante.
- Combinando ambos, puedes escribir **código Python limpio, seguro y profesional**, especialmente en proyectos grandes y orientados a objetos.

---

🔙 [Volver al índice](../00%20Índice.md)