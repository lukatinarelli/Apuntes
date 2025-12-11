empleados_data = {
    101: {'nombre': 'Ana', 'edad': 30, 'salario': 55000},
    102: {'nombre': 'Luis', 'edad': 45, 'salario': 72000},
    103: {'nombre': 'Marta', 'edad': 24, 'salario': 48000},
    104: {'nombre': 'Carlos', 'edad': 38, 'salario': 61000},
    105: {'nombre': 'Elena', 'edad': 50, 'salario': 85000}
}

"""
Tienes un diccionario que contiene información de empleados. Cada clave es el ID del empleado (un entero) y el valor es otro diccionario con su nombre, edad y salario.

Tu tarea es usar una función lambda para ordenar la lista de empleados (obtenida de los valores del diccionario) por su salario, de menor a mayor.
"""

empleados_sorted = sorted(empleados_data.values(), key=lambda e: e['salario'])

print(empleados_sorted)
