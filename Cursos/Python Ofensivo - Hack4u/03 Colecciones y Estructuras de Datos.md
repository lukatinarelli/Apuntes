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

# 📦 Listas

Las **listas** son una de las estructuras de datos más versátiles y utilizadas en Python.  
Permiten almacenar **secuencias ordenadas** de elementos y son **mutables**, es decir, pueden modificarse después de crearse.

Las usarás constantemente para almacenar, procesar y transformar datos.

## ⭐ Características principales

### 🔹 1. Permiten datos heterogéneos

Una misma lista puede contener distintos tipos:

```python
mi_lista = [1, "hola", 3.14, True]
```

### 🔹 2. Son indexadas

Puedes acceder a elementos usando índices (positivos o negativos):

```python
mi_lista[0]     # primer elemento  
mi_lista[-1]    # último elemento
```

### 🔹 3. Permiten slicing (cortes)

Puedes obtener sublistas fácilmente:

```python
mi_lista[1:3]
```

### 🔹 4. Soportan anidación

Puedes crear estructuras complejas como matrices:

```python
matriz = [[1,2,3], [4,5,6], [7,8,9]]
```

### 🔹 5. Son dinámicas

Puedes añadir o quitar elementos en cualquier momento.

## 🛠️ Operaciones básicas con listas

### 🔸 Añadir elementos

```python
lista.append(x)      # añade un elemento  
lista.extend([..])   # extiende con múltiples elementos  
lista.insert(i, x)   # inserta en una posición
```

### 🔸 Eliminar elementos

```python
lista.remove(x)      # elimina la primera aparición  
lista.pop()          # elimina y devuelve el último  
lista.pop(i)         # elimina por índice  
del lista[i]         # elimina sin devolver
```

### 🔸 Ordenar e invertir

```python
lista.sort()         # ordena la lista (in place)  
sorted(lista)        # devuelve una lista nueva  
lista.reverse()      # invierte la lista  
lista[::-1]          # slice invertido
```

## 🚀 Comprensiones de listas

Una forma “pythonica”, elegante y eficiente de crear listas:

```python
cuadrados = [x * x for x in range(10)]
```

Son rápidas, legibles y reducen código innecesario.

Variantes con condición:

```python
pares = [x for x in range(10) if x % 2 == 0]
```

Comprensiones anidadas:

```python
matriz = [[i * j for j in range(3)] for i in range(3)]
```

## 📚 Métodos útiles de listas

Lista de métodos más comunes:
- `append()`
- `extend()`
- `insert()`
- `remove()`
- `pop()`
- `clear()`
- `sort()`
- `reverse()`
- `index()`
- `count()`
- `copy()`

Cada uno te permite manipular listas de manera flexible y eficiente.
## ✔️ Buenas prácticas

- Usa listas cuando necesites **colecciones ordenadas y mutables**.
- Si necesitas **inmutabilidad**, usa **tuplas**.
- Si necesitas evitar duplicados, usa **sets**.
- Para datos con **claves–valores**, usa **diccionarios**.
- Evita listas extremadamente grandes dentro de bucles muy intensivos (considera `array`, `deque` u otras estructuras optimizadas).
- Prefiere **comprensiones de listas** cuando busques claridad y brevedad.

---

# 📚 Tuplas

Las **tuplas** son colecciones **ordenadas** de elementos, muy parecidas a las listas, pero con una diferencia clave: **son inmutables**.  
Una vez creadas, **no pueden modificarse**, lo que las convierte en una excelente opción para datos que deben permanecer constantes.

## ⭐ Características principales

### 🔹 1. Inmutables

No puedes añadir, eliminar ni modificar elementos:

```python
t = (1, 2, 3)
# t[0] = 10 → ❌ Error
```

Esto garantiza la **integridad** de los datos.

### 🔹 2. Ordenadas e indexables

Puedes acceder por índice y hacer slicing igual que con listas:

```python
t[1]        # acceso por índice
t[0:2]      # slicing
```

### 🔹 3. Heterogéneas

Pueden contener distintos tipos, incluso otras tuplas:

```python
t = (1, "hola", 3.14, (10, 20))
```

### 🔹 4. Más ligeras y rápidas que las listas

Son más eficientes en memoria y rendimiento.

## 🛠️ Operaciones con tuplas

Aunque no son modificables, sí permiten varias operaciones útiles:

### 🔸 Empaquetado y desempaquetado

Python empaqueta automáticamente:

```python
t = 1, 2, 3        # empaquetado
a, b, c = t        # desempaquetado
```

### 🔸 Concatenación y repetición

```python
(1, 2) + (3, 4)   # → (1, 2, 3, 4)
(1,)*4           # → (1, 1, 1, 1)
```

### 🔸 Métodos útiles

```python
t.index(x)   # primera posición de x
t.count(x)   # cuántas veces aparece x
```

## 🧰 Usos comunes de las tuplas

### ✔️ 1. Retorno múltiple en funciones

```python
def datos():
    return 1, 2, 3

a, b, c = datos()
```

### ✔️ 2. Datos constantes

Ejemplos típicos:

```python
DIAS = ("Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom")
punto = (10, 20)
```

### ✔️ 3. Claves en diccionarios

Como son inmutables, pueden usarse como claves:

```python
d = {(1,2): "coordenada"}
```

## ✔️ Buenas prácticas

- Usa **listas** si necesitas modificar los datos.
- Usa **tuplas** si los datos deben permanecer constantes.
- Aprovecha tuplas para **retornos múltiples** y para **estructuras ligeras**.
- No abuses de tuplas demasiado grandes o anidadas si afectan la claridad.

Aquí tienes el apartado de **Conjuntos** reformulado, limpio, claro y perfectamente adaptado al mismo estilo que tus otras notas: conciso, estructurado, con iconos y sin texto innecesario.

---

# 🔷 Conjuntos (Sets)

Los **conjuntos** (`set`) son colecciones **desordenadas**, **sin elementos repetidos** y con operaciones inspiradas en la teoría de conjuntos.  
Son ideales cuando necesitas **unicidad**, **comparar colecciones** o **buscar elementos rápidamente**.

## ⭐ Características principales

### 🔹 1. Unicidad automática

Los elementos duplicados se eliminan automáticamente:

```python
set([1, 2, 2, 3])   # {1, 2, 3}
```

### 🔹 2. No tienen orden

No conservan posiciones ni índices.  
No se puede acceder por índice como en listas o tuplas.

### 🔹 3. Son mutables

Puedes añadir y eliminar elementos, pero **solo admiten elementos inmutables**:

✔ enteros, cadenas, tuplas  
✖ listas, otros sets

### 🔹 4. Operaciones matemáticas nativas

Uniones, intersecciones, diferencias, etc.

## 🛠️ Operaciones básicas con sets

### 🔸 Añadir y eliminar elementos

```python
s = {1, 2, 3}

s.add(4)        # añade un elemento
s.remove(2)     # elimina (error si no existe)
s.discard(10)   # elimina sin error
s.clear()       # vacía el conjunto
```

## 🔗 Operaciones entre conjuntos

Python permite usar métodos **o** operadores.

### Unión

```python
a | b
a.union(b)
```

### Intersección

```python
a & b
a.intersection(b)
```

### Diferencia

```python
a - b
a.difference(b)
```

### Diferencia simétrica

(elementos presentes en uno u otro, pero no en ambos)

```python
a ^ b
a.symmetric_difference(b)
```

## 🔍 Pruebas de pertenencia

Los sets son extremadamente rápidos para comprobar si un elemento está dentro:

```python
if x in conjunto:
    ...
```

Son más rápidos que listas y tuplas para búsquedas.

## 🧱 Conjuntos inmutables: `frozenset`

Si necesitas un conjunto **que no pueda modificarse**, existe:

```python
fs = frozenset([1, 2, 3])
```

Ideal para usar como **clave en diccionarios** o para garantizar inmutabilidad.

## 🧰 Usos habituales de los conjuntos

✔ **Eliminar duplicados**

```python
sin_repetidos = set(mi_lista)
```

✔ **Comparar colecciones** (subconjuntos, intersecciones, elementos en común)

✔ **Búsquedas rápidas** en grandes cantidades de datos

✔ **Operaciones matemáticas** entre colecciones

## ✔️ Buenas prácticas

- Usa sets cuando necesites **elementos únicos**.
- No los uses si necesitas **orden** → usa listas o tuplas.
- Para conjuntos inmutables, prefiere **frozenset**.
- Excelente para detectar duplicados o hacer comparaciones rápidas.

---

# 📘 Diccionarios

Los **diccionarios** son una de las estructuras de datos más potentes y flexibles de Python.  
Permiten almacenar **pares clave–valor**, lo que los hace ideales para representar datos estructurados.

A diferencia de las listas (que usan índices numéricos), los diccionarios se acceden mediante **claves únicas**, que deben ser tipos **inmutables** (cadenas, números, tuplas…).

## ⭐ Características principales

### 🔹 1. Colección desordenada

Los elementos no tienen un orden fijo.  
(Desde Python 3.7 conservan el orden de inserción, pero **no debes depender de ello** en diseño lógico.)

### 🔹 2. Pares clave–valor

Cada entrada tiene una **clave única** y un **valor** asociado:

```python
persona = {"nombre": "Ana", "edad": 25}
```

### 🔹 3. Claves únicas

La clave no puede repetirse: si se asigna una clave ya existente, se sobrescribe el valor anterior.

### 🔹 4. Dinámicos

Puedes añadir, modificar y eliminar elementos en cualquier momento.

### 🔹 5. Valores flexibles

Los valores pueden ser de **cualquier tipo**: listas, diccionarios, números, funciones…

## 🛠️ Operaciones básicas

### 🔸 Acceder a valores

```python
persona["nombre"]
```

### 🔸 Agregar o modificar

```python
persona["ciudad"] = "Madrid"   # agregar
persona["edad"] = 26           # modificar
```

### 🔸 Eliminar elementos

```python
del persona["edad"]
persona.pop("ciudad")
```

### 🔸 Comprobar existencia de clave

```python
"edad" in persona
```

## 📚 Métodos útiles de diccionarios

### 🔸 `.keys()`

Devuelve todas las claves.

### 🔸 `.values()`

Devuelve todos los valores.

### 🔸 `.items()`

Devuelve pares `(clave, valor)`:

```python
for clave, valor in persona.items():
    print(clave, valor)
```

### 🔸 `.get()`

Accede sin lanzar error si la clave no existe:

```python
persona.get("altura", "desconocido")
```

### 🔸 `.update()`

Une diccionarios o actualiza valores.

## 🚀 Comprensiones de diccionarios

Una manera elegante y compacta de construir diccionarios:

```python
cuadrados = {x: x*x for x in range(5)}
```

Con condición:

```python
pares = {x: x*x for x in range(10) if x % 2 == 0}
```

## 🧰 Usos comunes

- **Modelar datos estructurados** (usuario, producto, configuración…)
- **Representar JSON** en Python
- **Tablas de búsqueda rápidas**
- **Contadores, registros, mapeos clave → valor**
- **Estructuras anidadas** como:

```python
usuario = {
    "nombre": "Ana",
    "direccion": {
        "ciudad": "Madrid",
        "cp": 28001
    }
}
```

Los diccionarios son extremadamente rápidos para buscar por clave (O(1) promedio).

## ✔️ Buenas prácticas

- Utiliza claves **descriptivas** y **consistentes**.
- Usa `.get()` si no estás seguro de que la clave exista.
- Evita claves mutables (listas, diccionarios…).
- Úsalos cuando necesites **accesos rápidos** por clave.
- No abuses de diccionarios anidados muy profundos (dificultan la lectura).

---

🔙 [Volver al índice](00%20Índice.md)