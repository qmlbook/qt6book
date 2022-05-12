# The QObject

As described in the introduction, the `QObject` is what enables many of Qt's core functions such as signals and slots. This is implemented through introspection, which is what `QObject` provides. `QObject` is the base class of almost all classes in Qt. Exceptions are value types such as `QColor`, `QString` and `QList`.

A Qt object is a standard C++ object, but with more abilities. These can be divided into two groups: introspection and memory management. The first means that a Qt object is aware of its class name, its relationship to other classes, as well as its methods and properties. The memory management concept means that each Qt object can be the parent of child objects. The parent *owns* the children, and when the parent is destroyed, it is responsible for destroying its children.

The best way of understanding how the `QObject` abilities affect a class is to take a standard C++ class and Qt enables it. The class shown below represents an ordinary such class.

The person class is a data class with a name and gender properties. The person class uses Qt’s object system to add meta information to the c++ class. It allows users of a person object to connect to the slots and get notified when the properties get changed.

```cpp
class Person : public QObject
{
    Q_OBJECT // enabled meta object abilities

    // property declarations required for QML
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(Gender gender READ gender WRITE setGender NOTIFY genderChanged)

    // enables enum introspections
    Q_ENUM(Gender)
    
    // makes the type creatable in QML
    QML_ELEMENT

public:
    // standard Qt constructor with parent for memory management
    Person(QObject *parent = 0);

    enum Gender { Unknown, Male, Female, Other };

    QString name() const;
    Gender gender() const;

public slots: // slots can be connected to signals, or called
    void setName(const QString &);
    void setGender(Gender);

signals: // signals can be emitted
    void nameChanged(const QString &name);
    void genderChanged(Gender gender);

private:
    // data members
    QString m_name;
    Gender m_gender;
};
```

The constructor passes the parent to the superclass and initializes the members. Qt’s value classes are automatically initialized. In this case `QString` will initialize to a null string (`QString::isNull()`) and the gender member will explicitly initialize to the unknown gender.

```cpp
Person::Person(QObject *parent)
    : QObject(parent)
    , m_gender(Person::Unknown)
{
}
```

The getter function is named after the property and is normally a basic `const` function. The setter emits the changed signal when the property has changed. To ensure that the value actually has changed, we insert a guard to compare the current value with the new value. Only when the value differs we assign it to the member variable and emit the changed signal.

```cpp
QString Person::name() const
{
    return m_name;
}

void Person::setName(const QString &name)
{
    if (m_name != name) // guard
    {
        m_name = name;
        emit nameChanged(m_name);
    }
}
```

Having a class derived from `QObject`, we have gained more meta object abilities we can explore using the `metaObject()` method. For example, retrieving the class name from the object.

```cpp
Person* person = new Person();
person->metaObject()->className(); // "Person"
Person::staticMetaObject.className(); // "Person"
```

There are many more features which can be accessed by the `QObject` base class and the meta object. Please check out the `QMetaObject` documentation.

::: tip
`QObject`, and the `Q_OBJECT` macro has a lightweight sibling: `Q_GADGET`. The `Q_GADGET` macro can be inserted in the private section of non-`QObject`-derived classes to expose properties and invokable methods. Beware that a `Q_GADGET` object cannot have signals, so the properties cannot provide a change notification signal. Still, this can be useful to provide a QML-like interface to data structures exposed from C++ to QML without invoking the cost of a fully fledged `QObject`.
:::

