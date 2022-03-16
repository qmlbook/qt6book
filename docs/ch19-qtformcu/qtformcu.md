# Qt for MCUs

::: tip Notice
Qt for MCUs is not a part of the open source Qt distribution, but as a commercial add-on.
:::

Qt for MCUs is a Qt version takes Qt for platforms that are too small to run Linux. Instead, Qt for MCUs can run on top of FreeRTOS, or even on the bare metal, i.e. without any operating system involved. As this book focuses on QML, we will have a deeper look at Qt Quick Ultralite and compare it to the full-size Qt offering.

Using Qt for MCUs you can build beautiful, fluid graphical user interfaces for your micro controller-based systems. Qt for MCUs is focused on the graphical front-end, so instead of the traditional Qt modules, common C++ types are used. This means that some interfaces change. Most notably how models are exposed to QML. In this chapter we will dive into this, and more.
