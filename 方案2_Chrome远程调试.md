# 方案 2：使用 Chrome DevTools 远程调试（更简单，无需 Frida）

## ✅ 优点
- **不需要 Frida**，避免崩溃问题
- **更稳定**，Chrome DevTools 是官方工具
- **可以直接查看 localStorage、Cookie、IndexedDB**
- **实时监控**，就像调试网页一样

## 📋 前提条件
- 手机已连接（✅ 已完成）
- Chrome 浏览器（Mac 上）
- Android 7.0+（你的手机是 Android 15，完全支持）

---

## 步骤 1：在手机上启用 WebView 调试

### 方法 A：通过代码（如果 App 支持）
Reddit App 可能已经开启了，先试试直接连接。

### 方法 B：通过 adb 命令
```bash
adb shell "echo persist.webview.debugging=1 >> /data/local/tmp/webview_debug.conf"
```

---

## 步骤 2：在 Mac 上打开 Chrome

1. 打开 Chrome 浏览器
2. 在地址栏输入：`chrome://inspect`
3. 勾选 "Discover USB devices"

---

## 步骤 3：在手机上打开 Reddit App 的 WebView

1. 打开 Reddit App
2. 进入包含 WebView 的页面（比如某个帖子里的链接）

---

## 步骤 4：在 Chrome 中查看

在 `chrome://inspect` 页面，你应该能看到：
- 一个 "WebView" 条目
- 点击 "inspect" 按钮

---

## 步骤 5：测试 WebStorage 残留

在打开的 DevTools 中：

1. **打开 Console**，输入：
```javascript
// 写入测试数据
localStorage.setItem('test_account_A', 'account_A_data_' + Date.now());

// 查看所有 localStorage
console.log('localStorage:', localStorage);

// 查看所有 Cookie
console.log('Cookies:', document.cookie);
```

2. **切换到账号 B**，再次打开 WebView

3. **再次打开 DevTools**，检查：
```javascript
// 检查是否还有账号 A 的数据
console.log('localStorage:', localStorage);
console.log('test_account_A:', localStorage.getItem('test_account_A'));
```

---

## 如果看不到 WebView

如果 `chrome://inspect` 看不到 WebView，可能需要：

1. **检查 App 是否启用了调试**：
```bash
adb shell "cat /data/local/tmp/webview_debug.conf"
```

2. **或者使用 adb 转发端口**：
```bash
adb forward tcp:9222 localabstract:chrome_devtools_remote
```

然后在 Chrome 访问：`http://localhost:9222`

---

## 优势对比

| 功能 | Frida | Chrome DevTools |
|------|-------|-----------------|
| 稳定性 | ❌ 可能崩溃 | ✅ 非常稳定 |
| 易用性 | ⚠️ 需要脚本 | ✅ 图形界面 |
| 查看 Storage | ✅ | ✅ |
| 实时监控 | ✅ | ✅ |
| 需要 Root | ❌ | ❌ |

---

## 推荐方案

**先用 Chrome DevTools 测试**，如果能看到 WebView 并成功测试，就不需要 Frida 了。

如果 Chrome DevTools 看不到 WebView（可能 App 禁用了调试），我们再考虑修复 Frida 的问题。
