const { app, BrowserWindow, shell } = require('electron');
const path = require('path');
const isDev = process.env.ELECTRON_IS_DEV === '1';
function createWindow() {
  const win = new BrowserWindow({ width: 1280, height: 800, webPreferences: { contextIsolation: true } });
  if (isDev) win.loadURL('http://localhost:3000'); else win.loadFile(path.join(__dirname, '..', 'frontend', 'out', 'index.html'));
  win.webContents.setWindowOpenHandler(({ url }) => { shell.openExternal(url); return { action: 'deny' }; });
}
app.whenReady().then(createWindow);
app.on('window-all-closed', () => { if (process.platform !== 'darwin') app.quit(); });
