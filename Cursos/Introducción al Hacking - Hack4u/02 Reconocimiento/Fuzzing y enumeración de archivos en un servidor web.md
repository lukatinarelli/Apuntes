# 🕵️ Fuzzing y Enumeración de Archivos Web

El **Fuzzing** en entornos web consiste en aplicar fuerza bruta sobre las rutas de un servidor para descubrir archivos, directorios o parámetros que no están a simple vista.

Navegar manualmente nos da una idea, pero el fuzzing automático nos permite encontrar:

- Paneles de administración (`/admin`, `/backend`).
- Archivos de configuración olvidada (`.env`, `config.php.bak`).
- Rutas de API ocultas.
- Directorios con listado de archivos habilitado.

> [!IMPORTANT]
> Antes de lanzar estas herramientas, recuerda validar el Scope. Consulta la nota [2.06 Alcance — Validación HackerOne](2.06%20Alcance%20—%20Validacion%20HackerOne.md) para asegurarte de que el dominio objetivo permite pruebas de fuerza bruta.

---

# 🛠️ Herramientas de Enumeración Activa

## 1. Gobuster: El tanque de Go 🏎️

**Gobuster** es extremadamente rápido porque está programado en Go y gestiona las conexiones de forma muy eficiente. Es ideal para ataques directos a directorios.

- **Instalación:** `sudo apt install gobuster` o compilar desde el [repo oficial](https://github.com/OJ/gobuster).

**Comando optimizado:**

```Bash
gobuster dir -u https://www.miwifi.com/ -w /usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt -t 75 --timeout 20s -s "200,204,301,302,307" -b "" -x html,php,txt
```

**Desglose del comando:**

- `dir`: Modo enumeración de directorios.
- `-u`: La URL objetivo (siempre usa `www` si el scope lo indica).
- `-w`: Diccionario de **SecLists** (el estándar de la industria).
- `-t 20`: Usamos 20 hilos para mayor velocidad (ajustar según la estabilidad del servidor).
- `-s`: Whitelist de estados (solo muéstrame los OK o redirecciones).
- `-b`: Blacklist de estados (oculta explícitamente errores o prohibidos). En caso de usar `-s` tienes que especificar `-b` con una cadena vacía.
- `-x`: Busca archivos con extensiones específicas (html, php, txt).
- `--add-slash`: Añade una barra `/` al final de cada petición.

---

## 2. Wfuzz: El bisturí multipropósito 🗡️

A diferencia de Gobuster, **Wfuzz** es altamente flexible. Permite inyectar datos en cualquier parte de la URL o las cabeceras usando la palabra clave `FUZZ`.

**Uso estándar para directorios:**

```Bash
wfuzz -c -L --hc=403,404 -t 200 -w /usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt https://www.miwifi.com/FUZZ/
```

**Parámetros clave:**

- `-c`: Salida con colores (mucho más legible).
- `-L`: Sigue redirecciones (Follow Redirects). Fundamental para ver a dónde nos llevan los 301.
- `--hc=403,404`: **H**ide **C**ode. Oculta los errores para no saturar la pantalla.
- `FUZZ`: Es el marcador de posición donde Wfuzz irá probando cada palabra del diccionario.

Fuzzing de extensiones y rangos:

Podemos buscar archivos específicos o incluso IDs de productos:

```Bash
# Buscando archivos con múltiples extensiones a la vez
wfuzz -c -L --hc=403,404 -t 20 -w /usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt -z list,html-txt-php https://www.miwifi.com/FUZZ.FUZ2Z

# Buscando IDs de productos en una tienda (rango numérico)
wfuzz -c -L --hw=5524 -t 20 -z range,1-20000 'https://mi.com/shop/buy/detail?product_id=FUZZ'
```

- `--hw`: **H**ide **W**ords. Útil cuando la página devuelve un 200 pero con un mensaje de "Producto no encontrado". Si el mensaje siempre tiene 5524 palabras, las ocultamos todas.

---

## 3. ffuf: La evolución del Fuzzing ⚡

**ffuf** (Fuzz Faster U Fool) es actualmente la herramienta favorita de muchos auditores. Combina la velocidad de Go con la flexibilidad de Wfuzz.

```Bash
ffuf -c -t 20 -w /usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt -u https://www.miwifi.com/FUZZ/ --mc=200 -v
```

- `-v`: Modo verbose. Nos enseña información extra, como el destino de los redirects.
- `--mc=200`: **M**atch **C**ode. Solo muestra resultados con estado 200.

---

## 4. BurpSuite: El Interceptor Maestro 🕸️

Mientras que las herramientas anteriores son para "fuerza bruta ciega", **BurpSuite** es una plataforma completa para análisis web. Su función principal es actuar como un **Proxy HTTP**.

### 🌍 ¿Qué es un Proxy HTTP en Pentesting?

Es un software que se sitúa entre tu navegador y el servidor web. Permite interceptar el tráfico, analizarlo y modificarlo antes de que llegue a su destino (o antes de que la respuesta llegue a tu navegador).

### 💸 Community Edition vs. Professional

|**Característica**|**Community Edition (Gratis)**|**Professional (Pago)**|
|---|---|---|
|**Proxy e Intercepción**|✅ Incluido|✅ Incluido|
|**Intruder**|⚠️ Limitado (Velocidad reducida)|✅ Completo y rápido|
|**Escáner de Vulnerabilidades**|❌ No disponible|✅ Automatizado y potente|
|**Extensiones (BApp Store)**|✅ Limitado|✅ Acceso total|

> [!NOTE]
> En este punto del curso, usaremos BurpSuite principalmente para identificar recursos de forma manual y entender cómo viajan las peticiones. Su potencia real (Intruder y Repeater) la veremos en módulos avanzados.

---

# 🔎 Alternativas Pasivas

No olvides que antes de hacer ruido con herramientas activas, podemos usar:

- **[Phonebook.cz](https://phonebook.cz/)**: Filtra por "URLs" para ver qué rutas tiene indexadas el motor de IntelX. Ahorra mucho tiempo y es 100% silencioso.

---

# 💡 Conclusión Metodológica

El éxito del reconocimiento web no depende de una sola herramienta, sino de la combinación de todas:

1. **OSINT Pasivo** (Phonebook) para ver qué se conoce.
2. **Tecnología** (Whatweb) para saber qué extensiones buscar (php, aspx, etc.).
3. **Fuzzing Activo** (Gobuster/ffuf) para encontrar lo que no está indexado.
4. **Análisis Manual** (BurpSuite) para entender el comportamiento de las rutas encontradas.

---

<hr>
<table width="100%" style="border-style: none; border-collapse: collapse; border: none;">
  <tr>
    <td align="left" style="border: none;">
      <a href="02.10%20Tecnologia%20-%20Whatweb%20y%20Wappalyzer.md">⬅️ 2.10 Tecnología</a>
    </td>
    <td align="center" style="border: none;">
      <a href="../00%20Índice.md">🏠 Índice</a>
    </td>
    <td align="right" style="border: none;">
      <a href="PENDIENTE">3.01 Siguiente ➡️</a>
    </td>
  </tr>
</table>