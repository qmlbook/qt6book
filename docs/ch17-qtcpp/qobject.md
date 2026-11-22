# QObject 类

正如引言中所述，`QObject` 使 Qt 的许多核心功能（例如信号和槽）成为可能。这通过内省来实现，而内省正是 `QObject` 所提供的能力。`QObject` 是 Qt 中几乎所有类的基类。例外的是值类型，例如 `QColor`、`QString` 和 `QList`。

Qt 对象是标准的 C++ 对象，但拥有更多的能力。这些能力可以分为两组：内省和内存管理。前者意味着 Qt 对象知道自己的类名、自己与其他类的关系，以及自己的方法和属性。内存管理的概念意味着每个 Qt 对象都可以成为子对象的父对象。父对象*拥有*子对象，当父对象被销毁时，它负责销毁自己的子对象。

理解 `QObject` 的能力如何影响一个类，最好的方式是拿一个标准 C++ 类，然后用 Qt 为它启用这些能力。下面展示的类就是这样一种普通的类。

Person 类是一个带有 name 和 gender 属性的数据类。Person 类使用 Qt 的对象系统为这个 C++ 类添加元信息。它允许 Person 对象的使用者连接到槽，并在属性发生改变时得到通知。

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

构造函数把 parent 传给基类，并初始化各成员。Qt 的值类会被自动初始化。在本例中，`QString` 会被初始化为一个 null 字符串（`QString::isNull()`），而 gender 成员会被显式初始化为未知性别。

```cpp
Person::Person(QObject *parent)
    : QObject(parent)
    , m_gender(Person::Unknown)
{
}
```

取值函数（getter）以属性命名，通常是一个基本的 `const` 函数。当属性发生改变时，设置函数（setter）会发出变更信号。为确保值确实发生了变化，我们插入一个防护检查，将当前值与新值进行比较。只有当值不同时，我们才把它赋给成员变量并发出变更信号。

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

有了派生自 `QObject` 的类，我们就获得了更多的元对象能力，可以用 `metaObject()` 方法来探索它们。例如，从对象获取类名。

```cpp
Person* person = new Person();
person->metaObject()->className(); // "Person"
Person::staticMetaObject.className(); // "Person"
```

通过 `QObject` 基类和元对象还能访问更多功能。请查阅 `QMetaObject` 的文档。

::: tip
`QObject` 以及 `Q_OBJECT` 宏有一个轻量级的同伴：`Q_GADGET` 宏。`Q_GADGET` 宏可以插入到非 `QObject` 派生类的私有小节中，以暴露属性和可调用方法（invokable method）。请注意，`Q_GADGET` 对象不能拥有信号，因此其属性无法提供变更通知信号。即便如此，它仍可用于为从 C++ 暴露到 QML 的数据结构提供类似 QML 的接口，而不必付出完整 `QObject` 的代价。
:::

