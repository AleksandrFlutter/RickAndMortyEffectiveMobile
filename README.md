# rick_and_morty

🧪 Rick and Morty Персонажи
Мобильное приложение на Flutter, которое отображает список персонажей из мультсериала Rick and Morty, позволяет добавлять их в избранное, поддерживает оффлайн-режим и темную тему.

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
Приложение полностью соответствует требованиям тестового задания и готово к расширению (например, добавление GraphQL или поиска).


🛠️ Требования:

[√] Flutter (Channel stable, 3.32.6, on Microsoft Windows [Version 10.0.19043.1526], locale ru-RU) [816ms]
• Flutter version 3.32.6 on channel stable at D:\SDK\flutter
• Upstream repository https://github.com/flutter/flutter.git
• Framework revision 077b4a4ce1 (3 months ago), 2025-07-08 13:31:08 -0700
• Engine revision 72f2b18bb0
• Dart version 3.8.1
• DevTools version 2.45.1

[√] Windows Version (Њ ©Єа®б®дв Windows 10 Pro 64-а §ап¤­ п, 21H1, 2009) [4,4s]

[!] Android toolchain - develop for Android devices (Android SDK version 34.0.0) [4,0s]
• Android SDK at C:\Users\poluektov\AppData\Local\Android\sdk
• Platform android-36, build-tools 34.0.0
• Java binary at: C:\Program Files\Android\Android Studio\jbr\bin\java
This is the JDK bundled with the latest Android Studio installation on this machine.
To manually set the JDK path, use: `flutter config --jdk-dir="path/to/jdk"`.
• Java version OpenJDK Runtime Environment (build 21.0.7+-13880790-b1038.58)
! Some Android licenses not accepted. To resolve this, run: flutter doctor --android-licenses

[√] Chrome - develop for the web [192ms]
• Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[√] Visual Studio - develop Windows apps (Visual Studio Community 2022 17.1.0) [190ms]
• Visual Studio at d:\Program Files\Microsoft Visual Studio\2022\Community
• Visual Studio Community 2022 version 17.1.32210.238
• Windows 10 SDK version 10.0.26100.0

[√] Android Studio (version 2025.1.3) [37ms]
• Android Studio at C:\Program Files\Android\Android Studio
• Flutter plugin can be installed from:
https://plugins.jetbrains.com/plugin/9212-flutter
• Dart plugin can be installed from:
https://plugins.jetbrains.com/plugin/6351-dart
• Java version OpenJDK Runtime Environment (build 21.0.7+-13880790-b1038.58)


