# Índice de la sección

- [🖥️ Intérprete de Python](#%EF%B8%8F-intérprete-de-python)
- [🔖 Shebang y convenios](#-shebang-y-convenios)
- [📝 Variables y tipos de datos](#-variables-y-tipos-de-datos)
- [⚡ Operadores Básicos en Python](#-operadores-básicos-en-python)
- [📝 Formateo de Cadenas (String Formatting)](#-formateo-de-cadenas-string-formatting)
- [🧭 Control de Flujo](#-control-de-flujo)
- [📌 Funciones y Ámbito](#-funciones-y-ámbito)
- [📌 Funciones Lambda](#-funciones-lambda)
- [⚠️ Excepciones y Manejo de Errores](#%EF%B8%8F-excepciones-y-manejo-de-errores)

---

# 🖥️ Intérprete de Python

El **intérprete** es el programa que **lee y ejecuta** el código Python. Es el “motor” que hace funcionar cualquier script o comando del lenguaje.

## Qué hace el intérprete

- **Ejecuta el código línea a línea**, facilitando la depuración.    
- Permite un **modo interactivo (REPL)** para probar comandos al instante.
- Ejecuta **scripts completos** guardados en archivos `.py`.
- **Compila el código a bytecode** (`.pyc`) para mejorar el rendimiento.
- Ejecuta ese bytecode en la **Python Virtual Machine (PVM)**, lo que hace que Python funcione igual en cualquier sistema operativo.

## Por qué es útil

- **Muy fácil de usar**: ideal para aprender y probar ideas rápidamente.    
- **Portable**: el mismo script funciona igual en Windows, Linux y macOS.
- **Extensible**: se puede ampliar con módulos en C/C++ para obtener más velocidad.

El intérprete es una pieza clave del lenguaje: entender cómo funciona te ayuda a escribir código más claro, portable y eficiente.

---

# 🔖 Shebang y convenios

## Shebang

- Línea al inicio de un script que indica **qué intérprete usar**:

	```bash
	#!/usr/bin/env python3
	```

- Garantiza que el script se ejecute con **Python 3**, incluso si Python 2 sigue instalado.
- Importante para scripts **ejecutables y portables**.

## Convenios de codificación

Siguiendo **PEP 8**, Python recomienda:

- **Nombres**:    
    - Variables y funciones → `lower_case_with_underscores`
    - Constantes → `UPPER_CASE_WITH_UNDERSCORES`
    - Clases → `CamelCase`
- **Indentación**: 4 espacios por nivel.
- **Longitud de línea**: máximo 79 caracteres (72 para comentarios/docstrings).
- **Espacios en blanco**: evitar espacios innecesarios.
- **Importaciones** (en este orden):
    1. Librería estándar
    2. Módulos de terceros
    3. Módulos locales

> [!Tip]  
> Seguir estos convenios **mejora la legibilidad y facilita el trabajo en equipo**.

---

# 📝 Variables y tipos de datos

## Variables

- Son **nombres que se asignan a datos**.
- No se declara el tipo: Python lo **infiera automáticamente**.

	```python
	nombre = "Ana"     # String
	edad = 25          # Integer
	altura = 1.75      # Float
	```

## Tipos de datos básicos

- **Cadenas (str)** → texto, inmutables.    
- **Números**:    
    - Enteros → `10`, `-3`
    - Flotantes → `3.14`, `-0.5`
- **Listas** → colecciones ordenadas **mutables**.  

	```python
	mi_lista = [1, "hola", 3.14]
	```

## Iterando sobre datos

```python
for elemento in mi_lista:
    print(elemento)
```

> [!Note]  
> Estos son los tipos base; más adelante veremos estructuras más avanzadas (tuplas, diccionarios, conjuntos…).

---

# ⚡ Operadores Básicos en Python

Los operadores permiten **realizar cálculos y manipular datos**.

## 1️⃣ Operadores Aritméticos

| Operador | Descripción                 | Ejemplo                          |
| -------- | --------------------------- | -------------------------------- |
| `+`      | Suma / Concatenación        | `2 + 3 → 5`, `"Hola" + " Mundo"` |
| `-`      | Resta                       | `5 - 2 → 3`                      |
| `*`      | Multiplicación / Repetición | `"Hola" * 3`                     |
| `/`      | División (float)            | `5 / 2 → 2.5`                    |
| `//`     | División entera             | `5 // 2 → 2`                     |
| `%`      | Módulo (resto)              | `5 % 2 → 1`                      |
| `**`     | Exponente                   | `2 ** 3 → 8`                     |

## 2️⃣ Operadores con secuencias

### Cadenas

```python
"Hola " + "Mundo"      # Concatenación
"Ha" * 3               # "HaHaHa"
```

### Listas

```python
[1,2] + [3,4]          # [1,2,3,4]
[0] * 5                # [0,0,0,0,0]
```

## 3️⃣ Funciones útiles para secuencias

```python
zip(["Ana", "Luis"], [25, 30])
# [('Ana', 25), ('Luis', 30)]

map(lambda x: x*2, [1,2,3])
# [2,4,6]
```

## 4️⃣ Conversión de tipos (TypeCast)

```python
int("10")   # 10
str(5)      # "5"
float("3.14") 
```

---

# 📝 Formateo de Cadenas (String Formatting)

## 1️⃣ Operador `%` (clásico)

```python
print("Hola %s, tienes %d años" % ("Ana", 25))
```

## 2️⃣ Método `.format()`

```python
print("Hola {}, tienes {} años".format("Luis", 30))
print("Pi vale {:.2f}".format(3.14159))  # 3.14
```

## 3️⃣ F-Strings (moderno y recomendado)

```python
nombre = "Marta"
edad = 28
print(f"Hola {nombre}, tienes {edad} años")
print(f"En 5 años tendrás {edad + 5}")
```

---

# 🧭 Control de Flujo

## 1️⃣ Condicionales

```python
if edad > 18:
    ...
elif edad == 18:
    ...
else:
    ...
```

## 2️⃣ Bucles

### For

```python
for x in [1,2,3]:
    print(x)
```

### While

```python
contador = 0
while contador < 3:
    contador += 1
```

## 3️⃣ Control del flujo interno

- `break` → sale del bucle
- `continue` → salta a la siguiente vuelta
- `pass` → no hace nada

---

# 📌 Funciones y Ámbito

## 1️⃣ Funciones

```python
def saludar(nombre):
    return f"Hola, {nombre}"
```

## 2️⃣ Scope

### Local

```python
def f():
    x = 10  # local
```

### Global

```python
x = 5
def f():
    global x
    x = 20
```

## 3️⃣ Buenas prácticas

- Funciones cortas.
- Nombres claros.
- Evitar variables globales innecesarias.

---

# 📌 Funciones Lambda

## ¿Qué son?

Funciones anónimas de una sola línea:

```python
lambda x: x * 2
```

## Usos típicos

```python
list(map(lambda x: x*2, [1,2,3]))
list(filter(lambda x: x > 5, [3,6,8]))
sorted(lista, key=lambda x: x.edad)
```

## Limitaciones

- Solo una expresión.
- No reemplazan funciones completas.

---

# ⚠️ Excepciones y Manejo de Errores

## 1️⃣ Excepciones

Errores durante la ejecución.  
Sin manejo → el programa se detiene.

## 2️⃣ `try` y `except`

```python
try:
    x = int("hola")
except ValueError:
    print("Dato inválido")
```

## 3️⃣ `else` y `finally`

```python
try:
    archivo = open("datos.txt")
except FileNotFoundError:
    print("No existe")
else:
    print("Abierto")
finally:
    print("Fin")
```

## 4️⃣ Lanzar excepciones

```python
if b == 0:
    raise ZeroDivisionError("No se puede dividir entre cero")
```

## 5️⃣ Excepciones comunes

- `ValueError`
- `TypeError`
- `IndexError`
- `KeyError`
- `ZeroDivisionError`
- `FileNotFoundError`

## 6️⃣ Buenas prácticas

✔ Manejar solo lo necesario  
✔ Mensajes claros  
✔ Usar `finally` para liberar recursos  
✔ No abusar de `except Exception`

---

🔙 [Volver al índice](Cursos/Python%20Ofensivo%20-%20Hack4u/00%20Índice.md)
