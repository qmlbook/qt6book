#include <QQmlEngineExtensionPlugin>

class FileioPlugin : public QQmlEngineExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlEngineExtensionInterface_iid)
};

#include "fileio_plugin.moc"
