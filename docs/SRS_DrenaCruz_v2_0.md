# Especificación de Requisitos de Software (SRS)
# DrenaCruz AI — Sistema de Alerta Temprana para Inundaciones Urbanas

---

<div align="center">

| Campo | Detalle |
| :--- | :--- |
| **Proyecto** | DrenaCruz AI |
| **Versión del Documento** | 2.0.0 |
| **Fecha de Emisión** | 30 de Mayo de 2026 |
| **Estándar de Referencia** | IEEE 830-1998 (Adaptado para Hackathon) |
| **Estado** | ✅ Aprobado — Versión de Ejecución |
| **Evento** | GDG Santa Cruz — Build with AI Hackathon 2026 |
| **Ubicación del Proyecto** | Santa Cruz de la Sierra, Bolivia |

</div>

---

## Historial de Revisiones

| Versión | Fecha | Autor | Cambios |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 30/05/2026 | Equipo DrenaCruz AI | Documento inicial del MVP |
| 2.0.0 | 30/05/2026 | Equipo DrenaCruz AI | Reestructuración completa: RNF, restricciones de seguridad, tablas auxiliares, matriz de trazabilidad, criterios de aceptación y plan de demo |

---

## Tabla de Contenidos

1. [Introducción](#1-introducción)
2. [Descripción General del Sistema](#2-descripción-general-del-sistema)
3. [Arquitectura Técnica](#3-arquitectura-técnica)
4. [Requisitos Funcionales](#4-requisitos-funcionales-mvp)
5. [Requisitos No Funcionales](#5-requisitos-no-funcionales)
6. [Modelo de Datos (Supabase)](#6-modelo-de-datos-supabase)
7. [Seguridad y Políticas RLS](#7-seguridad-y-políticas-rls-supabase)
8. [Inteligencia Artificial — Contrato de la API](#8-inteligencia-artificial--contrato-de-la-api-gemini)
9. [Modelo de Negocio e Impacto](#9-modelo-de-negocio-e-impacto)
10. [Matriz de Trazabilidad](#10-matriz-de-trazabilidad)
11. [Criterios de Aceptación del Demo](#11-criterios-de-aceptación-del-demo-hackathon)

---

## 1. Introducción

### 1.1 Propósito

Este documento constituye la guía definitiva y única fuente de verdad del equipo durante las 24 horas de desarrollo del Hackathon "Build with AI" de GDG Santa Cruz 2026. Define el alcance, los requisitos funcionales y no funcionales, la arquitectura de software, el modelo de datos y los criterios de aceptación del MVP de **DrenaCruz AI**.

Todo el código producido debe ser trazable a un requisito listado en este documento. Si una funcionalidad no aparece aquí, **no se implementa** durante el hackathon.

### 1.2 Alcance del MVP

**DrenaCruz AI** es un sistema de alerta temprana impulsado por Inteligencia Artificial para mitigar las inundaciones urbanas causadas por la obstrucción de canales de drenaje en Santa Cruz de la Sierra, Bolivia.

**Incluido en el MVP:**
- Captura fotográfica georreferenciada por ciudadanos.
- Análisis automático de imágenes mediante Gemini 1.5 Flash (Google AI).
- Generación de un Score de Riesgo de obstrucción (escala 1–10).
- Visualización de riesgos en mapa de calor con código de colores.
- Panel operativo para que el municipio gestione y cierre tareas de limpieza.

**Explícitamente fuera del alcance del MVP:**
- Autenticación de ciudadanos con gestión de perfiles.
- Notificaciones push a ciudadanos.
- Predicción meteorológica integrada.
- Módulo de reportes históricos y analítica avanzada.
- Soporte para múltiples ciudades.

### 1.3 Definiciones, Acrónimos y Abreviaturas

| Término | Definición |
| :--- | :--- |
| **MVP** | Minimum Viable Product — Producto Mínimo Viable. |
| **SEARPI** | Servicio de Encauzamiento de Aguas y Regulación del Río Piraí. Ente municipal que gestiona el drenaje urbano. |
| **SRS** | Software Requirements Specification — Especificación de Requisitos de Software. |
| **SoC** | Separation of Concerns — Separación de Responsabilidades. Principio de diseño de software. |
| **RLS** | Row Level Security — Seguridad a nivel de fila en PostgreSQL/Supabase. |
| **RF** | Requisito Funcional. |
| **RNF** | Requisito No Funcional. |
| **CU** | Caso de Uso. |
| **B2G** | Business to Government — Modelo de negocio orientado a entidades gubernamentales. |
| **B2B** | Business to Business — Modelo de negocio entre empresas. |
| **Score de Riesgo** | Valor numérico entero del 1 al 10 que representa el nivel de obstrucción de un canal, calculado por Gemini. |

### 1.4 Referencias

- [Documentación oficial de Flutter](https://docs.flutter.dev)
- [Documentación oficial de Supabase](https://supabase.com/docs)
- [Google AI Studio — Gemini API](https://ai.google.dev/docs)
- Lineamientos oficiales del Hackathon "Build with AI 2026" — GDG Santa Cruz.
- IEEE Std 830-1998: Recommended Practice for Software Requirements Specifications.

### 1.5 Stack Tecnológico

| Capa | Tecnología | Versión / Detalle |
| :--- | :--- | :--- |
| **Frontend / Móvil** | Flutter | SDK Estable — Material Design 3 |
| **Base de Datos** | Supabase (PostgreSQL) | Cloud — Tier Free |
| **Almacenamiento** | Supabase Storage | Bucket `report-photos` |
| **Autenticación** | Supabase Auth | Modo Anónimo para ciudadanos |
| **Inteligencia Artificial** | Google Gemini 1.5 Flash | REST API vía `google_generative_ai` SDK |
| **Mapas** | `flutter_map` + OpenStreetMap | Tiles OSM (sin costo) |

---

## 2. Descripción General del Sistema

### 2.1 Perspectiva del Producto

Santa Cruz de la Sierra sufre inundaciones recurrentes durante la época de lluvias (noviembre–marzo), causadas en gran parte por canales de drenaje tapados con basura, maleza y sedimentos. El sistema de monitoreo actual es **reactivo**: las cuadrillas solo actúan después de que ocurre la inundación.

**DrenaCruz AI** propone un modelo **proactivo**: los propios ciudadanos actúan como sensores distribuidos, reportando obstrucciones con sus teléfonos. La IA procesa estas fotos en segundos y genera un mapa de prioridades para que el municipio limpie los canales *antes* de que llueva.

```
PROBLEMA ACTUAL          →       SOLUCIÓN DRENACRUZ AI
─────────────────────────────────────────────────────────
Monitoreo reactivo       →   Alertas tempranas proactivas
Cuadrillas sin datos     →   Triage inteligente por riesgo
Canales tapados = inundación → Limpieza preventiva guiada
```

### 2.2 Funciones Principales del Sistema

| # | Función | Módulo |
| :--- | :--- | :--- |
| F-1 | Captura fotográfica con geolocalización GPS | Reportes Ciudadanos |
| F-2 | Análisis automático de imagen con Gemini 1.5 Flash | Motor de IA |
| F-3 | Generación de Score de Riesgo (1–10) y categorización | Motor de IA |
| F-4 | Visualización de mapa de calor con código de colores | Mapa de Riesgo |
| F-5 | Triage y gestión de tareas de limpieza | Panel Operativo |
| F-6 | Actualización de estado de reportes (`PENDIENTE` → `LIMPIADO`) | Panel Operativo |

### 2.3 Tipos de Usuarios y Roles

#### Actor 1: Ciudadano / Vecino
- **Descripción**: Usuario móvil que detecta y reporta una obstrucción en su barrio.
- **Perfil técnico**: Bajo — usa el teléfono para tomar fotos y ver alertas.
- **Autenticación**: Sesión anónima de Supabase (sin registro requerido).
- **Acciones permitidas**: Crear reportes, ver el mapa de calor público.

#### Actor 2: Operador Municipal (SEARPI / Alcaldía)
- **Descripción**: Funcionario que gestiona las cuadrillas de limpieza.
- **Perfil técnico**: Medio — maneja una lista de tareas desde su dispositivo.
- **Autenticación**: Cuenta de email/password en Supabase Auth (rol `operator`).
- **Acciones permitidas**: Ver todos los reportes, marcar reportes como `LIMPIADO`.

#### Actor 3: Sistema de IA (Gemini Engine)
- **Descripción**: Actor no humano. Procesa imágenes y enriquece los datos.
- **Interacción**: Llamada REST directa desde Flutter hacia la API de Gemini.
- **Acciones**: Analizar imagen y devolver JSON con `risk_score`, `category` y `ai_description`.

### 2.4 Restricciones del Proyecto

| Tipo | Restricción |
| :--- | :--- |
| **Tiempo** | Desarrollo en ≤ 24 horas de hackathon. |
| **Equipo** | Equipo pequeño de desarrolladores. |
| **Backend** | Arquitectura Serverless/Backendless. Sin servidor Node.js/Python intermedio. |
| **Costo** | Uso de tiers gratuitos de Supabase y Google AI Studio. |
| **Alcance Geo** | MVP limitado a Santa Cruz de la Sierra, Bolivia. |
| **Conectividad** | Requiere conexión a internet para análisis IA y sincronización de datos. |

### 2.5 Suposiciones y Dependencias

- Los ciudadanos tienen smartphones con cámara de calidad aceptable (≥5 MP) y GPS activo.
- Los servicios de Supabase y la API de Gemini están disponibles con una latencia aceptable desde Bolivia.
- La cuota gratuita de la API de Gemini es suficiente para la demo del hackathon.
- El municipio cuenta con cuadrillas disponibles para responder a las alertas generadas.
- Los tiles de OpenStreetMap están disponibles para renderizar el mapa base.

---

## 3. Arquitectura Técnica

### 3.1 Visión General de la Arquitectura (Serverless)

La arquitectura elimina la necesidad de un backend propio. Flutter se comunica directamente con los servicios en la nube usando sus SDKs oficiales, ocultos detrás de wrappers internos.

```
┌─────────────────────────────────────────────────────────────────┐
│                      APP FLUTTER (Cliente)                       │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────────────────┐ │
│  │  Presentación│  │    Dominio   │  │         Datos          │ │
│  │   (UI/UX)    │◄─│ (Casos de   │◄─│  (Repositorios +       │ │
│  │  Material 3  │  │    Uso +     │  │   Wrappers)            │ │
│  │              │  │  Entidades)  │  │                        │ │
│  └──────────────┘  └──────────────┘  └────────────────────────┘ │
│                                             │         │          │
└─────────────────────────────────────────────┼─────────┼──────────┘
                                              │         │
                      ┌───────────────────────┘         └────────────────┐
                      ▼                                                   ▼
        ┌─────────────────────────┐                     ┌────────────────────────┐
        │        SUPABASE         │                     │      GOOGLE GEMINI     │
        │  ─────────────────────  │                     │  ────────────────────  │
        │  • PostgreSQL (reports) │                     │  • Gemini 1.5 Flash    │
        │  • Storage (fotos)      │                     │  • Vision API (REST)   │
        │  • Auth (usuarios)      │                     │  • JSON Mode           │
        │  • RLS (seguridad)      │                     └────────────────────────┘
        └─────────────────────────┘
```

### 3.2 Estructura de Carpetas del Proyecto (Flutter)

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart         # URLs, claves de config, valores fijos
│   ├── theme/
│   │   ├── app_colors.dart            # Paleta de colores del sistema de diseño
│   │   ├── app_typography.dart        # Estilos de texto Material 3
│   │   └── app_theme.dart             # ThemeData global
│   ├── errors/
│   │   ├── app_exception.dart         # Clase base de excepciones del dominio
│   │   └── error_handler.dart         # Mapeo de errores externos a AppException
│   └── wrappers/
│       ├── database/
│       │   ├── database_wrapper.dart  # Interfaz abstracta de base de datos
│       │   └── supabase_database_wrapper.dart  # Implementación con Supabase SDK
│       ├── storage/
│       │   ├── storage_wrapper.dart   # Interfaz abstracta de almacenamiento
│       │   └── supabase_storage_wrapper.dart   # Implementación con Supabase Storage
│       └── ai/
│           ├── ai_wrapper.dart        # Interfaz abstracta del motor de IA
│           └── gemini_ai_wrapper.dart # Implementación con Gemini 1.5 Flash SDK
│
├── features/
│   ├── report/                        # Módulo de Reportes Ciudadanos
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── report_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── report_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── report.dart        # Entidad inmutable con copyWith()
│   │   │   ├── repositories/
│   │   │   │   └── report_repository.dart  # Interfaz abstracta
│   │   │   └── usecases/
│   │   │       ├── create_report_usecase.dart
│   │   │       └── analyze_report_usecase.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── report_controller.dart  # Estado: loading/error/data
│   │       └── screens/
│   │           ├── camera_screen.dart
│   │           └── report_preview_screen.dart
│   │
│   └── dashboard/                     # Módulo del Operador Municipal
│       ├── data/
│       │   ├── datasources/
│       │   │   └── dashboard_remote_datasource.dart
│       │   └── repositories/
│       │       └── dashboard_repository_impl.dart
│       ├── domain/
│       │   ├── repositories/
│       │   │   └── dashboard_repository.dart
│       │   └── usecases/
│       │       ├── get_reports_usecase.dart
│       │       └── mark_as_cleaned_usecase.dart
│       └── presentation/
│           ├── controllers/
│           │   └── dashboard_controller.dart
│           └── screens/
│               ├── map_screen.dart    # Mapa de calor con flutter_map
│               └── triage_screen.dart # Lista ordenada por risk_score
│
└── main.dart                          # Punto de entrada + inyección de dependencias
```

### 3.3 Descripción de las Capas (Separación de Responsabilidades)

**Capa de Presentación — "La UI es tonta"**
Responsabilidad única: renderizar la interfaz y reaccionar a los estados del controlador. No contiene lógica de negocio, no llama a repositorios directamente, no maneja excepciones de red. Toda pantalla debe implementar los cuatro estados obligatorios:

| Estado | Descripción | Widget recomendado |
| :--- | :--- | :--- |
| `Loading` | Operación asíncrona en curso | `CircularProgressIndicator` centrado |
| `Error` | Fallo controlado con mensaje legible | `ErrorStateWidget` con botón de reintento |
| `Empty` | Petición exitosa sin datos que mostrar | `EmptyStateWidget` con ilustración y CTA |
| `Data` | Datos disponibles para renderizar | Widget específico del módulo |

**Capa de Dominio — "El dominio es ciego"**
Contiene las entidades del negocio (`Report`) y los casos de uso (`CreateReportUseCase`). No importa ningún SDK externo. No sabe que Supabase existe. Todas las clases son `final` e inmutables.

**Capa de Datos**
Implementa las interfaces de los repositorios del dominio. Se comunica exclusivamente con los `wrappers` del `core`. Maneja la conversión de DTOs externos a entidades del dominio.

### 3.4 Patrón de Agnosticismo de Dependencias (Wrappers)

Cada integración externa queda encapsulada detrás de una interfaz abstracta. El resto del sistema solo conoce la interfaz, nunca la implementación concreta.

```dart
// core/wrappers/ai/ai_wrapper.dart
abstract class AIWrapper {
  /// Analiza una imagen de canal de drenaje y retorna el análisis de riesgo.
  /// Lanza [AppException] en caso de error de la API.
  Future<Map<String, dynamic>> analyzeImage({
    required String imageBase64,
    required String mimeType,
  });
}

// core/wrappers/database/database_wrapper.dart
abstract class DatabaseWrapper {
  Future<Map<String, dynamic>> insertRow({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<List<Map<String, dynamic>>> fetchRows({
    required String table,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = false,
  });

  Future<void> updateRow({
    required String table,
    required String id,
    required Map<String, dynamic> data,
  });
}

// core/wrappers/storage/storage_wrapper.dart
abstract class StorageWrapper {
  /// Sube un archivo y retorna su URL pública.
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String mimeType,
  });
}
```

### 3.5 Principios de Código Obligatorios

**Inmutabilidad:** Todas las entidades del dominio usan propiedades `final` y exponen un método `copyWith()`.

```dart
// features/report/domain/entities/report.dart
class Report {
  final String id;
  final String photoUrl;
  final double latitude;
  final double longitude;
  final String status;        // 'PENDIENTE' | 'LIMPIADO'
  final int? riskScore;
  final String? category;
  final String? aiDescription;
  final DateTime createdAt;

  const Report({
    required this.id,
    required this.photoUrl,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    this.riskScore,
    this.category,
    this.aiDescription,
  });

  Report copyWith({
    String? status,
    int? riskScore,
    String? category,
    String? aiDescription,
  }) {
    return Report(
      id: id,
      photoUrl: photoUrl,
      latitude: latitude,
      longitude: longitude,
      status: status ?? this.status,
      createdAt: createdAt,
      riskScore: riskScore ?? this.riskScore,
      category: category ?? this.category,
      aiDescription: aiDescription ?? this.aiDescription,
    );
  }
}
```

**Early Return (Evitar Arrow Code):**

```dart
// ✅ Correcto — Early return
Future<Report> createReport(File photo) async {
  if (!await _locationService.isPermissionGranted()) {
    throw AppException('Permiso de ubicación denegado.');
  }

  final position = await _locationService.getCurrentPosition();
  if (position == null) {
    throw AppException('No se pudo obtener la ubicación GPS.');
  }

  final photoUrl = await _storageWrapper.uploadFile(...);
  if (photoUrl.isEmpty) {
    throw AppException('Error al subir la foto.');
  }

  return _reportRepository.createReport(...);
}

// ❌ Incorrecto — Arrow code / callback hell
Future<Report> createReport(File photo) async {
  if (await _locationService.isPermissionGranted()) {
    final position = await _locationService.getCurrentPosition();
    if (position != null) {
      final photoUrl = await _storageWrapper.uploadFile(...);
      if (photoUrl.isNotEmpty) {
        return _reportRepository.createReport(...);
      }
    }
  }
}
```

---

## 4. Requisitos Funcionales (MVP)

### RF-01: Captura de Foto y Geolocalización

| Campo | Detalle |
| :--- | :--- |
| **ID** | RF-01 |
| **Módulo** | Reportes Ciudadanos |
| **Caso de Uso** | CU-01 — Crear Reporte de Obstrucción |
| **Actor Principal** | Ciudadano / Vecino |
| **Prioridad** | 🔴 Crítica |

**Flujo Principal:**
1. El ciudadano presiona "Reportar Canal" en la pantalla de inicio.
2. La app solicita permiso de cámara y GPS si no están concedidos.
3. Se abre la cámara nativa del dispositivo.
4. El ciudadano toma una foto del canal obstruido.
5. La app obtiene las coordenadas GPS (latitud, longitud) del dispositivo.
6. Se muestra una pantalla de previsualización con la foto y la ubicación en miniatura.
7. El ciudadano presiona "Enviar Reporte".
8. La foto se sube a Supabase Storage (`report-photos/`).
9. Se crea una fila en la tabla `reports` con estado `PENDIENTE` y la `photo_url` resultante.
10. La app envía la imagen a la API de Gemini para análisis (ver RF-02).

**Flujos Alternativos:**
- Si el GPS está desactivado → mostrar diálogo solicitando activarlo. No bloquear la app.
- Si la subida a Storage falla → mostrar `ErrorStateWidget` con opción de reintentar.
- Si se cancela la cámara → volver a la pantalla de inicio sin crear registro.

**Criterio de Aceptación:** El reporte aparece en la tabla `reports` de Supabase con `photo_url` válida y coordenadas geográficas reales dentro de 10 segundos de presionar "Enviar".

---

### RF-02: Análisis de Imagen con IA y Generación de Score

| Campo | Detalle |
| :--- | :--- |
| **ID** | RF-02 |
| **Módulo** | Motor de IA (Gemini) |
| **Caso de Uso** | CU-02 — Análisis Automático de Obstrucción |
| **Actor Principal** | Sistema (Gemini 1.5 Flash) |
| **Prioridad** | 🔴 Crítica |

**Flujo Principal:**
1. Inmediatamente después de creado el registro (RF-01 paso 9), la app llama al `GeminiAIWrapper`.
2. El wrapper envía la imagen en Base64 con el System Prompt predefinido (ver Sección 8).
3. Gemini procesa la imagen en modo JSON y retorna el análisis estructurado.
4. La app actualiza el registro en Supabase con los campos: `risk_score`, `category`, `ai_description`.
5. La UI del ciudadano muestra el resultado con el color del riesgo correspondiente.

**Contrato de la respuesta esperada de Gemini:**

```json
{
  "risk_score": 8,
  "category": "basura",
  "ai_description": "Canal con obstrucción total por plásticos y residuos sólidos."
}
```

**Flujo Alternativo:**
- Si Gemini responde con `category: "no_valido"` → mostrar mensaje: *"La foto no parece ser de un canal de drenaje. Por favor, intenta de nuevo."* y marcar el reporte como `INVALIDO` en la base de datos.
- Si la API de Gemini no responde en 10 segundos → timeout, marcar el reporte con `risk_score: null` para revisión manual.

**Criterio de Aceptación:** El registro en Supabase contiene `risk_score`, `category` y `ai_description` válidos en menos de 8 segundos desde la creación.

---

### RF-03: Mapa de Calor de Riesgos

| Campo | Detalle |
| :--- | :--- |
| **ID** | RF-03 |
| **Módulo** | Mapa de Riesgo |
| **Caso de Uso** | CU-03 — Visualización Geográfica de Alertas |
| **Actor Principal** | Ciudadano y Operador Municipal |
| **Prioridad** | 🔴 Crítica |

**Flujo Principal:**
1. El usuario navega a la pestaña "Mapa" en la barra de navegación inferior.
2. La app carga los reportes con `status = 'PENDIENTE'` desde Supabase.
3. Se renderiza el mapa base de Santa Cruz de la Sierra (OpenStreetMap via `flutter_map`).
4. Se dibujan marcadores circulares sobre cada reporte usando el código de colores de riesgo.
5. El usuario puede tocar un marcador para ver un popup con: foto en miniatura, `ai_description` y `risk_score`.

**Código de Colores de Riesgo:**

| Color | Risk Score | Nivel | Descripción |
| :--- | :--- | :--- | :--- |
| 🔴 Rojo | 8 – 10 | Crítico | Obstrucción total — riesgo inminente de desborde |
| 🟡 Amarillo | 5 – 7 | Moderado | Obstrucción parcial — vigilar ante lluvias |
| 🟢 Verde | 1 – 4 | Bajo | Canal mayormente limpio o con basura mínima |
| ⚪ Gris | null | Pendiente IA | Análisis en proceso o timeout |

**Criterio de Aceptación:** El mapa muestra al menos 3 marcadores de colores distintos con datos reales de la demo y el popup es funcional en menos de 3 segundos de carga.

---

### RF-04: Panel Operativo — Triage y Cierre de Tareas

| Campo | Detalle |
| :--- | :--- |
| **ID** | RF-04 |
| **Módulo** | Panel Operativo |
| **Caso de Uso** | CU-04 — Gestión de Tareas de Limpieza |
| **Actor Principal** | Operador Municipal (SEARPI) |
| **Prioridad** | 🔴 Crítica |

**Flujo Principal:**
1. El operador accede al panel desde la pestaña "Panel" (autenticado con email/password).
2. La app carga la lista de reportes con `status = 'PENDIENTE'`, ordenados descendentemente por `risk_score`.
3. Cada ítem de la lista muestra: miniatura de la foto, `risk_score` con color, `category`, `ai_description` y fecha.
4. El operador revisa el reporte y presiona el botón "✓ Marcar como Limpiado".
5. Se muestra un `AlertDialog` de confirmación: *"¿Confirmar que el canal fue limpiado?"*
6. Al confirmar, el campo `status` del reporte se actualiza a `LIMPIADO` en Supabase.
7. El marcador desaparece del mapa de calor activo (RF-03) en tiempo real.

**Flujo Alternativo:**
- Si la actualización falla → mostrar `SnackBar` de error con opción de reintentar.
- Si no hay reportes pendientes → mostrar `EmptyStateWidget`: *"🎉 ¡Todos los canales están en orden!"*

**Criterio de Aceptación:** Al marcar como limpiado, el registro en Supabase cambia a `LIMPIADO` y el marcador desaparece del mapa en menos de 5 segundos.

---

## 5. Requisitos No Funcionales

### RNF-01: Rendimiento

| ID | Requisito | Métrica |
| :--- | :--- | :--- |
| RNF-01.1 | El análisis de IA debe completarse en tiempo aceptable | ≤ 8 segundos (p95) |
| RNF-01.2 | La carga inicial del mapa de calor debe ser rápida | ≤ 3 segundos en WiFi |
| RNF-01.3 | La subida de la foto a Supabase Storage debe ser fluida | ≤ 10 segundos para imagen ≤ 5 MB |
| RNF-01.4 | La app debe responder a interacciones del usuario | ≤ 100 ms (sin operaciones I/O) |

### RNF-02: Usabilidad

| ID | Requisito |
| :--- | :--- |
| RNF-02.1 | Un ciudadano sin capacitación técnica debe poder enviar un reporte en ≤ 3 pasos visibles. |
| RNF-02.2 | Toda pantalla debe implementar los 4 estados: Loading, Error, Empty y Data. |
| RNF-02.3 | Los mensajes de error deben ser legibles para el usuario final, no mensajes técnicos de excepción. |
| RNF-02.4 | El código de colores (rojo/amarillo/verde) debe ser consistente en el mapa y en el panel. |

### RNF-03: Seguridad

| ID | Requisito |
| :--- | :--- |
| RNF-03.1 | Las claves de API (Supabase, Gemini) deben almacenarse en variables de entorno (`--dart-define`), nunca en el código fuente. |
| RNF-03.2 | Las políticas RLS de Supabase deben activarse para que ciudadanos solo puedan `INSERT`, no `DELETE` ni `UPDATE` reportes ajenos. |
| RNF-03.3 | Solo usuarios con rol `operator` en Supabase Auth pueden ejecutar `UPDATE` sobre `reports`. |
| RNF-03.4 | El bucket de Storage `report-photos` debe ser de lectura pública, escritura autenticada (solo usuarios de Supabase). |

### RNF-04: Mantenibilidad

| ID | Requisito |
| :--- | :--- |
| RNF-04.1 | Toda integración con SDK externo debe estar detrás de un wrapper abstracto en `core/wrappers/`. |
| RNF-04.2 | Las entidades del dominio deben ser inmutables (`final`) con `copyWith()`. |
| RNF-04.3 | Las funciones asíncronas deben usar el patrón Early Return. |
| RNF-04.4 | El código fuente debe estar en español (comentarios y nombres de variables descriptivos). |

### RNF-05: Confiabilidad

| ID | Requisito |
| :--- | :--- |
| RNF-05.1 | Si la API de Gemini falla, el reporte se guarda igualmente en Supabase con `risk_score: null` para revisión posterior. |
| RNF-05.2 | Si el GPS no está disponible, la app debe advertir al usuario pero no crashear. |
| RNF-05.3 | La app no debe mostrar excepciones no manejadas al usuario final bajo ninguna circunstancia. |

---

## 6. Modelo de Datos (Supabase)

### 6.1 Tabla Principal: `reports`

```sql
-- Tabla principal de reportes de obstrucción
CREATE TABLE public.reports (
  id              UUID            PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),

  -- Datos capturados por el ciudadano
  photo_url       TEXT            NOT NULL,
  latitude        DOUBLE PRECISION NOT NULL,
  longitude       DOUBLE PRECISION NOT NULL,

  -- Estado del reporte en el ciclo de vida
  -- Valores válidos: 'PENDIENTE' | 'LIMPIADO' | 'INVALIDO'
  status          TEXT            NOT NULL DEFAULT 'PENDIENTE',

  -- Datos calculados por Gemini 1.5 Flash (pueden ser NULL hasta completar el análisis)
  risk_score      SMALLINT        CHECK (risk_score >= 0 AND risk_score <= 10),
  category        TEXT            CHECK (category IN (
                                    'basura', 'maleza', 'sedimento',
                                    'escombros', 'despejado', 'no_valido'
                                  )),
  ai_description  TEXT,           -- Máximo 80 caracteres, generado por Gemini

  -- Metadata de auditoría
  reported_by     UUID            REFERENCES auth.users(id) ON DELETE SET NULL,
  cleaned_at      TIMESTAMPTZ,    -- Timestamp cuando el operador marcó como limpiado
  cleaned_by      UUID            REFERENCES auth.users(id) ON DELETE SET NULL
);

-- Índices para consultas frecuentes
CREATE INDEX idx_reports_status      ON public.reports (status);
CREATE INDEX idx_reports_risk_score  ON public.reports (risk_score DESC);
CREATE INDEX idx_reports_created_at  ON public.reports (created_at DESC);

-- Comentarios de columnas (documentación inline)
COMMENT ON TABLE  public.reports              IS 'Reportes de obstrucción de canales enviados por ciudadanos';
COMMENT ON COLUMN public.reports.risk_score   IS 'Score de riesgo de inundación: 1 (bajo) a 10 (crítico). NULL mientras Gemini procesa.';
COMMENT ON COLUMN public.reports.category     IS 'Tipo de obstrucción detectado por Gemini 1.5 Flash';
COMMENT ON COLUMN public.reports.ai_description IS 'Resumen técnico generado por Gemini, max 80 caracteres';
```

### 6.2 Tabla Auxiliar: `operators` (Roles del Panel Municipal)

```sql
-- Tabla de perfil extendido para operadores municipales
CREATE TABLE public.operators (
  id          UUID  PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name   TEXT  NOT NULL,
  badge_id    TEXT  UNIQUE,     -- Número de legajo municipal
  is_active   BOOL  NOT NULL DEFAULT true,
  created_at  TIMESTAMPTZ DEFAULT now()
);

COMMENT ON TABLE public.operators IS 'Perfiles de operadores municipales de SEARPI/Alcaldía';
```

### 6.3 Vista Auxiliar: `active_risk_map` (Para el Mapa de Calor)

```sql
-- Vista optimizada para la consulta del mapa de calor
-- Solo retorna reportes activos (PENDIENTE) con score calculado
CREATE VIEW public.active_risk_map AS
SELECT
  id,
  photo_url,
  latitude,
  longitude,
  risk_score,
  category,
  ai_description,
  created_at,
  CASE
    WHEN risk_score >= 8 THEN 'CRITICO'
    WHEN risk_score >= 5 THEN 'MODERADO'
    WHEN risk_score >= 1 THEN 'BAJO'
    ELSE 'PENDIENTE_IA'
  END AS risk_level
FROM public.reports
WHERE status = 'PENDIENTE'
  AND risk_score IS NOT NULL
ORDER BY risk_score DESC;

COMMENT ON VIEW public.active_risk_map IS 'Vista optimizada para el mapa de calor. Solo reportes pendientes con IA procesada.';
```

---

## 7. Seguridad y Políticas RLS (Supabase)

Activar Row Level Security en todas las tablas es obligatorio antes del demo.

```sql
-- ============================================================
-- HABILITAR RLS EN TODAS LAS TABLAS
-- ============================================================
ALTER TABLE public.reports   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.operators ENABLE ROW LEVEL SECURITY;


-- ============================================================
-- POLÍTICAS PARA: reports
-- ============================================================

-- POLÍTICA 1: Cualquier usuario (incluso anónimo) puede CREAR un reporte
CREATE POLICY "ciudadanos_pueden_crear_reportes"
ON public.reports
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- POLÍTICA 2: Cualquiera puede VER reportes (mapa público)
CREATE POLICY "mapa_es_publico"
ON public.reports
FOR SELECT
TO anon, authenticated
USING (true);

-- POLÍTICA 3: Solo operadores autenticados pueden ACTUALIZAR (marcar como limpiado)
CREATE POLICY "operadores_pueden_actualizar_reportes"
ON public.reports
FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.operators
    WHERE operators.id = auth.uid()
    AND operators.is_active = true
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.operators
    WHERE operators.id = auth.uid()
    AND operators.is_active = true
  )
);

-- POLÍTICA 4: Nadie puede ELIMINAR reportes (integridad de datos históricos)
-- (Sin política de DELETE = ningún usuario puede borrar)


-- ============================================================
-- POLÍTICAS PARA: operators
-- ============================================================

-- Solo el propio operador puede ver su perfil
CREATE POLICY "operador_ve_su_propio_perfil"
ON public.operators
FOR SELECT
TO authenticated
USING (auth.uid() = id);


-- ============================================================
-- BUCKET DE STORAGE: report-photos
-- ============================================================

-- Crear bucket con acceso público para lectura
INSERT INTO storage.buckets (id, name, public)
VALUES ('report-photos', 'report-photos', true);

-- Cualquier usuario puede subir fotos (INSERT)
CREATE POLICY "cualquiera_puede_subir_fotos"
ON storage.objects
FOR INSERT
TO anon, authenticated
WITH CHECK (bucket_id = 'report-photos');

-- Las fotos son públicamente legibles
CREATE POLICY "fotos_son_publicas"
ON storage.objects
FOR SELECT
TO anon, authenticated
USING (bucket_id = 'report-photos');
```

---

## 8. Inteligencia Artificial — Contrato de la API (Gemini)

### 8.1 System Prompt (Configuración del Motor DrenaCruz Engine)

Este prompt se configura como **System Instruction** en el `GeminiAIWrapper` o en Google AI Studio. Es la única fuente de comportamiento de la IA.

```
Eres "DrenaCruz Engine", un experto en ingeniería hidráulica urbana especializado
en gestión de riesgos de inundación para Santa Cruz de la Sierra, Bolivia.

═══════════════════════════════════════════════════════
TU MISIÓN ÚNICA
═══════════════════════════════════════════════════════
Analizar fotografías de canales de drenaje urbano (abiertos o cerrados) capturadas
por ciudadanos con sus teléfonos móviles. Determinar el nivel de obstrucción para
prevenir inundaciones urbanas.

═══════════════════════════════════════════════════════
REGLAS DE ANÁLISIS (aplicar en orden)
═══════════════════════════════════════════════════════

REGLA 1 — VALIDACIÓN DE IMAGEN:
  Si la fotografía NO muestra claramente un canal, cuneta, alcantarilla o estructura
  de drenaje urbano → devolver: { "risk_score": 0, "category": "no_valido",
  "ai_description": "Imagen no corresponde a canal de drenaje." }

REGLA 2 — IDENTIFICACIÓN DE OBSTRUCCIÓN:
  Identificar el tipo predominante de obstrucción:
  - basura      → Residuos plásticos, bolsas, botellas, desechos sólidos.
  - maleza      → Vegetación excesiva, raíces, pasto crecido dentro del canal.
  - sedimento   → Acumulación de tierra, arena, lodo o barro.
  - escombros   → Materiales de construcción, ramas grandes, objetos voluminosos.
  - despejado   → Canal visiblemente limpio, sin obstrucciones notables.

REGLA 3 — CÁLCULO DEL RISK_SCORE (escala 1–10):
  1–3  → Canal limpio o con residuos mínimos que no interrumpen el flujo del agua.
  4–7  → Obstrucción parcial visible; el agua fluiría con dificultad en caso de lluvia.
  8–10 → Obstrucción severa o total; alto riesgo de desborde inminente ante cualquier lluvia.

REGLA 4 — DESCRIPCIÓN TÉCNICA:
  Redactar un resumen técnico objetivo en español. Máximo 80 caracteres. Sin signos de
  exclamación. Solo hechos observables en la imagen.

═══════════════════════════════════════════════════════
FORMATO DE SALIDA — ESTRICTAMENTE JSON
═══════════════════════════════════════════════════════
Responder ÚNICAMENTE con el siguiente objeto JSON.
Sin texto adicional. Sin bloques de código Markdown. Sin explicaciones.

{
  "risk_score": [entero del 0 al 10],
  "category": "basura" | "maleza" | "sedimento" | "escombros" | "despejado" | "no_valido",
  "ai_description": "[texto máximo 80 caracteres]"
}
```

### 8.2 Ejemplos de Respuestas Esperadas

```json
// Ejemplo 1: Canal con basura severa
{
  "risk_score": 9,
  "category": "basura",
  "ai_description": "Canal bloqueado en ~85% por bolsas plásticas y residuos sólidos."
}

// Ejemplo 2: Canal con maleza moderada
{
  "risk_score": 6,
  "category": "maleza",
  "ai_description": "Vegetación densa reduce sección de flujo en aproximadamente 50%."
}

// Ejemplo 3: Canal limpio
{
  "risk_score": 2,
  "category": "despejado",
  "ai_description": "Canal despejado, residuos mínimos sin impacto en el flujo hidráulico."
}

// Ejemplo 4: Foto inválida
{
  "risk_score": 0,
  "category": "no_valido",
  "ai_description": "Imagen no corresponde a canal de drenaje urbano."
}
```

### 8.3 Manejo de Errores de la API

| Código HTTP | Causa probable | Acción en la app |
| :--- | :--- | :--- |
| `429` | Rate limit de la API gratuita | Esperar 30s y reintentar una vez. |
| `400` | Imagen demasiado grande o formato no soportado | Comprimir imagen a JPEG ≤ 1 MB antes de enviar. |
| `500` | Error interno de Gemini | Guardar reporte con `risk_score: null`, avisar al usuario. |
| Timeout (>10s) | Latencia de red elevada desde Bolivia | Timeout, guardar con `risk_score: null`. |

---

## 9. Modelo de Negocio e Impacto

### 9.1 Propuesta de Valor Central

> *"Convertimos a cada ciudadano de Santa Cruz en un sensor inteligente de inundaciones, y a la IA en el analista 24/7 que la Alcaldía no puede costear."*

### 9.2 Modelos de Monetización

**Modelo B2G — Gobierno Municipal:**
Venta de licencia SaaS del Panel Operativo + Dashboard con analítica de IA predictiva a la **Alcaldía de Santa Cruz de la Sierra** o **SEARPI**. El argumento económico central: una inundación severa destruye kilómetros de asfalto. El costo de reparación supera en órdenes de magnitud el costo anual de una licencia de software.

**Modelo B2B — Sector Asegurador:**
Venta de datos agregados y anonimizados sobre niveles históricos de riesgo por zona geográfica a aseguradoras locales (ej. Bisa Seguros, Alianza Seguros). Estos datos permiten calcular primas de seguros de propiedad con mayor precisión para zonas de riesgo.

### 9.3 Triple Impacto

| Dimensión | Impacto |
| :--- | :--- |
| 🤝 **Social** | Prevención de pérdidas materiales y vidas humanas mediante alertas tempranas a vecinos en zonas bajas de la ciudad. |
| 🌿 **Ambiental** | Retiro planificado y preventivo de plásticos, sedimentos y desechos antes de que las inundaciones los arrastren al Río Piraí. |
| 💰 **Económico** | Reducción del gasto municipal en emergencias y reparación de infraestructura dañada por aguas acumuladas. |

---

## 10. Matriz de Trazabilidad

Esta tabla asegura que cada módulo de código es justificado por un requisito.

| Requisito | Módulo / Archivo Flutter | Tabla Supabase | Actor |
| :--- | :--- | :--- | :--- |
| RF-01: Captura foto + GPS | `features/report/presentation/screens/camera_screen.dart` | `reports` (INSERT) | Ciudadano |
| RF-02: Análisis IA Gemini | `core/wrappers/ai/gemini_ai_wrapper.dart` | `reports` (UPDATE) | Sistema (IA) |
| RF-03: Mapa de calor | `features/dashboard/presentation/screens/map_screen.dart` | `active_risk_map` (SELECT) | Ciudadano + Operador |
| RF-04: Panel de triage | `features/dashboard/presentation/screens/triage_screen.dart` | `reports` (SELECT + UPDATE) | Operador Municipal |
| RNF-03.2: RLS ciudadano | — | Política `ciudadanos_pueden_crear_reportes` | Supabase Auth |
| RNF-03.3: RLS operador | — | Política `operadores_pueden_actualizar_reportes` | Supabase Auth |

---

## 11. Criterios de Aceptación del Demo (Hackathon)

El MVP se considera funcional para la presentación ante el jurado si cumple **todos** los siguientes criterios:

| # | Criterio | Verificación |
| :--- | :--- | :--- |
| DA-01 | Un ciudadano toma una foto real de un canal con el teléfono en vivo | Demo en tiempo real con teléfono físico |
| DA-02 | La foto aparece en Supabase Storage en menos de 10 segundos | Verificar en Supabase Dashboard |
| DA-03 | Gemini devuelve `risk_score`, `category` y `ai_description` válidos | El registro en `reports` muestra los 3 campos poblados |
| DA-04 | El mapa de calor muestra al menos 3 marcadores de colores distintos | Vista del mapa en la app con datos de prueba precargados |
| DA-05 | El operador puede marcar un reporte como "Limpiado" y desaparece del mapa | Demo del flujo completo end-to-end |
| DA-06 | La app no crashea durante el flujo completo de demo | Prueba de flujo sin interrupciones |
| DA-07 | Toda pantalla muestra el estado `Loading` durante operaciones de red | Observable durante la demo |

---

*Documento generado para el Hackathon "Build with AI" — GDG Santa Cruz 2026.*
*Versión 2.0.0 — Estado: Aprobado para ejecución.*
