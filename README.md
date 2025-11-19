# 🎮 Gamerpedia App

Aplicación móvil desarrollada en **Flutter** para consultar información de videojuegos usando la API pública **RAWG.io**.  
Incluye búsqueda, detalle de juegos, lista de favoritos persistente y navegación entre pantallas.

---

## 1. Descripción general de la app

**Gamerpedia App** permite:

- Ver una lista de juegos populares.
- Buscar videojuegos por nombre.
- Consultar detalles completos de cada juego:
  - Imagen
  - Rating
  - Metacritic
  - Plataformas
  - Géneros
  - Desarrollador
  - Descripción
- Guardar y gestionar juegos favoritos (persistentes con Hive).
- Navegar entre pantallas (Home, Favoritos, Acerca de).

El proyecto integra navegación, consumo de API, manejo de estado y base de datos local.

---

## 2. Patrones de diseño utilizados

### Clean Architecture (adaptada)

El proyecto está dividido en capas:

- **data** → API service, modelos, repositorios.
- **domain** → entidades y casos de uso.
- **presentation** → providers, pantallas, widgets.

**Motivo:**  
Separar responsabilidades, mejorar la escalabilidad y mantener el código organizado.

---

### Repository Pattern

Se utiliza un repositorio (`GameRepository`) para manejar la obtención de datos.

**Qué problema resuelve:**

- Desacopla la UI de la fuente de datos.
- Facilita pruebas y mantenimiento.
- Permite cambiar el origen de datos sin afectar la app.

---

### Dependency Injection (GetIt)

Los servicios se registran así:

```dart
getIt.registerLazySingleton(() => GameApiService());
getIt.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(getIt()));
getIt.registerLazySingleton(() => SearchGames(getIt()));

```

**Motivo:**

Evita crear instancias repetidas y centraliza dependencias.

---

### Provider – Manejo de estado

La UI reacciona automáticamente a cambios usando:

- GameListProvider

- GameDetailProvider

- FavoritesProvider

**Ventajas:**
Simple, eficiente y recomendado oficialmente en Flutter.

---

## 3. Manejo de estado

Se utiliza:

```dart
class GameListProvider extends ChangeNotifier { ... }
```

Esto permite:

- Notificar cambios a la UI.

- Manejar estados de carga (loading).

- Actualizar listas de juegos.

- Sincronizar favoritos con Hive.

---

## 4. Persistencia y consumo de datos

### Consumo de API REST (RAWG.io)

Funciones implementadas:

- Obtener juegos populares.

- Buscar juegos por palabra clave.

- Obtener detalle de un juego por ID.

Ejemplo de llamada:

```dart
final url = Uri.parse("$baseUrl/games?search=$query&key=$apiKey");
```

Los datos se procesan en:

- GameApiService

- GameRepositoryImpl

- GameModel

---

### Persistencia local con Hive

Se abre un box:

```dart
await Hive.openBox('favorites');
```

Se guardan IDs de juegos favoritos con:

```dart
favoritesBox.put(id, true);
favoritesBox.delete(id);
```

Los favoritos son persistentes incluso al cerrar la app.

---

## 5. Base de datos local

Se usa **Hive**, una base de datos rápida y liviana, ideal para dispositivos móviles.

Datos almacenados:

- Lista de IDs de juegos favoritos.

Accedido mediante `FavoritesProvider`.

---

## 6. Instrucciones para ejecutar el proyecto

1️⃣ Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd gamerpedia_app
```

2️⃣ Instalar dependencias

```bash
flutter pub get
```

3️⃣ Configurar archivo .env

El proyecto incluye:

```cpp
.env.template
```

Debe copiarse y renombrarse como:

```bash
.env
```

Luego agregar tu API Key:

```env
RAWG_API_KEY=tu_api_key_aqui
```

La API Key se obtiene gratis en:
https://rawg.io/apidocs

---

### 4️⃣ Ejecutar el proyecto

```bash
flutter run
```

---

## 7. Pantallas principales

- **Home:** Lista de juegos + barra de búsqueda.
- **Detalle:** Información completa del juego.
- **Favoritos:** Juegos guardados localmente.
- **Acerca de:** Información del desarrollador y del curso.
