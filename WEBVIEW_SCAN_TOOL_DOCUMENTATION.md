# WebView 静态扫描工具完整文档

## 概述

`webview_scan.py` 是一个用于静态分析 Android 应用代码的扫描工具，专门检测 WebView 相关的自定义 API 和隐私合规风险点。该工具通过扫描反编译后的 Java/Kotlin 源代码，识别所有与 WebView 相关的 API 暴露点、JavaScript 注入点、资源拦截点和标准回调改写点。

## 功能特性

### 核心检测能力

工具实现了**5条完整验收标准**，确保全面覆盖所有 WebView API 相关检测点：

1. **✅ addJavascriptInterface 注册点检测**
   - 检测所有 `addJavascriptInterface` 调用
   - 提取 bridge 对象名和实现类
   - 记录注册位置

2. **✅ @JavascriptInterface 方法归档**
   - 检测所有带有 `@JavascriptInterface` 注解的方法
   - 按 bridge 对象名自动归档
   - 提取完整方法签名（参数、返回类型、异常）

3. **✅ JS 注入点检测**
   - `evaluateJavascript` 调用
   - `loadUrl("javascript:...")` 调用
   - `loadDataWithBaseURL` HTML/JS 注入
   - 提取注入的 JavaScript 代码

4. **✅ 资源拦截点检测**
   - `shouldInterceptRequest` 方法重写
   - `WebResourceResponse` 构造
   - 检测自定义响应构造逻辑

5. **✅ WebViewClient/WebChromeClient 改写点检测**
   - 检测 `extends WebViewClient` 的类
   - 检测 `extends WebChromeClient` 的类
   - 检测匿名类改写（`new WebViewClient() {...}`）
   - 检测 `setWebViewClient` / `setWebChromeClient` 调用点
   - 检测 `setDownloadListener` 调用点（匿名类改写）

### 混淆代码检测

工具能够检测混淆后的代码，即使类名被混淆成单字母（如 `a`, `b`, `j`），也能通过系统API调用特征找到：

- **检测原理**：虽然类名和方法名被混淆，但系统API调用（如 `addJavascriptInterface(new a(), "RedditBridge")`）和注解（如 `@JavascriptInterface`）是变不了的
- **检测方法**：
  - 通过系统API调用检测：`addJavascriptInterface` 调用识别混淆的类
  - 通过注解检测：`@JavascriptInterface` 识别混淆的方法

## 检测规则

### 高优先级规则（HIGH_SIGNAL_RULES）

| 规则ID | API名称 | 检测内容 | 分类 |
|--------|---------|----------|------|
| `addJavascriptInterface` | WebView.addJavascriptInterface | JS bridge 注册 | bridge |
| `removeJavascriptInterface` | WebView.removeJavascriptInterface | Bridge 移除 | bridge |
| `javascriptInterfaceAnnotation` | @JavascriptInterface | JS 可调用方法 | bridge |
| `evaluateJavascript` | WebView.evaluateJavascript | JS 注入执行 | js_injection |
| `loadUrlJavascript` | WebView.loadUrl("javascript:...") | JS URL scheme 注入 | js_injection |
| `javascriptSchemeString` | "javascript:" 字符串 | JS 注入载荷 | js_injection |
| `loadDataWithBaseURL` | WebView.loadDataWithBaseURL | HTML/JS 内联注入 | js_injection |
| `shouldInterceptRequest` | WebViewClient.shouldInterceptRequest | 资源拦截 | resource_interception |
| `webResourceResponse` | WebResourceResponse | 自定义响应构造 | resource_interception |
| `shouldOverrideUrlLoading` | WebViewClient.shouldOverrideUrlLoading | 导航拦截 | standard_callback |
| `onPageFinished` | WebViewClient.onPageFinished | 页面加载完成钩子 | standard_callback |
| `webChromeClientOrPrompt` | WebChromeClient / onJsPrompt | 替代 JS bridge 通道 | standard_callback |
| `setWebViewClient` | WebView.setWebViewClient | 自定义 WebViewClient 注册 | standard_callback |
| `setWebChromeClient` | WebView.setWebChromeClient | 自定义 WebChromeClient 注册 | standard_callback |
| `setDownloadListener` | WebView.setDownloadListener | 自定义 DownloadListener 注册 | standard_callback |

### 自定义 Bridge 检测规则

工具还包含针对 Reddit 特定 bridge 对象的检测规则：

- `customBridgeNameDEVVIT`: 检测 `"__DEVVIT__"` bridge 对象
- `customBridgeNameAndroidBridge`: 检测 `"AndroidBridge"` bridge 对象
- `customBridgeNameAdsWebViewDownloadHandler`: 检测 `"AdsWebViewDownloadHandler"` bridge 对象
- `customBridgeMethodPostMessage`: 检测 `postMessage` 方法调用

## API 分类体系

工具将所有检测到的 API 按以下4类进行分类：

1. **js_bridge**: JavaScript Bridge API
   - `addJavascriptInterface` 注册
   - `@JavascriptInterface` 方法
   - 自定义 bridge 对象名和方法

2. **js_injection**: JavaScript 注入 API
   - `evaluateJavascript` 调用
   - `loadUrl("javascript:...")` 调用
   - `loadDataWithBaseURL` HTML/JS 注入

3. **resource_interception**: 资源拦截 API
   - `shouldInterceptRequest` 重写
   - `WebResourceResponse` 构造

4. **standard_callback**: 标准回调改写
   - `shouldOverrideUrlLoading` 重写
   - `onPageFinished` 重写
   - `setWebViewClient` / `setWebChromeClient` 调用
   - `setDownloadListener` 调用

## 使用方法

### 基本用法

```bash
python3 tools/webview_scan.py --root sources --out webview-scan --app-package com/reddit
```

### 参数说明

- `--root <path>`: 要扫描的根目录（反编译后的 APK 源代码目录），默认为当前目录
- `--out <base_path>`: 输出文件的基础路径（不含扩展名），默认 `webview-scan`
  - 会生成 `<base_path>.json` 和 `<base_path>.md` 两个文件
- `--app-package <prefix>`: 应用包名前缀过滤，只扫描指定包路径下的代码，例如 `com/reddit`
- `--include-low-signal`: 包含低优先级信号规则（WebSettings 风险标志等）
- `--signals <list>`: 信号级别过滤，逗号分隔，例如 `high,medium`
- `--auto-discover`: 自动发现自定义 API（用于扫描其他 APP）
- `--analyze-usage`: 分析 API 的调用位置（会显著增加扫描时间）

### 扫描其他 APP

使用 `--auto-discover` 参数可以自动发现目标 APP 的自定义 API，无需手动配置规则：

```bash
# 扫描 TikTok
python3 tools/webview_scan.py \
    --root sources \
    --out tiktok-scan \
    --app-package com/tiktok \
    --auto-discover
```

**工作流程**：
1. **Phase 1**：使用通用规则扫描（排除 Reddit 特定的 custom 规则）
2. **Phase 2**：从扫描结果中自动发现自定义 bridge 对象名和方法名
3. **Phase 3**：使用发现的规则重新扫描

### 分析 API 调用关系

使用 `--analyze-usage` 参数可以分析 API 的调用位置：

```bash
python3 tools/webview_scan.py \
    --root sources \
    --out webview-scan \
    --app-package com/reddit \
    --analyze-usage
```

**功能说明**：
1. **Native 调用查找**：在 Java 代码中查找方法调用（排除定义行）
2. **JS 调用查找**：在注入的 JavaScript 代码中查找方法调用
3. **调用信息记录**：记录调用位置、调用类型、调用次数

**注意**：启用此选项会显著增加扫描时间（需要遍历所有 Java 文件）

## 输出文件

### JSON 输出 (`webview-scan.json`)

包含完整的结构化数据：

```json
{
  "meta": {
    "generated_at": "2025-12-29T17:08:56-08:00",
    "root": "/path/to/sources",
    "finding_count": 100,
    "bridge_objects_count": 3,
    "overridden_methods_count": 14,
    "obfuscation_stats": {
      "total_obfuscated_apis": 4,
      "obfuscated_bridge_objects": 4,
      "obfuscated_bridge_methods": 0
    },
    "api_categories": {
      "js_bridge": 34,
      "js_injection": 11,
      "resource_interception": 13,
      "standard_callback": 28
    }
  },
  "findings": [...],
  "bridge_objects": {...},
  "overridden_standard_methods": [...]
}
```

### Markdown 输出 (`webview-scan.md`)

人类可读的报告，包含：
- 规则命中统计
- 混淆检测统计
- 结果明细表
- 代码片段（包含混淆标记）

## 核心功能实现

### 1. Bridge 对象名提取

工具通过以下方式提取 bridge 对象名：

1. 从 `addJavascriptInterface(object, "bridgeName")` 调用中提取字符串字面量
2. 通过实现类名关联（建立类名到 bridge 对象名的映射）
3. 从 JavaScript 代码中提取 bridge 对象调用

### 2. 方法签名提取

对于 `@JavascriptInterface` 方法，工具提取：
- 方法名
- 参数列表（类型和名称）
- 返回类型
- 异常声明

支持多行方法定义和注解分离的情况。

### 3. 标准方法重写检测

工具检测以下标准 Android WebView API 的重写：

**WebViewClient 标准方法：**
- `onPageStarted`
- `onPageFinished`
- `shouldOverrideUrlLoading`
- `shouldInterceptRequest`
- `onReceivedError`
- `onCreateWindow`

**WebChromeClient 标准方法：**
- `onProgressChanged`
- `onConsoleMessage`
- `getDefaultVideoPoster`
- `onShowFileChooser`
- `onPermissionRequest`

检测逻辑：
- 检测 `extends WebViewClient` / `extends WebChromeClient` 的类
- 检测匿名类 `new WebViewClient() {...}`
- 检测 `@Override` 注解
- 检查方法体是否有自定义逻辑（非仅 `super.xxx()` 调用）

### 4. 混淆代码检测

工具能够检测混淆后的代码：

- **类名混淆检测**：识别单字母或短名称的混淆类（如 `a`, `b`, `j`）
- **方法名混淆检测**：识别单字母方法名（如 `b()`, `c()`）
- **检测方法**：
  - 通过系统API调用：`addJavascriptInterface(new a(), "RedditBridge")` 中的系统API调用是固定的
  - 通过注解：`@JavascriptInterface` 注解是固定的

### 5. WebView 配置提取

工具提取每个 WebView 实例的配置信息：
- `setJavaScriptEnabled(true/false)`
- `setDomStorageEnabled(true/false)`
- `setMediaPlaybackRequiresUserGesture(true/false)`
- 其他 WebSettings 配置

### 6. JavaScript 代码提取

对于 JS 注入点，工具提取：
- `evaluateJavascript` 中的 JavaScript 代码
- `loadDataWithBaseURL` 中的 HTML/JS 内容
- 从注入代码中提取 API 调用

## 统计逻辑

### API 去重统计

工具按 `(类名, 方法名, 参数类型列表)` 去重统计，确保：
- 同一个方法在不同类中定义会算作不同的 API（正确行为）
- 同一个方法被多个规则匹配不会重复计数

### 混淆统计

工具统计混淆的 API 数量：
- 混淆的 bridge 对象数
- 混淆的 bridge 方法数
- 检测方法（system_api_call / annotation）

## 代码结构

### 主要函数

- `scan(root, include_low_signal, app_package_prefix)`: 主扫描函数
- `_find_overridden_standard_methods(root, app_package_prefix)`: 检测标准方法重写
- `_detect_obfuscated_bridge_via_system_api(...)`: 检测混淆的 bridge 对象
- `_detect_obfuscated_method_via_annotation(...)`: 检测混淆的方法
- `write_outputs(...)`: 生成输出文件
- `_extract_method_signature(lines, line_no)`: 提取方法签名
- `_extract_bridge_object_name(...)`: 提取 bridge 对象名
- `_extract_webview_config(lines, line_no, file_path)`: 提取 WebView 配置

### 数据类

- `Rule`: 检测规则定义
- `Finding`: 检测结果

## 依赖要求

- Python 3.7+
- `ripgrep` (rg) - 可选，用于加速文件搜索（如果未安装，会回退到 Python 正则搜索）

## 验收标准

工具满足以下5条完整验收标准：

1. ✅ **列出所有 addJavascriptInterface 注册点**（对象名、实现类）
2. ✅ **列出所有 @JavascriptInterface 方法**（按对象名归档）
3. ✅ **列出所有 JS 注入点**（evaluate/loadUrl javascript/loadDataWithBaseURL）
4. ✅ **列出所有资源拦截点**（shouldInterceptRequest + WebResourceResponse）
5. ✅ **列出所有 WebViewClient/WebChromeClient 改写点**（含匿名类）

## 输出验证

运行扫描后，可以使用以下命令验证结果：

```bash
python3 << 'EOF'
import json
data = json.load(open('webview-scan.json'))

# 验证5条标准
add_js_interface = [f for f in data['findings'] if f.get('rule_id') == 'addJavascriptInterface']
bridge_methods = [f for f in data['findings'] if f.get('code_facts', {}).get('api_type') == 'bridge_method']
js_injection = [f for f in data['findings'] if f.get('code_facts', {}).get('api_category') == 'js_injection']
resource_interception = [f for f in data['findings'] if f.get('code_facts', {}).get('api_category') == 'resource_interception']
overridden = data.get('overridden_standard_methods', [])

print(f"标准1: {len(add_js_interface)} 个注册点")
print(f"标准2: {len(bridge_methods)} 个方法，{len(data.get('bridge_objects', {}))} 个bridge对象")
print(f"标准3: {len(js_injection)} 个JS注入点")
print(f"标准4: {len(resource_interception)} 个资源拦截点")
print(f"标准5: {len(overridden)} 个改写点")

# 验证混淆检测
if 'obfuscation_stats' in data['meta']:
    print(f"混淆API: {data['meta']['obfuscation_stats']['total_obfuscated_apis']} 个")
EOF
```

## 注意事项

1. **扫描性能**: 对于大型代码库（如 84900+ Java 文件），扫描可能需要几分钟时间
2. **包名过滤**: 使用 `--app-package` 参数可以显著加速扫描，只扫描应用代码而非第三方库
3. **反编译质量**: 工具依赖反编译代码的质量，某些混淆或反编译错误可能影响检测准确性
4. **匿名类检测**: 匿名类检测基于代码模式匹配，可能无法覆盖所有复杂情况
5. **混淆检测**: 混淆检测基于命名模式和系统API调用特征，对于深度混淆可能需要进一步优化

## 更新日志

### 最新版本特性

- ✅ 添加混淆代码检测功能（通过系统API调用和注解特征）
- ✅ 添加 `setWebViewClient` / `setWebChromeClient` / `setDownloadListener` 检测
- ✅ 改进 bridge 对象名关联逻辑（通过实现类名映射）
- ✅ 完善 `bridge_objects` 结构，按对象名归档所有方法
- ✅ 改进匿名类检测逻辑（方法级别检查）
- ✅ 支持同时检测 WebViewClient 和 WebChromeClient 重写（同一文件中）
- ✅ 添加 `--auto-discover` 参数，自动发现自定义 API
- ✅ 添加 `--analyze-usage` 参数，分析 API 调用关系
- ✅ 修复统计逻辑，按类名+方法签名去重

## 相关文件

- `tools/webview_scan.py`: 主扫描工具
- `tools/standard_browser_apis.py`: 标准浏览器 API 基线定义
- `webview-scan.json`: 扫描结果 JSON
- `webview-scan.md`: 扫描结果 Markdown 报告




