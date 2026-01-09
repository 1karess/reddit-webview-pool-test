# GitHub Pages 部署指南

## 🚀 快速部署（3步）

### 第 1 步：创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称：`webview-pool-test`（或任何你喜欢的名字）
3. 选择 **Public**（GitHub Pages 免费版需要公开仓库）
4. **不要**勾选 "Initialize this repository with a README"
5. 点击 "Create repository"

### 第 2 步：上传文件

#### 方法 A：通过网页上传（最简单）

1. 在刚创建的仓库页面，点击 "uploading an existing file"
2. 把 `index.html` 文件拖进去
3. 点击 "Commit changes"

#### 方法 B：通过 Git 命令行

```bash
cd ~/Desktop/reddit-code
git init
git add index.html
git commit -m "Add WebView test page"
git branch -M main
git remote add origin https://github.com/你的用户名/webview-pool-test.git
git push -u origin main
```

### 第 3 步：启用 GitHub Pages

1. 在仓库页面，点击 **Settings**
2. 左侧菜单找到 **Pages**
3. 在 "Source" 下选择 **Deploy from a branch**
4. Branch 选择 **main**，文件夹选择 **/ (root)**
5. 点击 **Save**

### 第 4 步：获取访问链接

等待 1-2 分钟，GitHub Pages 会自动生成链接：

```
https://你的用户名.github.io/webview-pool-test/
```

例如：`https://karess.github.io/webview-pool-test/`

---

## ✅ 完成！

现在你可以在任何设备上访问这个链接了！

---

## 📱 在 Reddit App 中打开

### 方法 1：通过 adb 命令

```bash
adb shell am start -a android.intent.action.VIEW -d "https://你的用户名.github.io/webview-pool-test/"
```

### 方法 2：在 App 中手动输入

在 Reddit App 中找到可以输入 URL 的地方，输入你的 GitHub Pages 链接。

---

## 🔄 更新页面

如果需要更新测试页面：

1. 修改 `index.html`
2. 重新上传到 GitHub（或 `git push`）
3. 等待 1-2 分钟，GitHub Pages 会自动更新

---

## 💡 提示

- GitHub Pages 链接是 **HTTPS**，更安全
- 可以在任何设备、任何网络访问
- 完全免费
- 自动更新（上传后 1-2 分钟生效）

---

## 🆘 如果遇到问题

1. **404 错误**：等待 1-2 分钟，GitHub Pages 需要时间部署
2. **无法访问**：检查仓库是否是 Public
3. **需要帮助**：告诉我你的 GitHub 用户名，我可以帮你检查
