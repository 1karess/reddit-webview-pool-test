## WebView Pool 跨账号数据泄露测试说明（中文总览）

### 目标
- 利用同一个测试页面，验证 **Reddit Android App 的 WebView Pool** 在账号切换后，是否会把前一个账号的 WebView 存储（localStorage / Cookie）泄露给后一个账号。
- 提供一套**可重复、可分享**的测试方法和分析结论。

---

## 一、测试页面与数据设计

测试页面地址（GitHub Pages）：

```text
https://1karess.github.io/reddit-webview-pool-test/
```

页面功能：
- 写入测试数据到：
  - `localStorage`
  - `sessionStorage`
  - `Cookie`
- 读取并展示当前所有存储数据
- 一键复制所有数据为 JSON，便于对比账号 A / B 的结果

写入逻辑（点击“写入测试数据”按钮时）：

```javascript
// localStorage：持久存储
localStorage.setItem('test_account_A', 'account_A_data');

// sessionStorage：会话级存储（关闭页面后会清空）
sessionStorage.setItem('test_account_A_session', 'account_A_data_session');

// Cookie：持久存储
document.cookie =
  'test_account_A_cookie=account_A_data_cookie; path=/; max-age=3600';
```

说明：
- 这些键值全部是**我们自定义的测试数据**，不是 Reddit 真实数据。
- 如果账号 B 能在自己的会话里读到这些键值，说明 **WebView 存储没有在账号切换时被清理 / 隔离**。

---

## 二、标准测试步骤

### 1. 准备
1. 确保测试设备上安装了 Reddit Android App。
2. 准备两个 Reddit 账号：**账号 A** 与 **账号 B**。
3. 保持手机网络正常。

### 2. 账号 A 测试
1. 打开 Reddit App，登录 **账号 A**。
2. 在 App 内打开测试页面链接：
   ```text
   https://1karess.github.io/reddit-webview-pool-test/
   ```
   - 可以通过 deeplink / 贴链接进某个帖子等方式打开，只要确保是在 Reddit 的 WebView 里加载即可。
3. 页面加载后：
   - 点击“✅ 写入测试数据”
   - 点击“📖 读取所有数据”，确认页面上出现：
     - `localStorage` 中有 `test_account_A = account_A_data`
     - `sessionStorage` 中有 `test_account_A_session = account_A_data_session`
     - `Cookie` 中有 `test_account_A_cookie = account_A_data_cookie`
4. 点击“📋 复制所有数据（JSON）”，把结果粘贴保存为：
   - `A_result.json`（或贴到 Reddit / 记事本中保存）

### 3. 切换到账号 B
1. 在 Reddit App 中退出账号 A。
2. 登录 **账号 B**。
3. 等待数秒，确保账号切换完成。

### 4. 账号 B 测试
1. 再次在 Reddit App 中打开同一个测试页面链接。
2. 页面加载后自动展示当前 `localStorage` / `sessionStorage` / `Cookie` 数据。
3. 点击“📋 复制所有数据（JSON）”，保存为：
   - `B_result.json`。

### 5. 对比结果
重点查看 `B_result.json` 中的 `localStorage` 与 `Cookie`：

- 如果包含：
  - `localStorage.test_account_A = "account_A_data"`
  - `Cookie.test_account_A_cookie = "account_A_data_cookie"`
  则说明 **账号 B 看到账号 A 的测试数据 → 存在跨账号数据残留风险**。

- 如果账号 B 的 JSON 中：
  - `localStorage` 为 `（空）`
  - `Cookie` 中没有 `test_account_A_cookie`
  则说明 **切换账号时存储被正确清理 / 隔离**。

`sessionStorage` 为空是正常现象（会话级，关闭页面后会自动清空）。

---

## 三、一次实际测试结果示例

### 账号 A（写入）

```json
{
  "localStorage": {
    "test_account_A": "account_A_data"
  },
  "sessionStorage": {
    "test_account_A_session": "account_A_data_session"
  },
  "Cookie": {
    "test_account_A_cookie": "account_A_data_cookie"
  }
}
```

### 账号 B（读取）

```json
{
  "localStorage": {
    "test_account_A": "account_A_data"
  },
  "sessionStorage": "（空）",
  "Cookie": {
    "test_account_A_cookie": "account_A_data_cookie"
  }
}
```

分析：
- `localStorage` 中的 `test_account_A` 残留 → 账号 B 看到了账号 A 的本地存储。
- `Cookie` 中的 `test_account_A_cookie` 残留 → 账号 B 看到了账号 A 的 Cookie。
- `sessionStorage` 为空 → 正常。

结论：
- WebView 的 **持久存储（localStorage / Cookie）在账号切换后没有被清理或隔离**。
- 如果实际业务页面在这些存储中放了敏感数据（如用户 ID / token 等），则有被同设备其它账号访问到的风险。

---

## 四、部署与更新（GitHub Pages）

仓库地址：

```text
https://github.com/1karess/reddit-webview-pool-test
```

### 首次部署（已完成）
1. 本地在 `~/Desktop/reddit-code` 下创建 `index.html`（测试页面）。
2. 初始化 git 仓库并提交：
   ```bash
   git init
   git add index.html *.md webview_test.html
   git commit -m "Add WebView pool test page and docs"
   git branch -M main
   git remote add origin https://github.com/1karess/reddit-webview-pool-test.git
   git push -u origin main
   ```
3. 在 GitHub 仓库 Settings → Pages：
   - Source 选择：`Deploy from a branch`
   - Branch：`main`
   - Folder：`/ (root)`
4. GitHub Pages 启动后，得到永久链接：
   ```text
   https://1karess.github.io/reddit-webview-pool-test/
   ```

### 更新页面
未来如果你要修改测试逻辑：

1. 在本地编辑 `index.html` 或相关 `.md` 说明。
2. 然后执行：
   ```bash
   cd ~/Desktop/reddit-code
   git add index.html *.md
   git commit -m "Update test page or docs"
   git push
   ```
3. 等 GitHub Pages 自动重新部署（约 1–2 分钟），同一个链接会自动更新。

---

## 五、辅助方案（Chromium 远程调试，选看）

如果需要从 WebView 侧进一步观察行为，还可以使用：

- `chrome://inspect` + Android 设备调试  
- 或 `adb logcat` 过滤 `WebView` / `chromium` 日志

这部分对验证“跨账号数据是否残留”不是必需，只在深入分析实现细节时才会用到。

---

## 六、如何写给官方的漏洞报告（提纲）

1. **标题**：Reddit Android – DevPlatform WebView Pool 跨账号数据残留（localStorage & Cookie 未隔离）
2. **影响范围**：同一设备上不同 Reddit 账号之间的 WebView 数据隔离。
3. **复现步骤**：引用本 README 中的“标准测试步骤”一节，并给出公共测试链接。
4. **预期行为**：账号切换后，新账号不应看到旧账号在 WebView 中留下的任何存储（localStorage / Cookie）。
5. **实际行为**：账号 B 能看到账号 A 写入的 `test_account_A` / `test_account_A_cookie` 等测试数据。
6. **安全影响**：如果业务页面在这些存储中保存了用户标识 / token / 敏感状态，则可能被同设备上的其他账号读取。
7. **建议修复方案**：
   - 账号切换时清理所有 WebView 实例的 localStorage 和 Cookie；
   - 或者为不同账号使用 `WebView.setDataDirectorySuffix()` 做数据目录隔离；
   - 复用 WebView（Pool）时，在 `releaseWebView` 阶段强制执行清理逻辑。

这一份 `README_zh.md` 即是所有中文说明的汇总，其余中文 `.md` 文件可以视为历史草稿，不再需要单独维护。

