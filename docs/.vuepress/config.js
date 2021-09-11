module.exports = {
  title: 'Qt6 Book',
  description: "A book about Qt6",  
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
    ],
  },  
}

function ch18Sidebar() {
  return {
    title: "Qt for Python",
    path: '/ch18-python/qt-python',
    collapsable: false,
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
    title: "Extending QML (Qt6 - Draft)",
    path: '/ch17-extensions/extending-qml',
    collapsable: false,
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
    title: "Qt C++ (Qt6 - Draft)",
    path: '/ch16-qtcpp/qtcpp',
    collapsable: false,
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
    collapsable: false,
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
    title: "Dynamic QML (Qt6 - Draft)",
    path: '/ch14-dynamicqml/dynamic-qml',
    collapsable: false,
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
    title: "Storage (Qt6 - Draft)",
    path: '/ch13-storage/storage',
    collapsable: false,
    children: [
      '/ch13-storage/storage',
      '/ch13-storage/settings',
      '/ch13-storage/local-storage',
    ]
  }
}

function ch12Sidebar() {
  return {
    title: "Networking (Qt6 - Draft)",
    path: '/ch12-networking/networking',
    collapsable: false,
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
    collapsable: false,
    children: [
      '/ch11-multimedia/multimedia',
      '/ch11-multimedia/playing-media',
      '/ch11-multimedia/sound-effects',
      '/ch11-multimedia/video-streams',
      '/ch11-multimedia/capturing-images',
      '/ch11-multimedia/advanced',
      '/ch11-multimedia/summary',
    ]
  }
}

function ch10Sidebar() {
  return {
    title: "Effects (Qt6 - Draft)",
    path: '/ch10-effects/effects',
    collapsable: false,
    children: [
      '/ch10-effects/effects',
      '/ch10-effects/shader-effects',
      '/ch10-effects/opengl-shaders',
      '/ch10-effects/shader-elements',
      '/ch10-effects/fragment-shaders',
      '/ch10-effects/wave-effect',
      '/ch10-effects/vertex-shader',
      '/ch10-effects/curtain-effect',
      '/ch10-effects/effect-library',
      '/ch09-particles/particle-simulation',
      '/ch09-particles/concept',
      '/ch09-particles/simple-simulation',
      '/ch09-particles/particle-parameters',
      '/ch09-particles/directed-particles',
      '/ch09-particles/affecting-particles',
      '/ch09-particles/particle-groups',
      '/ch09-particles/summary',
    ]
  }
}

function ch09Sidebar() {
  return {
    title: "Shapes (Qt6 - Placeholder)",
    path: '/ch09-shapes/placeholder',
    collapsable: false,
    children: [
      '/ch09-shapes/placeholder',
    ]
  }
}

function ch08Sidebar() {
  return {
    title: "Canvas (Qt6 - Draft)",
    path: '/ch08-canvas/canvas-element',
    collapsable: false,
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
    title: "Model View",
    path: '/ch07-modelview/model-view',
    collapsable: false,
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
    title: "QtQuick Controls (Qt5)",
    path: '/ch06-controls/controls2',
    collapsable: false,
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
    title: "Fluid Elements (Qt6 - Draft)",
    path: '/ch05-fluid/fluid-elements',
    collapsable: false,
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
    title: "Quick Starter (Qt6 - Draft)",
    path: '/ch04-qmlstart/quick-start',
    collapsable: false,
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
    title: "Qt Creator IDE (Qt6 - Draft)",
    path: '/ch03-qtcreator/qt-creator',
    collapsable: false,
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
    title: "Getting Started (Qt6 - Draft)",
    path: '/ch02-start/quick-start',
    collapsable: false,
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
    title: "Meet Qt (Qt6 - Draft)",
    path: '/ch01-meetqt/meet-qt',
    collapsable: false,
    children: [
      '/ch01-meetqt/meet-qt',
      '/ch01-meetqt/blocks',
      '/ch01-meetqt/intro',
    ]
  }
}
