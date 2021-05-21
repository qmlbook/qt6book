# Introduction to Controls

Using Qt Quick from scratch gives you primitive graphical and interaction elements from which you can build your user interfaces. Using Qt Quick Controls 2 you start from a slightly more structured set of controls to build from. The controls range from simple text labels and buttons to more complex ones such as sliders and dials. These element are handy if you want to create a user interface based on classic interaction patterns as they provide a foundation to stand on.

The Qt Quick Controls 2 comes with a number of styles out of the box that are shown in the table below. The *Default* style is a basic flat style. The *Universal* style is based on the Microsoft Universal Design Guidelines, while *Material* is based on Google’s Material Design Guidelines, and the *Fusion* style is a desktop oriented style.

Some of the styles can be tweaked by tweaking the used palette. The *Imagine* is a style based on image assets, this allows a graphical designer to create a new style without writing any code at all, not even for palette colour codes.

* Default
    
    ![](./assets/style-default.png)

* Universal
    
    ![](./assets/style-universal.png)

* Material

    ![](././assets/style-material.png)

* Fusion

    ![](././assets/style-fusion.png)

* Imagine

    ![](././assets/style-imagine.png)

The Qt Quick Controls 2 is available from the `QtQuick.Controls` import module. In this module you will find the basic controls such as buttons, labels, checkboxes, sliders and so on. In addition to these controls, the following modules are also of interest:

* **`QtQuick.Controls`** - The basic controls.

* `QtQuick.Templates` - Provides the non-visual part of the controls.
| **`QtQuick.Dialogs`** - Provides standard dialogs for showing messages, picking files, picking colours, and picking fonts, as well as the base for custom dialogs.
* **`QtQuick.Controls.Universal`** - Universal style theming support.
* **`QtQuick.Controls.Material`** - Material style theming support.
* **`Qt.labs.calendar`** - Controls for supporting date picking and other calendar related interactions.
* **`Qt.labs.platform`** - Support for platform native dialogs for common tasks such as picking files, colours, etc, as well as system tray icons and standard paths.

Notice that the `Qt.labs` modules are experimental, meaning that their APIs can have breaking changes between Qt versions.

::: tip
The `QtQuick.Dialogs` module is a Qt Quick Controls 1 module, but it is also the only way to do dialogs without depending on the `QtWidgets` module. See below for more details.
:::

