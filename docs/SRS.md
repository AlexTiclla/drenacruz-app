Para un Hackathon de 36 horas, no pueden permitirse casos de uso complejos.
Deben enfocarse en el "Happy Path" (el camino principal) que demuestre la
integración de Flutter + Supabase + Gemini.

Aquí tienes los 4 Casos de Uso esenciales que deben funcionar perfectamente para
el domingo:

Caso de Uso 1: Reporte Ciudadano de Obstrucción (El "Input")

Este es el corazón de la aplicación para el vecino.

  - Actor: Ciudadano / Vecino.
  - Flujo:
    1.  El usuario abre la app (Flutter) y presiona un botón central: "Reportar
        Canal".
    2.  Se abre la cámara, toma la foto del canal obstruido.
    3.  La app obtiene automáticamente la Latitud y Longitud (GPS).
    4.  El usuario presiona "Enviar".
  - Resultado: La imagen se sube a Supabase Storage y los datos básicos a la
    tabla reports.
  - Lo que ve el jurado: Facilidad de uso y recolección de datos en tiempo real.

Caso de Uso 2: Análisis Automatizado con Gemini (La "Magia AI")

Este ocurre en segundos justo después del Caso 1 (Backend/Edge Function).

  - Actor: Sistema (Gemini 1.5 Flash API).
  - Flujo:
    1.  Al guardarse el reporte, se dispara la llamada a la API de Gemini
        enviando la imagen.
    2.  Gemini analiza la imagen usando el prompt que definimos antes.
    3.  El sistema recibe el JSON con: risk_score (1-10), category
        (maleza/basura) y summary.
    4.  El reporte en la base de datos se actualiza automáticamente con estos
        valores.
  - Resultado: El reporte pasa de ser "una simple foto" a ser "un dato
    inteligente" sin intervención humana.
  - Lo que ve el jurado: El uso real de Generative AI para toma de decisiones
    (Score de Riesgo).

Caso de Uso 3: Visualización del Mapa de Riesgo (El "Dashboard")

Aquí es donde el Municipio toma decisiones.

  - Actor: Operador Municipal / Ciudadano.
  - Flujo:
    1.  El usuario entra a la pestaña de "Mapa de Riesgo".
    2.  La app carga los puntos de la base de datos de Supabase.
    3.  Los pines en el mapa cambian de color según el risk_score de Gemini:
          - Rojo: Riesgo 8-10 (Obstrucción crítica).
          - Amarillo: Riesgo 5-7 (Mantenimiento preventivo).
          - Verde: Riesgo 1-4 (Limpieza leve o despejado).
  - Resultado: Un mapa visual de Santa Cruz que prioriza dónde hay que ir a
    limpiar antes de que llueva.
  - Lo que ve el jurado: Impacto visual y utilidad pública inmediata.

Caso de Uso 4: Gestión de Triage para Operadores (La "Acción")

Para demostrar que la app sirve para trabajar.

  - Actor: Operador Municipal.
  - Flujo:
    1.  El operador ve una lista (o tabla) de reportes ordenada por los más
        críticos (Score 10 primero).
    2.  Selecciona uno, ve la foto y el análisis que hizo la IA.
    3.  Presiona un botón: "Marcar como Limpiado".
  - Resultado: El estado del reporte cambia en la base de datos y el punto
    desaparece (o cambia a verde) en el mapa.
  - Lo que ve el jurado: Cierre del ciclo de vida del problema (Reporte ->
    Análisis -> Solución).

Resumen de Prioridades para el Equipo:

1.  Día 1 (Hoy - Tarde/Noche):

      - Tener la app de Flutter que saque la foto y la suba a Supabase.
      - Configurar la API Key de Gemini y probar el prompt en un script sencillo
        (Node.js o una Edge Function).

2.  Día 2 (Mañana - Todo el día):

      - Conectar la respuesta de Gemini con la base de datos.
      - Hacer que el Mapa de Flutter lea esos puntos y los pinte de colores.
      - Pulir la UI (que se vea limpia, usen los colores de Santa Cruz: Verde y
        Blanco).

3.  Día 3 (Domingo - Mañana):

      - Cargar datos de prueba: Si solo tienen 2 reportes reales, el mapa se
        verá vacío. Creen 20 reportes falsos en diferentes puntos de Santa Cruz
        (Plan 3000, Equipetrol, 4to Anillo, etc.) con diferentes niveles de
        riesgo para que la demo se vea impactante.

Tip Pro: Si la integración de Gemini desde Flutter les da problemas de CORS o
seguridad, hagan que la app suba la foto y que un pequeño proceso en el backend
(o una Database Function en Supabase) llame a Gemini. ¡Manténganlo simple!
