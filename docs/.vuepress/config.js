module.exports = {
  title: 'The Qt 6 Book',
  description: "A book about QML",  
  plugins: [
    'vuepress-plugin-mermaidjs',
    [ '@e8johan/vuepress-plugin-pdf-export', {
        puppeteerLaunchOptions: { args: [ '--no-sandbox', '--disable-setuid-sandbox' ] },
        outputFileName: 'qt6book.pdf',
        sorter: (a, b) => { return pageSorter(a.relativePath, b.relativePath); },
        filter: (p) => { return pageFilter(p.relativePath); },
        tocLevel: (p) => { return tocLevel(p.relativePath); },
        frontPage: 'assets/frontpage.pdf',
    }],
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
    sidebar: sidebarOrder(),
  },
}

function _pageOrder() {
    pageOrder = []

    const chapterOrder = sidebarOrder();
    chapterOrder.forEach(chapter => {
        pages = chapter.children
        pages.forEach(page => pageOrder.push(page));
    });

    return pageOrder;
}

function tocLevel(p) {
    const tocTopLevel = sidebarOrder().map(s => { return s.path; });
    if (p.endsWith('.md'))
        p = '/' + p.slice(0, -3)
    if (tocTopLevel.indexOf(p) != -1)
        return 0;
    else
        return 1;
}

function pageFilter(p) {
    const pageOrder = _pageOrder()

    if (p.endsWith('.md'))
        p = '/' + p.slice(0, -3);

    const indexP = pageOrder.indexOf(p);

    return (indexP != -1);
}

function pageSorter(a, b) {
    const pageOrder = _pageOrder();

    if (a.endsWith('.md'))
        a = '/' + a.slice(0, -3);
    if (b.endsWith('.md'))
        b = '/' + b.slice(0, -3);

    const indexA = pageOrder.indexOf(a);
    const indexB = pageOrder.indexOf(b);

    if (indexA == -1)
        console.log("Page not found in index " + a);
    if (indexB == -1)
        console.log("Page not found in index " + b);

    if (indexA < indexB)
        return -1;
    if (indexA > indexB)
        return 1;

    return 0;
}

function sidebarOrder() {
    return [
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
      ch19Sidebar(),
      ch20Sidebar(),
    ];
}

function ch20Sidebar() {
  return {
    title: "Qt for MCUs",
    path: '/ch20-qtformcu/qtformcu',
    collapsable: false,
    children: [
      '/ch20-qtformcu/qtformcu',
      '/ch20-qtformcu/setup',
      '/ch20-qtformcu/helloworld',
      '/ch20-qtformcu/cpp',
      '/ch20-qtformcu/models',
      '/ch20-qtformcu/summary',
    ]
  }
}

function ch19Sidebar() {
  return {
    title: "Qt for Python",
    path: '/ch19-python/qt-python',
    collapsable: false,
    children: [
      '/ch19-python/qt-python',
      '/ch19-python/introduction',
      '/ch19-python/installing',
      '/ch19-python/build-app',
      '/ch19-python/limitations',
      '/ch19-python/summary',
    ]
  }
}

function ch18Sidebar() {
  return {
    title: "Extending QML",
    path: '/ch18-extensions/extending-qml',
    collapsable: false,
    children: [
      '/ch18-extensions/extending-qml',
      '/ch18-extensions/qml-runtime',
      '/ch18-extensions/plugin-content',
      '/ch18-extensions/create-plugin',
      '/ch18-extensions/fileio-demo',
      '/ch18-extensions/using-fileio',
      '/ch18-extensions/summary',
    ]
  }
}

function ch17Sidebar() {
  return {
    title: "Qt C++",
    path: '/ch17-qtcpp/qtcpp',
    collapsable: false,
    children: [
      '/ch17-qtcpp/qtcpp',
      '/ch17-qtcpp/boilerplate',
      '/ch17-qtcpp/qobject',
      '/ch17-qtcpp/build-system',
      '/ch17-qtcpp/common-classes',
      '/ch17-qtcpp/cpp-models',
    ]
  }
}

function ch16Sidebar() {
  return {
    title: "Javascript",
    path: '/ch16-javascript/javascript',
    collapsable: false,
    children: [
      '/ch16-javascript/javascript',
      '/ch16-javascript/html-qml',
      '/ch16-javascript/js-language',
      '/ch16-javascript/js-objects',
      '/ch16-javascript/js-console',
    ]
  }
}

function ch15Sidebar() {
  return {
    title: "Dynamic QML",
    path: '/ch15-dynamicqml/dynamic-qml',
    collapsable: false,
    children: [
      '/ch15-dynamicqml/dynamic-qml',
      '/ch15-dynamicqml/loading-components',
      '/ch15-dynamicqml/dynamic-objects',
      '/ch15-dynamicqml/tracking-objects',
      '/ch15-dynamicqml/summary',
    ]
  }
}

function ch14Sidebar() {
  return {
    title: "Storage",
    path: '/ch14-storage/storage',
    collapsable: false,
    children: [
      '/ch14-storage/storage',
      '/ch14-storage/settings',
      '/ch14-storage/local-storage',
    ]
  }
}

function ch13Sidebar() {
  return {
    title: "Networking",
    path: '/ch13-networking/networking',
    collapsable: false,
    children: [
      '/ch13-networking/networking',
      '/ch13-networking/serve-qml',
      '/ch13-networking/templates',
      '/ch13-networking/http-requests',
      '/ch13-networking/local-files',
      '/ch13-networking/rest-api',
      '/ch13-networking/authentication',
      '/ch13-networking/web-sockets',
      '/ch13-networking/summary',
    ]
  }
}

function ch12Sidebar() {
  return {
    title: "Qt Quick 3D",
    path: '/ch12-qtquick3d/intro',
    collapsable: false,
    children: [
      '/ch12-qtquick3d/intro',
      '/ch12-qtquick3d/basics',
      '/ch12-qtquick3d/assets',
      '/ch12-qtquick3d/materials-and-light',
      '/ch12-qtquick3d/animations',
      '/ch12-qtquick3d/mixing-2d-and-3d',
      '/ch12-qtquick3d/summary',
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
      '/ch11-multimedia/summary',
    ]
  }
}

function ch10Sidebar() {
  return {
    title: "Effects",
    path: '/ch10-effects/effects',
    collapsable: false,
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
    title: "Shapes",
    path: '/ch09-shapes/shapes',
    collapsable: false,
    children: [
      '/ch09-shapes/shapes',
      '/ch09-shapes/basics',
      '/ch09-shapes/paths',
      '/ch09-shapes/gradients',
      '/ch09-shapes/animations',
      '/ch09-shapes/summary',
    ]
  }
}

function ch08Sidebar() {
  return {
    title: "Canvas",
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
    title: "QtQuick Controls",
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
    title: "Fluid Elements",
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
    title: "Quick Starter",
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
    title: "Qt Creator IDE",
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
    title: "Getting Started",
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
    title: "Meet Qt",
    path: '/ch01-meetqt/meet-qt',
    collapsable: false,
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
    collapsable: false,
    children: [
      '/preface/preface',
      '/preface/acknowledgements',
      '/preface/authors',
    ]
  }
}
