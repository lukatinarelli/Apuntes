# Índice de la sección
- [Condiciones `when`](#condiciones-when)
- [Bucles `loop` y `until`](#bucles-loop-y-until)
- [Handlers](#handlers)
- [Bloques](#bloques)
- [Otros conceptos](#otros-conceptos)

---
# Filtro `type_debug`
### Introducción
- .....
### Ejemplo básico con `when`
```YAML
---
- name: Ejemplos varios de filtros
  hosts: debian1
  vars:
       cadena: "hola"
 
  tasks:
  - name: Averiguar el tipo de una variable
    ansible.builtin.debug:
      var: cadena | type_debug
```
# Conversiones

# Cadenas

##   upper y lower

##  replace

## length

# numeros
## pow()
## root()
## round()
##