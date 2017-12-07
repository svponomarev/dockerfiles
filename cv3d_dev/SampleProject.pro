QT       += core gui widgets

TARGET = SampleProject
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler).
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += test.cpp

CONFIG += c++11

# PCL headers
INCLUDEPATH += /usr/include/pcl-1.8
# Eigen headers
INCLUDEPATH += /usr/include/eigen3
# VTK headers
INCLUDEPATH += /usr/include/vtk-5.10

# OpenCV libraries
LIBS += /usr/local/lib/libopencv*
# PCL libraries
LIBS += /usr/local/lib/libpcl*
# VTK libraries
LIBS += /usr/lib/libvtk*
# Boost libraries
LIBS += /usr/lib/x86_64-linux-gnu/libboost*
 
