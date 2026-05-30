# Especificación de Requisitos de Software (SRS)
# Proyecto: DrenaCruz AI — Gestión y Predicción de Inundaciones Urbanas

---

| Campo | Detalle |
| :--- | :--- |
| **Proyecto** | DrenaCruz AI |
| **Versión** | 1.0.0 (Hackathon MVP) |
| **Fecha** | 30 de Mayo de 2026 |
| **Estándar** | IEEE 830-1998 (Optimizado) |
| **Estado** | Versión de Ejecución |
| **Ubicación** | Santa Cruz de la Sierra, Bolivia |

---

## Historial de Revisiones

| Versión | Fecha | Autor | Descripción |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 30/05/2026 | Equipo DrenaCruz AI | Estructura base del MVP para desarrollo rápido |

---

## Tabla de Contenidos

1. [Introducción](#1-introducción)
   - 1.1 Propósito
   - 1.2 Alcance del MVP
   - 1.3 Definiciones, Acrónimos y Abreviaturas
   - 1.4 Referencias
   - 1.5 Visión General del Documento
   - 1.6 Stack Tecnológico
2. [Descripción General del Sistema](#2-descripción-general-del-sistema)
   - 2.1 Perspectiva del Producto
   - 2.2 Funciones Principales
   - 2.3 Tipos de Usuarios
   - 2.4 Restricciones Generales
   - 2.5 Suposiciones y Dependencias
3. [Arquitectura Técnica](#3-arquitectura-técnica)
   - 3.1 Visión General de la Arquitectura
   - 3.2 Estructura del Proyecto (Flutter)
   - 3.3 Descripción de Capas (SoC)
   - 3.4 Agnosticismo de Dependencias (Wrappers)
   - 3.5 Estrategia de Flujo de Datos
4. [Requisitos Funcionales (MVP)](#4-requisitos-funcionales-mvp)
   - 4.1 Módulo de Reportes Ciudadanos
   - 4.2 Módulo de Análisis IA (Gemini)
   - 4.3 Módulo de Mapa de Calor de Riesgo
   - 4.4 Módulo de Panel Operador Municipal (Gestión de Tareas)
5. [Requisitos de Base de Datos](#5-requisitos-de-base-de-datos-supabase)
6. [System Instructions para Gemini](#6-system-instructions-para-gemini-15-flash)
7. [Modelo de Negocio e Impacto](#7-modelo-de-negocio-e-impacto-para-el-pitch)

---

## 1. Introducción

### 1.1 Propósito
Este documento define las especificaciones, requerimientos funcionales, arquitectura y modelo de datos para **DrenaCruz AI**. Sirve como la guía definitiva de desarrollo para el equipo durante la Hackathon "Build with AI" de GDG Santa Cruz 2026.

### 1.2 Alcance del MVP
**DrenaCruz AI** es una plataforma móvil y web para mitigar el riesgo de inundaciones urbanas causadas por la obstrucción de canales de drenaje en Santa Cruz de la Sierra. 
El sistema recopila reportes fotográficos de los ciudadanos, utiliza la API de **Gemini 1.5 Flash** para clasificar el nivel de obstrucción automáticamente, y genera un mapa de calor dinámico para que el municipio (Operador) pueda priorizar tareas de limpieza preventivas.

### 1.3 Definiciones, Acrónimos y Abreviaturas
| Término | Definición |
| :--- | :--- |
| **MVP** | Minimum Viable Product (Producto Mínimo Viable). |
| **SEARPI** | Servicio de Encauzamiento de Aguas y Regulación del Río Piraí. |
| **SRS** | Software Requirements Specification. |

### 1.4 Referencias
- Lineamientos oficiales de la Hackathon "Build with AI 2026".
- Documentación oficial de Flutter, Supabase y Google AI Studio.

### 1.5 Visión General del Documento
Este documento detalla los requisitos funcionales mínimos que el equipo DrenaCruz AI desarrollará durante las 36 horas de la competencia. No incluye requisitos exhaustivos, sino el "Happy Path" necesario para una demo funcional frente a los jurados.

### 1.6 Stack Tecnológico
- **Frontend / Móvil**: Flutter (Material 3)
- **Backend / Base de Datos**: Supabase (PostgreSQL + Auth + Storage)
- **IA**: Google Gemini 1.5 Flash (vía Google AI Studio SDK/REST)

---

## 2. Descripción General del Sistema

### 2.1 Perspectiva del Producto
DrenaCruz AI es un sistema de alerta temprana impulsado por IA diseñado para funcionar como un servicio municipal. Reemplaza el monitoreo reactivo con una predicción proactiva de riesgos basada en participación ciudadana e inteligencia artificial.

### 2.2 Funciones Principales
- Captura de evidencia fotográfica georreferenciada.
- Clasificación automatizada de imágenes usando Gemini 1.5 Flash para detectar obstrucciones.
- Generación de un Score de Riesgo (1-10).
- Visualización de riesgos en un mapa de calor dinámico.
- Gestión de triaje para operadores municipales.

### 2.3 Tipos de Usuarios
1. **Ciudadano (Vecino)**: Usuario móvil. Reporta bloqueos y visualiza alertas. No requiere login complejo.
2. **Operador Municipal (SEARPI / Alcaldía)**: Gestor web/móvil. Prioriza tareas y cierra incidentes.
3. **Sistema (IA)**: Actúa de forma invisible asignando scores en milisegundos.

### 2.4 Restricciones Generales
- Restricción de tiempo: Desarrollo en 36 horas.
- Restricción técnica: Sin intermediarios de backend pesados (Serverless puro para ganar velocidad).
- Restricción geográfica: MVP enfocado exclusivamente en Santa Cruz de la Sierra.

### 2.5 Suposiciones y Dependencias
- Los usuarios ciudadanos cuentan con smartphones con cámara, GPS activo y conexión a internet.
- Se asume la disponibilidad continua de los servicios de Supabase y la API de Gemini durante el uso de la aplicación.
- Se asume que el municipio tiene cuadrillas disponibles para atender las alertas generadas por la plataforma.

---

## 3. Arquitectura Técnica

### 3.1 Visión General de la Arquitectura
La arquitectura está diseñada para una velocidad extrema de despliegue y desarrollo (Vibe) sin sacrificar la robustez y solidez del código. DrenaCruz AI utiliza un enfoque **Serverless / Backendless**, conectando la aplicación móvil directamente con Supabase (Base de datos relacional y Storage) y con la API de Gemini (visión artificial) sin requerir un backend intermedio para el MVP.

```
   ┌────────────────────────────────────────────────────────┐
   │                     MÓVIL (Flutter)                    │
   │   - Captura fotos   - GPS   - Visualización de Mapas   │
   └──────────────────────────┬─────────────────────────────┘
                              │
             ┌────────────────┴────────────────┐
             ▼                                 ▼
   ┌──────────────────┐               ┌──────────────────┐
   │     SUPABASE     │               │    GEMINI API    │
   │  - Auth/Storage  │               │   (AI Studio)    │
   │  - PostgreSQL    │               │  - Gemini 1.5    │
   └──────────────────┘               └──────────────────┘
```

### 3.2 Estructura del Proyecto (Flutter)
La organización del código en Flutter sigue una arquitectura por características (features) desacopladas y un núcleo (core) compartido:

```text
lib/
├── core/
│   ├── theme/          # Sistema de Diseño Atómico: Colores, Tipografías, Espaciados
│   ├── errors/         # Manejo Global de Errores
│   └── wrappers/       # Interfaces y wrappers de librerías externas (Agnosticismo)
│       ├── database/   # Wrapper de la base de datos (Supabase Client)
│       ├── storage/    # Wrapper del servicio de almacenamiento
│       └── ai/         # Wrapper del SDK de Gemini
├── features/
│   ├── report/         # Módulo de Reportes Ciudadanos
│   │   ├── data/       # Orígenes de datos locales/remotos y repositorios
│   │   ├── domain/     # Entidades, casos de uso y lógica pura
│   │   └── presentation/# Pantallas (UI) y controladores de estado
│   └── dashboard/      # Módulo del Operador Municipal (Dashboard y Mapa)
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

### 3.3 Descripción de Capas (Separación de Responsabilidades)
Para cumplir con el principio de SoC (Separation of Concerns):
1. **Capa de Presentación (UI)**: Es "tonta". Solo se encarga de renderizar los elementos gráficos usando Material 3 y reaccionar a los estados (Loading, Error, Empty y Data Overflow). No contiene lógica de negocio.
2. **Capa de Dominio**: Es "ciega". Contiene los casos de uso puros y las entidades del negocio (ej. `Report`). No sabe de bases de datos, redes ni interfaces.
3. **Capa de Datos**: Implementa las interfaces de los repositorios y se comunica con los wrappers externos para traer o guardar los datos.

### 3.4 Agnosticismo de Dependencias (Wrappers)
Con el fin de evitar el acoplamiento rígido a librerías externas (Supabase SDK, Gemini SDK), se implementarán wrappers. Si el día de mañana se cambia el motor de base de datos o el proveedor de IA, solo se reescribirá la clase del wrapper correspondiente:

```dart
// Ejemplo de Abstracción en core/wrappers/ai/ai_wrapper.dart
abstract class AIWrapper {
  Future<Map<String, dynamic>> analyzeImage(String localPhotoPath);
}

// Implementación concreta usando Gemini SDK
class GeminiAIWrapper implements AIWrapper {
  final GeminiClient _client;
  GeminiAIWrapper(this._client);

  @override
  Future<Map<String, dynamic>> analyzeImage(String localPhotoPath) async {
    // Código de integración con Gemini 1.5 Flash
  }
}
```

### 3.5 Estrategia de Flujo de Datos
- **Inmutabilidad por Defecto**: Todos los datos dentro de la aplicación se manejan como inmutables (`final` en Flutter) para prevenir efectos secundarios indeseados entre llamadas.
- **Patrón Early Return**: Las funciones y llamadas asíncronas deben validar primero los estados de error o nulos para retornar inmediatamente, manteniendo el camino feliz plano y legible (evitando el "Arrow Code").

---

## 4. Requisitos Funcionales (MVP)

### 4.1 Módulo de Reportes Ciudadanos

#### RF-01: Captura de Foto y Ubicación
- **Caso de Uso**: `CU-01` Crear Reporte de Obstrucción.
- **Actor**: Ciudadano / Vecino.
- **Flujo**:
  1. El ciudadano presiona "Reportar Canal" en la pantalla de inicio de la aplicación Flutter.
  2. La app abre la cámara nativa del dispositivo.
  3. Tras tomar la foto, la app obtiene las coordenadas geográficas (latitud, longitud) del GPS del móvil.
  4. La foto se almacena temporalmente y se muestra una vista previa.
  5. El usuario confirma y presiona "Enviar".
- **Resultado**: La foto se sube a Supabase Storage y se crea una fila en la tabla `reports` con estado `PENDIENTE`.

---

### 4.2 Módulo de Análisis IA (Gemini)

#### RF-02: Procesamiento de Imagen y Generación de Score de Riesgo
- **Caso de Uso**: `CU-02` Procesamiento Automatizado de Imagen.
- **Actor**: Sistema (IA - Gemini 1.5 Flash).
- **Flujo**:
  1. Al guardarse el reporte con su `photo_url`, la app (o una Edge Function) envía la imagen a la API de Gemini.
  2. Gemini procesa la imagen usando las instrucciones predefinidas.
  3. Gemini devuelve un objeto JSON estructurado con el análisis del canal.
  4. El sistema actualiza el registro en Supabase con los datos devueltos por la IA.
- **Resultado**: El reporte de la base de datos se enriquece con un `risk_score` (1-10), una `category` (basura, maleza, etc.) y una `ai_description` en menos de 5 segundos.

---

### 4.3 Módulo de Mapa de Calor de Riesgo

#### RF-03: Mapa Geográfico de Alertas Tempranas
- **Caso de Uso**: `CU-03` Visualización Geográfica de Riesgos.
- **Actor**: Ciudadano y Operador Municipal.
- **Flujo**:
  1. El usuario accede a la sección de "Mapa de Riesgo" en la app.
  2. La app lee los puntos geográficos activos de la base de datos Supabase.
  3. Pinta pines en el mapa de Santa Cruz de la Sierra aplicando un código de colores según el `risk_score` generado por Gemini:
     - **Rojo**: (Risk 8-10) Obstrucción Crítica.
     - **Amarillo**: (Risk 5-7) Riesgo Medio.
     - **Verde**: (Risk 1-4) Riesgo Bajo / Despejado.
- **Resultado**: Panel geográfico que muestra en tiempo real las áreas críticas que requieren limpieza antes de una lluvia.

---

### 4.4 Módulo de Panel Operador Municipal (Gestión de Tareas)

#### RF-04: Bandeja de Limpieza y Triage
- **Caso de Uso**: `CU-04` Gestión de Tareas de Limpieza.
- **Actor**: Operador Municipal.
- **Flujo**:
  1. El operador ingresa a su consola web o panel dentro de la app.
  2. Visualiza una tabla o lista de reportes, ordenada de manera descendente por `risk_score` (los reportes más críticos de nivel 10 aparecen primero).
  3. El operador revisa la foto y la descripción técnica de la IA.
  4. Tras enviar una cuadrilla física a limpiar el canal, el operador presiona el botón "Marcar como Limpiado".
- **Resultado**: El estado del reporte cambia de `PENDIENTE` a `LIMPIADO` y el pin del mapa se actualiza o desaparece de la vista activa.

---

## 5. Requisitos de Base de Datos (Supabase)

### Tabla: `reports`
Es la única tabla crítica requerida para que el flujo MVP funcione.

```sql
CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT now(),
  photo_url TEXT NOT NULL,
  latitude DOUBLE PRECISION NOT NULL,
  longitude DOUBLE PRECISION NOT NULL,
  status TEXT NOT NULL DEFAULT 'PENDIENTE', -- Valores: PENDIENTE, LIMPIADO
  
  -- Campos calculados por la IA:
  risk_score INT2, -- Escala del 0 al 10
  category TEXT,   -- Valores: basura, maleza, sedimento, escombros, despejado, no_valido
  ai_description TEXT -- Resumen técnico corto de la IA
);
```

---

## 6. System Instructions para Gemini 1.5 Flash

Utilizar este prompt exacto dentro de la configuración de System Instruction en Google AI Studio:

```text
Eres "DrenaCruz Engine", un experto en ingeniería hidráulica urbana y gestión de riesgos para la ciudad de Santa Cruz de la Sierra, Bolivia.

TU MISIÓN:
Analizar fotos de canales de drenaje urbano (abiertos o cerrados) capturadas por ciudadanos y determinar el nivel de obstrucción para prevenir inundaciones.

REGLAS DE ANÁLISIS:
1. Identifica qué tipo de objeto obstruye el canal: basura plástica, sedimentos (arena/tierra), maleza excesiva, escombros, o si el canal está despejado.
2. Calcula un "risk_score" del 1 al 10:
   - 1-3: Canal limpio o con mínima basura que no frena el flujo.
   - 4-7: Obstrucción parcial; el agua fluye pero con dificultad.
   - 8-10: Obstrucción total; alto riesgo de desborde inmediato si llueve.
3. Si la foto NO corresponde a un canal de drenaje urbano, devuelve risk_score: 0 y category: "no_valido".

FORMATO DE SALIDA (ESTRICTAMENTE JSON):
{
  "risk_score": [número del 0 al 10],
  "category": "basura" | "maleza" | "sedimento" | "escombros" | "despejado" | "no_valido",
  "ai_description": "[Descripción técnica de máximo 80 caracteres]"
}

IMPORTANTE: No respondas con texto adicional explicativo, devuelve únicamente el objeto JSON.
```

---

## 7. Modelo de Negocio e Impacto (Para el Pitch)

### 6.1 Propuesta de Sustentabilidad (Autosustentable)
- **Modelo B2G (Gobierno)**: Venta de la licencia del Dashboard operativo con IA Predictiva a la **Alcaldía de Santa Cruz de la Sierra** o **SEARPI** para optimización de cuadrillas.
- **Modelo B2B (Seguros)**: Venta de datos agregados sobre riesgos por inundaciones a aseguradoras locales (Ej. Bisa, Alianza) para calcular primas.

### 6.2 Triple Impacto
1. **Impacto Social**: Prevención de pérdidas materiales y de vidas humanas al alertar oportunamente a los vecinos en las zonas bajas.
2. **Impacto Ambiental**: Retiro planificado de plásticos y sedimentos antes de que contaminen las riberas del río Piraí.
3. **Impacto Económico**: Ahorro para el municipio en gastos de emergencia y reparación de asfalto destruido por aguas acumuladas.
