module.exports = {
  title: 'The Qt 6 Book',
  description: "A book about QML",
  locales: {
    '/': {
      lang: 'English',
      title: 'The Qt 6 Book',
      description: 'A book about QML'
    },
    '/zh/': {
      lang: '简体中文',
      title: 'Qt 6 电子书',
      description: '一本关于 QML 的电子书'
    }
  },
  plugins: [
    'vuepress-plugin-mermaidjs'
  ],
  themeConfig: {
    displayAllHeaders: false,
    repo: 'qmlbook/qt6book',
    repoLabel: 'Contribute!',
    docsDir: 'docs',
    docsBranch: 'main',
    editLinks: true,
    editLinkText: 'Help us improve this page!',
    smoothScroll: true,
    lastUpdated: 'Last Updated',
    nav: [
    ],
    sidebar: [
      {
        title: 'Qt 6 Book - English',
        path: '/',
        collapsable: true,
        children: [
          prefaceSidebar(),
          ch01Sidebar(),
          ch02Sidebar(),
          ch03Sidebar(),
          ch04Sidebar(),
          ch05Sidebar(),
          ch06Sidebar(),
          ch07Sidebar(),
          ch08Sidebar(),
          ch09Sidebar(),
          ch10Sidebar(),
          ch11Sidebar(),
          ch12Sidebar(),
          ch13Sidebar(),
          ch14Sidebar(),
          ch15Sidebar(),
          ch16Sidebar(),
          ch17Sidebar(),
          ch18Sidebar(),
        ]
      },
      {
        title: 'Qt 6 Book - Chinese',
        path: '/zh/',
        collapsable: true,
        children: [
          zh_prefaceSidebar(),
          zh_ch01Sidebar(),
          zh_ch02Sidebar(),
          zh_ch03Sidebar(),
          zh_ch04Sidebar(),
          zh_ch05Sidebar(),
          zh_ch06Sidebar(),
          zh_ch07Sidebar(),
          zh_ch08Sidebar(),
          zh_ch09Sidebar(),
          zh_ch10Sidebar(),
          zh_ch11Sidebar(),
          zh_ch12Sidebar(),
          zh_ch13Sidebar(),
          zh_ch14Sidebar(),
          zh_ch15Sidebar(),
          zh_ch16Sidebar(),
          zh_ch17Sidebar(),
          zh_ch18Sidebar(),
        ]
      },
    ],
  },
}

function ch18Sidebar() {
  return {
    title: "Qt for Python",
    path: '/ch18-python/qt-python',
    collapsable: true,
    children: [
      '/ch18-python/qt-python',
      '/ch18-python/introduction',
      '/ch18-python/installing',
      '/ch18-python/build-app',
      '/ch18-python/limitations',
      '/ch18-python/summary',
    ]
  }
}

function ch17Sidebar() {
  return {
    title: "Extending QML",
    path: '/ch17-extensions/extending-qml',
    collapsable: true,
    children: [
      '/ch17-extensions/extending-qml',
      '/ch17-extensions/qml-runtime',
      '/ch17-extensions/plugin-content',
      '/ch17-extensions/create-plugin',
      '/ch17-extensions/fileio-demo',
      '/ch17-extensions/using-fileio',
      '/ch17-extensions/summary',
    ]
  }
}

function ch16Sidebar() {
  return {
    title: "Qt C++",
    path: '/ch16-qtcpp/qtcpp',
    collapsable: true,
    children: [
      '/ch16-qtcpp/qtcpp',
      '/ch16-qtcpp/boilerplate',
      '/ch16-qtcpp/qobject',
      '/ch16-qtcpp/build-system',
      '/ch16-qtcpp/common-classes',
      '/ch16-qtcpp/cpp-models',
    ]
  }
}

function ch15Sidebar() {
  return {
    title: "Javascript",
    path: '/ch15-javascript/javascript',
    collapsable: true,
    children: [
      '/ch15-javascript/javascript',
      '/ch15-javascript/html-qml',
      '/ch15-javascript/js-language',
      '/ch15-javascript/js-objects',
      '/ch15-javascript/js-console',
    ]
  }
}

function ch14Sidebar() {
  return {
    title: "Dynamic QML",
    path: '/ch14-dynamicqml/dynamic-qml',
    collapsable: true,
    children: [
      '/ch14-dynamicqml/dynamic-qml',
      '/ch14-dynamicqml/loading-components',
      '/ch14-dynamicqml/dynamic-objects',
      '/ch14-dynamicqml/tracking-objects',
      '/ch14-dynamicqml/summary',
    ]
  }
}

function ch13Sidebar() {
  return {
    title: "Storage",
    path: '/ch13-storage/storage',
    collapsable: true,
    children: [
      '/ch13-storage/storage',
      '/ch13-storage/settings',
      '/ch13-storage/local-storage',
    ]
  }
}

function ch12Sidebar() {
  return {
    title: "Networking",
    path: '/ch12-networking/networking',
    collapsable: true,
    children: [
      '/ch12-networking/networking',
      '/ch12-networking/serve-qml',
      '/ch12-networking/templates',
      '/ch12-networking/http-requests',
      '/ch12-networking/local-files',
      '/ch12-networking/rest-api',
      '/ch12-networking/authentication',
      '/ch12-networking/web-sockets',
      '/ch12-networking/summary',
    ]
  }
}

function ch11Sidebar() {
  return {
    title: "Multimedia",
    path: '/ch11-multimedia/multimedia',
    collapsable: true,
    children: [
      '/ch11-multimedia/multimedia',
      '/ch11-multimedia/playing-media',
      '/ch11-multimedia/sound-effects',
      '/ch11-multimedia/video-streams',
      '/ch11-multimedia/capturing-images',
      '/ch11-multimedia/summary',
    ]
  }
}

function ch10Sidebar() {
  return {
    title: "Effects",
    path: '/ch10-effects/effects',
    collapsable: true,
    children: [
      '/ch10-effects/effects',
      '/ch10-effects/particles',
      '/ch10-effects/simple-simulation',
      '/ch10-effects/particle-parameters',
      '/ch10-effects/directed-particles',
      '/ch10-effects/affecting-particles',
      '/ch10-effects/particle-groups',
      '/ch10-effects/particle-painters',
      '/ch10-effects/opengl-shaders',
      '/ch10-effects/shader-elements',
      '/ch10-effects/fragment-shaders',
      '/ch10-effects/wave-effect',
      '/ch10-effects/vertex-shader',
      '/ch10-effects/curtain-effect',
      '/ch10-effects/summary',
    ]
  }
}

function ch09Sidebar() {
  return {
    title: "Shapes (Placeholder)",
    path: '/ch09-shapes/placeholder',
    collapsable: true,
    children: [
      '/ch09-shapes/placeholder',
    ]
  }
}

function ch08Sidebar() {
  return {
    title: "Canvas",
    path: '/ch08-canvas/canvas-element',
    collapsable: true,
    children: [
      '/ch08-canvas/canvas-element',
      '/ch08-canvas/convenience-api',
      '/ch08-canvas/gradients',
      '/ch08-canvas/shadows',
      '/ch08-canvas/images',
      '/ch08-canvas/transformation',
      '/ch08-canvas/composition-modes',
      '/ch08-canvas/pixel-buffer',
      '/ch08-canvas/canvas-paint',
      '/ch08-canvas/port-from-html',
    ]
  }
}

function ch07Sidebar() {
  return {
    title: "Model View (Qt 5)",
    path: '/ch07-modelview/model-view',
    collapsable: true,
    children: [
      '/ch07-modelview/model-view',
      '/ch07-modelview/concept',
      '/ch07-modelview/basic-models',
      '/ch07-modelview/dynamic-views',
      '/ch07-modelview/delegate',
      '/ch07-modelview/advanced',
      '/ch07-modelview/summary',
    ]
  }
}

function ch06Sidebar() {
  return {
    title: "QtQuick Controls",
    path: '/ch06-controls/controls2',
    collapsable: true,
    children: [
      '/ch06-controls/controls2',
      '/ch06-controls/introduction',
      '/ch06-controls/image-viewer',
      '/ch06-controls/common-patterns',
      '/ch06-controls/imagine-style',
      '/ch06-controls/summary',
    ]
  }
}

function ch05Sidebar() {
  return {
    title: "Fluid Elements",
    path: '/ch05-fluid/fluid-elements',
    collapsable: true,
    children: [
      '/ch05-fluid/fluid-elements',
      '/ch05-fluid/animations',
      '/ch05-fluid/states-transitions',
      '/ch05-fluid/advanced',
    ]
  }
}

function ch04Sidebar() {
  return {
    title: "Quick Starter",
    path: '/ch04-qmlstart/quick-start',
    collapsable: true,
    children: [
      '/ch04-qmlstart/quick-start',
      '/ch04-qmlstart/qml-syntax',
      '/ch04-qmlstart/core-elements',
      '/ch04-qmlstart/components',
      '/ch04-qmlstart/transformations',
      '/ch04-qmlstart/positioning',
      '/ch04-qmlstart/layout',
      '/ch04-qmlstart/input',
      '/ch04-qmlstart/advanced',
    ]
  }
}

function ch03Sidebar() {
  return {
    title: "Qt Creator IDE",
    path: '/ch03-qtcreator/qt-creator',
    collapsable: true,
    children: [
      '/ch03-qtcreator/qt-creator',
      '/ch03-qtcreator/user-interface',
      '/ch03-qtcreator/kit-registry',
      '/ch03-qtcreator/projects',
      '/ch03-qtcreator/editor',
      '/ch03-qtcreator/locator',
      '/ch03-qtcreator/debugging',
      '/ch03-qtcreator/shortcuts',
    ]
  }
}

function ch02Sidebar() {
  return {
    title: "Getting Started",
    path: '/ch02-start/quick-start',
    collapsable: true,
    children: [
      '/ch02-start/quick-start',
      '/ch02-start/install',
      '/ch02-start/hello-world',
      '/ch02-start/app-types',
      '/ch02-start/summary',
    ]
  }
}

function ch01Sidebar() {
  return {
    title: "Meet Qt",
    path: '/ch01-meetqt/meet-qt',
    collapsable: true,
    children: [
      '/ch01-meetqt/meet-qt',
      '/ch01-meetqt/blocks',
      '/ch01-meetqt/intro',
    ]
  }
}

function prefaceSidebar() {
  return {
    title: "Preface",
    path: '/preface/preface',
    collapsable: true,
    children: [
      '/preface/preface',
      '/preface/acknowledgements',
      '/preface/authors',
    ]
  }
}


// 1111111111111111111111111111111111111111111111111111111111

function zh_ch18Sidebar() {
  return {
    title: "用于 Python 的 Qt",
    path: '/zh/ch18-python/qt-python',
    collapsable: true,
    children: [
      '/zh/ch18-python/qt-python',
      '/zh/ch18-python/introduction',
      '/zh/ch18-python/installing',
      '/zh/ch18-python/build-app',
      '/zh/ch18-python/limitations',
      '/zh/ch18-python/summary',
    ]
  }
}

function zh_ch17Sidebar() {
  return {
    title: "扩展 QML",
    path: '/zh/ch17-extensions/extending-qml',
    collapsable: true,
    children: [
      '/zh/ch17-extensions/extending-qml',
      '/zh/ch17-extensions/qml-runtime',
      '/zh/ch17-extensions/plugin-content',
      '/zh/ch17-extensions/create-plugin',
      '/zh/ch17-extensions/fileio-demo',
      '/zh/ch17-extensions/using-fileio',
      '/zh/ch17-extensions/summary',
    ]
  }
}

function zh_ch16Sidebar() {
  return {
    title: "Qt C++",
    path: '/zh/ch16-qtcpp/qtcpp',
    collapsable: true,
    children: [
      '/zh/ch16-qtcpp/qtcpp',
      '/zh/ch16-qtcpp/boilerplate',
      '/zh/ch16-qtcpp/qobject',
      '/zh/ch16-qtcpp/build-system',
      '/zh/ch16-qtcpp/common-classes',
      '/zh/ch16-qtcpp/cpp-models',
    ]
  }
}

function zh_ch15Sidebar() {
  return {
    title: "Javascript",
    path: '/zh/ch15-javascript/javascript',
    collapsable: true,
    children: [
      '/zh/ch15-javascript/javascript',
      '/zh/ch15-javascript/html-qml',
      '/zh/ch15-javascript/js-language',
      '/zh/ch15-javascript/js-objects',
      '/zh/ch15-javascript/js-console',
    ]
  }
}

function zh_ch14Sidebar() {
  return {
    title: "动态 QML",
    path: '/zh/ch14-dynamicqml/dynamic-qml',
    collapsable: true,
    children: [
      '/zh/ch14-dynamicqml/dynamic-qml',
      '/zh/ch14-dynamicqml/loading-components',
      '/zh/ch14-dynamicqml/dynamic-objects',
      '/zh/ch14-dynamicqml/tracking-objects',
      '/zh/ch14-dynamicqml/summary',
    ]
  }
}

function zh_ch13Sidebar() {
  return {
    title: "存储",
    path: '/zh/ch13-storage/storage',
    collapsable: true,
    children: [
      '/zh/ch13-storage/storage',
      '/zh/ch13-storage/settings',
      '/zh/ch13-storage/local-storage',
    ]
  }
}

function zh_ch12Sidebar() {
  return {
    title: "网络",
    path: '/zh/ch12-networking/networking',
    collapsable: true,
    children: [
      '/zh/ch12-networking/networking',
      '/zh/ch12-networking/serve-qml',
      '/zh/ch12-networking/templates',
      '/zh/ch12-networking/http-requests',
      '/zh/ch12-networking/local-files',
      '/zh/ch12-networking/rest-api',
      '/zh/ch12-networking/authentication',
      '/zh/ch12-networking/web-sockets',
      '/zh/ch12-networking/summary',
    ]
  }
}

function zh_ch11Sidebar() {
  return {
    title: "多媒体",
    path: '/zh/ch11-multimedia/multimedia',
    collapsable: true,
    children: [
      '/zh/ch11-multimedia/multimedia',
      '/zh/ch11-multimedia/playing-media',
      '/zh/ch11-multimedia/sound-effects',
      '/zh/ch11-multimedia/video-streams',
      '/zh/ch11-multimedia/capturing-images',
      '/zh/ch11-multimedia/summary',
    ]
  }
}

function zh_ch10Sidebar() {
  return {
    title: "效果",
    path: '/zh/ch10-effects/effects',
    collapsable: true,
    children: [
      '/zh/ch10-effects/effects',
      '/zh/ch10-effects/particles',
      '/zh/ch10-effects/simple-simulation',
      '/zh/ch10-effects/particle-parameters',
      '/zh/ch10-effects/directed-particles',
      '/zh/ch10-effects/affecting-particles',
      '/zh/ch10-effects/particle-groups',
      '/zh/ch10-effects/particle-painters',
      '/zh/ch10-effects/opengl-shaders',
      '/zh/ch10-effects/shader-elements',
      '/zh/ch10-effects/fragment-shaders',
      '/zh/ch10-effects/wave-effect',
      '/zh/ch10-effects/vertex-shader',
      '/zh/ch10-effects/curtain-effect',
      '/zh/ch10-effects/summary',
    ]
  }
}

function zh_ch09Sidebar() {
  return {
    title: "形状（占位符）",
    path: '/zh/ch09-shapes/placeholder',
    collapsable: true,
    children: [
      '/zh/ch09-shapes/placeholder',
    ]
  }
}

function zh_ch08Sidebar() {
  return {
    title: "画布",
    path: '/zh/ch08-canvas/canvas-element',
    collapsable: true,
    children: [
      '/zh/ch08-canvas/canvas-element',
      '/zh/ch08-canvas/convenience-api',
      '/zh/ch08-canvas/gradients',
      '/zh/ch08-canvas/shadows',
      '/zh/ch08-canvas/images',
      '/zh/ch08-canvas/transformation',
      '/zh/ch08-canvas/composition-modes',
      '/zh/ch08-canvas/pixel-buffer',
      '/zh/ch08-canvas/canvas-paint',
      '/zh/ch08-canvas/port-from-html',
    ]
  }
}

function zh_ch07Sidebar() {
  return {
    title: "模型视图 (Qt 5)",
    path: '/zh/ch07-modelview/model-view',
    collapsable: true,
    children: [
      '/zh/ch07-modelview/model-view',
      '/zh/ch07-modelview/concept',
      '/zh/ch07-modelview/basic-models',
      '/zh/ch07-modelview/dynamic-views',
      '/zh/ch07-modelview/delegate',
      '/zh/ch07-modelview/advanced',
      '/zh/ch07-modelview/summary',
    ]
  }
}

function zh_ch06Sidebar() {
  return {
    title: "QtQuick 控件",
    path: '/zh/ch06-controls/controls2',
    collapsable: true,
    children: [
      '/zh/ch06-controls/controls2',
      '/zh/ch06-controls/introduction',
      '/zh/ch06-controls/image-viewer',
      '/zh/ch06-controls/common-patterns',
      '/zh/ch06-controls/imagine-style',
      '/zh/ch06-controls/summary',
    ]
  }
}

function zh_ch05Sidebar() {
  return {
    title: "流体元素",
    path: '/zh/ch05-fluid/fluid-elements',
    collapsable: true,
    children: [
      '/zh/ch05-fluid/fluid-elements',
      '/zh/ch05-fluid/animations',
      '/zh/ch05-fluid/states-transitions',
      '/zh/ch05-fluid/advanced',
    ]
  }
}

function zh_ch04Sidebar() {
  return {
    title: "快速入门",
    path: '/zh/ch04-qmlstart/quick-start',
    collapsable: true,
    children: [
      '/zh/ch04-qmlstart/quick-start',
      '/zh/ch04-qmlstart/qml-syntax',
      '/zh/ch04-qmlstart/core-elements',
      '/zh/ch04-qmlstart/components',
      '/zh/ch04-qmlstart/transformations',
      '/zh/ch04-qmlstart/positioning',
      '/zh/ch04-qmlstart/layout',
      '/zh/ch04-qmlstart/input',
      '/zh/ch04-qmlstart/advanced',
    ]
  }
}

function zh_ch03Sidebar() {
  return {
    title: "Qt Creator IDE",
    path: '/zh/ch03-qtcreator/qt-creator',
    collapsable: true,
    children: [
      '/zh/ch03-qtcreator/qt-creator',
      '/zh/ch03-qtcreator/user-interface',
      '/zh/ch03-qtcreator/kit-registry',
      '/zh/ch03-qtcreator/projects',
      '/zh/ch03-qtcreator/editor',
      '/zh/ch03-qtcreator/locator',
      '/zh/ch03-qtcreator/debugging',
      '/zh/ch03-qtcreator/shortcuts',
    ]
  }
}

function zh_ch02Sidebar() {
  return {
    title: "快速上手",
    path: '/zh/ch02-start/quick-start',
    collapsable: true,
    children: [
      '/zh/ch02-start/quick-start',
      '/zh/ch02-start/install',
      '/zh/ch02-start/hello-world',
      '/zh/ch02-start/app-types',
      '/zh/ch02-start/summary',
    ]
  }
}

function zh_ch01Sidebar() {
  return {
    title: "什么是 Qt",
    path: '/zh/ch01-meetqt/meet-qt',
    collapsable: true,
    children: [
      '/zh/ch01-meetqt/meet-qt',
      '/zh/ch01-meetqt/blocks',
      '/zh/ch01-meetqt/intro',
    ]
  }
}

function zh_prefaceSidebar() {
  return {
    title: "前言",
    path: '/zh/preface/preface',
    collapsable: true,
    children: [
      '/zh/preface/preface',
      '/zh/preface/acknowledgements',
      '/zh/preface/authors',
    ]
  }
}
