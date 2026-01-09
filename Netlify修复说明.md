# Netlify 404 错误修复

## 问题原因

Netlify Drop 需要文件名为 `index.html` 才能作为主页显示。

## 解决方案

### 方法 1：重新上传（推荐）

1. **访问 Netlify Drop**：https://app.netlify.com/drop

2. **确保文件名是 `index.html`**
   - 如果上传的是 `webview_test.html`，需要重命名为 `index.html`

3. **重新拖拽上传 `index.html` 文件**

4. **等待部署完成**，会生成新的链接

---

### 方法 2：使用 GitHub Pages（更稳定）

如果 Netlify 一直有问题，可以用 GitHub Pages：

1. **访问**：https://github.com/new
2. **创建仓库**（Public）
3. **上传 `index.html`**（确保文件名是 `index.html`）
4. **Settings → Pages → 启用**
5. **获得永久链接**：`https://你的用户名.github.io/仓库名/`

---

### 方法 3：检查当前文件

确保你上传的文件：
- ✅ 文件名是 `index.html`（不是 `webview_test.html`）
- ✅ 文件内容完整
- ✅ 文件大小不为 0

---

## 快速修复

如果你有 `index.html` 文件，直接重新上传到 Netlify Drop 即可。
