"""
Crear una función anónima que nos permita calcular el promedio de un arreglo de números enteros.
"""

numeros = [6, 5, 4, 7, 8, 6, 9, 10, 3]

print((lambda l: sum(l)/len(l))(numeros))
