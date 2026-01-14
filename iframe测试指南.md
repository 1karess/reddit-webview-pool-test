# iframe隐私泄漏风险测试指南

## 📋 概述

本指南提供了5个场景的测试方法，用于验证Reddit WebView Pool在iframe嵌套场景下是否会导致跨账号数据残留和隐私泄漏。

---

## 🎯 测试前准备

### 1. 准备测试环境

- ✅ Reddit Android App（已安装）
- ✅ 两个不同的Reddit账号（账号A和账号B）
- ✅ 测试页面文件（已创建）
- ✅ 能够访问测试页面的方式（如通过Reddit的DevPlatform或WebView）

### 2. 部署测试页面

**方法A：使用GitHub Pages（推荐）**
```bash
# 将所有测试页面上传到GitHub仓库
# 通过GitHub Pages访问
# 例如：https://yourusername.github.io/reddit-code/iframe测试-场景1-同源iframe共享存储.html
```

**方法B：使用本地服务器**
```bash
# 使用Python启动本地服务器
python3 -m http.server 8000

# 在Reddit App中访问
# http://your-computer-ip:8000/iframe测试-场景1-同源iframe共享存储.html
```

**方法C：直接使用文件路径**
- 如果Reddit App支持加载本地文件，可以直接使用文件路径

---

## 🧪 场景1：同源iframe共享存储

### 测试目标
验证同源iframe是否能访问父页面的localStorage

### 测试步骤

1. **在Reddit App的WebView中打开测试页面**
   - 打开：`iframe测试-场景1-同源iframe共享存储.html`

2. **账号A操作**
   - 点击"账号A：写入测试数据"按钮
   - 点击"读取父页面数据"，确认数据已写入
   - 点击"读取iframe数据"，查看iframe是否能看到数据

3. **切换到账号B**
   - 在Reddit App中退出账号A
   - 登录账号B

4. **账号B验证**
   - 刷新测试页面（或重新打开）
   - 点击"读取iframe数据"
   - **检查：iframe是否仍能看到账号A的数据**

### 预期结果

**如果存在风险：**
- ✅ iframe能看到账号A写入的`test_account_A`数据
- ✅ 说明同源iframe共享localStorage，存在跨账号数据残留

**如果安全：**
- ❌ iframe看不到账号A的数据
- ❌ 说明账号切换时localStorage被正确清理

### 记录结果
- [ ] 是否发现跨账号数据残留？
- [ ] 截图或数据证据

---

## 🧪 场景2：跨源iframe存储残留

### 测试目标
验证跨源iframe的localStorage是否会在账号切换后残留

### 测试步骤

1. **在Reddit App的WebView中打开测试页面**
   - 打开：`iframe测试-场景2-跨源iframe存储残留.html`

2. **账号A操作**
   - 点击"账号A：让第三方iframe写入数据"按钮
   - 点击"读取第三方iframe数据"，确认数据已写入

3. **切换到账号B**
   - 在Reddit App中退出账号A
   - 登录账号B

4. **账号B验证**
   - 刷新测试页面
   - 点击"读取第三方iframe数据"
   - **检查：第三方iframe是否仍能看到账号A的数据**

### 预期结果

**如果存在风险：**
- ✅ 第三方iframe能看到账号A写入的数据
- ✅ 说明跨源iframe的localStorage在账号切换后残留

**如果安全：**
- ❌ 第三方iframe看不到账号A的数据
- ❌ 说明账号切换时iframe的localStorage被正确清理

### 记录结果
- [ ] 是否发现跨账号数据残留？
- [ ] 截图或数据证据

---

## 🧪 场景3：window.name泄露给iframe

### 测试目标
验证iframe是否能访问父页面的window.name（bridgeContext）

### 测试步骤

1. **在Reddit App的WebView中打开测试页面**
   - 打开：`iframe测试-场景3-window.name泄露.html`

2. **账号A操作**
   - 点击"账号A：设置window.name（模拟bridgeContext）"按钮
   - 点击"读取父页面window.name"，确认数据已设置
   - 点击"读取iframe window.name"，查看iframe是否能访问

3. **切换到账号B**
   - 在Reddit App中退出账号A
   - 登录账号B

4. **账号B验证**
   - 刷新测试页面
   - 点击"读取iframe window.name"
   - **检查：iframe是否仍能看到账号A的window.name**

### 预期结果

**如果存在风险：**
- ✅ iframe能看到账号A的window.name（包含deviceId、userId、token等）
- ✅ 说明window.name泄露给iframe，存在跨账号数据残留

**如果安全：**
- ❌ iframe看不到账号A的window.name
- ❌ 说明账号切换时window.name被正确清理

### 记录结果
- [ ] 是否发现跨账号数据残留？
- [ ] 截图或数据证据

---

## 🧪 场景4：postMessage传递错误数据

### 测试目标
验证账号切换后，父页面是否仍会发送账号A的数据给iframe

### 测试步骤

1. **在Reddit App的WebView中打开测试页面**
   - 打开：`iframe测试-场景4-postMessage传递错误数据.html`

2. **账号A操作**
   - 点击"账号A：发送数据给iframe"按钮
   - 查看iframe收到的数据，确认是账号A的数据

3. **切换到账号B**
   - 在Reddit App中退出账号A
   - 登录账号B

4. **账号B验证**
   - 刷新测试页面
   - 点击"账号B：发送数据给iframe"
   - **检查：iframe是否收到账号A的数据（错误的数据）**

### 预期结果

**如果存在风险：**
- ✅ iframe收到账号A的数据（userId、token等）
- ✅ 说明父页面从localStorage读取了账号A的数据并发送给iframe
- ✅ 可能导致iframe用账号A的token发起请求

**如果安全：**
- ❌ iframe收到账号B的数据（或空数据）
- ❌ 说明账号切换时localStorage被正确清理

### 记录结果
- [ ] 是否发现跨账号数据残留？
- [ ] 截图或数据证据

---

## 🧪 场景5：Cookie共享跨账号认证

### 测试目标
验证同源iframe是否能使用父页面的Cookie，导致跨账号认证

### 测试步骤

1. **在Reddit App的WebView中打开测试页面**
   - 打开：`iframe测试-场景5-Cookie共享跨账号认证.html`

2. **账号A操作**
   - 点击"账号A：设置Cookie"按钮
   - 点击"读取父页面Cookie"，确认Cookie已设置
   - 点击"读取iframe Cookie"，查看iframe是否能看到Cookie
   - 点击"让iframe发送请求（携带Cookie）"，查看请求结果

3. **切换到账号B**
   - 在Reddit App中退出账号A
   - 登录账号B

4. **账号B验证**
   - 刷新测试页面
   - 点击"读取iframe Cookie"
   - 点击"让iframe发送请求（携带Cookie）"
   - **检查：iframe是否仍能使用账号A的Cookie**

### 预期结果

**如果存在风险：**
- ✅ iframe能看到账号A的Cookie（session_id、auth_token等）
- ✅ iframe使用账号A的Cookie发送请求
- ✅ 可能导致服务器误认为是账号A的请求，导致权限混乱

**如果安全：**
- ❌ iframe看不到账号A的Cookie
- ❌ 说明账号切换时Cookie被正确清理

### 记录结果
- [ ] 是否发现跨账号数据残留？
- [ ] 截图或数据证据

---

## 📊 测试结果汇总

### 测试结果表格

| 场景 | 测试时间 | 账号A | 账号B | 是否发现风险 | 证据 |
|------|---------|-------|-------|-------------|------|
| 场景1：同源iframe共享存储 | | | | | |
| 场景2：跨源iframe存储残留 | | | | | |
| 场景3：window.name泄露 | | | | | |
| 场景4：postMessage错误数据 | | | | | |
| 场景5：Cookie共享认证 | | | | | |

### 风险评估

**高风险场景：**
- 如果多个场景都发现跨账号数据残留，说明WebView Pool存在严重的安全问题

**中风险场景：**
- 如果部分场景发现风险，需要进一步分析影响范围

**低风险场景：**
- 如果没有发现风险，说明当前实现相对安全（但仍需持续监控）

---

## 🔧 故障排除

### 问题1：无法在Reddit App中打开测试页面

**解决方案：**
- 确保测试页面可以通过URL访问（使用GitHub Pages或本地服务器）
- 检查Reddit App是否允许加载外部URL
- 尝试通过Reddit的DevPlatform功能加载测试页面

### 问题2：iframe无法加载

**解决方案：**
- 检查iframe的src路径是否正确
- 确保iframe内容文件与主页面在同一目录
- 检查浏览器控制台是否有错误信息

### 问题3：postMessage无法通信

**解决方案：**
- 确保父页面和iframe使用相同的origin（同源iframe）
- 检查postMessage的目标origin设置（`*`表示允许所有origin）
- 检查浏览器控制台是否有错误信息

### 问题4：无法切换账号

**解决方案：**
- 确保Reddit App支持多账号切换
- 尝试完全退出App后重新登录
- 检查账号切换是否真的生效

---

## 📝 测试报告模板

```markdown
# iframe隐私泄漏风险测试报告

## 测试信息
- 测试时间：YYYY-MM-DD HH:MM
- 测试环境：Reddit App版本 X.X.X
- 测试账号A：username_A
- 测试账号B：username_B

## 测试结果

### 场景1：同源iframe共享存储
- 结果：[发现风险 / 未发现风险]
- 证据：[截图或数据]

### 场景2：跨源iframe存储残留
- 结果：[发现风险 / 未发现风险]
- 证据：[截图或数据]

### 场景3：window.name泄露
- 结果：[发现风险 / 未发现风险]
- 证据：[截图或数据]

### 场景4：postMessage错误数据
- 结果：[发现风险 / 未发现风险]
- 证据：[截图或数据]

### 场景5：Cookie共享认证
- 结果：[发现风险 / 未发现风险]
- 证据：[截图或数据]

## 结论
[总结测试结果，评估风险等级，提出修复建议]
```

---

## ✅ 完成测试检查清单

- [ ] 场景1测试完成
- [ ] 场景2测试完成
- [ ] 场景3测试完成
- [ ] 场景4测试完成
- [ ] 场景5测试完成
- [ ] 测试结果已记录
- [ ] 测试报告已生成

---

## 📚 相关文档

- [Reddit WebView vs Chrome 本质区别分析](./Reddit_WebView_vs_Chrome_本质区别分析.md)
- [WebView Pool 测试结果](./完整测试原理和结果分析.md)
