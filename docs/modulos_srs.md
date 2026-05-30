Aquí tienes el Mini-SRS optimizado para ejecución inmediata. Este documento es
su hoja de ruta técnica para las próximas horas.

MÓDULO 1: REPORTES CIUDADANOS

Caso de Uso: [CU-01] Crear Reporte de Obstrucción
Actor: Ciudadano / Vecino
Campos de la tabla reports en Supabase:

  - id: uuid (Primary Key)
  - created_at: timestamptz (Default: now)
  - photo_url: text (URL de Supabase Storage)
  - latitude: float8
  - longitude: float8
  - status: text (Default: 'PENDIENTE')
    Resultado esperado: El vecino ve un mensaje de éxito, la foto se sube al
    Storage y los datos geográficos se guardan en la base de datos.

MÓDULO 2: ANÁLISIS IA (GEMINI)

Caso de Uso: [CU-02] Procesamiento Automatizado de Imagen
Actor: Sistema (Gemini 1.5 Flash)
Campos de la tabla reports en Supabase (Update):

  - risk_score: int2 (Valor del 1 al 10 calculado por la IA)
  - category: text (Tipo detectado: basura, maleza, sedimento, despejado)
  - ai_description: text (Resumen breve de la obstrucción)
    Resultado esperado: Al subir la foto, el sistema dispara la API de Gemini y
    actualiza el reporte en Supabase con los datos estructurados del análisis en
    menos de 5 segundos.

MÓDULO 3: MAPA DE RIESGO

Caso de Uso: [CU-03] Visualización Geográfica de Riesgos
Actor: Ciudadano / Operador Municipal
Campos de la tabla reports en Supabase (Read):

  - latitude: float8
  - longitude: float8
  - risk_score: int2
    Resultado esperado: Un mapa de Santa Cruz de la Sierra con marcadores
    dinámicos:
  - Rojo: (Risk 8-10) Obstrucción crítica.
  - Amarillo: (Risk 5-7) Obstrucción media.
  - Verde: (Risk 1-4) Riesgo bajo / Despejado.

MÓDULO 4: PANEL OPERADOR

Caso de Uso: [CU-04] Gestión de Tareas de Limpieza
Actor: Operador Municipal
Campos de la tabla reports en Supabase (Read/Update):

  - status: text (Cambio de 'PENDIENTE' a 'LIMPIADO')
  - risk_score: int2 (Para ordenamiento prioritario)
  - ai_description: text
    Resultado esperado: Una lista tipo tabla donde el operador ve los casos más
    graves arriba, visualiza la foto de la basura/maleza y puede marcar el
    reporte como resuelto tras enviar la cuadrilla.

SYSTEM INSTRUCTION PARA GEMINI (Prompt Exacto)

Configuren este prompt en el System Instruction de Google AI Studio (Gemini 1.5
Flash):

Eres "DrenaCruz Engine", un experto en ingeniería hidráulica urbana y gestión de riesgos para la ciudad de Santa Cruz de la Sierra, Bolivia.

TU MISIÓN:
Analizar fotos de canales de drenaje (abiertos o cerrados) capturadas por ciudadanos y determinar el nivel de obstrucción para prevenir inundaciones.

REGLAS DE ANÁLISIS:
1. Identifica qué tipo de objeto obstruye el canal: basura plástica, sedimentos (arena/tierra), maleza excesiva, escombros o si el canal está despejado.
2. Calcula un "risk_score" del 1 al 10:
   - 1-3: Canal limpio o con mínima basura que no frena el agua.
   - 4-7: Obstrucción parcial; el agua fluye pero con dificultad.
   - 8-10: Obstrucción total; alto riesgo de desborde inmediato ante lluvia.
3. Si la foto NO es de un canal de drenaje, devuelve risk_score: 0 y categoría: "no_valido".

FORMATO DE SALIDA (ESTRICTAMENTE JSON):
{
  "risk_score": [número del 0 al 10],
  "category": "basura" | "maleza" | "sedimento" | "escombros" | "despejado" | "no_valido",
  "ai_description": "[Descripción técnica de máximo 80 caracteres]"
}

IMPORTANTE: No respondas con texto adicional, solo el objeto JSON.

Tips de último minuto para el equipo:

1.  En Flutter: Usen el paquete google_maps_flutter para el mapa y image_picker
    para la cámara.
2.  En Supabase: Activen RLS (Row Level Security) o simplemente dejen las
    políticas abiertas para el demo (INSERT/SELECT permitido para todos) para
    evitar errores de permisos durante el pitch.
3.  Dato de Color: Para el demo, asegúrense de que los puntos del mapa estén en
    lugares icónicos (Ej: 2do Anillo y Av. Cristo Redentor) para que el jurado
    local identifique la zona.

¡A programar! Tienen todo lo necesario para ganar.
