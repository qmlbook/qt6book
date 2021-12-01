# Hello World - for MCUs

variety of boards

NXP, Renesas, ST, Infinion/Cypress

platform abstraction classes to make porting easy

development hosts

Linux + Windows

since the topic is complex, we will start with a trivial example to ensure that the toolchain is properly setup

examples of code compatibility: `ListModel<T> = var`, import statements without version numbers.

https://doc.qt.io/QtForMCUs/qtul-qul-qt-compatibility.html

javascript support: https://doc.qt.io/QtForMCUs/qtul-javascript-environment.html#using-javascript

layer support: https://doc.qt.io/QtForMCUs/qtul-improving-performance-with-hardware-layers.html

as MCUx as targetted, the workflow is slightly different. E.g. no filesystem, no dynamic execution of QML, etc. Instead, QML is transpiled to C++, and all assets are combined into resources. This is then built into a single application binary.

there are fewer elements, but should be enough to build the typical applications for this type of hardware, e.g. control panels, monitoring uis, etc
