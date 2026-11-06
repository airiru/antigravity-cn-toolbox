// asar CLI 启动器：关闭 Electron 的 asar 内置支持后，再加载 @electron/asar 命令行。
// 目的：让打包工具把 app.asar 当普通文件读写，而不是当成“压缩包”去解析。
if (true) process.noAsar = true;

const path = require('path');
const { pathToFileURL } = require('url');

const cli = path.join(__dirname, 'node_modules', '@electron', 'asar', 'bin', 'asar.mjs');

import(pathToFileURL(cli).href).catch((err) => {
    console.error(err && err.stack ? err.stack : err);
    process.exit(1);
});
