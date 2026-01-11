# 方案 1：在 Reddit 真实 DevPlatform 页面中检测 window.name

## 目标

在 Reddit App 的真实 DevPlatform 页面中检测 `window.name`（bridgeContext），看是否包含敏感信息，以及是否会在账号切换后残留。

---

## 方法 1：使用我们的测试页面（最简单）

### 步骤

1. **找到 Reddit App 中使用 WebView 的真实页面**
   - 某些 DevPlatform 帖子（包含交互式内容的帖子）
   - 某些设置页面
   - 某些嵌入式内容

2. **在该页面中想办法打开我们的测试链接**
   
   **方法 A：如果页面支持输入 URL**
   - 在页面中找到可以输入 URL 的地方
   - 输入：`https://1karess.github.io/reddit-webview-pool-test/`
   - 打开

   **方法 B：如果页面支持链接跳转**
   - 发个帖子，把测试链接贴进去
   - 点击链接打开

   **方法 C：通过 adb 命令**
   ```bash
   adb shell am start -a android.intent.action.VIEW -d "https://1karess.github.io/reddit-webview-pool-test/"
   ```

3. **在测试页面中检测**
   - 点击"🔍 检查 window.name"按钮
   - 查看是否检测到 bridgeContext
   - 点击"🔍 检测真实业务数据"按钮，查看完整报告

4. **切换到账号 B，重复步骤 2-3**
   - 看账号 B 是否能看到账号 A 的 window.name 数据

---

## 方法 2：直接在真实页面中执行 JavaScript（需要控制台）

### 步骤

1. **找到 Reddit App 的真实 DevPlatform 页面**

2. **如果页面支持开发者工具/控制台**：
   - 打开控制台
   - 执行以下代码：

```javascript
// 检测 window.name
console.log('=== window.name 检测 ===');
console.log('window.name:', window.name);

// 尝试解析为 JSON
if (window.name && window.name.trim() !== '') {
    try {
        const bridgeContext = JSON.parse(window.name);
        console.log('bridgeContext:', bridgeContext);
        console.log('webbitToken:', bridgeContext.webbitToken);
        console.log('signedRequestContext:', bridgeContext.signedRequestContext);
        console.log('postData:', bridgeContext.postData);
        console.log('webViewContext:', bridgeContext.webViewContext);
        console.log('webViewClientData:', bridgeContext.webViewClientData);
    } catch (e) {
        console.log('不是 JSON:', e.message);
    }
} else {
    console.log('window.name 为空');
}
```

3. **复制输出结果**

4. **切换到账号 B，重复步骤 2-3**

---

## 方法 3：创建一个可以注入到任何页面的检测脚本

### 步骤

1. **创建一个书签（Bookmarklet）**

   在浏览器中创建一个书签，URL 为：

```javascript
javascript:(function(){const w=window.name;console.log('window.name:',w);if(w&&w.trim()!==''){try{const bc=JSON.parse(w);console.log('bridgeContext:',bc);alert('bridgeContext found!\nwebbitToken: '+!!bc.webbitToken+'\nsignedRequestContext: '+!!bc.signedRequestContext);}catch(e){console.log('Not JSON:',e);}}else{alert('window.name is empty');}})();
```

2. **在 Reddit App 的 WebView 中打开真实 DevPlatform 页面**

3. **如果 WebView 支持书签功能，点击书签执行检测**

---

## 方法 4：修改测试页面，让它自动检测并显示 window.name

### 已实现 ✅

我们的测试页面已经包含了 window.name 检测功能：

1. **打开测试页面**：`https://1karess.github.io/reddit-webview-pool-test/`
2. **点击"🔍 检查 window.name"按钮**
3. **查看结果**

**注意**：如果是在我们的测试页面中检测，`window.name` 可能是空的（因为测试页面不是 Reddit 的 DevPlatform 页面）。需要在 Reddit 的真实 DevPlatform 页面中检测才能看到 bridgeContext。

---

## 推荐方案

**推荐使用方法 1（使用我们的测试页面）**，因为：

1. ✅ 最简单，不需要控制台
2. ✅ 有完整的检测报告
3. ✅ 可以复制 JSON 数据
4. ✅ 可以对比账号 A 和账号 B 的结果

---

## 测试流程

### 第 1 步：账号 A 测试

1. 在 Reddit App 中登录账号 A
2. 找到或打开一个真实的 DevPlatform 页面（使用 WebView 的页面）
3. 在该页面中打开测试链接：`https://1karess.github.io/reddit-webview-pool-test/`
4. 点击"🔍 检查 window.name"
5. 点击"🔍 检测真实业务数据"
6. 点击"📋 复制检测报告"，保存结果

### 第 2 步：切换到账号 B

1. 退出账号 A
2. 登录账号 B
3. 等待几秒，确保账号切换完成

### 第 3 步：账号 B 测试

1. 再次打开同一个测试链接（或同一个 DevPlatform 页面）
2. 点击"🔍 检查 window.name"
3. 点击"🔍 检测真实业务数据"
4. 点击"📋 复制检测报告"，保存结果

### 第 4 步：对比结果

对比账号 A 和账号 B 的报告：

- **如果账号 B 能看到账号 A 的 window.name（bridgeContext）**
  - 说明存在跨账号泄露风险
  - 特别是如果 bridgeContext 包含 `webbitToken`、`signedRequestContext` 等敏感信息

- **如果账号 B 看不到账号 A 的 window.name**
  - 说明 window.name 被正确清理了（或者使用了不同的 WebView 实例）

---

## 关键检查点

1. **window.name 是否为空？**
   - 如果为空，说明不在 Reddit 的 DevPlatform 页面中
   - 需要在真实的 DevPlatform 页面中检测

2. **bridgeContext 包含什么字段？**
   - `webbitToken` - 可能是认证 token
   - `signedRequestContext` - 可能包含签名/会话信息
   - `postData` - 可能包含用户创建的帖子数据
   - `webViewContext` - 可能包含上下文信息
   - `webViewClientData` - 可能包含客户端数据

3. **账号 B 是否能看到账号 A 的 window.name？**
   - 如果能，说明存在跨账号泄露风险

---

## 现在开始测试

1. 在 Reddit App 中找到真实的 DevPlatform 页面
2. 打开测试链接：`https://1karess.github.io/reddit-webview-pool-test/`
3. 点击"🔍 检查 window.name"按钮
4. 查看结果
