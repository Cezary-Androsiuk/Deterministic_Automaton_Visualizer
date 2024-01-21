cmake_minimum_required(VERSION 3.16)

project(etaijf-deterministic_automaton_visualizer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appetaijf-deterministic_automaton_visualizer
    main.cpp
)

qt_add_qml_module(appetaijf-deterministic_automaton_visualizer
    URI etaijf-deterministic_automaton_visualizer
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES SetWordPage.qml
    QML_FILES AutomatPage.qml
    SOURCES backend.h backend.cpp
    QML_FILES CanvasFunctions.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appetaijf-deterministic_automaton_visualizer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appetaijf-deterministic_automaton_visualizer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appetaijf-deterministic_automaton_visualizer
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appetaijf-deterministic_automaton_visualizer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
