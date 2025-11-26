/**************************************************************************************************/

import { viteBundler } from '@vuepress/bundler-vite'
import { defaultTheme } from '@vuepress/theme-default'
import { defineUserConfig } from 'vuepress'

import { markdownIncludePlugin } from '@vuepress/plugin-markdown-include'
import { markdownChartPlugin } from '@vuepress/plugin-markdown-chart'

// import PdfExportPlugin from '@e8johan/vuepress-plugin-pdf-export'
// Fixme: Cannot find module '@vuepress/shared-utils'
//   node_modules/@e8johan/vuepress-plugin-pdf-export/index.js
//     1:const { path } = require('@vuepress/shared-utils')
//   node_modules/@e8johan/vuepress-plugin-pdf-export/src/generatePdf.js
//     4:const { fs, logger, chalk } = require('@vuepress/shared-utils')
//   node_modules/@e8johan/vuepress-plugin-pdf-export/src/extendCli.js
//     2:const { logger, chalk, path } = require('@vuepress/shared-utils')

/**************************************************************************************************/

export default defineUserConfig({
    title: "The Qt 6 Book",
    description: "A book about QML",
    bundler: viteBundler(),
    plugins: [
        markdownIncludePlugin(),
        markdownChartPlugin({
            mermaid: true,
        }),
        // PdfExportPlugin({
        //     puppeteerLaunchOptions: { args: [ '--no-sandbox', '--disable-setuid-sandbox' ] },
        //     outputFileName: 'qt6book.pdf',
        //     sorter: (a, b) => { return pageSorter(a.relativePath, b.relativePath); },
        //     filter: (p) => { return pageFilter(p.relativePath); },
        //     tocLevel: (p) => { return tocLevel(p.relativePath); },
        //     frontPage: 'assets/frontpage.pdf',
        // }),
    ],
    theme: defaultTheme({
        // Config
        contributors: true,
        docsBranch: 'main',
        docsDir: 'docs',
        editLinks: true,
        lastUpdated: true,
        repo: 'qmlbook/qt6book',
        sidebar: sidebar(),

        // Local config
        editLinkText: 'Help us improve this page!',
        repoLabel: 'Contribute!',
    }),
})

/**************************************************************************************************/

function sidebar() {
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
    ]
}

function prefaceSidebar() {
    return {
        text: "Preface",
        prefix: 'preface',
        collapsible: false,
        children: [
            'preface',
            'acknowledgements',
            'authors',
        ]
    }
}

function ch01Sidebar() {
    return {
        text: "Meet Qt",
        prefix: 'ch01-meetqt',
        collapsible: false,
        children: [
            'meet-qt',
            'blocks',
            'intro',
        ]
    }
}

function ch02Sidebar() {
    return {
        text: "Getting Started",
        prefix: '/ch02-start',
        collapsible: false,
        children: [
            'quick-start',
            'install',
            'hello-world',
            'app-types',
            'summary',
        ]
    }
}

function ch03Sidebar() {
    return {
        text: "Qt Creator IDE",
        prefix: 'ch03-qtcreator',
        collapsible: false,
        children: [
            'qt-creator',
            'user-interface',
            'kit-registry',
            'projects',
            'editor',
            'locator',
            'debugging',
            'shortcuts',
        ]
    }
}

function ch04Sidebar() {
    return {
        text: "Quick Starter",
        prefix: 'ch04-qmlstart',
        collapsible: false,
        children: [
            'quick-start',
            'qml-syntax',
            'core-elements',
            'components',
            'transformations',
            'positioning',
            'layout',
            'input',
            'advanced',
        ]
    }
}

function ch05Sidebar() {
    return {
        text: "Fluid Elements",
        prefix: 'ch05-fluid',
        collapsible: false,
        children: [
            'fluid-elements',
            'animations',
            'states-transitions',
            'advanced',
        ]
    }
}

function ch06Sidebar() {
    return {
        text: "QtQuick Controls",
        prefix: 'ch06-controls',
        collapsible: false,
        children: [
            'controls2',
            'introduction',
            'image-viewer',
            'common-patterns',
            'imagine-style',
            'summary',
        ]
    }
}

function ch07Sidebar() {
    return {
        text: "Model View",
        prefix: 'ch07-modelview',
        collapsible: false,
        children: [
            'model-view',
            'concept',
            'basic-models',
            'dynamic-views',
            'delegate',
            'advanced',
            'summary',
        ]
    }
}

function ch08Sidebar() {
    return {
        text: "Canvas",
        prefix: 'ch08-canvas',
        collapsible: false,
        children: [
            'canvas-element',
            'convenience-api',
            'gradients',
            'shadows',
            'images',
            'transformation',
            'composition-modes',
            'pixel-buffer',
            'canvas-paint',
            'port-from-html',
        ]
    }
}

function ch09Sidebar() {
    return {
        text: "Shapes",
        prefix: 'ch09-shapes',
        collapsible: false,
        children: [
            'shapes',
            'basics',
            'paths',
            'gradients',
            'animations',
            'summary',
        ]
    }
}

function ch10Sidebar() {
    return {
        text: "Effects",
        prefix: 'ch10-effects',
        collapsible: false,
        children: [
            'effects',
            'particles',
            'simple-simulation',
            'particle-parameters',
            'directed-particles',
            'affecting-particles',
            'particle-groups',
            'particle-painters',
            'opengl-shaders',
            'shader-elements',
            'fragment-shaders',
            'wave-effect',
            'vertex-shader',
            'curtain-effect',
            'summary',
        ]
    }
}

function ch11Sidebar() {
    return {
        text: "Multimedia",
        prefix: 'ch11-multimedia',
        collapsible: false,
        children: [
            'multimedia',
            'playing-media',
            'sound-effects',
            'video-streams',
            'capturing-images',
            'summary',
        ]
    }
}

function ch12Sidebar() {
    return {
        text: "Qt Quick 3D",
        prefix: 'ch12-qtquick3d',
        collapsible: false,
        children: [
            'intro',
            'basics',
            'assets',
            'materials-and-light',
            'animations',
            'mixing-2d-and-3d',
            'summary',
        ]
    }
}

function ch13Sidebar() {
    return {
        text: "Networking",
        prefix: 'ch13-networking',
        collapsible: false,
        children: [
            'networking',
            'serve-qml',
            'templates',
            'http-requests',
            'local-files',
            'rest-api',
            'authentication',
            'web-sockets',
            'summary',
        ]
    }
}

function ch14Sidebar() {
    return {
        text: "Storage",
        prefix: 'ch14-storage',
        collapsible: false,
        children: [
            'storage',
            'settings',
            'local-storage',
        ]
    }
}

function ch15Sidebar() {
    return {
        text: "Dynamic QML",
        prefix: 'ch15-dynamicqml',
        collapsible: false,
        children: [
            'dynamic-qml',
            'loading-components',
            'dynamic-objects',
            'tracking-objects',
            'summary',
        ]
    }
}

function ch16Sidebar() {
    return {
        text: "Javascript",
        prefix: 'ch16-javascript',
        collapsible: false,
        children: [
            'javascript',
            'html-qml',
            'js-language',
            'js-objects',
            'js-console',
        ]
    }
}

function ch17Sidebar() {
    return {
        text: "Qt C++",
        prefix: 'ch17-qtcpp',
        collapsible: false,
        children: [
            'qtcpp',
            'boilerplate',
            'qobject',
            'build-system',
            'common-classes',
            'cpp-models',
        ]
    }
}

function ch18Sidebar() {
    return {
        text: "Extending QML",
        prefix: 'ch18-extensions',
        collapsible: false,
        children: [
            'extending-qml',
            'qml-runtime',
            'plugin-content',
            'create-plugin',
            'fileio-demo',
            'using-fileio',
            'summary',
        ]
    }
}

function ch19Sidebar() {
    return {
        text: "Qt for Python",
        prefix: 'ch19-python',
        collapsible: false,
        children: [
            'qt-python',
            'introduction',
            'installing',
            'build-app',
            'limitations',
            'summary',
        ]
    }
}

function ch20Sidebar() {
    return {
        text: "Qt for MCUs",
        prefix: 'ch20-qtformcu',
        collapsible: false,
        children: [
            'qtformcu',
            'setup',
            'helloworld',
            'cpp',
            'models',
            'summary',
        ]
    }
}

/**************************************************************************************************/

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
