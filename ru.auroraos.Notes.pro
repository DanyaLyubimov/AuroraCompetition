TARGET = ru.auroraos.Notes

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    qml/pages/NewNotePage.qml \
    rpm/ru.auroraos.Notes.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.auroraos.Notes.ts \
    translations/ru.auroraos.Notes-ru.ts \
