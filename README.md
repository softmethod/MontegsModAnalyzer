# MontegsModAnalyzer
PowerShell скрипт для сканирования модов в майнкрафте.

# Установка
```powershell
powershell -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/softmethod/MontegsModAnalyzer/main/MontegsModAnalyzer.ps1')"
```

# Как пользоваться
При запуске скрипт запрашивает путь к папке mods:
- Просто вводим нужный путь

# Как это работает

### Этап 1: Проверка базы данных
Скрипт вычисляет хеш SHA1 каждого JAR-файла и сравнивает его с официальными базами данных:

**Modrinth API** `https://api.modrinth.com/v2/version_file/{hash}`
- Основная база данных проверенных модов
- Возвращает название, если найдены

**Megabase API** `https://megabase.vercel.app/api/query?hash={hash}`
- Альтернативная база данных для известных модов
- Бэкап на случай, если Modrinth не найдет совпадений

Найденные моды классифицируются как **ПРОВЕРЕННЫЕ**.

### Этап 2: Анализ шаблонов
Для непроверенных модификаций скрипт:
1. Извлекает содержимое JAR-файлов с помощью `System.IO.Compression.ZipFile`
2. Анализирует внутренние имена и пути файлов
3. Читает содержимое файлов `.class`, `.json` и `MANIFEST.MF`
4. Ищет подозрительные шаблоны с помощью сопоставления с паттернами

### Отслеживание источника загрузки
Скрипт считывает поток `Zone.Identifier` (альтернативный поток данных) Windows, чтобы определить откуда был загружен мод.

**Безопасные сайты:**
- CurseForge
- Modrinth

**Рискованные сайты:**
- Discord / Discord CDN
- MediaFire
- Github
- MEGA
- Dropbox
- Google Drive
- AnyDesk
- DoomsdayClient

## Обнаружены чит паттерны
Скрипт содержит более 100 шаблонов, связанных с читерскими паттернами:

**Пвп:**
`AimAssist`, `AutoCrystal`, `TriggerBot`, `Velocity`, `Criticals`, `Hitbox`, `ShieldBreaker`, `ShieldDisabler`,

**Мувмент:**
`Flight`, `JumpReset`, `SprintReset`, `NoJumpDelay`

**Визуалы:**
`BlockESP`, `Freecam`, `PackSpoof`, `PingSpoof`

**Автоматизация:**
`FastPlace`, `AutoTotem`, `AutoArmor`, `InventoryTotem`, `ChestStealer`, `Refill`, `AutoEat`, `AutoMine`, `AutoClicker`, `FastEXP`

**Известные клиенты:**
`Celestial`, `Nursultan`, `Catlavan`, `Minced`, `Dimasik`, `NightDLC`, `Expensive`, `WexSide`, `Wild`


**И куча других  паттернов.**

## Вывод
Скрипт разделяет моды на три группы:

**ПРОВЕРЕННЫЕ МОДЫ**
- Моды, найденные в официальных базах данных и считающиеся безопасными.

**НЕИЗВЕСТНЫЕ МОДЫ**
- Моды, отсутствующие в базах данных, но не имеющие подозрительных паттернов. При наличии указывается источник загрузки.

**ПОДОЗРИТЕЛЬНЫЕ МОДЫ**
- Моды, содержащие одну или несколько паттернов, связанных с читами. Для каждого мода отображается список всех обнаруженных паттернов.
