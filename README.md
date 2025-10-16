# rick_and_morty

🧪 Rick and Morty Мобильное приложение на Flutter, которое отображает список персонажей из мультсериала Rick and
Morty, позволяет добавлять их в избранное, поддерживает оффлайн-режим и темную тему.

Краткое описание проекта.  
Инструкция по сборке.  
Версии зависимостей.

Функционал:  
1)Список всех персонажей с пагинацией (загрузка при скролле)  
2)Добавление/удаление из избранного (данные сохраняются локально)  
3)Переключение светлой/тёмной темы (настройки сохраняются в БД)  
4)Полная поддержка оффлайн-режима (данные кэшируются в SQLite)  
5)Сортировка избранных по имени, статусу, виду и локации  

Данные загружаются с публичного API: https://rickandmortyapi.com  

iOS: 12.0+ (опционально)  
📦 Зависимости  
Основные пакеты (указаны в pubspec.yaml):  

dependencies:  
flutter:  
sdk: flutter  

cupertino_icons: ^1.0.0  
flutter_bloc: ^9.1.1  
equatable: ^2.0.7  
drift: ^2.28.2  
sqlite3_flutter_libs: ^0.5.40  
path: ^1.9.1  
path_provider: ^2.1.5  
http: ^1.5.0  
ffi: ^2.1.4  
cached_network_image: ^3.4.1  
connectivity_plus: ^7.0.0  
shimmer: ^3.0.0  

dev_dependencies:  
flutter_test:  
sdk: flutter  

flutter_lints: ^6.0.0  
build_runner: ^2.9.0  
drift_dev: ^2.28.3  

🚀 Сборка и запуск  
Клонируйте репозиторий:  

git clone https://github.com/AleksandrFlutter/RickAndMortyEffectiveMobile.git  
cd rick_and_morty  
Установите зависимости:  
flutter pub get
Сгенерируйте код Drift:  
dart run build_runner build --delete-conflicting-outputs  
Запустите приложение:  
flutter run  
💡 Убедитесь, что на устройстве/эмуляторе включён интернет при первом запуске для загрузки данных.  

📂 Архитектура  
Clean Architecture + BLoC для управления состоянием  
Drift (SQLite) для локального хранения данных и избранного  
Все сетевые запросы — через REST API  
Поддержка реактивных обновлений через Stream из Drift  
UI разделён на экраны: Список, Избранное, Настройки  
Приложение полностью соответствует требованиям тестового задания и готово к расширению (например,
добавление GraphQL или поиска).  

🛠️ Требования:  

[√] Flutter (Channel stable, 3.32.6, on Microsoft Windows [Version 10.0.19043.1526], locale
ru-RU) [816ms]  
• Flutter version 3.32.6 on channel stable at D:\SDK\flutter  
• Upstream repository https://github.com/flutter/flutter.git  
• Framework revision 077b4a4ce1 (3 months ago), 2025-07-08 13:31:08 -0700  
• Engine revision 72f2b18bb0  
• Dart version 3.8.1  
• DevTools version 2.45.1   
