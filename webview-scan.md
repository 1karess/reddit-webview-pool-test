# WebView 自定义 API 扫描报告

## 说明

本报告扫描的是 **Reddit 自定义的 WebView API**，包括：

1. **自定义桥接对象名**：Reddit 通过 `addJavascriptInterface` 注册的自定义对象名（如 `__DEVVIT__`、`AndroidBridge`）
2. **自定义桥接方法**：Reddit 定义的、带有 `@JavascriptInterface` 注解的方法（如 `postMessage`、`onAnchorLinkClicked`）

**为什么是自定义的？**
- 这些 API 名称不是 Android 标准 WebView API 的一部分
- 它们是 Reddit 开发者自己定义的，用于在 JavaScript 和 Native 代码之间通信

**为什么与 WebView 相关？**
- 自定义桥接对象名：通过 `addJavascriptInterface(对象, "对象名")` 注册到 WebView
- 自定义桥接方法：带有 `@JavascriptInterface` 注解，通过桥接对象暴露给 JavaScript 调用

**混淆代码检测**
- 本工具能够检测混淆后的代码，即使类名被混淆成 `a`、方法名被混淆成 `b`
- 检测原理：虽然类名和方法名被混淆，但系统API调用（如 `addJavascriptInterface`）和注解（如 `@JavascriptInterface`）是变不了的
- 通过系统API调用特征可以"顺藤摸瓜"找到混淆后的bridge对象和方法
- 例如：`webView.addJavascriptInterface(new a(), "RedditBridge")` 即使类名是 `a`，也能通过系统API调用检测到

---

- **generated_at**: `2026-01-06T16:08:39-08:00`
- **root**: `/Users/karess/Desktop/reddit-code/sources`
- **finding_count**: `142`
- **rg_available**: `False`
- **app_package_filter**: `com/reddit` (只扫描此路径下的代码)

### 混淆检测统计
- **检测到混淆的API总数**: `2`
- **混淆的bridge对象**: `2`
- **混淆的bridge方法**: `0`

## 规则命中统计

| rule_id | count |
|---|---:|
| `cookieManagerOps` | 18 |
| `webChromeClientOrPrompt` | 17 |
| `javascriptInterfaceAnnotation` | 13 |
| `webResourceResponse` | 10 |
| `setWebViewClient` | 9 |
| `evaluateJavascript` | 8 |
| `loadUrlDynamic` | 8 |
| `setJavaScriptEnabledTrue` | 8 |
| `onPageFinished` | 6 |
| `shouldOverrideUrlLoading` | 5 |
| `addJavascriptInterface` | 4 |
| `customBridgeMethodRefreshAuth` | 4 |
| `customBridgeNameDEVVIT` | 4 |
| `setWebChromeClient` | 4 |
| `userAgentHeaderInjection` | 4 |
| `removeJavascriptInterface` | 3 |
| `shouldInterceptRequest` | 3 |
| `webembedWrapperRegistration` | 3 |
| `customBridgeMethodGetBase64FromBlobData` | 2 |
| `customBridgeMethodPostMessage` | 2 |
| `loadDataWithBaseURL` | 2 |
| `customBridgeMethodOnAnchorLinkClicked` | 1 |
| `customBridgeNameAdsWebViewDownloadHandler` | 1 |
| `javascriptSchemeString` | 1 |
| `setAllowFileAccess` | 1 |
| `setDownloadListener` | 1 |

## 结果明细（总表）

> 字段：API / 注入方式 / 文件:行号 / 条件（近邻启发式） / 匹配行

| API | 注入方式 | 文件位置 | 条件 | 匹配行 |
|---|---|---|---|---|
| `HTTP header: "User-Agent" set` | Sets User-Agent at HTTP layer (tracking surface; may include identifiers) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/analytics/pixel/E.java:73` | if (i5 == 1 \|\| i5 == 2 \|\| i5 == 3 \|\| i5 == 4 \|\| i5 == 5) { \| if (property == null) { \| if (strA == null) { | Request.Builder builderTag = builder.addHeader("X-Dev-Ad-Id", strA).addHeader("User-Agent", property).tag((Class<? super Class>) com.reddit.network.interceptor.u.class, (Class) com.reddit.network.interceptor.u.f108177a); |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:6` |  | import android.webkit.WebChromeClient; |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:18` | /* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */ | public final class C9510b extends WebChromeClient { |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:31` | /* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */ | @Override // android.webkit.WebChromeClient |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:46` | case 1: \| if (interfaceC19002a != null) { \| return ((com.reddit.ads.impl.features.a) interfaceC19002a).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster(); | @Override // android.webkit.WebChromeClient |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:53` | switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null; | webView2.getSettings().setJavaScriptEnabled(true); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:54` | switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null; | webView2.setWebViewClient(new C8822a(webView2, 1)); |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java:63` | switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null; | @Override // android.webkit.WebChromeClient |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:7` |  | import android.webkit.CookieManager; |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:82` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); | webView.getSettings().setJavaScriptEnabled(true); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:86` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | CookieManager cookieManager = CookieManager.getInstance(); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:87` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | cookieManager.setCookie("https://reddit.com", str); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:88` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | cookieManager.flush(); |
| `WebView.setWebChromeClient` | Custom WebChromeClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:90` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0)); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:91` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar)); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java:92` | redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) { | webView.loadUrl(c9511c.f68576c); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdPresenter$attach$1.java:79` | if (redditComposeView != null) { \| if (redditComposeView2 != null) { \| if (fVar == null) { | fVar.loadUrl(webviewUrl); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:184` | if (c0135o == null) { | fVar.setWebViewClient(new d(M5(), M5())); |
| `WebView.setWebChromeClient` | Custom WebChromeClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:185` | if (c0135o == null) { | fVar.setWebChromeClient(new C9510b(this, 1)); |
| `WebView.addJavascriptInterface` | JS bridge registration (Native exposes object to JS) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:210` | if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) { | fVar.addJavascriptInterface(bVar, "AdsWebViewDownloadHandler"); |
| `Custom bridge: AdsWebViewDownloadHandler` | Reddit custom JS bridge object name | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:210` | if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) { | fVar.addJavascriptInterface(bVar, "AdsWebViewDownloadHandler"); |
| `WebView.setDownloadListener` | Custom DownloadListener registration (often anonymous class override) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:211` | if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) { | fVar.setDownloadListener(new DownloadListener() { // from class: com.reddit.ads.impl.screens.hybridvideo.u |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java:227` | if (videoAdScreen.X3() != null) { \| if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) { \| if (zI2) { | fVar3.loadUrl(bVar.b(str, str4)); |
| `Custom bridge method: getBase64FromBlobData` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/b.java:44` | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); |
| `"javascript:" string literal` | JS injection payload string (often passed into loadUrl indirectly) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/b.java:44` | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/b.java:47` | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); | @JavascriptInterface |
| `Custom bridge method: getBase64FromBlobData` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/b.java:48` | return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();"); | public final void getBase64FromBlobData(String base64Data) throws IOException { |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/compose/composables/webview/e.java:95` | switch (this.f69116a) { \| case 0: | fVar.setWebViewClient(new com.reddit.ads.impl.screens.hybridvideo.d(new L1.a(kVar2), new Vj0.h(kVar3))); |
| `WebView.setWebChromeClient` | Custom WebChromeClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/compose/composables/webview/e.java:98` | switch (this.f69116a) { \| case 0: | fVar.setWebChromeClient(new Fb.e(1, kVar4, c9543t)); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/d.java:42` | if (webView == null \|\| str == null) { \| if (URLUtil.isNetworkUrl(str)) { | webView.loadUrl(str); |
| `WebViewClient.shouldOverrideUrlLoading` | Navigation interception/rewriting (scheme handling, redirect logic) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/d.java:71` | if (uri.resolveActivity(webView.getContext().getPackageManager()) != null) { \| if (data.resolveActivity(webView.getContext().getPackageManager()) != null) { | public final boolean shouldOverrideUrlLoading(WebView webView, String str) { |
| `WebViewClient.shouldOverrideUrlLoading` | Navigation interception/rewriting (scheme handling, redirect logic) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/d.java:76` | if (uri.resolveActivity(webView.getContext().getPackageManager()) != null) { \| if (data.resolveActivity(webView.getContext().getPackageManager()) != null) { | public final boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) { |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/w.java:15` |  | settings.setJavaScriptEnabled(true); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/RedditWebUtil$clearCookiesCompletable$2.java:7` |  | import android.webkit.CookieManager; |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/RedditWebUtil$clearCookiesCompletable$2.java:43` | if (this.label != 0) { | CookieManager.getInstance().removeAllCookies(null); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/c.java:109` | if (r7 != 0) goto L53 \| if (r7 != r1) goto L85 | android.webkit.CookieManager r7 = android.webkit.CookieManager.getInstance() |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/c.java:112` | if (r7 != 0) goto L53 \| if (r7 != r1) goto L85 \| if (r6 == 0) goto L90 | r7.setCookie(r8, r6) |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/c.java:114` | if (r7 != r1) goto L85 \| if (r6 == 0) goto L90 | r7.setCookie(r8, r5) |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/presentation/composables/speedread/a.java:7` |  | import android.webkit.CookieManager; |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/presentation/composables/speedread/a.java:153` | case 22: \| case 23: \| case 24: | settings.setJavaScriptEnabled(true); |
| `WebSettings.setAllowFileAccess / setAllowFileAccessFromFileURLs` | File access settings (riskier when combined with JS / file URLs) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/presentation/composables/speedread/a.java:159` | case 22: \| case 23: \| case 24: | settings.setAllowFileAccess(false); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/presentation/composables/speedread/a.java:163` | case 22: \| case 23: \| case 24: | CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true); |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/tree/n.java:451` | if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8: | webView.getSettings().setJavaScriptEnabled(true); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/tree/n.java:453` | if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8: | webView.setWebViewClient((C8822a) obj3); |
| `WebView.setWebChromeClient` | Custom WebChromeClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/tree/n.java:454` | if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8: | webView.setWebChromeClient(new com.reddit.econearn.onboarding.composables.j()); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/tree/n.java:455` | if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8: | webView.loadUrl((String) key); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/data/model/mediaupload/ProgressRequestBody.java:95` |  | iB2.flush(); |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:8` |  | import android.webkit.WebResourceResponse; |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:113` | if (t0Var2 == null \|\| !t0Var2.isActive() \|\| (t0Var = this.f78321o) == null) { | public final WebResourceResponse b(WebResourceRequest webResourceRequest) throws IOException { |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:125` | Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); | return new WebResourceResponse("application/javascript", "UTF-8", new ByteArrayInputStream(bytes)); |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:130` | Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); | public final WebResourceResponse c(WebResourceRequest webResourceRequest) throws IOException { |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:141` | Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); \| Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); | return new WebResourceResponse("application/javascript", "UTF-8", new BE.b(bytes, responseExecute.body().byteStream(), responseExecute)); |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:145` | Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); | public final void onPageFinished(WebView webView, String str) { |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:146` | Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); | super.onPageFinished(webView, str); |
| `WebViewClient.shouldInterceptRequest` | Resource interception (can rewrite JS/HTML/CSS, inject scripts) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:196` | if (webView != null) { \| if (webView == null) { | public final android.webkit.WebResourceResponse shouldInterceptRequest(android.webkit.WebView r13, android.webkit.WebResourceRequest r14) { |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:196` | if (webView != null) { \| if (webView == null) { | public final android.webkit.WebResourceResponse shouldInterceptRequest(android.webkit.WebView r13, android.webkit.WebResourceRequest r14) { |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:244` | if (r14 == 0) goto L3e \| if (r0 == 0) goto Lc0 \| if (r0 == 0) goto L56 | android.webkit.WebResourceResponse r5 = r12.c(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54 |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:253` | if (r14 == 0) goto L3e \| if (r0 == 0) goto Lc0 \| if (r0 == 0) goto L56 | android.webkit.WebResourceResponse r5 = r12.b(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54 |
| `WebViewClient.shouldInterceptRequest` | Resource interception (can rewrite JS/HTML/CSS, inject scripts) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:304` | if (r5 == 0) goto Lc3 | android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14) |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:304` | if (r5 == 0) goto Lc3 | android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14) |
| `WebViewClient.shouldInterceptRequest` | Resource interception (can rewrite JS/HTML/CSS, inject scripts) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:307` | if (r5 == 0) goto Lc3 | throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse"); |
| `WebResourceResponse` | Custom response used with shouldInterceptRequest (often injection) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java:307` | if (r5 == 0) goto Lc3 | throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse"); |
| `Custom bridge: __DEVVIT__` | Reddit custom JS bridge object name | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/DevPlatformWebViewKt$WebViewContent$3$1.java:40` | if (p02.f79105b.f79137o) { | p02.removeJavascriptInterface("__DEVVIT__"); |
| `WebView.removeJavascriptInterface` | Bridge removal / surface reduction (or re-bind) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/DevPlatformWebViewKt$WebViewContent$3$1.java:40` | if (p02.f79105b.f79137o) { | p02.removeJavascriptInterface("__DEVVIT__"); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/DevPlatformWebViewKt$WebViewContent$3$1.java:69` | if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) { \| p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null; | p02.setWebViewClient(new WebViewClient()); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:339` | if (objG8 == c8116f2) { \| if (zH2 \|\| objT5 == c8116f2) { \| if (objG9 == c8116f2) { | webView3.setWebViewClient(new com.reddit.devplatform.composables.blocks.beta.block.webview.g(webViewDependencies.f79127e, aVar3, aVar2, bVar, okHttpClient, strA, webViewDependencies.f79136n, webViewDependencies.f79137o, jLongValue2, (Mf0.m) c12345f0F.f136638c.f134709w.get(), a9, aVar, cVar, webViewDependencies.f79142t)); |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:340` | if (objG8 == c8116f2) { \| if (zH2 \|\| objT5 == c8116f2) { \| if (objG9 == c8116f2) { | webView3.getSettings().setJavaScriptEnabled(true); |
| `WebView.addJavascriptInterface` | JS bridge registration (Native exposes object to JS) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:357` | if (objG9 == c8116f2) { | webView3.addJavascriptInterface(jVar, "__DEVVIT__"); |
| `Custom bridge: __DEVVIT__` | Reddit custom JS bridge object name | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:357` | if (objG9 == c8116f2) { | webView3.addJavascriptInterface(jVar, "__DEVVIT__"); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:359` | if (!webViewDependencies.f79141s \|\| webViewDependencies.f79142t) { | webView3.loadUrl(str); |
| `WebView.loadDataWithBaseURL` | HTML/JS injection via inline HTML payload | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:361` | if (!webViewDependencies.f79141s \|\| webViewDependencies.f79142t) { | webView3.loadDataWithBaseURL(null, q.q("\n        <html>\n        <body>\n        <script>\n            window.name = " + JSONObject.quote(strA) + ";\n            window.location.replace(\"" + str + "\");\n        </script>\n        </body>\n        </html>\n        "), "text/html", "UTF-8", null); |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java:616` | if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) { \| p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null; | lVar.setWebViewClient(gVar); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/g.java:34` | switch (i5) { \| case 0: | webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/g.java:45` | switch (i5) { \| case 0: | webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null); |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/j.java:43` |  | @JavascriptInterface |
| `Custom bridge method: postMessage` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/j.java:44` |  | public final void postMessage(String jsonData) { |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/DevPlatformWebView$javaScriptInjectUpdateStateMessageInWebView$1.java:39` | if (this.label != 0) { | this.this$0.evaluateJavascript(this.$stateJson, null); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/DevPlatformWebView$logToConsole$1.java:36` | if (this.label != 0) { | this.this$0.evaluateJavascript("console.log(\"AndroidDebug: " + this.$message + "\");", null); |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/k.java:16` |  | @JavascriptInterface |
| `Custom bridge method: postMessage` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/k.java:17` |  | public final void postMessage(String jsonData) { |
| `WebView.setWebViewClient` | Custom WebViewClient registration point | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:57` |  | setWebViewClient(gVar); |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:58` |  | getSettings().setJavaScriptEnabled(true); |
| `Custom bridge: __DEVVIT__` | Reddit custom JS bridge object name | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:111` | } else if (action == 2) { \| if (Math.abs(this.f79108e - event.getX()) <= Math.abs(this.f79109f - event.getY())) { \| zCanScrollVertically = y > 0.0f ? view.canScrollVertically(1) : y < 0.0f ? view.canScrollVertically(-1) : false; | removeJavascriptInterface("__DEVVIT__"); |
| `WebView.removeJavascriptInterface` | Bridge removal / surface reduction (or re-bind) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:111` | } else if (action == 2) { \| if (Math.abs(this.f79108e - event.getX()) <= Math.abs(this.f79109f - event.getY())) { \| zCanScrollVertically = y > 0.0f ? view.canScrollVertically(1) : y < 0.0f ? view.canScrollVertically(-1) : false; | removeJavascriptInterface("__DEVVIT__"); |
| `WebView.addJavascriptInterface` | JS bridge registration (Native exposes object to JS) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:116` | if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) { | addJavascriptInterface(this.f79110g, "__DEVVIT__"); |
| `Custom bridge: __DEVVIT__` | Reddit custom JS bridge object name | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:116` | if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) { | addJavascriptInterface(this.f79110g, "__DEVVIT__"); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:120` | if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) { | loadUrl(nVar.f79123a); |
| `WebView.loadDataWithBaseURL` | HTML/JS injection via inline HTML payload | `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java:123` | if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) { | loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null); |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java:5` |  | import android.webkit.WebChromeClient; |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java:10` |  | public final class j extends WebChromeClient { |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java:11` |  | @Override // android.webkit.WebChromeClient |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java:17` |  | @Override // android.webkit.WebChromeClient |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java:18` |  | public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) { |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/fullbleedplayer/ui/composables/linkviewer/a.java:28` |  | public final void onPageFinished(WebView webView, String str) { |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/fullbleedplayer/ui/composables/linkviewer/a.java:29` |  | super.onPageFinished(webView, str); |
| `WebViewClient.shouldOverrideUrlLoading` | Navigation interception/rewriting (scheme handling, redirect logic) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/fullbleedplayer/ui/composables/linkviewer/a.java:38` | if (this.f88416c) { | public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) { |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/image/impl/RedditImageContentResolver$downsampleImageAndCopy$2.java:116` | if (i11 <= 6000 && i12 <= 6000) { \| if (z11) { \| Bitmap.CompressFormat compressFormat = strW.equals("png") ? Bitmap.CompressFormat.PNG : Bitmap.CompressFormat.JPEG; | fileOutputStream.flush(); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/matrix/data/logger/MatrixLoggerImpl$logToFile$1.java:77` | if (this.label != 0) { \| if (outputStreamWriter == null) { \| if (th2 != null) { | outputStreamWriter.flush(); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/matrix/data/logger/a.java:131` | if (r5 != r1) goto L48 \| if (r5 == 0) goto L7c | r5.flush() |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/mediacomponent/composables/embed/EmbedVideoKt$EmbedVideo$3$1.java:47` | if (f.b(this.$playerState, D.f81157a) && (webView = (WebView) this.$webViewReference.getValue()) != null) { | webView.evaluateJavascript(this.$props.f96784c, null); |
| `WebSettings.setJavaScriptEnabled(true)` | Enables JS execution in WebView (expands attack surface) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/mod/filters/impl/generic/screen/k.java:2019` | case 24: \| case 25: \| case 26: | webView.getSettings().setJavaScriptEnabled(true); |
| `WebView.removeJavascriptInterface` | Bridge removal / surface reduction (or re-bind) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/mod/filters/impl/generic/screen/k.java:2026` | if (webEmbedWebView$JsCallbacks == null) { | webView.removeJavascriptInterface(str15); |
| `WebView.addJavascriptInterface` | JS bridge registration (Native exposes object to JS) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/mod/filters/impl/generic/screen/k.java:2027` | if (webEmbedWebView$JsCallbacks == null) { | webView.addJavascriptInterface(webEmbedWebView$JsCallbacks, str15); |
| `HTTP header: "User-Agent" set` | Sets User-Agent at HTTP layer (tracking surface; may include identifiers) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/network/interceptor/G.java:24` | return request.tag(u.class) != null ? chain.proceed(request) : chain.proceed(request.newBuilder().header("User-Agent", this.f108134a.f34519d).build()); | return request.tag(u.class) != null ? chain.proceed(request) : chain.proceed(request.newBuilder().header("User-Agent", this.f108134a.f34519d).build()); |
| `HTTP header: "User-Agent" set` | Sets User-Agent at HTTP layer (tracking surface; may include identifiers) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/network/interceptor/n.java:119` | if (vVar == null \|\| (redditSession = ((Gd0.b) vVar).f6987a) == null) { \| if (vVar == null \|\| (dVar = ((Gd0.b) vVar).f6988b) == null) { | Request.Builder builderHeader2 = builderHeader.header("x-reddit-device-id", strF2).header("User-Agent", this.f108160d.f34519d).header("X-Dev-Ad-Id", this.f108160d.a()).header("Device-Name", this.f108160d.f34520e).header("x-reddit-dpr", String.valueOf(this.f108161e.f169000d)); |
| `HTTP header: "User-Agent" set` | Sets User-Agent at HTTP layer (tracking surface; may include identifiers) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/postsubmit/data/remote/RedditPostPreviewExtractor$getPostPreview$2.java:69` | if (this.label != 0) { | dVar.a("User-Agent", "Mozilla"); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/subredditcreation/ui/CommunityMediaUrlProcessor$downloadFileFromUrl$2.java:61` | if (fileExtensionFromUrl == null \|\| (strConcat = ".".concat(fileExtensionFromUrl)) == null) { | fileOutputStream.flush(); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/video/VideoRenderApiImpl.java:76` |  | fileOutputStream.flush(); |
| `CookieManager operations` | Cookie sync/third-party cookie configuration (privacy + session exposure risk) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/widgets/utils/file/FileUtils.java:31` | if (inputStreamOpenInputStream == null \|\| outputStreamOpenOutputStream == null) { \| if (i5 == -1) { | outputStreamOpenOutputStream.flush(); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/widgets/widget/trimclipview/m.java:159` | switch (this.f131464a) { \| case 10: | webView.evaluateJavascript(q.q(sbR.toString()), null); |
| `WebView.loadUrl(dynamic)` | Navigation with non-literal URL expression (potentially user-controlled/deeplink-controlled) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/WebBrowserLogic$onCreateView$4$1.java:67` | if (((com.reddit.auth.login.common.util.c) dVar).b(context, account, redditSession, dVar2, webBrowserLogic$onCreateView$4$1) == coroutineSingletons) { \| if (webView != null) { | webView.loadUrl(webBrowserLogic$onCreateView$4$1.$initialUrl); |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:6` |  | import android.webkit.WebChromeClient; |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:13` |  | public final class g extends WebChromeClient { |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:42` |  | @Override // android.webkit.WebChromeClient |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:47` | return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster(); | @Override // android.webkit.WebChromeClient |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:48` | return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster(); | public final boolean onConsoleMessage(ConsoleMessage consoleMessage) { |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:50` | return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster(); | return super.onConsoleMessage(consoleMessage); |
| `WebChromeClient / onJsPrompt` | Alternate JS bridge channel via prompt/console | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java:53` | return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster(); | @Override // android.webkit.WebChromeClient |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/c.java:25` |  | @JavascriptInterface |
| `Custom bridge method: refreshAuth` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/c.java:26` |  | public void refreshAuth() { |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java:19` |  | public final void onPageFinished(WebView webView, String str) { |
| `WebViewClient.onPageFinished` | Post-load hook (commonly used to run evaluateJavascript / adjust DOM) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java:20` |  | super.onPageFinished(webView, str); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java:27` | if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null); | webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null); |
| `WebViewClient.shouldOverrideUrlLoading` | Navigation interception/rewriting (scheme handling, redirect logic) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java:31` | if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null); | public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) { |
| `WebViewClient.shouldOverrideUrlLoading` | Navigation interception/rewriting (scheme handling, redirect logic) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java:32` | if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null); | super.shouldOverrideUrlLoading(webView, webResourceRequest); |
| `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` | Bridge registration via wrapper (may call addJavascriptInterface internally) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/e.java:30` |  | throw new UnsupportedOperationException("Method not decompiled: com.reddit.webembed.composables.e.a(java.lang.String, androidx.compose.ui.r, qm0.d, boolean, java.lang.String, com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks, com.reddit.wiki.screens.composables.s, Tk0.a, androidx.compose.runtime.l, int, int):void"); |
| `WebView.evaluateJavascript` | JS injection (executes JS in page context) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/webview/RedditEmbedWebViewViewModel$onRefreshAuth$2.java:52` | if (this.label != 0) { | webView.evaluateJavascript(redditEmbedWebViewViewModel.y, new ValueCallback() { // from class: com.reddit.webembed.webview.d |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/webview/WebEmbedWebView$JsCallbacks.java:12` |  | @JavascriptInterface |
| `Custom bridge method: refreshAuth` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/webview/WebEmbedWebView$JsCallbacks.java:13` |  | void refreshAuth(); |
| `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` | Bridge registration via wrapper (may call addJavascriptInterface internally) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/b.java:263` | if (c8154u0V != null) { \| int i10 = (rVar.f(str) ? 4 : 2) \| i5 \| (rVar.h(aVar) ? 32 : 16) \| (rVar.h(kVar) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128); \| if (rVar.Y(i10 & 1, (i10 & 147) != 146)) { | com.reddit.webembed.composables.e.a(str2, AbstractC7923d.H(r0.d(AbstractC8274l0.C(androidx.compose.ui.o.f54960a, "wiki_web_view"), 1.0f), 16, 0.0f, 2), null, false, "AndroidBridge", new i(aVar, kVar), null, null, rVar, (i10 & 14) \| 196656, 3996); |
| `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` | Bridge registration via wrapper (may call addJavascriptInterface internally) | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/b.java:1093` | int i10 = i5 \| (rVar.f(contentUrl) ? 4 : 2) \| (rVar.h(onAnchorLinkClick) ? 32 : 16) \| (rVar.h(onRichTextLinkClick) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128) \| (rVar.h(onWikiInteractive) ? 2048 : 1024); | com.reddit.webembed.composables.e.a(contentUrl, null, null, false, "AndroidBridge", new r(onAnchorLinkClick, onRichTextLinkClick, onWikiInteractive), new s(), null, rVar, (i10 & 14) \| 196608, 3742); |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java:21` |  | @JavascriptInterface |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java:26` |  | @JavascriptInterface |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java:31` |  | @JavascriptInterface |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java:37` |  | @JavascriptInterface |
| `Custom bridge method: refreshAuth` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java:38` |  | public void refreshAuth() { |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:25` |  | @JavascriptInterface |
| `Custom bridge method: onAnchorLinkClicked` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:26` |  | public final void onAnchorLinkClicked(long j10, float f3) { |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:30` |  | @JavascriptInterface |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:37` |  | @JavascriptInterface |
| `@JavascriptInterface` | JS-to-Native callable method exposed on bridge objects | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:43` |  | @JavascriptInterface |
| `Custom bridge method: refreshAuth` | Reddit custom JS-to-Native method | `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java:44` |  | public void refreshAuth() { |

## 代码片段（按文件分组）

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/analytics/pixel/E.java`

- **userAgentHeaderInjection** @ L73 — `HTTP header: "User-Agent" set` (medium/settings)
  - **条件**：`if (i5 == 1 \|\| i5 == 2 \|\| i5 == 3 \|\| i5 == 4 \|\| i5 == 5) { \| if (property == null) { \| if (strA == null) {`

  **代码上下文**：
```
   58:         int i5 = D.f67905a[hVar.a(str).ordinal()];
   59:         InterfaceC9080c interfaceC9080c = this.f67908b;
   60:         if (i5 == 1 || i5 == 2 || i5 == 3 || i5 == 4 || i5 == 5) {
   61:             property = System.getProperty("http.agent");
   62:             if (property == null) {
   63:                 property = "";
   64:             }
   65:         } else {
   66:             property = ((com.reddit.ads.impl.analytics.c) interfaceC9080c).f67832b;
   67:         }
   68:         Request.Builder builder = new Request.Builder();
   69:         String strA = ((com.reddit.ads.impl.analytics.c) interfaceC9080c).f67831a.a();
   70:         if (strA == null) {
   71:             strA = "";
   72:         }
>> 73:         Request.Builder builderTag = builder.addHeader("X-Dev-Ad-Id", strA).addHeader("User-Agent", property).tag((Class<? super Class>) com.reddit.network.interceptor.u.class, (Class) com.reddit.network.interceptor.u.f108177a);
   74:         if (hVar.a(str) == TrackerType.ADJUST_TRACKER && (httpUrl = HttpUrl.INSTANCE.parse(str)) != null && (builderNewBuilder = httpUrl.newBuilder()) != null) {
   75:             String property2 = System.getProperty("http.agent");
   76:             str = builderNewBuilder.addQueryParameter("user_agent", property2 != null ? property2 : "").toString();
   77:         }
   78:         Request.Builder builderUrl = builderTag.url(str);
   79:         if (m7.s.B(str2)) {
   80:             builderUrl.post(RequestBody.INSTANCE.create(str2, MediaType.INSTANCE.get("application/json")));
   81:         }
   82:         return this.f67907a.newCall(builderUrl.build());
   83:     }
   84: 
   85:     /* JADX WARN: Code restructure failed: missing block: B:118:0x024c, code lost:
   86:     
   87:         if (r0 == r8) goto L119;
   88:      */
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9510b.java`

- **webChromeClientOrPrompt** @ L6 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.ads.impl.feeds.composables;
   2: 
   3: import android.content.Context;
   4: import android.graphics.Bitmap;
   5: import android.os.Message;
>> 6: import android.webkit.WebChromeClient;
   7: import android.webkit.WebView;
   8: import androidx.compose.runtime.InterfaceC8113d0;
   9: import bI.C8822a;
   10: import com.reddit.ads.analytics.ClickDestination;
   11: import com.reddit.ads.impl.screens.hybridvideo.VideoAdScreen;
   12: import fb.InterfaceC12618d;
   13: import ra.InterfaceC19002a;
   14: 
   15: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   16: /* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */
   17: /* loaded from: classes5.dex */
   18: public final class C9510b extends WebChromeClient {
   19: 
   20:     /* renamed from: a, reason: collision with root package name */
   21:     public final /* synthetic */ int f68572a;
```

- **webChromeClientOrPrompt** @ L18 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`/* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */`

  **代码上下文**：
```
   3: import android.content.Context;
   4: import android.graphics.Bitmap;
   5: import android.os.Message;
   6: import android.webkit.WebChromeClient;
   7: import android.webkit.WebView;
   8: import androidx.compose.runtime.InterfaceC8113d0;
   9: import bI.C8822a;
   10: import com.reddit.ads.analytics.ClickDestination;
   11: import com.reddit.ads.impl.screens.hybridvideo.VideoAdScreen;
   12: import fb.InterfaceC12618d;
   13: import ra.InterfaceC19002a;
   14: 
   15: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   16: /* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */
   17: /* loaded from: classes5.dex */
>> 18: public final class C9510b extends WebChromeClient {
   19: 
   20:     /* renamed from: a, reason: collision with root package name */
   21:     public final /* synthetic */ int f68572a;
   22: 
   23:     /* renamed from: b, reason: collision with root package name */
   24:     public final Object f68573b;
   25: 
   26:     public /* synthetic */ C9510b(Object obj, int i5) {
   27:         this.f68572a = i5;
   28:         this.f68573b = obj;
   29:     }
   30: 
   31:     @Override // android.webkit.WebChromeClient
   32:     public Bitmap getDefaultVideoPoster() {
   33:         switch (this.f68572a) {
```

- **webChromeClientOrPrompt** @ L31 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`/* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */`

  **代码上下文**：
```
   16: /* renamed from: com.reddit.ads.impl.feeds.composables.b, reason: case insensitive filesystem */
   17: /* loaded from: classes5.dex */
   18: public final class C9510b extends WebChromeClient {
   19: 
   20:     /* renamed from: a, reason: collision with root package name */
   21:     public final /* synthetic */ int f68572a;
   22: 
   23:     /* renamed from: b, reason: collision with root package name */
   24:     public final Object f68573b;
   25: 
   26:     public /* synthetic */ C9510b(Object obj, int i5) {
   27:         this.f68572a = i5;
   28:         this.f68573b = obj;
   29:     }
   30: 
>> 31:     @Override // android.webkit.WebChromeClient
   32:     public Bitmap getDefaultVideoPoster() {
   33:         switch (this.f68572a) {
   34:             case 1:
   35:                 InterfaceC19002a interfaceC19002a = ((VideoAdScreen) this.f68573b).K0;
   36:                 if (interfaceC19002a != null) {
   37:                     return ((com.reddit.ads.impl.features.a) interfaceC19002a).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   38:                 }
   39:                 kotlin.jvm.internal.f.o("adsFeatures");
   40:                 throw null;
   41:             default:
   42:                 return super.getDefaultVideoPoster();
   43:         }
   44:     }
   45: 
   46:     @Override // android.webkit.WebChromeClient
```

- **webChromeClientOrPrompt** @ L46 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`case 1: \| if (interfaceC19002a != null) { \| return ((com.reddit.ads.impl.features.a) interfaceC19002a).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();`

  **代码上下文**：
```
   31:     @Override // android.webkit.WebChromeClient
   32:     public Bitmap getDefaultVideoPoster() {
   33:         switch (this.f68572a) {
   34:             case 1:
   35:                 InterfaceC19002a interfaceC19002a = ((VideoAdScreen) this.f68573b).K0;
   36:                 if (interfaceC19002a != null) {
   37:                     return ((com.reddit.ads.impl.features.a) interfaceC19002a).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   38:                 }
   39:                 kotlin.jvm.internal.f.o("adsFeatures");
   40:                 throw null;
   41:             default:
   42:                 return super.getDefaultVideoPoster();
   43:         }
   44:     }
   45: 
>> 46:     @Override // android.webkit.WebChromeClient
   47:     public boolean onCreateWindow(WebView webView, boolean z11, boolean z12, Message message) {
   48:         switch (this.f68572a) {
   49:             case 2:
   50:                 Object obj = message != null ? message.obj : null;
   51:                 kotlin.jvm.internal.f.e(obj, "null cannot be cast to non-null type android.webkit.WebView.WebViewTransport");
   52:                 WebView webView2 = new WebView((Context) this.f68573b);
   53:                 webView2.getSettings().setJavaScriptEnabled(true);
   54:                 webView2.setWebViewClient(new C8822a(webView2, 1));
   55:                 ((WebView.WebViewTransport) obj).setWebView(webView2);
   56:                 message.sendToTarget();
   57:                 return true;
   58:             default:
   59:                 return super.onCreateWindow(webView, z11, z12, message);
   60:         }
   61:     }
```

- **setJavaScriptEnabledTrue** @ L53 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null;`

  **代码上下文**：
```
   38:                 }
   39:                 kotlin.jvm.internal.f.o("adsFeatures");
   40:                 throw null;
   41:             default:
   42:                 return super.getDefaultVideoPoster();
   43:         }
   44:     }
   45: 
   46:     @Override // android.webkit.WebChromeClient
   47:     public boolean onCreateWindow(WebView webView, boolean z11, boolean z12, Message message) {
   48:         switch (this.f68572a) {
   49:             case 2:
   50:                 Object obj = message != null ? message.obj : null;
   51:                 kotlin.jvm.internal.f.e(obj, "null cannot be cast to non-null type android.webkit.WebView.WebViewTransport");
   52:                 WebView webView2 = new WebView((Context) this.f68573b);
>> 53:                 webView2.getSettings().setJavaScriptEnabled(true);
   54:                 webView2.setWebViewClient(new C8822a(webView2, 1));
   55:                 ((WebView.WebViewTransport) obj).setWebView(webView2);
   56:                 message.sendToTarget();
   57:                 return true;
   58:             default:
   59:                 return super.onCreateWindow(webView, z11, z12, message);
   60:         }
   61:     }
   62: 
   63:     @Override // android.webkit.WebChromeClient
   64:     public void onProgressChanged(WebView view, int i5) {
   65:         int i10 = this.f68572a;
   66:         Object obj = this.f68573b;
   67:         switch (i10) {
   68:             case 0:
```

- **setWebViewClient** @ L54 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null;`

  **代码上下文**：
```
   39:                 kotlin.jvm.internal.f.o("adsFeatures");
   40:                 throw null;
   41:             default:
   42:                 return super.getDefaultVideoPoster();
   43:         }
   44:     }
   45: 
   46:     @Override // android.webkit.WebChromeClient
   47:     public boolean onCreateWindow(WebView webView, boolean z11, boolean z12, Message message) {
   48:         switch (this.f68572a) {
   49:             case 2:
   50:                 Object obj = message != null ? message.obj : null;
   51:                 kotlin.jvm.internal.f.e(obj, "null cannot be cast to non-null type android.webkit.WebView.WebViewTransport");
   52:                 WebView webView2 = new WebView((Context) this.f68573b);
   53:                 webView2.getSettings().setJavaScriptEnabled(true);
>> 54:                 webView2.setWebViewClient(new C8822a(webView2, 1));
   55:                 ((WebView.WebViewTransport) obj).setWebView(webView2);
   56:                 message.sendToTarget();
   57:                 return true;
   58:             default:
   59:                 return super.onCreateWindow(webView, z11, z12, message);
   60:         }
   61:     }
   62: 
   63:     @Override // android.webkit.WebChromeClient
   64:     public void onProgressChanged(WebView view, int i5) {
   65:         int i10 = this.f68572a;
   66:         Object obj = this.f68573b;
   67:         switch (i10) {
   68:             case 0:
   69:                 super.onProgressChanged(view, i5);
```

- **webChromeClientOrPrompt** @ L63 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`switch (this.f68572a) { \| case 2: \| Object obj = message != null ? message.obj : null;`

  **代码上下文**：
```
   48:         switch (this.f68572a) {
   49:             case 2:
   50:                 Object obj = message != null ? message.obj : null;
   51:                 kotlin.jvm.internal.f.e(obj, "null cannot be cast to non-null type android.webkit.WebView.WebViewTransport");
   52:                 WebView webView2 = new WebView((Context) this.f68573b);
   53:                 webView2.getSettings().setJavaScriptEnabled(true);
   54:                 webView2.setWebViewClient(new C8822a(webView2, 1));
   55:                 ((WebView.WebViewTransport) obj).setWebView(webView2);
   56:                 message.sendToTarget();
   57:                 return true;
   58:             default:
   59:                 return super.onCreateWindow(webView, z11, z12, message);
   60:         }
   61:     }
   62: 
>> 63:     @Override // android.webkit.WebChromeClient
   64:     public void onProgressChanged(WebView view, int i5) {
   65:         int i10 = this.f68572a;
   66:         Object obj = this.f68573b;
   67:         switch (i10) {
   68:             case 0:
   69:                 super.onProgressChanged(view, i5);
   70:                 if (i5 == 100) {
   71:                     ((InterfaceC8113d0) obj).setValue(Boolean.FALSE);
   72:                     break;
   73:                 }
   74:                 break;
   75:             case 1:
   76:                 kotlin.jvm.internal.f.g(view, "view");
   77:                 com.reddit.ads.impl.screens.hybridvideo.n nVarM5 = ((VideoAdScreen) obj).M5();
   78:                 if (i5 == 100) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/feeds/composables/C9511c.java`

- **cookieManagerOps** @ L7 — `CookieManager operations` (medium/settings)

  **代码上下文**：
```
   1: package com.reddit.ads.impl.feeds.composables;
   2: 
   3: import Be.C0256A;
   4: import android.content.Context;
   5: import android.view.LayoutInflater;
   6: import android.view.View;
>> 7: import android.webkit.CookieManager;
   8: import android.webkit.WebView;
   9: import androidx.compose.foundation.layout.AbstractC7923d;
   10: import androidx.compose.foundation.layout.AbstractC7934o;
   11: import androidx.compose.foundation.layout.r0;
   12: import androidx.compose.runtime.AbstractC8122i;
   13: import androidx.compose.runtime.C8116f;
   14: import androidx.compose.runtime.C8126k;
   15: import androidx.compose.runtime.C8129l0;
   16: import androidx.compose.runtime.C8154u0;
   17: import androidx.compose.runtime.InterfaceC8113d0;
   18: import androidx.compose.runtime.InterfaceC8128l;
   19: import androidx.compose.runtime.InterfaceC8135o0;
   20: import androidx.compose.ui.layout.Q;
   21: import androidx.compose.ui.node.C8233h;
   22: import androidx.compose.ui.node.InterfaceC8234i;
```

- **setJavaScriptEnabledTrue** @ L82 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);`

  **代码上下文**：
```
   67:         this.f68577d = z11;
   68:         this.f68578e = m11;
   69:         this.f68579f = str;
   70:         this.f68580g = pVar;
   71:         this.f68581h = AbstractC8122i.E(Boolean.FALSE);
   72:     }
   73: 
   74:     public static final ConstraintLayout b(Context context, InterfaceC8113d0 interfaceC8113d0, int i5, C9511c c9511c, com.reddit.feeds.ui.c cVar) {
   75:         ConstraintLayout constraintLayout = new ConstraintLayout(context);
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
>> 82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
```

- **cookieManagerOps** @ L86 — `CookieManager operations` (medium/settings)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   71:         this.f68581h = AbstractC8122i.E(Boolean.FALSE);
   72:     }
   73: 
   74:     public static final ConstraintLayout b(Context context, InterfaceC8113d0 interfaceC8113d0, int i5, C9511c c9511c, com.reddit.feeds.ui.c cVar) {
   75:         ConstraintLayout constraintLayout = new ConstraintLayout(context);
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
>> 86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
```

- **cookieManagerOps** @ L87 — `CookieManager operations` (medium/settings)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   72:     }
   73: 
   74:     public static final ConstraintLayout b(Context context, InterfaceC8113d0 interfaceC8113d0, int i5, C9511c c9511c, com.reddit.feeds.ui.c cVar) {
   75:         ConstraintLayout constraintLayout = new ConstraintLayout(context);
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
>> 87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
   102:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
```

- **cookieManagerOps** @ L88 — `CookieManager operations` (medium/settings)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   73: 
   74:     public static final ConstraintLayout b(Context context, InterfaceC8113d0 interfaceC8113d0, int i5, C9511c c9511c, com.reddit.feeds.ui.c cVar) {
   75:         ConstraintLayout constraintLayout = new ConstraintLayout(context);
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
>> 88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
   102:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   103:         rVar.k0(-311484606);
```

- **setWebChromeClient** @ L90 — `WebView.setWebChromeClient` (high/hookpoint)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   75:         ConstraintLayout constraintLayout = new ConstraintLayout(context);
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
>> 90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
   102:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   103:         rVar.k0(-311484606);
   104:         if ((i5 & 6) == 0) {
   105:             i10 = (rVar.f(feedContext) ? 4 : 2) | i5;
```

- **setWebViewClient** @ L91 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   76:         View viewInflate = LayoutInflater.from(context).inflate(R.layout.ads_brand_lift_container_minimized, constraintLayout);
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
>> 91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
   92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
   102:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   103:         rVar.k0(-311484606);
   104:         if ((i5 & 6) == 0) {
   105:             i10 = (rVar.f(feedContext) ? 4 : 2) | i5;
   106:         } else {
```

- **loadUrlDynamic** @ L92 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8); \| if (str != null) {`

  **代码上下文**：
```
   77:         RedditComposeView redditComposeView = (RedditComposeView) viewInflate.findViewById(R.id.rbl_survey_loading_view);
   78:         kotlin.jvm.internal.f.d(redditComposeView);
   79:         redditComposeView.setVisibility(((Boolean) interfaceC8113d0.getValue()).booleanValue() ? 0 : 8);
   80:         redditComposeView.setContent(new androidx.compose.runtime.internal.a(new Ob.c(interfaceC8113d0, 8), -346778377, true));
   81:         WebView webView = (WebView) viewInflate.findViewById(R.id.survey_content);
   82:         webView.getSettings().setJavaScriptEnabled(true);
   83:         webView.setBackgroundColor(i5);
   84:         String str = c9511c.f68579f;
   85:         if (str != null) {
   86:             CookieManager cookieManager = CookieManager.getInstance();
   87:             cookieManager.setCookie("https://reddit.com", str);
   88:             cookieManager.flush();
   89:         }
   90:         webView.setWebChromeClient(new C9510b(interfaceC8113d0, 0));
   91:         webView.setWebViewClient(new C0256A(interfaceC8113d0, c9511c, cVar));
>> 92:         webView.loadUrl(c9511c.f68576c);
   93:         return constraintLayout;
   94:     }
   95: 
   96:     @Override // com.reddit.feeds.ui.composables.InterfaceC9950e
   97:     public final void a(final com.reddit.feeds.ui.c feedContext, InterfaceC8128l interfaceC8128l, final int i5) {
   98:         int i10;
   99:         C8154u0 c8154u0V;
   100:         Tk0.n nVar;
   101:         kotlin.jvm.internal.f.g(feedContext, "feedContext");
   102:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   103:         rVar.k0(-311484606);
   104:         if ((i5 & 6) == 0) {
   105:             i10 = (rVar.f(feedContext) ? 4 : 2) | i5;
   106:         } else {
   107:             i10 = i5;
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdPresenter$attach$1.java`

- **loadUrlDynamic** @ L79 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (redditComposeView != null) { \| if (redditComposeView2 != null) { \| if (fVar == null) {`

  **代码上下文**：
```
   64:             if (!videoAdScreen.B5()) {
   65:                 videoAdScreen.f68968a1 = eVarB;
   66:                 RedditComposeView redditComposeView = videoAdScreen.f68960S0;
   67:                 if (redditComposeView != null) {
   68:                     redditComposeView.setVisibility(0);
   69:                 }
   70:                 RedditComposeView redditComposeView2 = videoAdScreen.f68960S0;
   71:                 if (redditComposeView2 != null) {
   72:                     redditComposeView2.setContent(new androidx.compose.runtime.internal.a(new com.reddit.achievements.achievement.composables.sections.community.a(videoAdScreen, 19, redditComposeView2, lVar), -1523375692, true));
   73:                 }
   74:                 f fVar = videoAdScreen.f68959R0;
   75:                 if (fVar == null) {
   76:                     kotlin.jvm.internal.f.o("webView");
   77:                     throw null;
   78:                 }
>> 79:                 fVar.loadUrl(webviewUrl);
   80:             }
   81:             int i5 = URLUtil.isHttpsUrl(nVar.j()) ? R.drawable.icon_lock_fill : R.drawable.icon_unlock_fill;
   82:             r rVar = nVar.f69246W;
   83:             String domain = nVar.f69251b.f69236f;
   84:             if (domain == null) {
   85:                 domain = link.getDomain();
   86:             }
   87:             rVar.getClass();
   88:             kotlin.jvm.internal.f.g(domain, "domain");
   89:             nVar.d(new r(domain, 0, i5, true));
   90:             n.c(this.this$0);
   91:             return Fk0.v.f6415a;
   92:         }
   93: 
   94:         @Override // Tk0.n
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/VideoAdScreen.java`

- **setWebViewClient** @ L184 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`if (c0135o == null) {`

  **代码上下文**：
```
   169:     public final View E5(LayoutInflater layoutInflater, ViewGroup container) {
   170:         kotlin.jvm.internal.f.g(container, "container");
   171:         View viewE5 = super.E5(layoutInflater, container);
   172:         ih.c cVar = this.f68961T0;
   173:         CoordinatorLayout coordinatorLayout = (CoordinatorLayout) cVar.getValue();
   174:         kotlin.jvm.internal.f.g(coordinatorLayout, "<this>");
   175:         Context context = coordinatorLayout.getContext();
   176:         kotlin.jvm.internal.f.f(context, "getContext(...)");
   177:         final f fVar = new f(new v(context), 6);
   178:         f1.e eVar = new f1.e(-1, -1);
   179:         eVar.b(new AppBarLayout.ScrollingViewBehavior());
   180:         fVar.setLayoutParams(eVar);
   181:         fVar.setFocusableInTouchMode(true);
   182:         coordinatorLayout.addView(fVar);
   183:         this.f68959R0 = fVar;
>> 184:         fVar.setWebViewClient(new d(M5(), M5()));
   185:         fVar.setWebChromeClient(new C9510b(this, 1));
   186:         w.a(fVar);
   187:         InterfaceC19002a interfaceC19002a = this.K0;
   188:         if (interfaceC19002a == null) {
   189:             kotlin.jvm.internal.f.o("adsFeatures");
   190:             throw null;
   191:         }
   192:         com.reddit.ads.impl.features.a aVar = (com.reddit.ads.impl.features.a) interfaceC19002a;
   193:         if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) {
   194:             C7628b c7628b = this.f68958Q0;
   195:             if (c7628b == null) {
   196:                 kotlin.jvm.internal.f.o("adsWebViewDownloadHandler");
   197:                 throw null;
   198:             }
   199:             Activity activityX3 = X3();
```

- **setWebChromeClient** @ L185 — `WebView.setWebChromeClient` (high/hookpoint)
  - **条件**：`if (c0135o == null) {`

  **代码上下文**：
```
   170:         kotlin.jvm.internal.f.g(container, "container");
   171:         View viewE5 = super.E5(layoutInflater, container);
   172:         ih.c cVar = this.f68961T0;
   173:         CoordinatorLayout coordinatorLayout = (CoordinatorLayout) cVar.getValue();
   174:         kotlin.jvm.internal.f.g(coordinatorLayout, "<this>");
   175:         Context context = coordinatorLayout.getContext();
   176:         kotlin.jvm.internal.f.f(context, "getContext(...)");
   177:         final f fVar = new f(new v(context), 6);
   178:         f1.e eVar = new f1.e(-1, -1);
   179:         eVar.b(new AppBarLayout.ScrollingViewBehavior());
   180:         fVar.setLayoutParams(eVar);
   181:         fVar.setFocusableInTouchMode(true);
   182:         coordinatorLayout.addView(fVar);
   183:         this.f68959R0 = fVar;
   184:         fVar.setWebViewClient(new d(M5(), M5()));
>> 185:         fVar.setWebChromeClient(new C9510b(this, 1));
   186:         w.a(fVar);
   187:         InterfaceC19002a interfaceC19002a = this.K0;
   188:         if (interfaceC19002a == null) {
   189:             kotlin.jvm.internal.f.o("adsFeatures");
   190:             throw null;
   191:         }
   192:         com.reddit.ads.impl.features.a aVar = (com.reddit.ads.impl.features.a) interfaceC19002a;
   193:         if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) {
   194:             C7628b c7628b = this.f68958Q0;
   195:             if (c7628b == null) {
   196:                 kotlin.jvm.internal.f.o("adsWebViewDownloadHandler");
   197:                 throw null;
   198:             }
   199:             Activity activityX3 = X3();
   200:             f fVar2 = this.f68959R0;
```

- **addJavascriptInterface** @ L210 — `WebView.addJavascriptInterface` (high/bridge)
  - **⚠️ 检测到混淆代码**
    - 混淆后的类名: `b`
    - 检测方法: system_api_call
    - 说明: 虽然类名/方法名被混淆，但通过系统API调用（`addJavascriptInterface`）或注解（`@JavascriptInterface`）检测到
  - **条件**：`if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) {`

  **代码上下文**：
```
   195:             if (c7628b == null) {
   196:                 kotlin.jvm.internal.f.o("adsWebViewDownloadHandler");
   197:                 throw null;
   198:             }
   199:             Activity activityX3 = X3();
   200:             f fVar2 = this.f68959R0;
   201:             if (fVar2 == null) {
   202:                 kotlin.jvm.internal.f.o("webView");
   203:                 throw null;
   204:             }
   205:             c7628b.a(fVar2, activityX3, (CoordinatorLayout) cVar.getValue(), new VQ.c(this, 27));
   206:         } else {
   207:             Context context2 = fVar.getContext();
   208:             kotlin.jvm.internal.f.f(context2, "getContext(...)");
   209:             final b bVar = new b(context2, this.f117290y0);
>> 210:             fVar.addJavascriptInterface(bVar, "AdsWebViewDownloadHandler");
   211:             fVar.setDownloadListener(new DownloadListener() { // from class: com.reddit.ads.impl.screens.hybridvideo.u
   212:                 @Override // android.webkit.DownloadListener
   213:                 public final void onDownloadStart(String str, String str2, String str3, String str4, long j10) {
   214:                     VideoAdScreen videoAdScreen = this.f69276a;
   215:                     if (videoAdScreen.X3() != null) {
   216:                         if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) {
   217:                             Activity activityX32 = videoAdScreen.X3();
   218:                             kotlin.jvm.internal.f.d(activityX32);
   219:                             com.reddit.devvit.ui.events.v1alpha.q.Y(activityX32, PermissionUtil$Permission.STORAGE);
   220:                             return;
   221:                         }
   222:                         kotlin.jvm.internal.f.d(str);
   223:                         boolean zI2 = kotlin.text.w.I(str, "blob", false);
   224:                         f fVar3 = fVar;
   225:                         if (zI2) {
```

- **customBridgeNameAdsWebViewDownloadHandler** @ L210 — `Custom bridge: AdsWebViewDownloadHandler` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接对象名，通过 `addJavascriptInterface` 或 `removeJavascriptInterface` 与 WebView 关联
  - **条件**：`if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) {`

  **代码上下文**：
```
   195:             if (c7628b == null) {
   196:                 kotlin.jvm.internal.f.o("adsWebViewDownloadHandler");
   197:                 throw null;
   198:             }
   199:             Activity activityX3 = X3();
   200:             f fVar2 = this.f68959R0;
   201:             if (fVar2 == null) {
   202:                 kotlin.jvm.internal.f.o("webView");
   203:                 throw null;
   204:             }
   205:             c7628b.a(fVar2, activityX3, (CoordinatorLayout) cVar.getValue(), new VQ.c(this, 27));
   206:         } else {
   207:             Context context2 = fVar.getContext();
   208:             kotlin.jvm.internal.f.f(context2, "getContext(...)");
   209:             final b bVar = new b(context2, this.f117290y0);
>> 210:             fVar.addJavascriptInterface(bVar, "AdsWebViewDownloadHandler");
   211:             fVar.setDownloadListener(new DownloadListener() { // from class: com.reddit.ads.impl.screens.hybridvideo.u
   212:                 @Override // android.webkit.DownloadListener
   213:                 public final void onDownloadStart(String str, String str2, String str3, String str4, long j10) {
   214:                     VideoAdScreen videoAdScreen = this.f69276a;
   215:                     if (videoAdScreen.X3() != null) {
   216:                         if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) {
   217:                             Activity activityX32 = videoAdScreen.X3();
   218:                             kotlin.jvm.internal.f.d(activityX32);
   219:                             com.reddit.devvit.ui.events.v1alpha.q.Y(activityX32, PermissionUtil$Permission.STORAGE);
   220:                             return;
   221:                         }
   222:                         kotlin.jvm.internal.f.d(str);
   223:                         boolean zI2 = kotlin.text.w.I(str, "blob", false);
   224:                         f fVar3 = fVar;
   225:                         if (zI2) {
```

- **setDownloadListener** @ L211 — `WebView.setDownloadListener` (high/hookpoint)
  - **条件**：`if (com.reddit.accessibility.devsettings.g.C(aVar.f68439C, aVar, com.reddit.ads.impl.features.a.f68436p0[25])) { \| if (c7628b == null) { \| if (fVar2 == null) {`

  **代码上下文**：
```
   196:                 kotlin.jvm.internal.f.o("adsWebViewDownloadHandler");
   197:                 throw null;
   198:             }
   199:             Activity activityX3 = X3();
   200:             f fVar2 = this.f68959R0;
   201:             if (fVar2 == null) {
   202:                 kotlin.jvm.internal.f.o("webView");
   203:                 throw null;
   204:             }
   205:             c7628b.a(fVar2, activityX3, (CoordinatorLayout) cVar.getValue(), new VQ.c(this, 27));
   206:         } else {
   207:             Context context2 = fVar.getContext();
   208:             kotlin.jvm.internal.f.f(context2, "getContext(...)");
   209:             final b bVar = new b(context2, this.f117290y0);
   210:             fVar.addJavascriptInterface(bVar, "AdsWebViewDownloadHandler");
>> 211:             fVar.setDownloadListener(new DownloadListener() { // from class: com.reddit.ads.impl.screens.hybridvideo.u
   212:                 @Override // android.webkit.DownloadListener
   213:                 public final void onDownloadStart(String str, String str2, String str3, String str4, long j10) {
   214:                     VideoAdScreen videoAdScreen = this.f69276a;
   215:                     if (videoAdScreen.X3() != null) {
   216:                         if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) {
   217:                             Activity activityX32 = videoAdScreen.X3();
   218:                             kotlin.jvm.internal.f.d(activityX32);
   219:                             com.reddit.devvit.ui.events.v1alpha.q.Y(activityX32, PermissionUtil$Permission.STORAGE);
   220:                             return;
   221:                         }
   222:                         kotlin.jvm.internal.f.d(str);
   223:                         boolean zI2 = kotlin.text.w.I(str, "blob", false);
   224:                         f fVar3 = fVar;
   225:                         if (zI2) {
   226:                             kotlin.jvm.internal.f.d(str4);
```

- **loadUrlDynamic** @ L227 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (videoAdScreen.X3() != null) { \| if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) { \| if (zI2) {`

  **代码上下文**：
```
   212:                 @Override // android.webkit.DownloadListener
   213:                 public final void onDownloadStart(String str, String str2, String str3, String str4, long j10) {
   214:                     VideoAdScreen videoAdScreen = this.f69276a;
   215:                     if (videoAdScreen.X3() != null) {
   216:                         if (!com.reddit.devvit.ui.events.v1alpha.q.g0(videoAdScreen, 11)) {
   217:                             Activity activityX32 = videoAdScreen.X3();
   218:                             kotlin.jvm.internal.f.d(activityX32);
   219:                             com.reddit.devvit.ui.events.v1alpha.q.Y(activityX32, PermissionUtil$Permission.STORAGE);
   220:                             return;
   221:                         }
   222:                         kotlin.jvm.internal.f.d(str);
   223:                         boolean zI2 = kotlin.text.w.I(str, "blob", false);
   224:                         f fVar3 = fVar;
   225:                         if (zI2) {
   226:                             kotlin.jvm.internal.f.d(str4);
>> 227:                             fVar3.loadUrl(bVar.b(str, str4));
   228:                             return;
   229:                         }
   230:                         kotlin.jvm.internal.f.d(str3);
   231:                         kotlin.jvm.internal.f.d(str4);
   232:                         Context context3 = fVar3.getContext();
   233:                         kotlin.jvm.internal.f.f(context3, "getContext(...)");
   234:                         np0.c.n(context3, str, str3, str4);
   235:                     }
   236:                 }
   237:             });
   238:         }
   239:         fVar.setOnTouchListener(new Wg0.a(this, 2));
   240:         com.reddit.localization.e eVar2 = this.f68954M0;
   241:         if (eVar2 == null) {
   242:             kotlin.jvm.internal.f.o("localizationDelegate");
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/b.java`

- **customBridgeMethodGetBase64FromBlobData** @ L44 — `Custom bridge method: getBase64FromBlobData` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用
  - **条件**：`return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");`

  **代码上下文**：
```
   29:     /* JADX WARN: Removed duplicated region for block: B:97:? A[LOOP:0: B:20:0x00b3->B:97:?, LOOP_END, SYNTHETIC] */
   30:     /*
   31:         Code decompiled incorrectly, please refer to instructions dump.
   32:         To view partially-correct add '--show-bad-code' argument
   33:     */
   34:     public final void a(java.lang.String r12) throws java.io.IOException {
   35:         /*
   36:             Method dump skipped, instructions count: 494
   37:             To view this dump add '--comments-level debug' option
   38:         */
   39:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.ads.impl.screens.hybridvideo.b.a(java.lang.String):void");
   40:     }
   41: 
   42:     public final String b(String str, String str2) {
   43:         this.f68980c = str2;
>> 44:         return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");
   45:     }
   46: 
   47:     @JavascriptInterface
   48:     public final void getBase64FromBlobData(String base64Data) throws IOException {
   49:         kotlin.jvm.internal.f.g(base64Data, "base64Data");
   50:         a(base64Data);
   51:     }
   52: }
```

- **javascriptSchemeString** @ L44 — `"javascript:" string literal` (high/js_injection)
  - **条件**：`return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");`

  **代码上下文**：
```
   29:     /* JADX WARN: Removed duplicated region for block: B:97:? A[LOOP:0: B:20:0x00b3->B:97:?, LOOP_END, SYNTHETIC] */
   30:     /*
   31:         Code decompiled incorrectly, please refer to instructions dump.
   32:         To view partially-correct add '--show-bad-code' argument
   33:     */
   34:     public final void a(java.lang.String r12) throws java.io.IOException {
   35:         /*
   36:             Method dump skipped, instructions count: 494
   37:             To view this dump add '--comments-level debug' option
   38:         */
   39:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.ads.impl.screens.hybridvideo.b.a(java.lang.String):void");
   40:     }
   41: 
   42:     public final String b(String str, String str2) {
   43:         this.f68980c = str2;
>> 44:         return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");
   45:     }
   46: 
   47:     @JavascriptInterface
   48:     public final void getBase64FromBlobData(String base64Data) throws IOException {
   49:         kotlin.jvm.internal.f.g(base64Data, "base64Data");
   50:         a(base64Data);
   51:     }
   52: }
```

- **javascriptInterfaceAnnotation** @ L47 — `@JavascriptInterface` (high/bridge)
  - **条件**：`return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");`

  **代码上下文**：
```
   32:         To view partially-correct add '--show-bad-code' argument
   33:     */
   34:     public final void a(java.lang.String r12) throws java.io.IOException {
   35:         /*
   36:             Method dump skipped, instructions count: 494
   37:             To view this dump add '--comments-level debug' option
   38:         */
   39:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.ads.impl.screens.hybridvideo.b.a(java.lang.String):void");
   40:     }
   41: 
   42:     public final String b(String str, String str2) {
   43:         this.f68980c = str2;
   44:         return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");
   45:     }
   46: 
>> 47:     @JavascriptInterface
   48:     public final void getBase64FromBlobData(String base64Data) throws IOException {
   49:         kotlin.jvm.internal.f.g(base64Data, "base64Data");
   50:         a(base64Data);
   51:     }
   52: }
```

- **customBridgeMethodGetBase64FromBlobData** @ L48 — `Custom bridge method: getBase64FromBlobData` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用
  - **条件**：`return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");`

  **代码上下文**：
```
   33:     */
   34:     public final void a(java.lang.String r12) throws java.io.IOException {
   35:         /*
   36:             Method dump skipped, instructions count: 494
   37:             To view this dump add '--comments-level debug' option
   38:         */
   39:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.ads.impl.screens.hybridvideo.b.a(java.lang.String):void");
   40:     }
   41: 
   42:     public final String b(String str, String str2) {
   43:         this.f68980c = str2;
   44:         return p9.d.q("javascript: var xhr = new XMLHttpRequest();xhr.open('GET', '", str, "', true);xhr.setRequestHeader('Content-type','", str2, "');xhr.responseType = 'blob';xhr.onload = function(e) {    if (this.status == 200) {        var blobFile = this.response;        var reader = new FileReader();        reader.readAsDataURL(blobFile);        reader.onloadend = function() {            base64data = reader.result;            AdsWebViewDownloadHandler.getBase64FromBlobData(base64data);        }    }};xhr.send();");
   45:     }
   46: 
   47:     @JavascriptInterface
>> 48:     public final void getBase64FromBlobData(String base64Data) throws IOException {
   49:         kotlin.jvm.internal.f.g(base64Data, "base64Data");
   50:         a(base64Data);
   51:     }
   52: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/compose/composables/webview/e.java`

- **setWebViewClient** @ L95 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`switch (this.f69116a) { \| case 0:`

  **代码上下文**：
```
   80:     }
   81: 
   82:     @Override // Tk0.k
   83:     public final Object invoke(Object obj) {
   84:         switch (this.f69116a) {
   85:             case 0:
   86:                 Tk0.k kVar = (Tk0.k) this.f69118c;
   87:                 Tk0.k kVar2 = (Tk0.k) this.f69119d;
   88:                 Tk0.k kVar3 = (Tk0.k) this.f69120e;
   89:                 Tk0.a aVar = (Tk0.a) this.f69117b;
   90:                 Tk0.k kVar4 = (Tk0.k) this.f69121f;
   91:                 C9543t c9543t = (C9543t) this.f69122g;
   92:                 Context context = (Context) obj;
   93:                 kotlin.jvm.internal.f.g(context, "context");
   94:                 com.reddit.ads.impl.screens.hybridvideo.f fVar = new com.reddit.ads.impl.screens.hybridvideo.f(context, 2);
>> 95:                 fVar.setWebViewClient(new com.reddit.ads.impl.screens.hybridvideo.d(new L1.a(kVar2), new Vj0.h(kVar3)));
   96:                 fVar.setOnTouchListener(new f(0, aVar, kVar3));
   97:                 fVar.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   98:                 fVar.setWebChromeClient(new Fb.e(1, kVar4, c9543t));
   99:                 fVar.setBackgroundColor(com.reddit.devvit.ui.events.v1alpha.q.D(context, R.attr.rdt_modal_background_color));
   100:                 fVar.setLayerType(2, null);
   101:                 w.a(fVar);
   102:                 kVar.invoke(fVar);
   103:                 return fVar;
   104:             case 1:
   105:                 C8317h c8317h = (C8317h) this.f69118c;
   106:                 Tk0.a aVar2 = (Tk0.a) this.f69117b;
   107:                 Tk0.n nVar = (Tk0.n) this.f69119d;
   108:                 String str = (String) this.f69120e;
   109:                 Tk0.a aVar3 = (Tk0.a) this.f69121f;
   110:                 String str2 = (String) this.f69122g;
```

- **setWebChromeClient** @ L98 — `WebView.setWebChromeClient` (high/hookpoint)
  - **条件**：`switch (this.f69116a) { \| case 0:`

  **代码上下文**：
```
   83:     public final Object invoke(Object obj) {
   84:         switch (this.f69116a) {
   85:             case 0:
   86:                 Tk0.k kVar = (Tk0.k) this.f69118c;
   87:                 Tk0.k kVar2 = (Tk0.k) this.f69119d;
   88:                 Tk0.k kVar3 = (Tk0.k) this.f69120e;
   89:                 Tk0.a aVar = (Tk0.a) this.f69117b;
   90:                 Tk0.k kVar4 = (Tk0.k) this.f69121f;
   91:                 C9543t c9543t = (C9543t) this.f69122g;
   92:                 Context context = (Context) obj;
   93:                 kotlin.jvm.internal.f.g(context, "context");
   94:                 com.reddit.ads.impl.screens.hybridvideo.f fVar = new com.reddit.ads.impl.screens.hybridvideo.f(context, 2);
   95:                 fVar.setWebViewClient(new com.reddit.ads.impl.screens.hybridvideo.d(new L1.a(kVar2), new Vj0.h(kVar3)));
   96:                 fVar.setOnTouchListener(new f(0, aVar, kVar3));
   97:                 fVar.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
>> 98:                 fVar.setWebChromeClient(new Fb.e(1, kVar4, c9543t));
   99:                 fVar.setBackgroundColor(com.reddit.devvit.ui.events.v1alpha.q.D(context, R.attr.rdt_modal_background_color));
   100:                 fVar.setLayerType(2, null);
   101:                 w.a(fVar);
   102:                 kVar.invoke(fVar);
   103:                 return fVar;
   104:             case 1:
   105:                 C8317h c8317h = (C8317h) this.f69118c;
   106:                 Tk0.a aVar2 = (Tk0.a) this.f69117b;
   107:                 Tk0.n nVar = (Tk0.n) this.f69119d;
   108:                 String str = (String) this.f69120e;
   109:                 Tk0.a aVar3 = (Tk0.a) this.f69121f;
   110:                 String str2 = (String) this.f69122g;
   111:                 int iIntValue = ((Integer) obj).intValue();
   112:                 if (((C8307f) kotlin.collections.p.e0(c8317h.b(iIntValue, iIntValue, "agreement"))) != null) {
   113:                     aVar2.invoke();
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/d.java`

- **loadUrlDynamic** @ L42 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (webView == null \|\| str == null) { \| if (URLUtil.isNetworkUrl(str)) {`

  **代码上下文**：
```
   27:     public d(c cVar, e eVar) {
   28:         this.f69206a = cVar;
   29:         this.f69207b = eVar;
   30:     }
   31: 
   32:     public final boolean a(WebView webView, String str, Boolean bool) throws URISyntaxException {
   33:         if (webView == null || str == null) {
   34:             return false;
   35:         }
   36:         if (!this.f69209d) {
   37:             boolean zI2 = kotlin.text.w.I(str, "intent:", false);
   38:             e eVar = this.f69207b;
   39:             if (!zI2) {
   40:                 if (URLUtil.isNetworkUrl(str)) {
   41:                     this.f69206a.a(str);
>> 42:                     webView.loadUrl(str);
   43:                     return true;
   44:                 }
   45:                 this.f69209d = true;
   46:                 eVar.b();
   47:                 return true;
   48:             }
   49:             if (!this.f69208c || !kotlin.jvm.internal.f.b(bool, Boolean.FALSE)) {
   50:                 this.f69209d = true;
   51:                 try {
   52:                     Intent uri = Intent.parseUri(webView.getUrl(), 1);
   53:                     if (uri.resolveActivity(webView.getContext().getPackageManager()) != null) {
   54:                         webView.getContext().startActivity(uri);
   55:                     } else {
   56:                         Intent data = new Intent("android.intent.action.VIEW").setData(Uri.parse("market://details?id=" + uri.getPackage()));
   57:                         kotlin.jvm.internal.f.f(data, "setData(...)");
```

- **shouldOverrideUrlLoading** @ L71 — `WebViewClient.shouldOverrideUrlLoading` (high/hookpoint)
  - **条件**：`if (uri.resolveActivity(webView.getContext().getPackageManager()) != null) { \| if (data.resolveActivity(webView.getContext().getPackageManager()) != null) {`

  **代码上下文**：
```
   56:                         Intent data = new Intent("android.intent.action.VIEW").setData(Uri.parse("market://details?id=" + uri.getPackage()));
   57:                         kotlin.jvm.internal.f.f(data, "setData(...)");
   58:                         if (data.resolveActivity(webView.getContext().getPackageManager()) != null) {
   59:                             webView.getContext().startActivity(data);
   60:                         }
   61:                     }
   62:                 } catch (Exception unused) {
   63:                     eVar.b();
   64:                 }
   65:             }
   66:         }
   67:         return true;
   68:     }
   69: 
   70:     @Override // android.webkit.WebViewClient
>> 71:     public final boolean shouldOverrideUrlLoading(WebView webView, String str) {
   72:         return a(webView, str, null);
   73:     }
   74: 
   75:     @Override // android.webkit.WebViewClient
   76:     public final boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
   77:         kotlin.jvm.internal.f.g(view, "view");
   78:         kotlin.jvm.internal.f.g(request, "request");
   79:         return a(view, request.getUrl().toString(), Boolean.valueOf(request.hasGesture()));
   80:     }
   81: }
```

- **shouldOverrideUrlLoading** @ L76 — `WebViewClient.shouldOverrideUrlLoading` (high/hookpoint)
  - **条件**：`if (uri.resolveActivity(webView.getContext().getPackageManager()) != null) { \| if (data.resolveActivity(webView.getContext().getPackageManager()) != null) {`

  **代码上下文**：
```
   61:                     }
   62:                 } catch (Exception unused) {
   63:                     eVar.b();
   64:                 }
   65:             }
   66:         }
   67:         return true;
   68:     }
   69: 
   70:     @Override // android.webkit.WebViewClient
   71:     public final boolean shouldOverrideUrlLoading(WebView webView, String str) {
   72:         return a(webView, str, null);
   73:     }
   74: 
   75:     @Override // android.webkit.WebViewClient
>> 76:     public final boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
   77:         kotlin.jvm.internal.f.g(view, "view");
   78:         kotlin.jvm.internal.f.g(request, "request");
   79:         return a(view, request.getUrl().toString(), Boolean.valueOf(request.hasGesture()));
   80:     }
   81: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/ads/impl/screens/hybridvideo/w.java`

- **setJavaScriptEnabledTrue** @ L15 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)

  **代码上下文**：
```
   1: package com.reddit.ads.impl.screens.hybridvideo;
   2: 
   3: import android.webkit.WebSettings;
   4: import ca.C9079b;
   5: import com.reddit.ads.analytics.AdPlacementType;
   6: import com.reddit.ads.analytics.ClickLocation;
   7: import com.reddit.domain.model.Link;
   8: import com.reddit.videoplayer.player.VideoDimensions;
   9: 
   10: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   11: /* loaded from: classes5.dex */
   12: public abstract class w {
   13:     public static final void a(f fVar) {
   14:         WebSettings settings = fVar.getSettings();
>> 15:         settings.setJavaScriptEnabled(true);
   16:         settings.setDomStorageEnabled(true);
   17:         settings.setLoadWithOverviewMode(true);
   18:         settings.setUseWideViewPort(true);
   19:         settings.setBuiltInZoomControls(true);
   20:         settings.setDisplayZoomControls(false);
   21:         settings.setDomStorageEnabled(true);
   22:         settings.setMediaPlaybackRequiresUserGesture(false);
   23:     }
   24: 
   25:     public static final int b(VideoDimensions videoDimensions, float f3, int i5, int i10) {
   26:         kotlin.jvm.internal.f.g(videoDimensions, "videoDimensions");
   27:         if (videoDimensions.f131552b <= videoDimensions.f131551a) {
   28:             i5 = (int) Math.max(i10, i5 / videoDimensions.a());
   29:         }
   30:         return (int) (i5 / f3);
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/RedditWebUtil$clearCookiesCompletable$2.java`

- **cookieManagerOps** @ L7 — `CookieManager operations` (medium/settings)

  **代码上下文**：
```
   1: package com.reddit.auth.login.common.util;
   2: 
   3: import Fk0.v;
   4: import Tk0.n;
   5: import android.content.res.Resources;
   6: import android.util.AndroidRuntimeException;
>> 7: import android.webkit.CookieManager;
   8: import com.reddit.appupdate.h;
   9: import kotlin.Metadata;
   10: import kotlin.coroutines.intrinsics.CoroutineSingletons;
   11: import kotlin.coroutines.jvm.internal.SuspendLambda;
   12: import kotlin.text.p;
   13: import kotlinx.coroutines.A;
   14: 
   15: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   16: @Lk0.c(c = "com.reddit.auth.login.common.util.RedditWebUtil$clearCookiesCompletable$2", f = "RedditWebUtil.kt", l = {}, m = "invokeSuspend", v = 1)
   17: @Metadata(d1 = {"\u0000\f\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\u0010\u0002\u001a\u00020\u0001*\u00020\u0000H\n¢\u0006\u0004\b\u0002\u0010\u0003"}, d2 = {"Lkotlinx/coroutines/A;", "LFk0/v;", "<anonymous>", "(Lkotlinx/coroutines/A;)V"}, k = 3, mv = {2, 2, 0})
   18: /* loaded from: classes5.dex */
   19: final class RedditWebUtil$clearCookiesCompletable$2 extends SuspendLambda implements n {
   20:     int label;
   21:     final /* synthetic */ c this$0;
   22: 
```

- **cookieManagerOps** @ L43 — `CookieManager operations` (medium/settings)
  - **条件**：`if (this.label != 0) {`

  **代码上下文**：
```
   28: 
   29:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   30:     public final Kk0.b<v> create(Object obj, Kk0.b<?> bVar) {
   31:         return new RedditWebUtil$clearCookiesCompletable$2(this.this$0, bVar);
   32:     }
   33: 
   34:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   35:     public final Object invokeSuspend(Object obj) {
   36:         String message;
   37:         CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   38:         if (this.label != 0) {
   39:             throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   40:         }
   41:         kotlin.b.b(obj);
   42:         try {
>> 43:             CookieManager.getInstance().removeAllCookies(null);
   44:         } catch (Resources.NotFoundException e11) {
   45:             WP.d.b(this.this$0.f71099a, "RedditWebUtil", null, e11, new h(27), 2);
   46:         } catch (AndroidRuntimeException e12) {
   47:             String message2 = e12.getMessage();
   48:             if ((message2 != null && p.O(message2, "MissingWebViewPackageException", false)) || ((message = e12.getMessage()) != null && p.O(message, "No WebView installed", false))) {
   49:                 WP.d dVar = this.this$0.f71099a;
   50:                 Throwable cause = e12.getCause();
   51:                 WP.d.b(dVar, "RedditWebUtil", null, cause == null ? e12 : cause, new h(26), 2);
   52:             }
   53:         }
   54:         return v.f6415a;
   55:     }
   56: 
   57:     @Override // Tk0.n
   58:     public final Object invoke(A a9, Kk0.b<? super v> bVar) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/auth/login/common/util/c.java`

- **cookieManagerOps** @ L109 — `CookieManager operations` (medium/settings)
  - **条件**：`if (r7 != 0) goto L53 \| if (r7 != r1) goto L85`

  **代码上下文**：
```
   94:             java.lang.String r5 = r8.b()
   95:             java.lang.String r7 = "loid="
   96:             java.lang.String r8 = "; Secure; Domain=.reddit.com"
   97:             java.lang.String r5 = G.e.l(r7, r5, r8)
   98:             r0.L$0 = r9
   99:             r0.L$1 = r9
   100:             r0.L$2 = r9
   101:             r0.L$3 = r9
   102:             r0.L$4 = r6
   103:             r0.L$5 = r5
   104:             r0.label = r3
   105:             java.lang.Object r7 = r4.a(r0)
   106:             if (r7 != r1) goto L85
   107:             return r1
   108:         L85:
>> 109:             android.webkit.CookieManager r7 = android.webkit.CookieManager.getInstance()
   110:             java.lang.String r8 = "https://reddit.com"
   111:             if (r6 == 0) goto L90
   112:             r7.setCookie(r8, r6)
   113:         L90:
   114:             r7.setCookie(r8, r5)
   115:             Fk0.v r5 = Fk0.v.f6415a
   116:             return r5
   117:         */
   118:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.auth.login.common.util.c.b(android.content.Context, android.accounts.Account, com.reddit.session.Session, Kd0.d, kotlin.coroutines.jvm.internal.ContinuationImpl):java.lang.Object");
   119:     }
   120: }
```

- **cookieManagerOps** @ L112 — `CookieManager operations` (medium/settings)
  - **条件**：`if (r7 != 0) goto L53 \| if (r7 != r1) goto L85 \| if (r6 == 0) goto L90`

  **代码上下文**：
```
   97:             java.lang.String r5 = G.e.l(r7, r5, r8)
   98:             r0.L$0 = r9
   99:             r0.L$1 = r9
   100:             r0.L$2 = r9
   101:             r0.L$3 = r9
   102:             r0.L$4 = r6
   103:             r0.L$5 = r5
   104:             r0.label = r3
   105:             java.lang.Object r7 = r4.a(r0)
   106:             if (r7 != r1) goto L85
   107:             return r1
   108:         L85:
   109:             android.webkit.CookieManager r7 = android.webkit.CookieManager.getInstance()
   110:             java.lang.String r8 = "https://reddit.com"
   111:             if (r6 == 0) goto L90
>> 112:             r7.setCookie(r8, r6)
   113:         L90:
   114:             r7.setCookie(r8, r5)
   115:             Fk0.v r5 = Fk0.v.f6415a
   116:             return r5
   117:         */
   118:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.auth.login.common.util.c.b(android.content.Context, android.accounts.Account, com.reddit.session.Session, Kd0.d, kotlin.coroutines.jvm.internal.ContinuationImpl):java.lang.Object");
   119:     }
   120: }
```

- **cookieManagerOps** @ L114 — `CookieManager operations` (medium/settings)
  - **条件**：`if (r7 != r1) goto L85 \| if (r6 == 0) goto L90`

  **代码上下文**：
```
   99:             r0.L$1 = r9
   100:             r0.L$2 = r9
   101:             r0.L$3 = r9
   102:             r0.L$4 = r6
   103:             r0.L$5 = r5
   104:             r0.label = r3
   105:             java.lang.Object r7 = r4.a(r0)
   106:             if (r7 != r1) goto L85
   107:             return r1
   108:         L85:
   109:             android.webkit.CookieManager r7 = android.webkit.CookieManager.getInstance()
   110:             java.lang.String r8 = "https://reddit.com"
   111:             if (r6 == 0) goto L90
   112:             r7.setCookie(r8, r6)
   113:         L90:
>> 114:             r7.setCookie(r8, r5)
   115:             Fk0.v r5 = Fk0.v.f6415a
   116:             return r5
   117:         */
   118:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.auth.login.common.util.c.b(android.content.Context, android.accounts.Account, com.reddit.session.Session, Kd0.d, kotlin.coroutines.jvm.internal.ContinuationImpl):java.lang.Object");
   119:     }
   120: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/presentation/composables/speedread/a.java`

- **cookieManagerOps** @ L7 — `CookieManager operations` (medium/settings)

  **代码上下文**：
```
   1: package com.reddit.comments.presentation.composables.speedread;
   2: 
   3: import Fk0.v;
   4: import Q0.l;
   5: import Tk0.k;
   6: import android.graphics.PointF;
>> 7: import android.webkit.CookieManager;
   8: import android.webkit.WebSettings;
   9: import android.webkit.WebView;
   10: import androidx.compose.runtime.InterfaceC8113d0;
   11: import androidx.compose.ui.layout.AbstractC8222w;
   12: import androidx.compose.ui.layout.InterfaceC8221v;
   13: import androidx.compose.ui.text.W;
   14: import androidx.compose.ui.text.input.z;
   15: import com.bumptech.glide.load.DecodeFormat;
   16: import com.reddit.fullbleedplayer.composables.SubsamplingImageComposeViewKt;
   17: import com.reddit.ui.compose.ds.U1;
   18: import kotlin.jvm.internal.Ref$FloatRef;
   19: import x0.C20107a;
   20: import x0.C20111e;
   21: 
   22: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
```

- **setJavaScriptEnabledTrue** @ L153 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`case 22: \| case 23: \| case 24:`

  **代码上下文**：
```
   138:                 kotlin.jvm.internal.f.g(coordinates4, "coordinates");
   139:                 interfaceC8113d0.setValue(AbstractC8222w.f(coordinates4));
   140:                 break;
   141:             case 23:
   142:                 kotlin.jvm.internal.f.g((InterfaceC8221v) obj, "it");
   143:                 interfaceC8113d0.setValue(Boolean.TRUE);
   144:                 break;
   145:             case 24:
   146:                 WebView webView = (WebView) obj;
   147:                 kotlin.jvm.internal.f.g(webView, "webView");
   148:                 interfaceC8113d0.setValue(webView);
   149:                 webView.setBackgroundColor(0);
   150:                 webView.setLayerType(2, null);
   151:                 webView.setOnTouchListener(new com.reddit.ads.impl.screens.hybridvideo.compose.composables.webview.f(2, new Ref$FloatRef(), new Ref$FloatRef()));
   152:                 WebSettings settings = webView.getSettings();
>> 153:                 settings.setJavaScriptEnabled(true);
   154:                 settings.setDomStorageEnabled(true);
   155:                 settings.setDatabaseEnabled(true);
   156:                 settings.setMediaPlaybackRequiresUserGesture(false);
   157:                 settings.setUseWideViewPort(true);
   158:                 settings.setLoadWithOverviewMode(true);
   159:                 settings.setAllowFileAccess(false);
   160:                 settings.setAllowContentAccess(true);
   161:                 settings.setJavaScriptCanOpenWindowsAutomatically(true);
   162:                 settings.setSupportMultipleWindows(true);
   163:                 CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true);
   164:                 break;
   165:             case 25:
   166:                 W it6 = (W) obj;
   167:                 kotlin.jvm.internal.f.g(it6, "it");
   168:                 interfaceC8113d0.setValue(it6);
```

- **setAllowFileAccess** @ L159 — `WebSettings.setAllowFileAccess / setAllowFileAccessFromFileURLs` (low/settings)
  - **条件**：`case 22: \| case 23: \| case 24:`

  **代码上下文**：
```
   144:                 break;
   145:             case 24:
   146:                 WebView webView = (WebView) obj;
   147:                 kotlin.jvm.internal.f.g(webView, "webView");
   148:                 interfaceC8113d0.setValue(webView);
   149:                 webView.setBackgroundColor(0);
   150:                 webView.setLayerType(2, null);
   151:                 webView.setOnTouchListener(new com.reddit.ads.impl.screens.hybridvideo.compose.composables.webview.f(2, new Ref$FloatRef(), new Ref$FloatRef()));
   152:                 WebSettings settings = webView.getSettings();
   153:                 settings.setJavaScriptEnabled(true);
   154:                 settings.setDomStorageEnabled(true);
   155:                 settings.setDatabaseEnabled(true);
   156:                 settings.setMediaPlaybackRequiresUserGesture(false);
   157:                 settings.setUseWideViewPort(true);
   158:                 settings.setLoadWithOverviewMode(true);
>> 159:                 settings.setAllowFileAccess(false);
   160:                 settings.setAllowContentAccess(true);
   161:                 settings.setJavaScriptCanOpenWindowsAutomatically(true);
   162:                 settings.setSupportMultipleWindows(true);
   163:                 CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true);
   164:                 break;
   165:             case 25:
   166:                 W it6 = (W) obj;
   167:                 kotlin.jvm.internal.f.g(it6, "it");
   168:                 interfaceC8113d0.setValue(it6);
   169:                 break;
   170:             case 26:
   171:                 z it7 = (z) obj;
   172:                 kotlin.jvm.internal.f.g(it7, "it");
   173:                 interfaceC8113d0.setValue(it7);
   174:                 break;
```

- **cookieManagerOps** @ L163 — `CookieManager operations` (medium/settings)
  - **条件**：`case 22: \| case 23: \| case 24:`

  **代码上下文**：
```
   148:                 interfaceC8113d0.setValue(webView);
   149:                 webView.setBackgroundColor(0);
   150:                 webView.setLayerType(2, null);
   151:                 webView.setOnTouchListener(new com.reddit.ads.impl.screens.hybridvideo.compose.composables.webview.f(2, new Ref$FloatRef(), new Ref$FloatRef()));
   152:                 WebSettings settings = webView.getSettings();
   153:                 settings.setJavaScriptEnabled(true);
   154:                 settings.setDomStorageEnabled(true);
   155:                 settings.setDatabaseEnabled(true);
   156:                 settings.setMediaPlaybackRequiresUserGesture(false);
   157:                 settings.setUseWideViewPort(true);
   158:                 settings.setLoadWithOverviewMode(true);
   159:                 settings.setAllowFileAccess(false);
   160:                 settings.setAllowContentAccess(true);
   161:                 settings.setJavaScriptCanOpenWindowsAutomatically(true);
   162:                 settings.setSupportMultipleWindows(true);
>> 163:                 CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true);
   164:                 break;
   165:             case 25:
   166:                 W it6 = (W) obj;
   167:                 kotlin.jvm.internal.f.g(it6, "it");
   168:                 interfaceC8113d0.setValue(it6);
   169:                 break;
   170:             case 26:
   171:                 z it7 = (z) obj;
   172:                 kotlin.jvm.internal.f.g(it7, "it");
   173:                 interfaceC8113d0.setValue(it7);
   174:                 break;
   175:             case 27:
   176:                 Boolean bool2 = (Boolean) obj;
   177:                 bool2.booleanValue();
   178:                 interfaceC8113d0.setValue(bool2);
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/comments/tree/n.java`

- **setJavaScriptEnabledTrue** @ L451 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8:`

  **代码上下文**：
```
   436:                 if (((AbstractC14858a) collectionU).isEmpty()) {
   437:                     androidx.compose.foundation.lazy.n.d(LazyColumn5, "no_activity_key", null, com.reddit.econearn.activitylist.presentation.composables.a.f80533b, i5);
   438:                 } else {
   439:                     int i15 = 0;
   440:                     for (GH.a aVar2 : collectionU) {
   441:                         androidx.compose.foundation.lazy.n.d(LazyColumn5, i15 + "_" + aVar2.hashCode(), null, new androidx.compose.runtime.internal.a(new E9.a(aVar2, i15, kVar6), 579615642, true), 2);
   442:                         i15++;
   443:                     }
   444:                 }
   445:                 return vVar;
   446:             case 8:
   447:                 Context context2 = (Context) obj;
   448:                 kotlin.jvm.internal.f.g(context2, "context");
   449:                 WebView webView = new WebView(context2);
   450:                 webView.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
>> 451:                 webView.getSettings().setJavaScriptEnabled(true);
   452:                 webView.getSettings().setDomStorageEnabled(true);
   453:                 webView.setWebViewClient((C8822a) obj3);
   454:                 webView.setWebChromeClient(new com.reddit.econearn.onboarding.composables.j());
   455:                 webView.loadUrl((String) key);
   456:                 ((InterfaceC8113d0) obj2).setValue(webView);
   457:                 FrameLayout frameLayout = new FrameLayout(context2);
   458:                 frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   459:                 frameLayout.addView(webView);
   460:                 return frameLayout;
   461:             case 9:
   462:                 Uk0.a aVar3 = (qm0.c) obj3;
   463:                 androidx.compose.foundation.lazy.n LazyColumn6 = (androidx.compose.foundation.lazy.n) obj;
   464:                 kotlin.jvm.internal.f.g(LazyColumn6, "$this$LazyColumn");
   465:                 androidx.compose.foundation.lazy.n.e(LazyColumn6, ((AbstractC14858a) aVar3).size(), null, null, new androidx.compose.runtime.internal.a(new G40.b(aVar3, i13, (Tk0.k) key, (androidx.compose.foundation.pager.r) obj2), 626449738, true), 6);
   466:                 return vVar;
```

- **setWebViewClient** @ L453 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8:`

  **代码上下文**：
```
   438:                 } else {
   439:                     int i15 = 0;
   440:                     for (GH.a aVar2 : collectionU) {
   441:                         androidx.compose.foundation.lazy.n.d(LazyColumn5, i15 + "_" + aVar2.hashCode(), null, new androidx.compose.runtime.internal.a(new E9.a(aVar2, i15, kVar6), 579615642, true), 2);
   442:                         i15++;
   443:                     }
   444:                 }
   445:                 return vVar;
   446:             case 8:
   447:                 Context context2 = (Context) obj;
   448:                 kotlin.jvm.internal.f.g(context2, "context");
   449:                 WebView webView = new WebView(context2);
   450:                 webView.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   451:                 webView.getSettings().setJavaScriptEnabled(true);
   452:                 webView.getSettings().setDomStorageEnabled(true);
>> 453:                 webView.setWebViewClient((C8822a) obj3);
   454:                 webView.setWebChromeClient(new com.reddit.econearn.onboarding.composables.j());
   455:                 webView.loadUrl((String) key);
   456:                 ((InterfaceC8113d0) obj2).setValue(webView);
   457:                 FrameLayout frameLayout = new FrameLayout(context2);
   458:                 frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   459:                 frameLayout.addView(webView);
   460:                 return frameLayout;
   461:             case 9:
   462:                 Uk0.a aVar3 = (qm0.c) obj3;
   463:                 androidx.compose.foundation.lazy.n LazyColumn6 = (androidx.compose.foundation.lazy.n) obj;
   464:                 kotlin.jvm.internal.f.g(LazyColumn6, "$this$LazyColumn");
   465:                 androidx.compose.foundation.lazy.n.e(LazyColumn6, ((AbstractC14858a) aVar3).size(), null, null, new androidx.compose.runtime.internal.a(new G40.b(aVar3, i13, (Tk0.k) key, (androidx.compose.foundation.pager.r) obj2), 626449738, true), 6);
   466:                 return vVar;
   467:             case 10:
   468:                 kotlin.jvm.internal.f.g((D0) obj, "it");
```

- **setWebChromeClient** @ L454 — `WebView.setWebChromeClient` (high/hookpoint)
  - **条件**：`if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8:`

  **代码上下文**：
```
   439:                     int i15 = 0;
   440:                     for (GH.a aVar2 : collectionU) {
   441:                         androidx.compose.foundation.lazy.n.d(LazyColumn5, i15 + "_" + aVar2.hashCode(), null, new androidx.compose.runtime.internal.a(new E9.a(aVar2, i15, kVar6), 579615642, true), 2);
   442:                         i15++;
   443:                     }
   444:                 }
   445:                 return vVar;
   446:             case 8:
   447:                 Context context2 = (Context) obj;
   448:                 kotlin.jvm.internal.f.g(context2, "context");
   449:                 WebView webView = new WebView(context2);
   450:                 webView.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   451:                 webView.getSettings().setJavaScriptEnabled(true);
   452:                 webView.getSettings().setDomStorageEnabled(true);
   453:                 webView.setWebViewClient((C8822a) obj3);
>> 454:                 webView.setWebChromeClient(new com.reddit.econearn.onboarding.composables.j());
   455:                 webView.loadUrl((String) key);
   456:                 ((InterfaceC8113d0) obj2).setValue(webView);
   457:                 FrameLayout frameLayout = new FrameLayout(context2);
   458:                 frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   459:                 frameLayout.addView(webView);
   460:                 return frameLayout;
   461:             case 9:
   462:                 Uk0.a aVar3 = (qm0.c) obj3;
   463:                 androidx.compose.foundation.lazy.n LazyColumn6 = (androidx.compose.foundation.lazy.n) obj;
   464:                 kotlin.jvm.internal.f.g(LazyColumn6, "$this$LazyColumn");
   465:                 androidx.compose.foundation.lazy.n.e(LazyColumn6, ((AbstractC14858a) aVar3).size(), null, null, new androidx.compose.runtime.internal.a(new G40.b(aVar3, i13, (Tk0.k) key, (androidx.compose.foundation.pager.r) obj2), 626449738, true), 6);
   466:                 return vVar;
   467:             case 10:
   468:                 kotlin.jvm.internal.f.g((D0) obj, "it");
   469:                 AbstractC9910p.d((C13971z) obj3, HeaderClickLocation.TITLE, (FeedType) key, (com.reddit.feeds.ui.c) obj2, true);
```

- **loadUrlDynamic** @ L455 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (cVarE != null) { \| if (((AbstractC14858a) collectionU).isEmpty()) { \| case 8:`

  **代码上下文**：
```
   440:                     for (GH.a aVar2 : collectionU) {
   441:                         androidx.compose.foundation.lazy.n.d(LazyColumn5, i15 + "_" + aVar2.hashCode(), null, new androidx.compose.runtime.internal.a(new E9.a(aVar2, i15, kVar6), 579615642, true), 2);
   442:                         i15++;
   443:                     }
   444:                 }
   445:                 return vVar;
   446:             case 8:
   447:                 Context context2 = (Context) obj;
   448:                 kotlin.jvm.internal.f.g(context2, "context");
   449:                 WebView webView = new WebView(context2);
   450:                 webView.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   451:                 webView.getSettings().setJavaScriptEnabled(true);
   452:                 webView.getSettings().setDomStorageEnabled(true);
   453:                 webView.setWebViewClient((C8822a) obj3);
   454:                 webView.setWebChromeClient(new com.reddit.econearn.onboarding.composables.j());
>> 455:                 webView.loadUrl((String) key);
   456:                 ((InterfaceC8113d0) obj2).setValue(webView);
   457:                 FrameLayout frameLayout = new FrameLayout(context2);
   458:                 frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -1));
   459:                 frameLayout.addView(webView);
   460:                 return frameLayout;
   461:             case 9:
   462:                 Uk0.a aVar3 = (qm0.c) obj3;
   463:                 androidx.compose.foundation.lazy.n LazyColumn6 = (androidx.compose.foundation.lazy.n) obj;
   464:                 kotlin.jvm.internal.f.g(LazyColumn6, "$this$LazyColumn");
   465:                 androidx.compose.foundation.lazy.n.e(LazyColumn6, ((AbstractC14858a) aVar3).size(), null, null, new androidx.compose.runtime.internal.a(new G40.b(aVar3, i13, (Tk0.k) key, (androidx.compose.foundation.pager.r) obj2), 626449738, true), 6);
   466:                 return vVar;
   467:             case 10:
   468:                 kotlin.jvm.internal.f.g((D0) obj, "it");
   469:                 AbstractC9910p.d((C13971z) obj3, HeaderClickLocation.TITLE, (FeedType) key, (com.reddit.feeds.ui.c) obj2, true);
   470:                 return vVar;
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/data/model/mediaupload/ProgressRequestBody.java`

- **cookieManagerOps** @ L95 — `CookieManager operations` (medium/settings)

  **代码上下文**：
```
   80:     @Override // okhttp3.RequestBody
   81:     public boolean isDuplex() {
   82:         return this.delegate.isDuplex();
   83:     }
   84: 
   85:     @Override // okhttp3.RequestBody
   86:     public boolean isOneShot() {
   87:         return this.delegate.isOneShot();
   88:     }
   89: 
   90:     @Override // okhttp3.RequestBody
   91:     public void writeTo(InterfaceC7176l sink) {
   92:         kotlin.jvm.internal.f.g(sink, "sink");
   93:         I iB2 = AbstractC7166b.b(new ProgressSink(sink, this._progressChannel, contentLength()));
   94:         this.delegate.writeTo(iB2);
>> 95:         iB2.flush();
   96:         this._progressChannel.l(null);
   97:     }
   98: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/g.java`

- **webResourceResponse** @ L8 — `WebResourceResponse` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.devplatform.composables.blocks.beta.block.webview;
   2: 
   3: import A.AbstractC0117w;
   4: import Mf0.m;
   5: import android.graphics.Bitmap;
   6: import android.webkit.RenderProcessGoneDetail;
   7: import android.webkit.WebResourceRequest;
>> 8: import android.webkit.WebResourceResponse;
   9: import android.webkit.WebView;
   10: import android.webkit.WebViewClient;
   11: import com.google.protobuf.Struct;
   12: import gh.C13356b;
   13: import gh.C13360f;
   14: import ia0.AbstractC14359a;
   15: import java.io.ByteArrayInputStream;
   16: import java.io.IOException;
   17: import java.nio.charset.Charset;
   18: import java.nio.charset.StandardCharsets;
   19: import java.util.Map;
   20: import kotlin.text.q;
   21: import kotlinx.coroutines.A;
   22: import kotlinx.coroutines.t0;
   23: import kotlinx.coroutines.w0;
```

- **webResourceResponse** @ L113 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (t0Var2 == null \|\| !t0Var2.isActive() \|\| (t0Var = this.f78321o) == null) {`

  **代码上下文**：
```
   98:         this.f78317k = coroutineScope;
   99:         this.f78318l = dispatcherProvider;
   100:         this.f78319m = cVar;
   101:         this.f78320n = z13;
   102:     }
   103: 
   104:     public final void a() {
   105:         t0 t0Var;
   106:         t0 t0Var2 = this.f78321o;
   107:         if (t0Var2 == null || !t0Var2.isActive() || (t0Var = this.f78321o) == null) {
   108:             return;
   109:         }
   110:         t0Var.cancel(null);
   111:     }
   112: 
>> 113:     public final WebResourceResponse b(WebResourceRequest webResourceRequest) throws IOException {
   114:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   115:         try {
   116:             if (!responseExecute.getIsSuccessful()) {
   117:                 throw new IOException("Failed to load JS file: " + responseExecute.code());
   118:             }
   119:             String str = NN.a.z(this.f78312f, this.f78313g) + "\n" + responseExecute.body().string();
   120:             responseExecute.close();
   121:             Charset UTF_8 = StandardCharsets.UTF_8;
   122:             kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   123:             byte[] bytes = str.getBytes(UTF_8);
   124:             kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
   125:             return new WebResourceResponse("application/javascript", "UTF-8", new ByteArrayInputStream(bytes));
   126:         } finally {
   127:         }
   128:     }
```

- **webResourceResponse** @ L125 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();`

  **代码上下文**：
```
   110:         t0Var.cancel(null);
   111:     }
   112: 
   113:     public final WebResourceResponse b(WebResourceRequest webResourceRequest) throws IOException {
   114:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   115:         try {
   116:             if (!responseExecute.getIsSuccessful()) {
   117:                 throw new IOException("Failed to load JS file: " + responseExecute.code());
   118:             }
   119:             String str = NN.a.z(this.f78312f, this.f78313g) + "\n" + responseExecute.body().string();
   120:             responseExecute.close();
   121:             Charset UTF_8 = StandardCharsets.UTF_8;
   122:             kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   123:             byte[] bytes = str.getBytes(UTF_8);
   124:             kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
>> 125:             return new WebResourceResponse("application/javascript", "UTF-8", new ByteArrayInputStream(bytes));
   126:         } finally {
   127:         }
   128:     }
   129: 
   130:     public final WebResourceResponse c(WebResourceRequest webResourceRequest) throws IOException {
   131:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   132:         if (!responseExecute.getIsSuccessful()) {
   133:             responseExecute.close();
   134:             throw new IOException(AbstractC0117w.n(responseExecute.code(), "Failed to load JS file: "));
   135:         }
   136:         String strO = W9.e.o(NN.a.z(this.f78312f, this.f78313g), "\n");
   137:         Charset UTF_8 = StandardCharsets.UTF_8;
   138:         kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   139:         byte[] bytes = strO.getBytes(UTF_8);
   140:         kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
```

- **webResourceResponse** @ L130 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();`

  **代码上下文**：
```
   115:         try {
   116:             if (!responseExecute.getIsSuccessful()) {
   117:                 throw new IOException("Failed to load JS file: " + responseExecute.code());
   118:             }
   119:             String str = NN.a.z(this.f78312f, this.f78313g) + "\n" + responseExecute.body().string();
   120:             responseExecute.close();
   121:             Charset UTF_8 = StandardCharsets.UTF_8;
   122:             kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   123:             byte[] bytes = str.getBytes(UTF_8);
   124:             kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
   125:             return new WebResourceResponse("application/javascript", "UTF-8", new ByteArrayInputStream(bytes));
   126:         } finally {
   127:         }
   128:     }
   129: 
>> 130:     public final WebResourceResponse c(WebResourceRequest webResourceRequest) throws IOException {
   131:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   132:         if (!responseExecute.getIsSuccessful()) {
   133:             responseExecute.close();
   134:             throw new IOException(AbstractC0117w.n(responseExecute.code(), "Failed to load JS file: "));
   135:         }
   136:         String strO = W9.e.o(NN.a.z(this.f78312f, this.f78313g), "\n");
   137:         Charset UTF_8 = StandardCharsets.UTF_8;
   138:         kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   139:         byte[] bytes = strO.getBytes(UTF_8);
   140:         kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
   141:         return new WebResourceResponse("application/javascript", "UTF-8", new BE.b(bytes, responseExecute.body().byteStream(), responseExecute));
   142:     }
   143: 
   144:     @Override // android.webkit.WebViewClient
   145:     public final void onPageFinished(WebView webView, String str) {
```

- **webResourceResponse** @ L141 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute(); \| Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();`

  **代码上下文**：
```
   126:         } finally {
   127:         }
   128:     }
   129: 
   130:     public final WebResourceResponse c(WebResourceRequest webResourceRequest) throws IOException {
   131:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   132:         if (!responseExecute.getIsSuccessful()) {
   133:             responseExecute.close();
   134:             throw new IOException(AbstractC0117w.n(responseExecute.code(), "Failed to load JS file: "));
   135:         }
   136:         String strO = W9.e.o(NN.a.z(this.f78312f, this.f78313g), "\n");
   137:         Charset UTF_8 = StandardCharsets.UTF_8;
   138:         kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   139:         byte[] bytes = strO.getBytes(UTF_8);
   140:         kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
>> 141:         return new WebResourceResponse("application/javascript", "UTF-8", new BE.b(bytes, responseExecute.body().byteStream(), responseExecute));
   142:     }
   143: 
   144:     @Override // android.webkit.WebViewClient
   145:     public final void onPageFinished(WebView webView, String str) {
   146:         super.onPageFinished(webView, str);
   147:         Struct struct = this.f78307a;
   148:         if (struct != null && struct.getFieldsCount() > 0 && webView != null) {
   149:             String string = new JSONObject((Map<?, ?>) AbstractC14359a.f(struct.getFieldsMap())).toString();
   150:             kotlin.jvm.internal.f.f(string, "toString(...)");
   151:             NN.a.I(webView, q.q("\n         window.dispatchEvent(\n           new MessageEvent(\n              'message',\n              {\n                data: {\n                  type: 'stateUpdate',\n                  data: JSON.parse(`" + ((Object) string) + "`)\n                }\n              }\n           )\n        );\n    "), "Initial state has been passed to webview");
   152:         }
   153:         if (webView == null || webView.getProgress() != 100) {
   154:             return;
   155:         }
   156:         this.f78308b.invoke();
```

- **onPageFinished** @ L145 — `WebViewClient.onPageFinished` (high/hookpoint)
  - **条件**：`Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();`

  **代码上下文**：
```
   130:     public final WebResourceResponse c(WebResourceRequest webResourceRequest) throws IOException {
   131:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   132:         if (!responseExecute.getIsSuccessful()) {
   133:             responseExecute.close();
   134:             throw new IOException(AbstractC0117w.n(responseExecute.code(), "Failed to load JS file: "));
   135:         }
   136:         String strO = W9.e.o(NN.a.z(this.f78312f, this.f78313g), "\n");
   137:         Charset UTF_8 = StandardCharsets.UTF_8;
   138:         kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   139:         byte[] bytes = strO.getBytes(UTF_8);
   140:         kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
   141:         return new WebResourceResponse("application/javascript", "UTF-8", new BE.b(bytes, responseExecute.body().byteStream(), responseExecute));
   142:     }
   143: 
   144:     @Override // android.webkit.WebViewClient
>> 145:     public final void onPageFinished(WebView webView, String str) {
   146:         super.onPageFinished(webView, str);
   147:         Struct struct = this.f78307a;
   148:         if (struct != null && struct.getFieldsCount() > 0 && webView != null) {
   149:             String string = new JSONObject((Map<?, ?>) AbstractC14359a.f(struct.getFieldsMap())).toString();
   150:             kotlin.jvm.internal.f.f(string, "toString(...)");
   151:             NN.a.I(webView, q.q("\n         window.dispatchEvent(\n           new MessageEvent(\n              'message',\n              {\n                data: {\n                  type: 'stateUpdate',\n                  data: JSON.parse(`" + ((Object) string) + "`)\n                }\n              }\n           )\n        );\n    "), "Initial state has been passed to webview");
   152:         }
   153:         if (webView == null || webView.getProgress() != 100) {
   154:             return;
   155:         }
   156:         this.f78308b.invoke();
   157:         C13360f c13360fL = D0.c.l();
   158:         com.reddit.devplatform.data.analytics.custompost.c cVar = this.f78319m;
   159:         cVar.f78478a.k(c13360fL, cVar.f78479b);
   160:         a();
```

- **onPageFinished** @ L146 — `WebViewClient.onPageFinished` (high/hookpoint)
  - **条件**：`Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();`

  **代码上下文**：
```
   131:         Response responseExecute = this.f78311e.newCall(new Request.Builder().url(String.valueOf(webResourceRequest != null ? webResourceRequest.getUrl() : null)).build()).execute();
   132:         if (!responseExecute.getIsSuccessful()) {
   133:             responseExecute.close();
   134:             throw new IOException(AbstractC0117w.n(responseExecute.code(), "Failed to load JS file: "));
   135:         }
   136:         String strO = W9.e.o(NN.a.z(this.f78312f, this.f78313g), "\n");
   137:         Charset UTF_8 = StandardCharsets.UTF_8;
   138:         kotlin.jvm.internal.f.f(UTF_8, "UTF_8");
   139:         byte[] bytes = strO.getBytes(UTF_8);
   140:         kotlin.jvm.internal.f.f(bytes, "getBytes(...)");
   141:         return new WebResourceResponse("application/javascript", "UTF-8", new BE.b(bytes, responseExecute.body().byteStream(), responseExecute));
   142:     }
   143: 
   144:     @Override // android.webkit.WebViewClient
   145:     public final void onPageFinished(WebView webView, String str) {
>> 146:         super.onPageFinished(webView, str);
   147:         Struct struct = this.f78307a;
   148:         if (struct != null && struct.getFieldsCount() > 0 && webView != null) {
   149:             String string = new JSONObject((Map<?, ?>) AbstractC14359a.f(struct.getFieldsMap())).toString();
   150:             kotlin.jvm.internal.f.f(string, "toString(...)");
   151:             NN.a.I(webView, q.q("\n         window.dispatchEvent(\n           new MessageEvent(\n              'message',\n              {\n                data: {\n                  type: 'stateUpdate',\n                  data: JSON.parse(`" + ((Object) string) + "`)\n                }\n              }\n           )\n        );\n    "), "Initial state has been passed to webview");
   152:         }
   153:         if (webView == null || webView.getProgress() != 100) {
   154:             return;
   155:         }
   156:         this.f78308b.invoke();
   157:         C13360f c13360fL = D0.c.l();
   158:         com.reddit.devplatform.data.analytics.custompost.c cVar = this.f78319m;
   159:         cVar.f78478a.k(c13360fL, cVar.f78479b);
   160:         a();
   161:     }
```

- **shouldInterceptRequest** @ L196 — `WebViewClient.shouldInterceptRequest` (high/hookpoint)
  - **条件**：`if (webView != null) { \| if (webView == null) {`

  **代码上下文**：
```
   181:         }
   182:         webView.destroy();
   183:         return true;
   184:     }
   185: 
   186:     /* JADX WARN: Multi-variable type inference failed */
   187:     /* JADX WARN: Removed duplicated region for block: B:18:0x0037  */
   188:     /* JADX WARN: Removed duplicated region for block: B:39:0x0049 A[EXC_TOP_SPLITTER, SYNTHETIC] */
   189:     /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:32:0x005b -> B:38:0x00c0). Please report as a decompilation issue!!! */
   190:     /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:33:0x008e -> B:38:0x00c0). Please report as a decompilation issue!!! */
   191:     @Override // android.webkit.WebViewClient
   192:     /*
   193:         Code decompiled incorrectly, please refer to instructions dump.
   194:         To view partially-correct add '--show-bad-code' argument
   195:     */
>> 196:     public final android.webkit.WebResourceResponse shouldInterceptRequest(android.webkit.WebView r13, android.webkit.WebResourceRequest r14) {
   197:         /*
   198:             r12 = this;
   199:             if (r14 == 0) goto L12
   200:             java.util.Map r0 = r14.getRequestHeaders()
   201:             if (r0 == 0) goto L12
   202:             java.lang.String r1 = "Accept-Encoding"
   203:             java.lang.String r2 = "gzip"
   204:             java.lang.Object r0 = r0.put(r1, r2)
   205:             java.lang.String r0 = (java.lang.String) r0
   206:         L12:
   207:             java.lang.String r1 = "javascript_injection_load_fail"
   208:             com.reddit.devplatform.data.analytics.custompost.c r2 = r12.f78319m
   209:             boolean r0 = r12.f78320n
   210:             r3 = 0
   211:             java.lang.String r4 = ".js"
```

- **webResourceResponse** @ L196 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (webView != null) { \| if (webView == null) {`

  **代码上下文**：
```
   181:         }
   182:         webView.destroy();
   183:         return true;
   184:     }
   185: 
   186:     /* JADX WARN: Multi-variable type inference failed */
   187:     /* JADX WARN: Removed duplicated region for block: B:18:0x0037  */
   188:     /* JADX WARN: Removed duplicated region for block: B:39:0x0049 A[EXC_TOP_SPLITTER, SYNTHETIC] */
   189:     /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:32:0x005b -> B:38:0x00c0). Please report as a decompilation issue!!! */
   190:     /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:33:0x008e -> B:38:0x00c0). Please report as a decompilation issue!!! */
   191:     @Override // android.webkit.WebViewClient
   192:     /*
   193:         Code decompiled incorrectly, please refer to instructions dump.
   194:         To view partially-correct add '--show-bad-code' argument
   195:     */
>> 196:     public final android.webkit.WebResourceResponse shouldInterceptRequest(android.webkit.WebView r13, android.webkit.WebResourceRequest r14) {
   197:         /*
   198:             r12 = this;
   199:             if (r14 == 0) goto L12
   200:             java.util.Map r0 = r14.getRequestHeaders()
   201:             if (r0 == 0) goto L12
   202:             java.lang.String r1 = "Accept-Encoding"
   203:             java.lang.String r2 = "gzip"
   204:             java.lang.Object r0 = r0.put(r1, r2)
   205:             java.lang.String r0 = (java.lang.String) r0
   206:         L12:
   207:             java.lang.String r1 = "javascript_injection_load_fail"
   208:             com.reddit.devplatform.data.analytics.custompost.c r2 = r12.f78319m
   209:             boolean r0 = r12.f78320n
   210:             r3 = 0
   211:             java.lang.String r4 = ".js"
```

- **webResourceResponse** @ L244 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (r14 == 0) goto L3e \| if (r0 == 0) goto Lc0 \| if (r0 == 0) goto L56`

  **代码上下文**：
```
   229:         L35:
   230:             if (r0 != 0) goto L49
   231:         L37:
   232:             if (r14 == 0) goto L3e
   233:             android.net.Uri r0 = r14.getUrl()
   234:             goto L3f
   235:         L3e:
   236:             r0 = r5
   237:         L3f:
   238:             java.lang.String r0 = java.lang.String.valueOf(r0)
   239:             boolean r0 = kotlin.text.w.y(r0, r4, r3)
   240:             if (r0 == 0) goto Lc0
   241:         L49:
   242:             boolean r0 = r12.f78314h     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   243:             if (r0 == 0) goto L56
>> 244:             android.webkit.WebResourceResponse r5 = r12.c(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   245:             goto Lc0
   246:         L52:
   247:             r0 = move-exception
   248:             goto L5b
   249:         L54:
   250:             r0 = move-exception
   251:             goto L8e
   252:         L56:
   253:             android.webkit.WebResourceResponse r5 = r12.b(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   254:             goto Lc0
   255:         L5b:
   256:             com.reddit.devplatform.composables.blocks.beta.block.webview.e r10 = new com.reddit.devplatform.composables.blocks.beta.block.webview.e
   257:             r3 = 1
   258:             r10.<init>(r3, r14, r0)
   259:             r11 = 6
```

- **webResourceResponse** @ L253 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (r14 == 0) goto L3e \| if (r0 == 0) goto Lc0 \| if (r0 == 0) goto L56`

  **代码上下文**：
```
   238:             java.lang.String r0 = java.lang.String.valueOf(r0)
   239:             boolean r0 = kotlin.text.w.y(r0, r4, r3)
   240:             if (r0 == 0) goto Lc0
   241:         L49:
   242:             boolean r0 = r12.f78314h     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   243:             if (r0 == 0) goto L56
   244:             android.webkit.WebResourceResponse r5 = r12.c(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   245:             goto Lc0
   246:         L52:
   247:             r0 = move-exception
   248:             goto L5b
   249:         L54:
   250:             r0 = move-exception
   251:             goto L8e
   252:         L56:
>> 253:             android.webkit.WebResourceResponse r5 = r12.b(r14)     // Catch: java.lang.Exception -> L52 java.lang.OutOfMemoryError -> L54
   254:             goto Lc0
   255:         L5b:
   256:             com.reddit.devplatform.composables.blocks.beta.block.webview.e r10 = new com.reddit.devplatform.composables.blocks.beta.block.webview.e
   257:             r3 = 1
   258:             r10.<init>(r3, r14, r0)
   259:             r11 = 6
   260:             WP.d r6 = r12.f78310d
   261:             java.lang.String r7 = "devplat-webview"
   262:             r8 = 0
   263:             r9 = 0
   264:             WP.d.b(r6, r7, r8, r9, r10, r11)
   265:             r12.a()
   266:             gh.b r3 = new gh.b
   267:             com.reddit.devplatform.data.analytics.custompost.f r4 = new com.reddit.devplatform.data.analytics.custompost.f
   268:             java.lang.Class r0 = r0.getClass()
```

- **shouldInterceptRequest** @ L304 — `WebViewClient.shouldInterceptRequest` (high/hookpoint)
  - **条件**：`if (r5 == 0) goto Lc3`

  **代码上下文**：
```
   289:             gh.b r3 = new gh.b
   290:             com.reddit.devplatform.data.analytics.custompost.f r4 = new com.reddit.devplatform.data.analytics.custompost.f
   291:             java.lang.Class r0 = r0.getClass()
   292:             kotlin.jvm.internal.i r6 = kotlin.jvm.internal.h.f149734a
   293:             al0.d r0 = r6.b(r0)
   294:             java.lang.String r0 = r0.s()
   295:             r4.<init>(r1, r0)
   296:             r3.<init>(r4)
   297:             com.reddit.devplatform.data.analytics.custompost.a r0 = r2.f78478a
   298:             com.reddit.devplatform.data.analytics.custompost.b r1 = r2.f78479b
   299:             r0.k(r3, r1)
   300:         Lc0:
   301:             if (r5 == 0) goto Lc3
   302:             return r5
   303:         Lc3:
>> 304:             android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14)
   305:             return r13
   306:         */
   307:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse");
   308:     }
   309: }
```

- **webResourceResponse** @ L304 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (r5 == 0) goto Lc3`

  **代码上下文**：
```
   289:             gh.b r3 = new gh.b
   290:             com.reddit.devplatform.data.analytics.custompost.f r4 = new com.reddit.devplatform.data.analytics.custompost.f
   291:             java.lang.Class r0 = r0.getClass()
   292:             kotlin.jvm.internal.i r6 = kotlin.jvm.internal.h.f149734a
   293:             al0.d r0 = r6.b(r0)
   294:             java.lang.String r0 = r0.s()
   295:             r4.<init>(r1, r0)
   296:             r3.<init>(r4)
   297:             com.reddit.devplatform.data.analytics.custompost.a r0 = r2.f78478a
   298:             com.reddit.devplatform.data.analytics.custompost.b r1 = r2.f78479b
   299:             r0.k(r3, r1)
   300:         Lc0:
   301:             if (r5 == 0) goto Lc3
   302:             return r5
   303:         Lc3:
>> 304:             android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14)
   305:             return r13
   306:         */
   307:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse");
   308:     }
   309: }
```

- **shouldInterceptRequest** @ L307 — `WebViewClient.shouldInterceptRequest` (high/hookpoint)
  - **条件**：`if (r5 == 0) goto Lc3`

  **代码上下文**：
```
   292:             kotlin.jvm.internal.i r6 = kotlin.jvm.internal.h.f149734a
   293:             al0.d r0 = r6.b(r0)
   294:             java.lang.String r0 = r0.s()
   295:             r4.<init>(r1, r0)
   296:             r3.<init>(r4)
   297:             com.reddit.devplatform.data.analytics.custompost.a r0 = r2.f78478a
   298:             com.reddit.devplatform.data.analytics.custompost.b r1 = r2.f78479b
   299:             r0.k(r3, r1)
   300:         Lc0:
   301:             if (r5 == 0) goto Lc3
   302:             return r5
   303:         Lc3:
   304:             android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14)
   305:             return r13
   306:         */
>> 307:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse");
   308:     }
   309: }
```

- **webResourceResponse** @ L307 — `WebResourceResponse` (medium/hookpoint)
  - **条件**：`if (r5 == 0) goto Lc3`

  **代码上下文**：
```
   292:             kotlin.jvm.internal.i r6 = kotlin.jvm.internal.h.f149734a
   293:             al0.d r0 = r6.b(r0)
   294:             java.lang.String r0 = r0.s()
   295:             r4.<init>(r1, r0)
   296:             r3.<init>(r4)
   297:             com.reddit.devplatform.data.analytics.custompost.a r0 = r2.f78478a
   298:             com.reddit.devplatform.data.analytics.custompost.b r1 = r2.f78479b
   299:             r0.k(r3, r1)
   300:         Lc0:
   301:             if (r5 == 0) goto Lc3
   302:             return r5
   303:         Lc3:
   304:             android.webkit.WebResourceResponse r13 = super.shouldInterceptRequest(r13, r14)
   305:             return r13
   306:         */
>> 307:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.devplatform.composables.blocks.beta.block.webview.g.shouldInterceptRequest(android.webkit.WebView, android.webkit.WebResourceRequest):android.webkit.WebResourceResponse");
   308:     }
   309: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/DevPlatformWebViewKt$WebViewContent$3$1.java`

- **customBridgeNameDEVVIT** @ L40 — `Custom bridge: __DEVVIT__` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接对象名，通过 `addJavascriptInterface` 或 `removeJavascriptInterface` 与 WebView 关联
  - **条件**：`if (p02.f79105b.f79137o) {`

  **代码上下文**：
```
   25:     }
   26: 
   27:     @Override // Tk0.k
   28:     public /* bridge */ /* synthetic */ Object invoke(Object obj) {
   29:         invoke((l) obj);
   30:         return v.f6415a;
   31:     }
   32: 
   33:     public final void invoke(l p02) {
   34:         kotlin.jvm.internal.f.g(p02, "p0");
   35:         a aVar = (a) this.receiver;
   36:         aVar.getClass();
   37:         t0 t0Var = p02.f79111q;
   38:         p02.f79104a.a();
   39:         if (p02.f79105b.f79137o) {
>> 40:             p02.removeJavascriptInterface("__DEVVIT__");
   41:             p02.stopLoading();
   42:         }
   43:         if (p02.f79105b.f79140r) {
   44:             p02.stopLoading();
   45:             p02.loadUrl("about:blank");
   46:             p02.clearHistory();
   47:         }
   48:         if (t0Var.isActive()) {
   49:             t0Var.cancel(null);
   50:         }
   51:         WP.d.c(p02.f79105b.f79133k, "devplat-webview", null, null, new E(p02, 12), 6);
   52:         com.reddit.devplatform.domain.h hVar = (com.reddit.devplatform.domain.h) aVar.f78336h;
   53:         if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) {
   54:             Z z11 = aVar.f78332d;
   55:             synchronized (z11) {
```

- **removeJavascriptInterface** @ L40 — `WebView.removeJavascriptInterface` (high/bridge)
  - **条件**：`if (p02.f79105b.f79137o) {`

  **代码上下文**：
```
   25:     }
   26: 
   27:     @Override // Tk0.k
   28:     public /* bridge */ /* synthetic */ Object invoke(Object obj) {
   29:         invoke((l) obj);
   30:         return v.f6415a;
   31:     }
   32: 
   33:     public final void invoke(l p02) {
   34:         kotlin.jvm.internal.f.g(p02, "p0");
   35:         a aVar = (a) this.receiver;
   36:         aVar.getClass();
   37:         t0 t0Var = p02.f79111q;
   38:         p02.f79104a.a();
   39:         if (p02.f79105b.f79137o) {
>> 40:             p02.removeJavascriptInterface("__DEVVIT__");
   41:             p02.stopLoading();
   42:         }
   43:         if (p02.f79105b.f79140r) {
   44:             p02.stopLoading();
   45:             p02.loadUrl("about:blank");
   46:             p02.clearHistory();
   47:         }
   48:         if (t0Var.isActive()) {
   49:             t0Var.cancel(null);
   50:         }
   51:         WP.d.c(p02.f79105b.f79133k, "devplat-webview", null, null, new E(p02, 12), 6);
   52:         com.reddit.devplatform.domain.h hVar = (com.reddit.devplatform.domain.h) aVar.f78336h;
   53:         if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) {
   54:             Z z11 = aVar.f78332d;
   55:             synchronized (z11) {
```

- **setWebViewClient** @ L69 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) { \| p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null;`

  **代码上下文**：
```
   54:             Z z11 = aVar.f78332d;
   55:             synchronized (z11) {
   56:                 try {
   57:                     Context context = p02.getContext();
   58:                     MutableContextWrapper mutableContextWrapper = context instanceof MutableContextWrapper ? (MutableContextWrapper) context : null;
   59:                     if (mutableContextWrapper != null) {
   60:                         mutableContextWrapper.setBaseContext((Context) z11.f172819b);
   61:                     }
   62:                     u webViewDelegate = p02.getWebViewDelegate();
   63:                     p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null;
   64:                     if (pVar != null) {
   65:                         q newDelegate = (q) z11.f172824g;
   66:                         kotlin.jvm.internal.f.g(newDelegate, "newDelegate");
   67:                         pVar.f79145a = newDelegate;
   68:                     }
>> 69:                     p02.setWebViewClient(new WebViewClient());
   70:                     ((LinkedList) z11.f172823f).addFirst(p02);
   71:                     while (true) {
   72:                         int size = ((LinkedList) z11.f172823f).size();
   73:                         com.reddit.devplatform.domain.h hVar2 = (com.reddit.devplatform.domain.h) ((com.reddit.devplatform.domain.f) z11.f172821d);
   74:                         Integer num = (Integer) hVar2.f78671b0.getValue(hVar2, com.reddit.devplatform.domain.h.n0[51]);
   75:                         if (size <= (num != null ? num.intValue() : 7)) {
   76:                             break;
   77:                         } else {
   78:                             kotlin.collections.u.O((LinkedList) z11.f172823f);
   79:                         }
   80:                     }
   81:                 } catch (Throwable th2) {
   82:                     throw th2;
   83:                 }
   84:             }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/d.java`

- **setWebViewClient** @ L339 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`if (objG8 == c8116f2) { \| if (zH2 \|\| objT5 == c8116f2) { \| if (objG9 == c8116f2) {`

  **代码上下文**：
```
   324:             if (zH2 || objT5 == c8116f2) {
   325:                 objT5 = new Tk0.a() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.f
   326:                     @Override // Tk0.a
   327:                     public final Object invoke() {
   328:                         w0.l(a9, webViewDependencies.f79132j.f991a.d(), null, new DevPlatformWebViewLegacyKt$DevPlatformWebViewLegacy$webViewInitListener$1$1$1(interfaceC8113d05, null), 2);
   329:                         return v.f6415a;
   330:                     }
   331:                 };
   332:                 rVar4.t0(objT5);
   333:             }
   334:             Tk0.a aVar3 = (Tk0.a) objT5;
   335:             Object objG9 = com.reddit.accessibility.devsettings.g.g(1849434622, rVar4, false);
   336:             if (objG9 == c8116f2) {
   337:                 WebView webView3 = new WebView(context);
   338:                 String strA = yE.d.a(gVar);
>> 339:                 webView3.setWebViewClient(new com.reddit.devplatform.composables.blocks.beta.block.webview.g(webViewDependencies.f79127e, aVar3, aVar2, bVar, okHttpClient, strA, webViewDependencies.f79136n, webViewDependencies.f79137o, jLongValue2, (Mf0.m) c12345f0F.f136638c.f134709w.get(), a9, aVar, cVar, webViewDependencies.f79142t));
   340:                 webView3.getSettings().setJavaScriptEnabled(true);
   341:                 webView3.getSettings().setLoadWithOverviewMode(true);
   342:                 webView3.getSettings().setUseWideViewPort(true);
   343:                 webView3.getSettings().setMediaPlaybackRequiresUserGesture(true);
   344:                 webView3.getSettings().setDomStorageEnabled(true);
   345:                 webView3.setLayoutParams(new ViewGroup.LayoutParams(webView3.getWidth(), 320));
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
```

- **setJavaScriptEnabledTrue** @ L340 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`if (objG8 == c8116f2) { \| if (zH2 \|\| objT5 == c8116f2) { \| if (objG9 == c8116f2) {`

  **代码上下文**：
```
   325:                 objT5 = new Tk0.a() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.f
   326:                     @Override // Tk0.a
   327:                     public final Object invoke() {
   328:                         w0.l(a9, webViewDependencies.f79132j.f991a.d(), null, new DevPlatformWebViewLegacyKt$DevPlatformWebViewLegacy$webViewInitListener$1$1$1(interfaceC8113d05, null), 2);
   329:                         return v.f6415a;
   330:                     }
   331:                 };
   332:                 rVar4.t0(objT5);
   333:             }
   334:             Tk0.a aVar3 = (Tk0.a) objT5;
   335:             Object objG9 = com.reddit.accessibility.devsettings.g.g(1849434622, rVar4, false);
   336:             if (objG9 == c8116f2) {
   337:                 WebView webView3 = new WebView(context);
   338:                 String strA = yE.d.a(gVar);
   339:                 webView3.setWebViewClient(new com.reddit.devplatform.composables.blocks.beta.block.webview.g(webViewDependencies.f79127e, aVar3, aVar2, bVar, okHttpClient, strA, webViewDependencies.f79136n, webViewDependencies.f79137o, jLongValue2, (Mf0.m) c12345f0F.f136638c.f134709w.get(), a9, aVar, cVar, webViewDependencies.f79142t));
>> 340:                 webView3.getSettings().setJavaScriptEnabled(true);
   341:                 webView3.getSettings().setLoadWithOverviewMode(true);
   342:                 webView3.getSettings().setUseWideViewPort(true);
   343:                 webView3.getSettings().setMediaPlaybackRequiresUserGesture(true);
   344:                 webView3.getSettings().setDomStorageEnabled(true);
   345:                 webView3.setLayoutParams(new ViewGroup.LayoutParams(webView3.getWidth(), 320));
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
   355:                 webViewDependencies = webViewDependencies;
```

- **addJavascriptInterface** @ L357 — `WebView.addJavascriptInterface` (high/bridge)
  - **⚠️ 检测到混淆代码**
    - 混淆后的类名: `j`
    - 检测方法: system_api_call
    - 说明: 虽然类名/方法名被混淆，但通过系统API调用（`addJavascriptInterface`）或注解（`@JavascriptInterface`）检测到
  - **条件**：`if (objG9 == c8116f2) {`

  **代码上下文**：
```
   342:                 webView3.getSettings().setUseWideViewPort(true);
   343:                 webView3.getSettings().setMediaPlaybackRequiresUserGesture(true);
   344:                 webView3.getSettings().setDomStorageEnabled(true);
   345:                 webView3.setLayoutParams(new ViewGroup.LayoutParams(webView3.getWidth(), 320));
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
   355:                 webViewDependencies = webViewDependencies;
   356:                 linkedList = linkedList6;
>> 357:                 webView3.addJavascriptInterface(jVar, "__DEVVIT__");
   358:                 if (!webViewDependencies.f79141s || webViewDependencies.f79142t) {
   359:                     webView3.loadUrl(str);
   360:                 } else {
   361:                     webView3.loadDataWithBaseURL(null, q.q("\n        <html>\n        <body>\n        <script>\n            window.name = " + JSONObject.quote(strA) + ";\n            window.location.replace(\"" + str + "\");\n        </script>\n        </body>\n        </html>\n        "), "text/html", "UTF-8", null);
   362:                 }
   363:                 final Ref$FloatRef ref$FloatRef = new Ref$FloatRef();
   364:                 final Ref$FloatRef ref$FloatRef2 = new Ref$FloatRef();
   365:                 webView3.setOnTouchListener(new View.OnTouchListener() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.h
   366:                     @Override // android.view.View.OnTouchListener
   367:                     public final boolean onTouch(View view, MotionEvent motionEvent) {
   368:                         int actionMasked = motionEvent.getActionMasked();
   369:                         n nVar3 = webViewDependencies;
   370:                         boolean zCanScrollVertically = true;
   371:                         if (actionMasked == 1) {
   372:                             o oVar = nVar3.f79130h;
```

- **customBridgeNameDEVVIT** @ L357 — `Custom bridge: __DEVVIT__` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接对象名，通过 `addJavascriptInterface` 或 `removeJavascriptInterface` 与 WebView 关联
  - **条件**：`if (objG9 == c8116f2) {`

  **代码上下文**：
```
   342:                 webView3.getSettings().setUseWideViewPort(true);
   343:                 webView3.getSettings().setMediaPlaybackRequiresUserGesture(true);
   344:                 webView3.getSettings().setDomStorageEnabled(true);
   345:                 webView3.setLayoutParams(new ViewGroup.LayoutParams(webView3.getWidth(), 320));
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
   355:                 webViewDependencies = webViewDependencies;
   356:                 linkedList = linkedList6;
>> 357:                 webView3.addJavascriptInterface(jVar, "__DEVVIT__");
   358:                 if (!webViewDependencies.f79141s || webViewDependencies.f79142t) {
   359:                     webView3.loadUrl(str);
   360:                 } else {
   361:                     webView3.loadDataWithBaseURL(null, q.q("\n        <html>\n        <body>\n        <script>\n            window.name = " + JSONObject.quote(strA) + ";\n            window.location.replace(\"" + str + "\");\n        </script>\n        </body>\n        </html>\n        "), "text/html", "UTF-8", null);
   362:                 }
   363:                 final Ref$FloatRef ref$FloatRef = new Ref$FloatRef();
   364:                 final Ref$FloatRef ref$FloatRef2 = new Ref$FloatRef();
   365:                 webView3.setOnTouchListener(new View.OnTouchListener() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.h
   366:                     @Override // android.view.View.OnTouchListener
   367:                     public final boolean onTouch(View view, MotionEvent motionEvent) {
   368:                         int actionMasked = motionEvent.getActionMasked();
   369:                         n nVar3 = webViewDependencies;
   370:                         boolean zCanScrollVertically = true;
   371:                         if (actionMasked == 1) {
   372:                             o oVar = nVar3.f79130h;
```

- **loadUrlDynamic** @ L359 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (!webViewDependencies.f79141s \|\| webViewDependencies.f79142t) {`

  **代码上下文**：
```
   344:                 webView3.getSettings().setDomStorageEnabled(true);
   345:                 webView3.setLayoutParams(new ViewGroup.LayoutParams(webView3.getWidth(), 320));
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
   355:                 webViewDependencies = webViewDependencies;
   356:                 linkedList = linkedList6;
   357:                 webView3.addJavascriptInterface(jVar, "__DEVVIT__");
   358:                 if (!webViewDependencies.f79141s || webViewDependencies.f79142t) {
>> 359:                     webView3.loadUrl(str);
   360:                 } else {
   361:                     webView3.loadDataWithBaseURL(null, q.q("\n        <html>\n        <body>\n        <script>\n            window.name = " + JSONObject.quote(strA) + ";\n            window.location.replace(\"" + str + "\");\n        </script>\n        </body>\n        </html>\n        "), "text/html", "UTF-8", null);
   362:                 }
   363:                 final Ref$FloatRef ref$FloatRef = new Ref$FloatRef();
   364:                 final Ref$FloatRef ref$FloatRef2 = new Ref$FloatRef();
   365:                 webView3.setOnTouchListener(new View.OnTouchListener() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.h
   366:                     @Override // android.view.View.OnTouchListener
   367:                     public final boolean onTouch(View view, MotionEvent motionEvent) {
   368:                         int actionMasked = motionEvent.getActionMasked();
   369:                         n nVar3 = webViewDependencies;
   370:                         boolean zCanScrollVertically = true;
   371:                         if (actionMasked == 1) {
   372:                             o oVar = nVar3.f79130h;
   373:                             Z1 z1NewBuilder = Struct.newBuilder();
   374:                             kotlin.jvm.internal.f.f(z1NewBuilder, "newBuilder()");
```

- **loadDataWithBaseURL** @ L361 — `WebView.loadDataWithBaseURL` (high/js_injection)
  - **条件**：`if (!webViewDependencies.f79141s \|\| webViewDependencies.f79142t) {`

  **代码上下文**：
```
   346:                 z11 = true;
   347:                 c8116f = c8116f2;
   348:                 interfaceC8113d0 = interfaceC8113d05;
   349:                 i11 = 0;
   350:                 rVar4 = rVar4;
   351:                 i12 = i14;
   352:                 j jVar = new j(kVar3, webViewDependencies, new g(webView3, 0), o13, linkedList6, interfaceC8113d0);
   353:                 o11 = o13;
   354:                 kVar = kVar3;
   355:                 webViewDependencies = webViewDependencies;
   356:                 linkedList = linkedList6;
   357:                 webView3.addJavascriptInterface(jVar, "__DEVVIT__");
   358:                 if (!webViewDependencies.f79141s || webViewDependencies.f79142t) {
   359:                     webView3.loadUrl(str);
   360:                 } else {
>> 361:                     webView3.loadDataWithBaseURL(null, q.q("\n        <html>\n        <body>\n        <script>\n            window.name = " + JSONObject.quote(strA) + ";\n            window.location.replace(\"" + str + "\");\n        </script>\n        </body>\n        </html>\n        "), "text/html", "UTF-8", null);
   362:                 }
   363:                 final Ref$FloatRef ref$FloatRef = new Ref$FloatRef();
   364:                 final Ref$FloatRef ref$FloatRef2 = new Ref$FloatRef();
   365:                 webView3.setOnTouchListener(new View.OnTouchListener() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.ui.h
   366:                     @Override // android.view.View.OnTouchListener
   367:                     public final boolean onTouch(View view, MotionEvent motionEvent) {
   368:                         int actionMasked = motionEvent.getActionMasked();
   369:                         n nVar3 = webViewDependencies;
   370:                         boolean zCanScrollVertically = true;
   371:                         if (actionMasked == 1) {
   372:                             o oVar = nVar3.f79130h;
   373:                             Z1 z1NewBuilder = Struct.newBuilder();
   374:                             kotlin.jvm.internal.f.f(z1NewBuilder, "newBuilder()");
   375:                             oVar.invoke("", (Struct) z1NewBuilder.b(), new com.reddit.devplatform.data.analytics.custompost.d(Enums$BlockType.BLOCK_WEBVIEW, null, new com.reddit.devplatform.data.analytics.c(nVar3.f79134l.f160094i.f160142c), 2));
   376:                         }
```

- **setWebViewClient** @ L616 — `WebView.setWebViewClient` (high/hookpoint)
  - **条件**：`if (J3.C(hVar.a0, hVar, com.reddit.devplatform.domain.h.n0[50])) { \| p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null;`

  **代码上下文**：
```
   601:                             synchronized (z12) {
   602:                                 try {
   603:                                     kotlin.jvm.internal.f.g(webViewDependencies, "webViewDependencies");
   604:                                     lVar = (l) u.O((LinkedList) z12.f172823f);
   605:                                     if (lVar != null) {
   606:                                         Context context2 = lVar.getContext();
   607:                                         MutableContextWrapper mutableContextWrapper = context2 instanceof MutableContextWrapper ? (MutableContextWrapper) context2 : null;
   608:                                         if (mutableContextWrapper != null) {
   609:                                             mutableContextWrapper.setBaseContext(context);
   610:                                         }
   611:                                         com.reddit.devplatform.features.customposts.webview.u webViewDelegate = lVar.getWebViewDelegate();
   612:                                         p pVar = webViewDelegate instanceof p ? (p) webViewDelegate : null;
   613:                                         if (pVar != null) {
   614:                                             pVar.f79145a = mVar;
   615:                                         }
>> 616:                                         lVar.setWebViewClient(gVar);
   617:                                         lVar.setWebViewDependencies(webViewDependencies);
   618:                                     } else {
   619:                                         MutableContextWrapper mutableContextWrapper2 = new MutableContextWrapper(context);
   620:                                         p pVar2 = new p();
   621:                                         pVar2.f79145a = mVar;
   622:                                         lVar = new l(mutableContextWrapper2, pVar2, gVar, webViewDependencies, (C20306d) z12.f172820c, (com.reddit.common.coroutines.a) z12.f172822e);
   623:                                     }
   624:                                 } catch (Throwable th2) {
   625:                                     throw th2;
   626:                                 }
   627:                             }
   628:                         } else {
   629:                             lVar = new l(context, aVar3.f78333e, gVar, aVar3.f78331c, aVar3.f78329a, aVar3.f78330b);
   630:                         }
   631:                         lVar.setup(strA);
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/g.java`

- **evaluateJavascript** @ L34 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`switch (i5) { \| case 0:`

  **代码上下文**：
```
   19:     }
   20: 
   21:     @Override // Tk0.k
   22:     public final Object invoke(Object obj) {
   23:         int i5 = this.f78350a;
   24:         v vVar = v.f6415a;
   25:         final WebView webView = this.f78351b;
   26:         final String message = (String) obj;
   27:         switch (i5) {
   28:             case 0:
   29:                 kotlin.jvm.internal.f.g(message, "message");
   30:                 int i10 = com.reddit.devplatform.composables.blocks.beta.block.webview.g.f78306p;
   31:                 webView.post(new Runnable() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.f
   32:                     @Override // java.lang.Runnable
   33:                     public final void run() {
>> 34:                         webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null);
   35:                     }
   36:                 });
   37:                 break;
   38:             default:
   39:                 int i11 = com.reddit.devplatform.composables.blocks.beta.block.webview.g.f78306p;
   40:                 kotlin.jvm.internal.f.g(webView, "<this>");
   41:                 kotlin.jvm.internal.f.g(message, "message");
   42:                 webView.post(new Runnable() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.f
   43:                     @Override // java.lang.Runnable
   44:                     public final void run() {
   45:                         webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null);
   46:                     }
   47:                 });
   48:                 break;
   49:         }
```

- **evaluateJavascript** @ L45 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`switch (i5) { \| case 0:`

  **代码上下文**：
```
   30:                 int i10 = com.reddit.devplatform.composables.blocks.beta.block.webview.g.f78306p;
   31:                 webView.post(new Runnable() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.f
   32:                     @Override // java.lang.Runnable
   33:                     public final void run() {
   34:                         webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null);
   35:                     }
   36:                 });
   37:                 break;
   38:             default:
   39:                 int i11 = com.reddit.devplatform.composables.blocks.beta.block.webview.g.f78306p;
   40:                 kotlin.jvm.internal.f.g(webView, "<this>");
   41:                 kotlin.jvm.internal.f.g(message, "message");
   42:                 webView.post(new Runnable() { // from class: com.reddit.devplatform.composables.blocks.beta.block.webview.f
   43:                     @Override // java.lang.Runnable
   44:                     public final void run() {
>> 45:                         webView.evaluateJavascript("console.log(\"AndroidDebug: " + message + "\");", null);
   46:                     }
   47:                 });
   48:                 break;
   49:         }
   50:         return vVar;
   51:     }
   52: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/composables/blocks/beta/block/webview/ui/j.java`

- **javascriptInterfaceAnnotation** @ L43 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   28:     /* renamed from: e, reason: collision with root package name */
   29:     public final /* synthetic */ LinkedList f78361e;
   30: 
   31:     /* renamed from: f, reason: collision with root package name */
   32:     public final /* synthetic */ InterfaceC8113d0 f78362f;
   33: 
   34:     public j(com.reddit.devplatform.composables.blocks.beta.block.webview.k kVar, n nVar, g gVar, O o11, LinkedList linkedList, InterfaceC8113d0 interfaceC8113d0) {
   35:         this.f78357a = kVar;
   36:         this.f78358b = nVar;
   37:         this.f78359c = gVar;
   38:         this.f78360d = o11;
   39:         this.f78361e = linkedList;
   40:         this.f78362f = interfaceC8113d0;
   41:     }
   42: 
>> 43:     @JavascriptInterface
   44:     public final void postMessage(String jsonData) {
   45:         kotlin.jvm.internal.f.g(jsonData, "jsonData");
   46:         if (!d.c(this.f78362f)) {
   47:             this.f78361e.add(jsonData);
   48:             return;
   49:         }
   50:         n nVar = this.f78358b;
   51:         if (((com.reddit.devplatform.composables.blocks.beta.block.webview.d) this.f78357a).a(jsonData, nVar.f79134l, nVar.f79138p)) {
   52:             return;
   53:         }
   54:         Attributes$BlockAction attributes$BlockAction = nVar.f79128f;
   55:         o oVar = nVar.f79130h;
   56:         O o11 = this.f78360d;
   57:         kotlin.jvm.internal.f.d(o11);
   58:         AbstractC1221c.M(jsonData, this.f78359c, attributes$BlockAction, oVar, o11, nVar.f79133k);
```

- **customBridgeMethodPostMessage** @ L44 — `Custom bridge method: postMessage` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   29:     public final /* synthetic */ LinkedList f78361e;
   30: 
   31:     /* renamed from: f, reason: collision with root package name */
   32:     public final /* synthetic */ InterfaceC8113d0 f78362f;
   33: 
   34:     public j(com.reddit.devplatform.composables.blocks.beta.block.webview.k kVar, n nVar, g gVar, O o11, LinkedList linkedList, InterfaceC8113d0 interfaceC8113d0) {
   35:         this.f78357a = kVar;
   36:         this.f78358b = nVar;
   37:         this.f78359c = gVar;
   38:         this.f78360d = o11;
   39:         this.f78361e = linkedList;
   40:         this.f78362f = interfaceC8113d0;
   41:     }
   42: 
   43:     @JavascriptInterface
>> 44:     public final void postMessage(String jsonData) {
   45:         kotlin.jvm.internal.f.g(jsonData, "jsonData");
   46:         if (!d.c(this.f78362f)) {
   47:             this.f78361e.add(jsonData);
   48:             return;
   49:         }
   50:         n nVar = this.f78358b;
   51:         if (((com.reddit.devplatform.composables.blocks.beta.block.webview.d) this.f78357a).a(jsonData, nVar.f79134l, nVar.f79138p)) {
   52:             return;
   53:         }
   54:         Attributes$BlockAction attributes$BlockAction = nVar.f79128f;
   55:         o oVar = nVar.f79130h;
   56:         O o11 = this.f78360d;
   57:         kotlin.jvm.internal.f.d(o11);
   58:         AbstractC1221c.M(jsonData, this.f78359c, attributes$BlockAction, oVar, o11, nVar.f79133k);
   59:     }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/DevPlatformWebView$javaScriptInjectUpdateStateMessageInWebView$1.java`

- **evaluateJavascript** @ L39 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`if (this.label != 0) {`

  **代码上下文**：
```
   24:         this.$message = str2;
   25:     }
   26: 
   27:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   28:     public final Kk0.b<Fk0.v> create(Object obj, Kk0.b<?> bVar) {
   29:         return new DevPlatformWebView$javaScriptInjectUpdateStateMessageInWebView$1(this.this$0, this.$stateJson, this.$message, bVar);
   30:     }
   31: 
   32:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   33:     public final Object invokeSuspend(Object obj) {
   34:         CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   35:         if (this.label != 0) {
   36:             throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   37:         }
   38:         kotlin.b.b(obj);
>> 39:         this.this$0.evaluateJavascript(this.$stateJson, null);
   40:         if (!kotlin.text.p.c0(this.$message)) {
   41:             l lVar = this.this$0;
   42:             w0.l(lVar.f79106c, lVar.f79107d.b(), null, new DevPlatformWebView$logToConsole$1(lVar, this.$message, null), 2);
   43:         }
   44:         return Fk0.v.f6415a;
   45:     }
   46: 
   47:     @Override // Tk0.n
   48:     public final Object invoke(A a9, Kk0.b<? super Fk0.v> bVar) {
   49:         return ((DevPlatformWebView$javaScriptInjectUpdateStateMessageInWebView$1) create(a9, bVar)).invokeSuspend(Fk0.v.f6415a);
   50:     }
   51: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/DevPlatformWebView$logToConsole$1.java`

- **evaluateJavascript** @ L36 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`if (this.label != 0) {`

  **代码上下文**：
```
   21:         this.$message = str;
   22:     }
   23: 
   24:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   25:     public final Kk0.b<Fk0.v> create(Object obj, Kk0.b<?> bVar) {
   26:         return new DevPlatformWebView$logToConsole$1(this.this$0, this.$message, bVar);
   27:     }
   28: 
   29:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   30:     public final Object invokeSuspend(Object obj) {
   31:         CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   32:         if (this.label != 0) {
   33:             throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   34:         }
   35:         kotlin.b.b(obj);
>> 36:         this.this$0.evaluateJavascript("console.log(\"AndroidDebug: " + this.$message + "\");", null);
   37:         return Fk0.v.f6415a;
   38:     }
   39: 
   40:     @Override // Tk0.n
   41:     public final Object invoke(A a9, Kk0.b<? super Fk0.v> bVar) {
   42:         return ((DevPlatformWebView$logToConsole$1) create(a9, bVar)).invokeSuspend(Fk0.v.f6415a);
   43:     }
   44: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/k.java`

- **javascriptInterfaceAnnotation** @ L16 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   1: package com.reddit.devplatform.features.customposts.webview;
   2: 
   3: import android.webkit.JavascriptInterface;
   4: 
   5: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   6: /* loaded from: classes9.dex */
   7: public final class k {
   8: 
   9:     /* renamed from: a, reason: collision with root package name */
   10:     public final /* synthetic */ l f79103a;
   11: 
   12:     public k(l lVar) {
   13:         this.f79103a = lVar;
   14:     }
   15: 
>> 16:     @JavascriptInterface
   17:     public final void postMessage(String jsonData) {
   18:         kotlin.jvm.internal.f.g(jsonData, "jsonData");
   19:         this.f79103a.getWebViewDelegate().e(jsonData);
   20:     }
   21: }
```

- **customBridgeMethodPostMessage** @ L17 — `Custom bridge method: postMessage` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   2: 
   3: import android.webkit.JavascriptInterface;
   4: 
   5: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   6: /* loaded from: classes9.dex */
   7: public final class k {
   8: 
   9:     /* renamed from: a, reason: collision with root package name */
   10:     public final /* synthetic */ l f79103a;
   11: 
   12:     public k(l lVar) {
   13:         this.f79103a = lVar;
   14:     }
   15: 
   16:     @JavascriptInterface
>> 17:     public final void postMessage(String jsonData) {
   18:         kotlin.jvm.internal.f.g(jsonData, "jsonData");
   19:         this.f79103a.getWebViewDelegate().e(jsonData);
   20:     }
   21: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/devplatform/features/customposts/webview/l.java`

- **setWebViewClient** @ L57 — `WebView.setWebViewClient` (high/hookpoint)

  **代码上下文**：
```
   42:     /* renamed from: q, reason: collision with root package name */
   43:     public final t0 f79111q;
   44: 
   45:     /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
   46:     public l(Context context, u uVar, com.reddit.devplatform.composables.blocks.beta.block.webview.g gVar, n webViewDependencies, C20306d c20306d, com.reddit.common.coroutines.a dispatcherProvider) {
   47:         super(new MutableContextWrapper(context));
   48:         kotlin.jvm.internal.f.g(context, "context");
   49:         kotlin.jvm.internal.f.g(webViewDependencies, "webViewDependencies");
   50:         kotlin.jvm.internal.f.g(dispatcherProvider, "dispatcherProvider");
   51:         this.f79104a = uVar;
   52:         this.f79105b = webViewDependencies;
   53:         this.f79106c = c20306d;
   54:         this.f79107d = dispatcherProvider;
   55:         this.f79110g = new k(this);
   56:         this.f79111q = w0.l(c20306d, null, null, new DevPlatformWebView$webViewDelegateEventCollectionJob$1(this, null), 3);
>> 57:         setWebViewClient(gVar);
   58:         getSettings().setJavaScriptEnabled(true);
   59:         getSettings().setLoadWithOverviewMode(true);
   60:         getSettings().setUseWideViewPort(true);
   61:         getSettings().setMediaPlaybackRequiresUserGesture(true);
   62:         getSettings().setDomStorageEnabled(true);
   63:         setLayoutParams(new ViewGroup.LayoutParams(getWidth(), 320));
   64:     }
   65: 
   66:     public final u getWebViewDelegate() {
   67:         return this.f79104a;
   68:     }
   69: 
   70:     public final n getWebViewDependencies() {
   71:         return this.f79105b;
   72:     }
```

- **setJavaScriptEnabledTrue** @ L58 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)

  **代码上下文**：
```
   43:     public final t0 f79111q;
   44: 
   45:     /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
   46:     public l(Context context, u uVar, com.reddit.devplatform.composables.blocks.beta.block.webview.g gVar, n webViewDependencies, C20306d c20306d, com.reddit.common.coroutines.a dispatcherProvider) {
   47:         super(new MutableContextWrapper(context));
   48:         kotlin.jvm.internal.f.g(context, "context");
   49:         kotlin.jvm.internal.f.g(webViewDependencies, "webViewDependencies");
   50:         kotlin.jvm.internal.f.g(dispatcherProvider, "dispatcherProvider");
   51:         this.f79104a = uVar;
   52:         this.f79105b = webViewDependencies;
   53:         this.f79106c = c20306d;
   54:         this.f79107d = dispatcherProvider;
   55:         this.f79110g = new k(this);
   56:         this.f79111q = w0.l(c20306d, null, null, new DevPlatformWebView$webViewDelegateEventCollectionJob$1(this, null), 3);
   57:         setWebViewClient(gVar);
>> 58:         getSettings().setJavaScriptEnabled(true);
   59:         getSettings().setLoadWithOverviewMode(true);
   60:         getSettings().setUseWideViewPort(true);
   61:         getSettings().setMediaPlaybackRequiresUserGesture(true);
   62:         getSettings().setDomStorageEnabled(true);
   63:         setLayoutParams(new ViewGroup.LayoutParams(getWidth(), 320));
   64:     }
   65: 
   66:     public final u getWebViewDelegate() {
   67:         return this.f79104a;
   68:     }
   69: 
   70:     public final n getWebViewDependencies() {
   71:         return this.f79105b;
   72:     }
   73: 
```

- **customBridgeNameDEVVIT** @ L111 — `Custom bridge: __DEVVIT__` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接对象名，通过 `addJavascriptInterface` 或 `removeJavascriptInterface` 与 WebView 关联
  - **条件**：`} else if (action == 2) { \| if (Math.abs(this.f79108e - event.getX()) <= Math.abs(this.f79109f - event.getY())) { \| zCanScrollVertically = y > 0.0f ? view.canScrollVertically(1) : y < 0.0f ? view.canScrollVertically(-1) : false;`

  **代码上下文**：
```
   96:                 this.f79108e = event.getX();
   97:                 this.f79109f = event.getY();
   98:             }
   99:         }
   100:         view.performClick();
   101:         return false;
   102:     }
   103: 
   104:     public final void setWebViewDependencies(n nVar) {
   105:         kotlin.jvm.internal.f.g(nVar, "<set-?>");
   106:         this.f79105b = nVar;
   107:     }
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
>> 111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
   116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
   120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
   123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

- **removeJavascriptInterface** @ L111 — `WebView.removeJavascriptInterface` (high/bridge)
  - **条件**：`} else if (action == 2) { \| if (Math.abs(this.f79108e - event.getX()) <= Math.abs(this.f79109f - event.getY())) { \| zCanScrollVertically = y > 0.0f ? view.canScrollVertically(1) : y < 0.0f ? view.canScrollVertically(-1) : false;`

  **代码上下文**：
```
   96:                 this.f79108e = event.getX();
   97:                 this.f79109f = event.getY();
   98:             }
   99:         }
   100:         view.performClick();
   101:         return false;
   102:     }
   103: 
   104:     public final void setWebViewDependencies(n nVar) {
   105:         kotlin.jvm.internal.f.g(nVar, "<set-?>");
   106:         this.f79105b = nVar;
   107:     }
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
>> 111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
   116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
   120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
   123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

- **addJavascriptInterface** @ L116 — `WebView.addJavascriptInterface` (high/bridge)
  - **条件**：`if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {`

  **代码上下文**：
```
   101:         return false;
   102:     }
   103: 
   104:     public final void setWebViewDependencies(n nVar) {
   105:         kotlin.jvm.internal.f.g(nVar, "<set-?>");
   106:         this.f79105b = nVar;
   107:     }
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
   111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
>> 116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
   120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
   123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

- **customBridgeNameDEVVIT** @ L116 — `Custom bridge: __DEVVIT__` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接对象名，通过 `addJavascriptInterface` 或 `removeJavascriptInterface` 与 WebView 关联
  - **条件**：`if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {`

  **代码上下文**：
```
   101:         return false;
   102:     }
   103: 
   104:     public final void setWebViewDependencies(n nVar) {
   105:         kotlin.jvm.internal.f.g(nVar, "<set-?>");
   106:         this.f79105b = nVar;
   107:     }
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
   111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
>> 116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
   120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
   123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

- **loadUrlDynamic** @ L120 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {`

  **代码上下文**：
```
   105:         kotlin.jvm.internal.f.g(nVar, "<set-?>");
   106:         this.f79105b = nVar;
   107:     }
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
   111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
   116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
>> 120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
   123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

- **loadDataWithBaseURL** @ L123 — `WebView.loadDataWithBaseURL` (high/js_injection)
  - **条件**：`if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {`

  **代码上下文**：
```
   108: 
   109:     public final void setup(String bridgeContext) {
   110:         kotlin.jvm.internal.f.g(bridgeContext, "bridgeContext");
   111:         removeJavascriptInterface("__DEVVIT__");
   112:         if (!kotlin.jvm.internal.f.b(getUrl(), "about:blank")) {
   113:             loadUrl("about:blank");
   114:         }
   115:         this.f79104a.b();
   116:         addJavascriptInterface(this.f79110g, "__DEVVIT__");
   117:         setOnTouchListener(this);
   118:         n nVar = this.f79105b;
   119:         if (!nVar.f79141s || nVar.f79142t) {
   120:             loadUrl(nVar.f79123a);
   121:             return;
   122:         }
>> 123:         loadDataWithBaseURL(null, kotlin.text.q.q("\n          <html>\n          <body>\n          <script>\n              window.name = " + JSONObject.quote(bridgeContext) + ";\n              window.location.replace(\"" + this.f79105b.f79123a + "\");\n          </script>\n          </body>\n          </html>\n      "), "text/html", "UTF-8", null);
   124:     }
   125: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/econearn/onboarding/composables/j.java`

- **webChromeClientOrPrompt** @ L5 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.econearn.onboarding.composables;
   2: 
   3: import android.webkit.PermissionRequest;
   4: import android.webkit.ValueCallback;
>> 5: import android.webkit.WebChromeClient;
   6: import android.webkit.WebView;
   7: 
   8: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   9: /* loaded from: classes10.dex */
   10: public final class j extends WebChromeClient {
   11:     @Override // android.webkit.WebChromeClient
   12:     public final void onPermissionRequest(PermissionRequest request) {
   13:         kotlin.jvm.internal.f.g(request, "request");
   14:         request.deny();
   15:     }
   16: 
   17:     @Override // android.webkit.WebChromeClient
   18:     public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
   19:         kotlin.jvm.internal.f.g(webView, "webView");
   20:         return false;
```

- **webChromeClientOrPrompt** @ L10 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.econearn.onboarding.composables;
   2: 
   3: import android.webkit.PermissionRequest;
   4: import android.webkit.ValueCallback;
   5: import android.webkit.WebChromeClient;
   6: import android.webkit.WebView;
   7: 
   8: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   9: /* loaded from: classes10.dex */
>> 10: public final class j extends WebChromeClient {
   11:     @Override // android.webkit.WebChromeClient
   12:     public final void onPermissionRequest(PermissionRequest request) {
   13:         kotlin.jvm.internal.f.g(request, "request");
   14:         request.deny();
   15:     }
   16: 
   17:     @Override // android.webkit.WebChromeClient
   18:     public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
   19:         kotlin.jvm.internal.f.g(webView, "webView");
   20:         return false;
   21:     }
   22: }
```

- **webChromeClientOrPrompt** @ L11 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.econearn.onboarding.composables;
   2: 
   3: import android.webkit.PermissionRequest;
   4: import android.webkit.ValueCallback;
   5: import android.webkit.WebChromeClient;
   6: import android.webkit.WebView;
   7: 
   8: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   9: /* loaded from: classes10.dex */
   10: public final class j extends WebChromeClient {
>> 11:     @Override // android.webkit.WebChromeClient
   12:     public final void onPermissionRequest(PermissionRequest request) {
   13:         kotlin.jvm.internal.f.g(request, "request");
   14:         request.deny();
   15:     }
   16: 
   17:     @Override // android.webkit.WebChromeClient
   18:     public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
   19:         kotlin.jvm.internal.f.g(webView, "webView");
   20:         return false;
   21:     }
   22: }
```

- **webChromeClientOrPrompt** @ L17 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   2: 
   3: import android.webkit.PermissionRequest;
   4: import android.webkit.ValueCallback;
   5: import android.webkit.WebChromeClient;
   6: import android.webkit.WebView;
   7: 
   8: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   9: /* loaded from: classes10.dex */
   10: public final class j extends WebChromeClient {
   11:     @Override // android.webkit.WebChromeClient
   12:     public final void onPermissionRequest(PermissionRequest request) {
   13:         kotlin.jvm.internal.f.g(request, "request");
   14:         request.deny();
   15:     }
   16: 
>> 17:     @Override // android.webkit.WebChromeClient
   18:     public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
   19:         kotlin.jvm.internal.f.g(webView, "webView");
   20:         return false;
   21:     }
   22: }
```

- **webChromeClientOrPrompt** @ L18 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   3: import android.webkit.PermissionRequest;
   4: import android.webkit.ValueCallback;
   5: import android.webkit.WebChromeClient;
   6: import android.webkit.WebView;
   7: 
   8: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   9: /* loaded from: classes10.dex */
   10: public final class j extends WebChromeClient {
   11:     @Override // android.webkit.WebChromeClient
   12:     public final void onPermissionRequest(PermissionRequest request) {
   13:         kotlin.jvm.internal.f.g(request, "request");
   14:         request.deny();
   15:     }
   16: 
   17:     @Override // android.webkit.WebChromeClient
>> 18:     public final boolean onShowFileChooser(WebView webView, ValueCallback valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
   19:         kotlin.jvm.internal.f.g(webView, "webView");
   20:         return false;
   21:     }
   22: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/fullbleedplayer/ui/composables/linkviewer/a.java`

- **onPageFinished** @ L28 — `WebViewClient.onPageFinished` (high/hookpoint)

  **代码上下文**：
```
   13:     /* renamed from: a, reason: collision with root package name */
   14:     public final Context f88414a;
   15: 
   16:     /* renamed from: b, reason: collision with root package name */
   17:     public final com.reddit.contribution.kickstarting.impl.screen.composables.c f88415b;
   18: 
   19:     /* renamed from: c, reason: collision with root package name */
   20:     public boolean f88416c;
   21: 
   22:     public a(Context context, com.reddit.contribution.kickstarting.impl.screen.composables.c cVar) {
   23:         this.f88414a = context;
   24:         this.f88415b = cVar;
   25:     }
   26: 
   27:     @Override // android.webkit.WebViewClient
>> 28:     public final void onPageFinished(WebView webView, String str) {
   29:         super.onPageFinished(webView, str);
   30:         if (this.f88416c) {
   31:             return;
   32:         }
   33:         this.f88416c = true;
   34:         this.f88415b.invoke();
   35:     }
   36: 
   37:     @Override // android.webkit.WebViewClient
   38:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   39:         Uri url;
   40:         if (webResourceRequest != null && webResourceRequest.isRedirect()) {
   41:             return false;
   42:         }
   43:         if (webResourceRequest != null && (url = webResourceRequest.getUrl()) != null) {
```

- **onPageFinished** @ L29 — `WebViewClient.onPageFinished` (high/hookpoint)

  **代码上下文**：
```
   14:     public final Context f88414a;
   15: 
   16:     /* renamed from: b, reason: collision with root package name */
   17:     public final com.reddit.contribution.kickstarting.impl.screen.composables.c f88415b;
   18: 
   19:     /* renamed from: c, reason: collision with root package name */
   20:     public boolean f88416c;
   21: 
   22:     public a(Context context, com.reddit.contribution.kickstarting.impl.screen.composables.c cVar) {
   23:         this.f88414a = context;
   24:         this.f88415b = cVar;
   25:     }
   26: 
   27:     @Override // android.webkit.WebViewClient
   28:     public final void onPageFinished(WebView webView, String str) {
>> 29:         super.onPageFinished(webView, str);
   30:         if (this.f88416c) {
   31:             return;
   32:         }
   33:         this.f88416c = true;
   34:         this.f88415b.invoke();
   35:     }
   36: 
   37:     @Override // android.webkit.WebViewClient
   38:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   39:         Uri url;
   40:         if (webResourceRequest != null && webResourceRequest.isRedirect()) {
   41:             return false;
   42:         }
   43:         if (webResourceRequest != null && (url = webResourceRequest.getUrl()) != null) {
   44:             c.b(this.f88414a, url);
```

- **shouldOverrideUrlLoading** @ L38 — `WebViewClient.shouldOverrideUrlLoading` (high/hookpoint)
  - **条件**：`if (this.f88416c) {`

  **代码上下文**：
```
   23:         this.f88414a = context;
   24:         this.f88415b = cVar;
   25:     }
   26: 
   27:     @Override // android.webkit.WebViewClient
   28:     public final void onPageFinished(WebView webView, String str) {
   29:         super.onPageFinished(webView, str);
   30:         if (this.f88416c) {
   31:             return;
   32:         }
   33:         this.f88416c = true;
   34:         this.f88415b.invoke();
   35:     }
   36: 
   37:     @Override // android.webkit.WebViewClient
>> 38:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   39:         Uri url;
   40:         if (webResourceRequest != null && webResourceRequest.isRedirect()) {
   41:             return false;
   42:         }
   43:         if (webResourceRequest != null && (url = webResourceRequest.getUrl()) != null) {
   44:             c.b(this.f88414a, url);
   45:         }
   46:         return true;
   47:     }
   48: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/image/impl/RedditImageContentResolver$downsampleImageAndCopy$2.java`

- **cookieManagerOps** @ L116 — `CookieManager operations` (medium/settings)
  - **条件**：`if (i11 <= 6000 && i12 <= 6000) { \| if (z11) { \| Bitmap.CompressFormat compressFormat = strW.equals("png") ? Bitmap.CompressFormat.PNG : Bitmap.CompressFormat.JPEG;`

  **代码上下文**：
```
   101:                 BitmapFactory.Options options2 = new BitmapFactory.Options();
   102:                 options2.inJustDecodeBounds = false;
   103:                 if (z11) {
   104:                     d.c(d.f39766a, h.f149734a.b(this.this$0.getClass()).t(), null, null, new com.reddit.frontpage.util.h(20), 6);
   105:                     options2.inSampleSize = 2;
   106:                 }
   107:                 InputStream inputStreamB2 = b.b(this.this$0, this.$imageUri, contentResolver);
   108:                 Bitmap bitmapDecodeStream = BitmapFactory.decodeStream(inputStreamB2, null, options2);
   109:                 f.d(bitmapDecodeStream);
   110:                 inputStreamB2.close();
   111:                 File file = new File(this.this$0.f88928a.getFilesDir(), UUID.randomUUID() + "." + strW);
   112:                 Bitmap.CompressFormat compressFormat = strW.equals("png") ? Bitmap.CompressFormat.PNG : Bitmap.CompressFormat.JPEG;
   113:                 for (int i13 = 100; i13 > 75; i13 -= 5) {
   114:                     FileOutputStream fileOutputStream = new FileOutputStream(file);
   115:                     bitmapDecodeStream.compress(compressFormat, i13, fileOutputStream);
>> 116:                     fileOutputStream.flush();
   117:                     fileOutputStream.close();
   118:                     if (file.length() <= i10) {
   119:                         d.c(d.f39766a, h.f149734a.b(this.this$0.getClass()).t(), null, null, new com.reddit.frontpage.util.h(22), 6);
   120:                         bitmapDecodeStream.recycle();
   121:                         return file;
   122:                     }
   123:                 }
   124:                 d.b(d.f39766a, h.f149734a.b(this.this$0.getClass()).t(), null, null, new com.reddit.frontpage.util.h(21), 6);
   125:                 throw new IllegalStateException("Image compression failed");
   126:             }
   127:             inputStreamB.close();
   128:             b bVar3 = this.this$0;
   129:             Uri uri3 = this.$imageUri;
   130:             this.L$0 = null;
   131:             this.L$1 = null;
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/matrix/data/logger/MatrixLoggerImpl$logToFile$1.java`

- **cookieManagerOps** @ L77 — `CookieManager operations` (medium/settings)
  - **条件**：`if (this.label != 0) { \| if (outputStreamWriter == null) { \| if (th2 != null) {`

  **代码上下文**：
```
   62:                 throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   63:             }
   64:             kotlin.b.b(obj);
   65:             a aVar = this.this$0;
   66:             OutputStreamWriter outputStreamWriter = aVar.f92317g;
   67:             if (outputStreamWriter == null) {
   68:                 return null;
   69:             }
   70:             String str = this.$level;
   71:             String str2 = this.$message;
   72:             Throwable th2 = this.$throwable;
   73:             outputStreamWriter.write(aVar.f92318h.format(new Long(System.currentTimeMillis())) + " " + str + ": " + str2 + "\n");
   74:             if (th2 != null) {
   75:                 outputStreamWriter.write(th2 + "\n");
   76:             }
>> 77:             outputStreamWriter.flush();
   78:             return v.f6415a;
   79:         }
   80:     }
   81: 
   82:     /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
   83:     public MatrixLoggerImpl$logToFile$1(a aVar, String str, String str2, Throwable th2, b<? super MatrixLoggerImpl$logToFile$1> bVar) {
   84:         super(2, bVar);
   85:         this.this$0 = aVar;
   86:         this.$level = str;
   87:         this.$message = str2;
   88:         this.$throwable = th2;
   89:     }
   90: 
   91:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   92:     public final b<v> create(Object obj, b<?> bVar) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/matrix/data/logger/a.java`

- **cookieManagerOps** @ L131 — `CookieManager operations` (medium/settings)
  - **条件**：`if (r5 != r1) goto L48 \| if (r5 == 0) goto L7c`

  **代码上下文**：
```
   116:             java.io.OutputStreamWriter r5 = (java.io.OutputStreamWriter) r5
   117:             if (r5 == 0) goto L7c
   118:             java.text.SimpleDateFormat r4 = r4.f92318h
   119:             long r1 = java.lang.System.currentTimeMillis()
   120:             java.lang.Long r3 = new java.lang.Long
   121:             r3.<init>(r1)
   122:             java.lang.String r4 = r4.format(r3)
   123:             java.lang.StringBuilder r1 = new java.lang.StringBuilder
   124:             java.lang.String r2 = "---------Start log "
   125:             r1.<init>(r2)
   126:             r1.append(r4)
   127:             java.lang.String r4 = "---------\n"
   128:             r1.append(r4)
   129:             java.lang.String r4 = r1.toString()
   130:             r5.write(r4)
>> 131:             r5.flush()
   132:             goto L7d
   133:         L7c:
   134:             r5 = 0
   135:         L7d:
   136:             r0.f92317g = r5
   137:             Fk0.v r4 = Fk0.v.f6415a
   138:             return r4
   139:         */
   140:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.matrix.data.logger.a.a(com.reddit.matrix.data.logger.a, kotlin.coroutines.jvm.internal.ContinuationImpl):java.lang.Object");
   141:     }
   142: 
   143:     public static void f(a aVar, String str, String str2) {
   144:         aVar.f92312b.getClass();
   145:         com.reddit.chat.impl.a aVar2 = (com.reddit.chat.impl.a) aVar.f92313c;
   146:         if (aVar2.f74046f.getValue(aVar2, com.reddit.chat.impl.a.f73987Z0[0]).booleanValue()) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/mediacomponent/composables/embed/EmbedVideoKt$EmbedVideo$3$1.java`

- **evaluateJavascript** @ L47 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`if (f.b(this.$playerState, D.f81157a) && (webView = (WebView) this.$webViewReference.getValue()) != null) {`

  **代码上下文**：
```
   32: 
   33:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   34:     public final Kk0.b<v> create(Object obj, Kk0.b<?> bVar) {
   35:         return new EmbedVideoKt$EmbedVideo$3$1(this.$playerState, this.$webViewReference, this.$props, bVar);
   36:     }
   37: 
   38:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   39:     public final Object invokeSuspend(Object obj) {
   40:         WebView webView;
   41:         CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   42:         if (this.label != 0) {
   43:             throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   44:         }
   45:         kotlin.b.b(obj);
   46:         if (f.b(this.$playerState, D.f81157a) && (webView = (WebView) this.$webViewReference.getValue()) != null) {
>> 47:             webView.evaluateJavascript(this.$props.f96784c, null);
   48:         }
   49:         return v.f6415a;
   50:     }
   51: 
   52:     @Override // Tk0.n
   53:     public final Object invoke(A a9, Kk0.b<? super v> bVar) {
   54:         return ((EmbedVideoKt$EmbedVideo$3$1) create(a9, bVar)).invokeSuspend(v.f6415a);
   55:     }
   56: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/mod/filters/impl/generic/screen/k.java`

- **setJavaScriptEnabledTrue** @ L2019 — `WebSettings.setJavaScriptEnabled(true)` (medium/settings)
  - **条件**：`case 24: \| case 25: \| case 26:`

  **代码上下文**：
```
   2004:             case 24:
   2005:                 return TrimClipScrubber.observeMarginUpdates$lambda$0((Tk0.n) this.f99188c, (TrimClipScrubber) this.f99189d, (View) this.f99190e, (Tk0.n) this.f99187b, (Pair) obj);
   2006:             case 25:
   2007:                 return VoiceoverScrubber.observeMarginUpdates$lambda$0((Tk0.n) this.f99188c, (VoiceoverScrubber) this.f99189d, (View) this.f99190e, (Tk0.n) this.f99187b, (Pair) obj);
   2008:             case 26:
   2009:                 RedditEmbedWebViewViewModel redditEmbedWebViewViewModel = (RedditEmbedWebViewViewModel) this.f99188c;
   2010:                 InterfaceC8113d0 interfaceC8113d05 = (InterfaceC8113d0) this.f99189d;
   2011:                 String str15 = (String) this.f99190e;
   2012:                 WebEmbedWebView$JsCallbacks webEmbedWebView$JsCallbacks = (WebEmbedWebView$JsCallbacks) this.f99187b;
   2013:                 WebView webView = (WebView) obj;
   2014:                 kotlin.jvm.internal.f.g(webView, "webView");
   2015:                 com.reddit.webembed.composables.c cVar11 = new com.reddit.webembed.composables.c(redditEmbedWebViewViewModel, interfaceC8113d05);
   2016:                 interfaceC8113d05.setValue(webView);
   2017:                 webView.setFocusable(true);
   2018:                 webView.setFocusableInTouchMode(true);
>> 2019:                 webView.getSettings().setJavaScriptEnabled(true);
   2020:                 webView.getSettings().setDomStorageEnabled(true);
   2021:                 WebView.setWebContentsDebuggingEnabled(false);
   2022:                 if (str15 != null) {
   2023:                     if (webEmbedWebView$JsCallbacks == null) {
   2024:                         webEmbedWebView$JsCallbacks = cVar11;
   2025:                     }
   2026:                     webView.removeJavascriptInterface(str15);
   2027:                     webView.addJavascriptInterface(webEmbedWebView$JsCallbacks, str15);
   2028:                 }
   2029:                 webView.setOnTouchListener(null);
   2030:                 webView.setOnClickListener(null);
   2031:                 com.reddit.video.creation.widgets.widget.trimclipview.m mVar2 = new com.reddit.video.creation.widgets.widget.trimclipview.m(webView, 10);
   2032:                 WeakHashMap weakHashMap = V.f56346a;
   2033:                 androidx.core.view.M.m(webView, mVar2);
   2034:                 return v.f6415a;
```

- **removeJavascriptInterface** @ L2026 — `WebView.removeJavascriptInterface` (high/bridge)
  - **条件**：`if (webEmbedWebView$JsCallbacks == null) {`

  **代码上下文**：
```
   2011:                 String str15 = (String) this.f99190e;
   2012:                 WebEmbedWebView$JsCallbacks webEmbedWebView$JsCallbacks = (WebEmbedWebView$JsCallbacks) this.f99187b;
   2013:                 WebView webView = (WebView) obj;
   2014:                 kotlin.jvm.internal.f.g(webView, "webView");
   2015:                 com.reddit.webembed.composables.c cVar11 = new com.reddit.webembed.composables.c(redditEmbedWebViewViewModel, interfaceC8113d05);
   2016:                 interfaceC8113d05.setValue(webView);
   2017:                 webView.setFocusable(true);
   2018:                 webView.setFocusableInTouchMode(true);
   2019:                 webView.getSettings().setJavaScriptEnabled(true);
   2020:                 webView.getSettings().setDomStorageEnabled(true);
   2021:                 WebView.setWebContentsDebuggingEnabled(false);
   2022:                 if (str15 != null) {
   2023:                     if (webEmbedWebView$JsCallbacks == null) {
   2024:                         webEmbedWebView$JsCallbacks = cVar11;
   2025:                     }
>> 2026:                     webView.removeJavascriptInterface(str15);
   2027:                     webView.addJavascriptInterface(webEmbedWebView$JsCallbacks, str15);
   2028:                 }
   2029:                 webView.setOnTouchListener(null);
   2030:                 webView.setOnClickListener(null);
   2031:                 com.reddit.video.creation.widgets.widget.trimclipview.m mVar2 = new com.reddit.video.creation.widgets.widget.trimclipview.m(webView, 10);
   2032:                 WeakHashMap weakHashMap = V.f56346a;
   2033:                 androidx.core.view.M.m(webView, mVar2);
   2034:                 return v.f6415a;
   2035:             case 27:
   2036:                 InterfaceC7599C interfaceC7599C = (InterfaceC7599C) this.f99188c;
   2037:                 t tVar = (t) this.f99189d;
   2038:                 UY.a aVar9 = (UY.a) this.f99190e;
   2039:                 String str16 = (String) this.f99187b;
   2040:                 kotlin.jvm.internal.f.g((String) obj, "it");
   2041:                 C7598B c7598b = (C7598B) interfaceC7599C;
```

- **addJavascriptInterface** @ L2027 — `WebView.addJavascriptInterface` (high/bridge)
  - **条件**：`if (webEmbedWebView$JsCallbacks == null) {`

  **代码上下文**：
```
   2012:                 WebEmbedWebView$JsCallbacks webEmbedWebView$JsCallbacks = (WebEmbedWebView$JsCallbacks) this.f99187b;
   2013:                 WebView webView = (WebView) obj;
   2014:                 kotlin.jvm.internal.f.g(webView, "webView");
   2015:                 com.reddit.webembed.composables.c cVar11 = new com.reddit.webembed.composables.c(redditEmbedWebViewViewModel, interfaceC8113d05);
   2016:                 interfaceC8113d05.setValue(webView);
   2017:                 webView.setFocusable(true);
   2018:                 webView.setFocusableInTouchMode(true);
   2019:                 webView.getSettings().setJavaScriptEnabled(true);
   2020:                 webView.getSettings().setDomStorageEnabled(true);
   2021:                 WebView.setWebContentsDebuggingEnabled(false);
   2022:                 if (str15 != null) {
   2023:                     if (webEmbedWebView$JsCallbacks == null) {
   2024:                         webEmbedWebView$JsCallbacks = cVar11;
   2025:                     }
   2026:                     webView.removeJavascriptInterface(str15);
>> 2027:                     webView.addJavascriptInterface(webEmbedWebView$JsCallbacks, str15);
   2028:                 }
   2029:                 webView.setOnTouchListener(null);
   2030:                 webView.setOnClickListener(null);
   2031:                 com.reddit.video.creation.widgets.widget.trimclipview.m mVar2 = new com.reddit.video.creation.widgets.widget.trimclipview.m(webView, 10);
   2032:                 WeakHashMap weakHashMap = V.f56346a;
   2033:                 androidx.core.view.M.m(webView, mVar2);
   2034:                 return v.f6415a;
   2035:             case 27:
   2036:                 InterfaceC7599C interfaceC7599C = (InterfaceC7599C) this.f99188c;
   2037:                 t tVar = (t) this.f99189d;
   2038:                 UY.a aVar9 = (UY.a) this.f99190e;
   2039:                 String str16 = (String) this.f99187b;
   2040:                 kotlin.jvm.internal.f.g((String) obj, "it");
   2041:                 C7598B c7598b = (C7598B) interfaceC7599C;
   2042:                 String str17 = c7598b.f48258b;
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/network/interceptor/G.java`

- **userAgentHeaderInjection** @ L24 — `HTTP header: "User-Agent" set` (medium/settings)
  - **条件**：`return request.tag(u.class) != null ? chain.proceed(request) : chain.proceed(request.newBuilder().header("User-Agent", this.f108134a.f34519d).build());`

  **代码上下文**：
```
   9: /* loaded from: classes12.dex */
   10: public final class G implements Interceptor {
   11: 
   12:     /* renamed from: a, reason: collision with root package name */
   13:     public final C5598a f108134a;
   14: 
   15:     public G(C5598a analyticsConfig) {
   16:         kotlin.jvm.internal.f.g(analyticsConfig, "analyticsConfig");
   17:         this.f108134a = analyticsConfig;
   18:     }
   19: 
   20:     @Override // okhttp3.Interceptor
   21:     public final Response intercept(Interceptor.Chain chain) {
   22:         kotlin.jvm.internal.f.g(chain, "chain");
   23:         Request request = chain.request();
>> 24:         return request.tag(u.class) != null ? chain.proceed(request) : chain.proceed(request.newBuilder().header("User-Agent", this.f108134a.f34519d).build());
   25:     }
   26: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/network/interceptor/n.java`

- **userAgentHeaderInjection** @ L119 — `HTTP header: "User-Agent" set` (medium/settings)
  - **条件**：`if (vVar == null \|\| (redditSession = ((Gd0.b) vVar).f6987a) == null) { \| if (vVar == null \|\| (dVar = ((Gd0.b) vVar).f6988b) == null) {`

  **代码上下文**：
```
   104:         String strA;
   105:         kotlin.jvm.internal.f.g(chain, "chain");
   106:         com.reddit.session.v vVar = (com.reddit.session.v) chain.request().tag(com.reddit.session.v.class);
   107:         if (vVar == null || (redditSession = ((Gd0.b) vVar).f6987a) == null) {
   108:             redditSession = ((Gd0.b) this.f108157a).f6987a;
   109:         }
   110:         if (vVar == null || (dVar = ((Gd0.b) vVar).f6988b) == null) {
   111:             dVar = ((Gd0.b) this.f108157a).f6988b;
   112:         }
   113:         Request.Builder builderNewBuilder = chain.request().newBuilder();
   114:         String strF = dVar.f();
   115:         kotlin.jvm.internal.f.d(strF);
   116:         Request.Builder builderHeader = builderNewBuilder.header("Client-Vendor-ID", strF);
   117:         String strF2 = dVar.f();
   118:         kotlin.jvm.internal.f.d(strF2);
>> 119:         Request.Builder builderHeader2 = builderHeader.header("x-reddit-device-id", strF2).header("User-Agent", this.f108160d.f34519d).header("X-Dev-Ad-Id", this.f108160d.a()).header("Device-Name", this.f108160d.f34520e).header("x-reddit-dpr", String.valueOf(this.f108161e.f169000d));
   120:         C18681a c18681a = this.f108161e;
   121:         float f3 = c18681a.f169000d;
   122:         Request.Builder builderHeader3 = builderHeader2.header("x-reddit-width", f3 > 0.0f ? String.valueOf((int) (c18681a.f168998b / f3)) : String.valueOf(c18681a.f168998b));
   123:         String strB = dVar.b();
   124:         if (strB == null || strB.length() == 0) {
   125:             strB = null;
   126:         }
   127:         if (strB != null) {
   128:             builderHeader3.header("x-reddit-loid", strB);
   129:         }
   130:         if (((com.reddit.analytics.sessiontracker.e) this.f108168x).c()) {
   131:             BI.d dVar2 = this.y;
   132:             com.reddit.analytics.sessiontracker.a aVar = this.f108166v.f70045i;
   133:             if (aVar == null) {
   134:                 dVar2.a(new WI.a(MetricName.AnalyticsSessionNoActiveSession, 0.0d, gk.r("source", "header_interceptor"), null, 26));
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/postsubmit/data/remote/RedditPostPreviewExtractor$getPostPreview$2.java`

- **userAgentHeaderInjection** @ L69 — `HTTP header: "User-Agent" set` (medium/settings)
  - **条件**：`if (this.label != 0) {`

  **代码上下文**：
```
   54:     @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   55:     public final Object invokeSuspend(Object obj) throws Throwable {
   56:         CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   57:         if (this.label != 0) {
   58:             throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   59:         }
   60:         kotlin.b.b(obj);
   61:         String str = this.$url;
   62:         ho0.d dVar = new ho0.d();
   63:         j.E(str, "url");
   64:         try {
   65:             dVar.f145155a = new h(new URL(str)).t();
   66:             dVar.f145165k = true;
   67:             j.E("User-Agent", "name");
   68:             dVar.d("User-Agent");
>> 69:             dVar.a("User-Agent", "Mozilla");
   70:             dVar.f145160f = PlaybackException.ERROR_CODE_DRM_UNSPECIFIED;
   71:             C12343e0 c12343e0 = null;
   72:             ho0.e eVarF = ho0.e.f(dVar, null);
   73:             f.f(eVarF, "execute(...)");
   74:             c cVar = this.this$0;
   75:             String str2 = eVarF.f145177k;
   76:             cVar.getClass();
   77:             int i5 = 0;
   78:             RedditPostPreviewExtractor$ContentType redditPostPreviewExtractor$ContentType = (str2 != null && w.I(str2, WidgetKey.IMAGE_KEY, false)) ? RedditPostPreviewExtractor$ContentType.IMAGE : RedditPostPreviewExtractor$ContentType.OTHER;
   79:             int i10 = b.f111800a[redditPostPreviewExtractor$ContentType.ordinal()];
   80:             if (i10 == 1) {
   81:                 String str3 = this.$url;
   82:                 return new m50.a(str3, str3, 1);
   83:             }
   84:             if (i10 != 2) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/subredditcreation/ui/CommunityMediaUrlProcessor$downloadFileFromUrl$2.java`

- **cookieManagerOps** @ L61 — `CookieManager operations` (medium/settings)
  - **条件**：`if (fileExtensionFromUrl == null \|\| (strConcat = ".".concat(fileExtensionFromUrl)) == null) {`

  **代码上下文**：
```
   46:             URLConnection uRLConnectionOpenConnection = new URL(this.$urlString).openConnection();
   47:             uRLConnectionOpenConnection.setConnectTimeout(30000);
   48:             uRLConnectionOpenConnection.setReadTimeout(30000);
   49:             uRLConnectionOpenConnection.connect();
   50:             String fileExtensionFromUrl = MimeTypeMap.getFileExtensionFromUrl(this.$urlString);
   51:             if (fileExtensionFromUrl == null || (strConcat = ".".concat(fileExtensionFromUrl)) == null) {
   52:                 strConcat = EditImagePresenter.IMAGE_FILE_SUFFIX;
   53:             }
   54:             File fileCreateTempFile = File.createTempFile("reddit_community_", strConcat);
   55:             InputStream inputStream = uRLConnectionOpenConnection.getInputStream();
   56:             try {
   57:                 FileOutputStream fileOutputStream = new FileOutputStream(fileCreateTempFile);
   58:                 try {
   59:                     kotlin.jvm.internal.f.d(inputStream);
   60:                     AbstractC1221c.x(inputStream, fileOutputStream);
>> 61:                     fileOutputStream.flush();
   62:                     fileOutputStream.close();
   63:                     inputStream.close();
   64:                     if (fileCreateTempFile.exists() && fileCreateTempFile.length() != 0) {
   65:                         return fileCreateTempFile;
   66:                     }
   67:                     fileCreateTempFile.delete();
   68:                     return null;
   69:                 } finally {
   70:                 }
   71:             } finally {
   72:             }
   73:         } catch (Exception unused) {
   74:             return null;
   75:         }
   76:     }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/video/VideoRenderApiImpl.java`

- **cookieManagerOps** @ L76 — `CookieManager operations` (medium/settings)

  **代码上下文**：
```
   61: 
   62:     private final Bitmap createErrorThumbnail() {
   63:         Bitmap bitmapCreateBitmap = Bitmap.createBitmap(VideoCreatorConfigs.FRAME_DIMENSION_WIDTH, VideoCreatorConfigs.FRAME_DIMENSION_HEIGHT, Bitmap.Config.ARGB_8888);
   64:         f.f(bitmapCreateBitmap, "createBitmap(...)");
   65:         bitmapCreateBitmap.eraseColor(Color.parseColor("#E5E5E8"));
   66:         return bitmapCreateBitmap;
   67:     }
   68: 
   69:     /* JADX INFO: Access modifiers changed from: private */
   70:     public static final File createThumbnail$lambda$0(VideoRenderApiImpl videoRenderApiImpl, Bitmap thumbnail) throws IOException {
   71:         f.g(thumbnail, "thumbnail");
   72:         File fileCreateTempFile = File.createTempFile("video-thumbnail-", EditImagePresenter.IMAGE_FILE_SUFFIX, VideoCacheHelper.getVideoCacheDirectory(videoRenderApiImpl.context));
   73:         FileOutputStream fileOutputStream = new FileOutputStream(fileCreateTempFile);
   74:         thumbnail.compress(Bitmap.CompressFormat.JPEG, 70, fileOutputStream);
   75:         thumbnail.recycle();
>> 76:         fileOutputStream.flush();
   77:         fileOutputStream.close();
   78:         return fileCreateTempFile;
   79:     }
   80: 
   81:     /* JADX INFO: Access modifiers changed from: private */
   82:     public static final File createThumbnail$lambda$1(k kVar, Object p02) {
   83:         f.g(p02, "p0");
   84:         return (File) kVar.invoke(p02);
   85:     }
   86: 
   87:     /* JADX INFO: Access modifiers changed from: private */
   88:     /* JADX WARN: Removed duplicated region for block: B:12:0x0021  */
   89:     /* JADX WARN: Removed duplicated region for block: B:24:? A[RETURN, SYNTHETIC] */
   90:     /*
   91:         Code decompiled incorrectly, please refer to instructions dump.
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/widgets/utils/file/FileUtils.java`

- **cookieManagerOps** @ L31 — `CookieManager operations` (medium/settings)
  - **条件**：`if (inputStreamOpenInputStream == null \|\| outputStreamOpenOutputStream == null) { \| if (i5 == -1) {`

  **代码上下文**：
```
   16:     private static final int FILE_BYTE_ARRAY_SIZE = 4096;
   17: 
   18:     public static final boolean copyFile(ContentResolver contentResolver, Uri from, Uri to2) throws IOException {
   19:         f.g(contentResolver, "<this>");
   20:         f.g(from, "from");
   21:         f.g(to2, "to");
   22:         InputStream inputStreamOpenInputStream = contentResolver.openInputStream(from);
   23:         OutputStream outputStreamOpenOutputStream = contentResolver.openOutputStream(to2);
   24:         byte[] bArr = new byte[FILE_BYTE_ARRAY_SIZE];
   25:         if (inputStreamOpenInputStream == null || outputStreamOpenOutputStream == null) {
   26:             return false;
   27:         }
   28:         while (true) {
   29:             int i5 = inputStreamOpenInputStream.read(bArr);
   30:             if (i5 == -1) {
>> 31:                 outputStreamOpenOutputStream.flush();
   32:                 outputStreamOpenOutputStream.close();
   33:                 inputStreamOpenInputStream.close();
   34:                 return true;
   35:             }
   36:             outputStreamOpenOutputStream.write(bArr, 0, i5);
   37:         }
   38:     }
   39: 
   40:     public static final File createNewFile(File file, String fileName) {
   41:         f.g(file, "<this>");
   42:         f.g(fileName, "fileName");
   43:         File file2 = new File(file, fileName);
   44:         if (!file2.exists()) {
   45:             file2.createNewFile();
   46:         }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/video/creation/widgets/widget/trimclipview/m.java`

- **evaluateJavascript** @ L159 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`switch (this.f131464a) { \| case 10:`

  **代码上下文**：
```
   144:         switch (this.f131464a) {
   145:             case 10:
   146:                 WebView webView = (WebView) this.f131465b;
   147:                 kotlin.jvm.internal.f.g(view, "<unused var>");
   148:                 float f3 = webView.getContext().getResources().getDisplayMetrics().density;
   149:                 kotlin.jvm.internal.f.f(y0Var.f56440a.g(1), "getInsets(...)");
   150:                 int iL2 = Vk0.a.L(r1.f150708a / f3);
   151:                 int iL3 = Vk0.a.L(r1.f150710c / f3);
   152:                 int iL4 = Vk0.a.L(r1.f150709b / f3);
   153:                 int iL5 = Vk0.a.L(r1.f150711d / f3);
   154:                 StringBuilder sbR = AbstractC0117w.r("\n             document.documentElement.style.setProperty('--android-safe-area-inset-left', '", iL2, "px');\n             document.documentElement.style.setProperty('--android-safe-area-inset-right', '", "px');\n             document.documentElement.style.setProperty('--android-safe-area-inset-top', '", iL3);
   155:                 sbR.append(iL4);
   156:                 sbR.append("px');\n             document.documentElement.style.setProperty('--android-safe-area-inset-bottom', '");
   157:                 sbR.append(iL5);
   158:                 sbR.append("px');\n        ");
>> 159:                 webView.evaluateJavascript(q.q(sbR.toString()), null);
   160:                 return y0Var;
   161:             default:
   162:                 View view2 = (View) this.f131465b;
   163:                 kotlin.jvm.internal.f.g(view, "<unused var>");
   164:                 view2.setPadding(view2.getPaddingLeft(), view2.getPaddingTop(), view2.getPaddingRight(), y0Var.a());
   165:                 return y0Var.f56440a.c();
   166:         }
   167:     }
   168: 
   169:     @Override // androidx.appcompat.widget.f1
   170:     public boolean onMenuItemClick(MenuItem item) {
   171:         String str;
   172:         switch (this.f131464a) {
   173:             case 9:
   174:                 WebBrowserScreen webBrowserScreen = (WebBrowserScreen) this.f131465b;
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/WebBrowserLogic$onCreateView$4$1.java`

- **loadUrlDynamic** @ L67 — `WebView.loadUrl(dynamic)` (high/hookpoint)
  - **条件**：`if (((com.reddit.auth.login.common.util.c) dVar).b(context, account, redditSession, dVar2, webBrowserLogic$onCreateView$4$1) == coroutineSingletons) { \| if (webView != null) {`

  **代码上下文**：
```
   52:             Ld0.d dVar2 = bVar.f6988b;
   53:             this.label = 1;
   54:             webBrowserLogic$onCreateView$4$1 = this;
   55:             if (((com.reddit.auth.login.common.util.c) dVar).b(context, account, redditSession, dVar2, webBrowserLogic$onCreateView$4$1) == coroutineSingletons) {
   56:                 return coroutineSingletons;
   57:             }
   58:         } else {
   59:             if (i5 != 1) {
   60:                 throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   61:             }
   62:             kotlin.b.b(obj);
   63:             webBrowserLogic$onCreateView$4$1 = this;
   64:         }
   65:         WebView webView = webBrowserLogic$onCreateView$4$1.this$0.f131657v;
   66:         if (webView != null) {
>> 67:             webView.loadUrl(webBrowserLogic$onCreateView$4$1.$initialUrl);
   68:             return v.f6415a;
   69:         }
   70:         kotlin.jvm.internal.f.o("webView");
   71:         throw null;
   72:     }
   73: 
   74:     @Override // Tk0.n
   75:     public final Object invoke(A a9, Kk0.b<? super v> bVar) {
   76:         return ((WebBrowserLogic$onCreateView$4$1) create(a9, bVar)).invokeSuspend(v.f6415a);
   77:     }
   78: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/browser/g.java`

- **webChromeClientOrPrompt** @ L6 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.webembed.browser;
   2: 
   3: import android.graphics.Bitmap;
   4: import android.os.Bundle;
   5: import android.webkit.ConsoleMessage;
>> 6: import android.webkit.WebChromeClient;
   7: import android.webkit.WebView;
   8: import com.reddit.ads.analytics.AdPlacementType;
   9: import com.reddit.ads.analytics.ClickDestination;
   10: 
   11: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   12: /* loaded from: classes.dex */
   13: public final class g extends WebChromeClient {
   14: 
   15:     /* renamed from: a, reason: collision with root package name */
   16:     public final /* synthetic */ h f131625a;
   17: 
   18:     /* renamed from: b, reason: collision with root package name */
   19:     public final /* synthetic */ long f131626b;
   20: 
   21:     /* renamed from: c, reason: collision with root package name */
```

- **webChromeClientOrPrompt** @ L13 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   1: package com.reddit.webembed.browser;
   2: 
   3: import android.graphics.Bitmap;
   4: import android.os.Bundle;
   5: import android.webkit.ConsoleMessage;
   6: import android.webkit.WebChromeClient;
   7: import android.webkit.WebView;
   8: import com.reddit.ads.analytics.AdPlacementType;
   9: import com.reddit.ads.analytics.ClickDestination;
   10: 
   11: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   12: /* loaded from: classes.dex */
>> 13: public final class g extends WebChromeClient {
   14: 
   15:     /* renamed from: a, reason: collision with root package name */
   16:     public final /* synthetic */ h f131625a;
   17: 
   18:     /* renamed from: b, reason: collision with root package name */
   19:     public final /* synthetic */ long f131626b;
   20: 
   21:     /* renamed from: c, reason: collision with root package name */
   22:     public final /* synthetic */ String f131627c;
   23: 
   24:     /* renamed from: d, reason: collision with root package name */
   25:     public final /* synthetic */ String f131628d;
   26: 
   27:     /* renamed from: e, reason: collision with root package name */
   28:     public final /* synthetic */ String f131629e;
```

- **webChromeClientOrPrompt** @ L42 — `WebChromeClient / onJsPrompt` (medium/hookpoint)

  **代码上下文**：
```
   27:     /* renamed from: e, reason: collision with root package name */
   28:     public final /* synthetic */ String f131629e;
   29: 
   30:     /* renamed from: f, reason: collision with root package name */
   31:     public final /* synthetic */ AdPlacementType f131630f;
   32: 
   33:     public g(h hVar, long j10, String str, String str2, String str3, AdPlacementType adPlacementType) {
   34:         this.f131625a = hVar;
   35:         this.f131626b = j10;
   36:         this.f131627c = str;
   37:         this.f131628d = str2;
   38:         this.f131629e = str3;
   39:         this.f131630f = adPlacementType;
   40:     }
   41: 
>> 42:     @Override // android.webkit.WebChromeClient
   43:     public final Bitmap getDefaultVideoPoster() {
   44:         return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   45:     }
   46: 
   47:     @Override // android.webkit.WebChromeClient
   48:     public final boolean onConsoleMessage(ConsoleMessage consoleMessage) {
   49:         WP.d.c(this.f131625a.f131647l, null, null, null, new com.reddit.vault.dynamic.f(consoleMessage, 13), 7);
   50:         return super.onConsoleMessage(consoleMessage);
   51:     }
   52: 
   53:     @Override // android.webkit.WebChromeClient
   54:     public final void onProgressChanged(WebView webView, int i5) {
   55:         h hVar = this.f131625a;
   56:         Bundle bundle = hVar.f131637b;
   57:         if (bundle != null && bundle.getBoolean("com.reddit.arg.send_ad_analytics") && i5 == 100 && hVar.f131634D.compareAndSet(false, true)) {
```

- **webChromeClientOrPrompt** @ L47 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();`

  **代码上下文**：
```
   32: 
   33:     public g(h hVar, long j10, String str, String str2, String str3, AdPlacementType adPlacementType) {
   34:         this.f131625a = hVar;
   35:         this.f131626b = j10;
   36:         this.f131627c = str;
   37:         this.f131628d = str2;
   38:         this.f131629e = str3;
   39:         this.f131630f = adPlacementType;
   40:     }
   41: 
   42:     @Override // android.webkit.WebChromeClient
   43:     public final Bitmap getDefaultVideoPoster() {
   44:         return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   45:     }
   46: 
>> 47:     @Override // android.webkit.WebChromeClient
   48:     public final boolean onConsoleMessage(ConsoleMessage consoleMessage) {
   49:         WP.d.c(this.f131625a.f131647l, null, null, null, new com.reddit.vault.dynamic.f(consoleMessage, 13), 7);
   50:         return super.onConsoleMessage(consoleMessage);
   51:     }
   52: 
   53:     @Override // android.webkit.WebChromeClient
   54:     public final void onProgressChanged(WebView webView, int i5) {
   55:         h hVar = this.f131625a;
   56:         Bundle bundle = hVar.f131637b;
   57:         if (bundle != null && bundle.getBoolean("com.reddit.arg.send_ad_analytics") && i5 == 100 && hVar.f131634D.compareAndSet(false, true)) {
   58:             hVar.f131639d.c(this.f131627c, ClickDestination.IN_APP_BROWSER, (int) (this.f131626b - hVar.f131633C), this.f131628d, this.f131629e, this.f131630f);
   59:         }
   60:     }
   61: }
```

- **webChromeClientOrPrompt** @ L48 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();`

  **代码上下文**：
```
   33:     public g(h hVar, long j10, String str, String str2, String str3, AdPlacementType adPlacementType) {
   34:         this.f131625a = hVar;
   35:         this.f131626b = j10;
   36:         this.f131627c = str;
   37:         this.f131628d = str2;
   38:         this.f131629e = str3;
   39:         this.f131630f = adPlacementType;
   40:     }
   41: 
   42:     @Override // android.webkit.WebChromeClient
   43:     public final Bitmap getDefaultVideoPoster() {
   44:         return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   45:     }
   46: 
   47:     @Override // android.webkit.WebChromeClient
>> 48:     public final boolean onConsoleMessage(ConsoleMessage consoleMessage) {
   49:         WP.d.c(this.f131625a.f131647l, null, null, null, new com.reddit.vault.dynamic.f(consoleMessage, 13), 7);
   50:         return super.onConsoleMessage(consoleMessage);
   51:     }
   52: 
   53:     @Override // android.webkit.WebChromeClient
   54:     public final void onProgressChanged(WebView webView, int i5) {
   55:         h hVar = this.f131625a;
   56:         Bundle bundle = hVar.f131637b;
   57:         if (bundle != null && bundle.getBoolean("com.reddit.arg.send_ad_analytics") && i5 == 100 && hVar.f131634D.compareAndSet(false, true)) {
   58:             hVar.f131639d.c(this.f131627c, ClickDestination.IN_APP_BROWSER, (int) (this.f131626b - hVar.f131633C), this.f131628d, this.f131629e, this.f131630f);
   59:         }
   60:     }
   61: }
```

- **webChromeClientOrPrompt** @ L50 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();`

  **代码上下文**：
```
   35:         this.f131626b = j10;
   36:         this.f131627c = str;
   37:         this.f131628d = str2;
   38:         this.f131629e = str3;
   39:         this.f131630f = adPlacementType;
   40:     }
   41: 
   42:     @Override // android.webkit.WebChromeClient
   43:     public final Bitmap getDefaultVideoPoster() {
   44:         return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   45:     }
   46: 
   47:     @Override // android.webkit.WebChromeClient
   48:     public final boolean onConsoleMessage(ConsoleMessage consoleMessage) {
   49:         WP.d.c(this.f131625a.f131647l, null, null, null, new com.reddit.vault.dynamic.f(consoleMessage, 13), 7);
>> 50:         return super.onConsoleMessage(consoleMessage);
   51:     }
   52: 
   53:     @Override // android.webkit.WebChromeClient
   54:     public final void onProgressChanged(WebView webView, int i5) {
   55:         h hVar = this.f131625a;
   56:         Bundle bundle = hVar.f131637b;
   57:         if (bundle != null && bundle.getBoolean("com.reddit.arg.send_ad_analytics") && i5 == 100 && hVar.f131634D.compareAndSet(false, true)) {
   58:             hVar.f131639d.c(this.f131627c, ClickDestination.IN_APP_BROWSER, (int) (this.f131626b - hVar.f131633C), this.f131628d, this.f131629e, this.f131630f);
   59:         }
   60:     }
   61: }
```

- **webChromeClientOrPrompt** @ L53 — `WebChromeClient / onJsPrompt` (medium/hookpoint)
  - **条件**：`return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();`

  **代码上下文**：
```
   38:         this.f131629e = str3;
   39:         this.f131630f = adPlacementType;
   40:     }
   41: 
   42:     @Override // android.webkit.WebChromeClient
   43:     public final Bitmap getDefaultVideoPoster() {
   44:         return ((com.reddit.ads.impl.features.a) this.f131625a.f131640e).L() ? Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) : super.getDefaultVideoPoster();
   45:     }
   46: 
   47:     @Override // android.webkit.WebChromeClient
   48:     public final boolean onConsoleMessage(ConsoleMessage consoleMessage) {
   49:         WP.d.c(this.f131625a.f131647l, null, null, null, new com.reddit.vault.dynamic.f(consoleMessage, 13), 7);
   50:         return super.onConsoleMessage(consoleMessage);
   51:     }
   52: 
>> 53:     @Override // android.webkit.WebChromeClient
   54:     public final void onProgressChanged(WebView webView, int i5) {
   55:         h hVar = this.f131625a;
   56:         Bundle bundle = hVar.f131637b;
   57:         if (bundle != null && bundle.getBoolean("com.reddit.arg.send_ad_analytics") && i5 == 100 && hVar.f131634D.compareAndSet(false, true)) {
   58:             hVar.f131639d.c(this.f131627c, ClickDestination.IN_APP_BROWSER, (int) (this.f131626b - hVar.f131633C), this.f131628d, this.f131629e, this.f131630f);
   59:         }
   60:     }
   61: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/c.java`

- **javascriptInterfaceAnnotation** @ L25 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   10: /* loaded from: classes.dex */
   11: public final class c implements WebEmbedWebView$JsCallbacks {
   12: 
   13:     /* renamed from: a, reason: collision with root package name */
   14:     public final /* synthetic */ RedditEmbedWebViewViewModel f131665a;
   15: 
   16:     /* renamed from: b, reason: collision with root package name */
   17:     public final /* synthetic */ InterfaceC8113d0 f131666b;
   18: 
   19:     public c(RedditEmbedWebViewViewModel redditEmbedWebViewViewModel, InterfaceC8113d0 interfaceC8113d0) {
   20:         this.f131665a = redditEmbedWebViewViewModel;
   21:         this.f131666b = interfaceC8113d0;
   22:     }
   23: 
   24:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
>> 25:     @JavascriptInterface
   26:     public void refreshAuth() {
   27:         this.f131665a.onEvent(new com.reddit.webembed.webview.a((WebView) this.f131666b.getValue()));
   28:     }
   29: }
```

- **customBridgeMethodRefreshAuth** @ L26 — `Custom bridge method: refreshAuth` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   11: public final class c implements WebEmbedWebView$JsCallbacks {
   12: 
   13:     /* renamed from: a, reason: collision with root package name */
   14:     public final /* synthetic */ RedditEmbedWebViewViewModel f131665a;
   15: 
   16:     /* renamed from: b, reason: collision with root package name */
   17:     public final /* synthetic */ InterfaceC8113d0 f131666b;
   18: 
   19:     public c(RedditEmbedWebViewViewModel redditEmbedWebViewViewModel, InterfaceC8113d0 interfaceC8113d0) {
   20:         this.f131665a = redditEmbedWebViewViewModel;
   21:         this.f131666b = interfaceC8113d0;
   22:     }
   23: 
   24:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   25:     @JavascriptInterface
>> 26:     public void refreshAuth() {
   27:         this.f131665a.onEvent(new com.reddit.webembed.webview.a((WebView) this.f131666b.getValue()));
   28:     }
   29: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/d.java`

- **onPageFinished** @ L19 — `WebViewClient.onPageFinished` (high/hookpoint)

  **代码上下文**：
```
   4: import android.webkit.WebView;
   5: import com.reddit.wiki.screens.composables.s;
   6: 
   7: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   8: /* loaded from: classes.dex */
   9: public final class d extends com.google.accompanist.web.b {
   10: 
   11:     /* renamed from: d, reason: collision with root package name */
   12:     public final /* synthetic */ s f131667d;
   13: 
   14:     public d(s sVar) {
   15:         this.f131667d = sVar;
   16:     }
   17: 
   18:     @Override // com.google.accompanist.web.b, android.webkit.WebViewClient
>> 19:     public final void onPageFinished(WebView webView, String str) {
   20:         super.onPageFinished(webView, str);
   21:         if (webView != null) {
   22:             webView.requestApplyInsets();
   23:         }
   24:         if (this.f131667d == null || webView == null) {
   25:             return;
   26:         }
   27:         webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href || !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);
   28:     }
   29: 
   30:     @Override // android.webkit.WebViewClient
   31:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   32:         super.shouldOverrideUrlLoading(webView, webResourceRequest);
   33:         return false;
   34:     }
```

- **onPageFinished** @ L20 — `WebViewClient.onPageFinished` (high/hookpoint)

  **代码上下文**：
```
   5: import com.reddit.wiki.screens.composables.s;
   6: 
   7: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   8: /* loaded from: classes.dex */
   9: public final class d extends com.google.accompanist.web.b {
   10: 
   11:     /* renamed from: d, reason: collision with root package name */
   12:     public final /* synthetic */ s f131667d;
   13: 
   14:     public d(s sVar) {
   15:         this.f131667d = sVar;
   16:     }
   17: 
   18:     @Override // com.google.accompanist.web.b, android.webkit.WebViewClient
   19:     public final void onPageFinished(WebView webView, String str) {
>> 20:         super.onPageFinished(webView, str);
   21:         if (webView != null) {
   22:             webView.requestApplyInsets();
   23:         }
   24:         if (this.f131667d == null || webView == null) {
   25:             return;
   26:         }
   27:         webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href || !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);
   28:     }
   29: 
   30:     @Override // android.webkit.WebViewClient
   31:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   32:         super.shouldOverrideUrlLoading(webView, webResourceRequest);
   33:         return false;
   34:     }
   35: }
```

- **evaluateJavascript** @ L27 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);`

  **代码上下文**：
```
   12:     public final /* synthetic */ s f131667d;
   13: 
   14:     public d(s sVar) {
   15:         this.f131667d = sVar;
   16:     }
   17: 
   18:     @Override // com.google.accompanist.web.b, android.webkit.WebViewClient
   19:     public final void onPageFinished(WebView webView, String str) {
   20:         super.onPageFinished(webView, str);
   21:         if (webView != null) {
   22:             webView.requestApplyInsets();
   23:         }
   24:         if (this.f131667d == null || webView == null) {
   25:             return;
   26:         }
>> 27:         webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href || !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);
   28:     }
   29: 
   30:     @Override // android.webkit.WebViewClient
   31:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   32:         super.shouldOverrideUrlLoading(webView, webResourceRequest);
   33:         return false;
   34:     }
   35: }
```

- **shouldOverrideUrlLoading** @ L31 — `WebViewClient.shouldOverrideUrlLoading` (high/hookpoint)
  - **条件**：`if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);`

  **代码上下文**：
```
   16:     }
   17: 
   18:     @Override // com.google.accompanist.web.b, android.webkit.WebViewClient
   19:     public final void onPageFinished(WebView webView, String str) {
   20:         super.onPageFinished(webView, str);
   21:         if (webView != null) {
   22:             webView.requestApplyInsets();
   23:         }
   24:         if (this.f131667d == null || webView == null) {
   25:             return;
   26:         }
   27:         webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href || !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);
   28:     }
   29: 
   30:     @Override // android.webkit.WebViewClient
>> 31:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
   32:         super.shouldOverrideUrlLoading(webView, webResourceRequest);
   33:         return false;
   34:     }
   35: }
```

- **shouldOverrideUrlLoading** @ L32 — `WebViewClient.shouldOverrideUrlLoading` (high/hookpoint)
  - **条件**：`if (webView != null) { \| if (this.f131667d == null \|\| webView == null) { \| webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href \|\| !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);`

  **代码上下文**：
```
   17: 
   18:     @Override // com.google.accompanist.web.b, android.webkit.WebViewClient
   19:     public final void onPageFinished(WebView webView, String str) {
   20:         super.onPageFinished(webView, str);
   21:         if (webView != null) {
   22:             webView.requestApplyInsets();
   23:         }
   24:         if (this.f131667d == null || webView == null) {
   25:             return;
   26:         }
   27:         webView.evaluateJavascript("\n  (function() {\n    document.addEventListener('click', function(event) {\n      if (event.target.tagName !== 'A') return;\n\n      var href = event.target.getAttribute('href');\n      if (!href || !href.startsWith('#')) return;\n\n      event.preventDefault();\n\n      var id = href.substring(1);\n      var element = document.getElementById(id);\n      if (!element) return;\n\n      AndroidBridge.onAnchorLinkClicked(element.offsetTop, window.devicePixelRatio);\n    });\n})();\n", null);
   28:     }
   29: 
   30:     @Override // android.webkit.WebViewClient
   31:     public final boolean shouldOverrideUrlLoading(WebView webView, WebResourceRequest webResourceRequest) {
>> 32:         super.shouldOverrideUrlLoading(webView, webResourceRequest);
   33:         return false;
   34:     }
   35: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/composables/e.java`

- **webembedWrapperRegistration** @ L30 — `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` (high/bridge)

  **代码上下文**：
```
   15:     /* JADX WARN: Removed duplicated region for block: B:43:0x0089  */
   16:     /* JADX WARN: Removed duplicated region for block: B:46:0x0093  */
   17:     /* JADX WARN: Removed duplicated region for block: B:47:0x009a  */
   18:     /* JADX WARN: Removed duplicated region for block: B:54:0x00ba  */
   19:     /* JADX WARN: Removed duplicated region for block: B:55:0x00bc  */
   20:     /* JADX WARN: Removed duplicated region for block: B:58:0x00c6  */
   21:     /*
   22:         Code decompiled incorrectly, please refer to instructions dump.
   23:         To view partially-correct add '--show-bad-code' argument
   24:     */
   25:     public static final void a(java.lang.String r29, androidx.compose.ui.r r30, qm0.d r31, boolean r32, java.lang.String r33, com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks r34, com.reddit.wiki.screens.composables.s r35, Tk0.a r36, androidx.compose.runtime.InterfaceC8128l r37, int r38, int r39) {
   26:         /*
   27:             Method dump skipped, instructions count: 737
   28:             To view this dump add '--comments-level debug' option
   29:         */
>> 30:         throw new UnsupportedOperationException("Method not decompiled: com.reddit.webembed.composables.e.a(java.lang.String, androidx.compose.ui.r, qm0.d, boolean, java.lang.String, com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks, com.reddit.wiki.screens.composables.s, Tk0.a, androidx.compose.runtime.l, int, int):void");
   31:     }
   32: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/webview/RedditEmbedWebViewViewModel$onRefreshAuth$2.java`

- **evaluateJavascript** @ L52 — `WebView.evaluateJavascript` (high/js_injection)
  - **条件**：`if (this.label != 0) {`

  **代码上下文**：
```
   37: 
   38:         @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   39:         public final Kk0.b<v> create(Object obj, Kk0.b<?> bVar) {
   40:             return new AnonymousClass1(this.$webView, this.this$0, bVar);
   41:         }
   42: 
   43:         @Override // kotlin.coroutines.jvm.internal.BaseContinuationImpl
   44:         public final Object invokeSuspend(Object obj) {
   45:             CoroutineSingletons coroutineSingletons = CoroutineSingletons.COROUTINE_SUSPENDED;
   46:             if (this.label != 0) {
   47:                 throw new IllegalStateException("call to 'resume' before 'invoke' with coroutine");
   48:             }
   49:             kotlin.b.b(obj);
   50:             WebView webView = this.$webView;
   51:             final RedditEmbedWebViewViewModel redditEmbedWebViewViewModel = this.this$0;
>> 52:             webView.evaluateJavascript(redditEmbedWebViewViewModel.y, new ValueCallback() { // from class: com.reddit.webembed.webview.d
   53:                 @Override // android.webkit.ValueCallback
   54:                 public final void onReceiveValue(Object obj2) {
   55:                     RedditEmbedWebViewViewModel redditEmbedWebViewViewModel2 = redditEmbedWebViewViewModel;
   56:                     WP.d.c(redditEmbedWebViewViewModel2.f131740x, null, null, null, new com.reddit.video.creation.widgets.utils.b(22), 7);
   57:                     redditEmbedWebViewViewModel2.f131739w.invoke();
   58:                 }
   59:             });
   60:             return v.f6415a;
   61:         }
   62: 
   63:         @Override // Tk0.n
   64:         public final Object invoke(A a9, Kk0.b<? super v> bVar) {
   65:             return ((AnonymousClass1) create(a9, bVar)).invokeSuspend(v.f6415a);
   66:         }
   67:     }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/webembed/webview/WebEmbedWebView$JsCallbacks.java`

- **javascriptInterfaceAnnotation** @ L12 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   1: package com.reddit.webembed.webview;
   2: 
   3: import android.webkit.JavascriptInterface;
   4: import androidx.annotation.Keep;
   5: import kotlin.Metadata;
   6: 
   7: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   8: @Keep
   9: @Metadata(d1 = {"\u0000\u000e\n\u0000\n\u0002\u0010\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\bg\u0018\u00002\u00020\u0001J\u000f\u0010\u0003\u001a\u00020\u0002H'¢\u0006\u0004\b\u0003\u0010\u0004¨\u0006\u0005À\u0006\u0003"}, d2 = {"com/reddit/webembed/webview/WebEmbedWebView$JsCallbacks", "", "LFk0/v;", "refreshAuth", "()V", "webembed_public-ui"}, k = 1, mv = {2, 2, 0}, xi = 48)
   10: /* loaded from: classes6.dex */
   11: public interface WebEmbedWebView$JsCallbacks {
>> 12:     @JavascriptInterface
   13:     void refreshAuth();
   14: }
```

- **customBridgeMethodRefreshAuth** @ L13 — `Custom bridge method: refreshAuth` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   1: package com.reddit.webembed.webview;
   2: 
   3: import android.webkit.JavascriptInterface;
   4: import androidx.annotation.Keep;
   5: import kotlin.Metadata;
   6: 
   7: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   8: @Keep
   9: @Metadata(d1 = {"\u0000\u000e\n\u0000\n\u0002\u0010\u0000\n\u0002\u0018\u0002\n\u0002\b\u0003\bg\u0018\u00002\u00020\u0001J\u000f\u0010\u0003\u001a\u00020\u0002H'¢\u0006\u0004\b\u0003\u0010\u0004¨\u0006\u0005À\u0006\u0003"}, d2 = {"com/reddit/webembed/webview/WebEmbedWebView$JsCallbacks", "", "LFk0/v;", "refreshAuth", "()V", "webembed_public-ui"}, k = 1, mv = {2, 2, 0}, xi = 48)
   10: /* loaded from: classes6.dex */
   11: public interface WebEmbedWebView$JsCallbacks {
   12:     @JavascriptInterface
>> 13:     void refreshAuth();
   14: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/b.java`

- **webembedWrapperRegistration** @ L263 — `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` (high/bridge)
  - **条件**：`if (c8154u0V != null) { \| int i10 = (rVar.f(str) ? 4 : 2) \| i5 \| (rVar.h(aVar) ? 32 : 16) \| (rVar.h(kVar) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128); \| if (rVar.Y(i10 & 1, (i10 & 147) != 146)) {`

  **代码上下文**：
```
   248:             rVar2 = rVar;
   249:         }
   250:         C8154u0 c8154u0V = rVar3.v();
   251:         if (c8154u0V != null) {
   252:             c8154u0V.f53701d = new Ef0.g(str, aVar, rVar2, i5, 15);
   253:         }
   254:     }
   255: 
   256:     public static final void e(String str, Tk0.a aVar, Tk0.k kVar, InterfaceC8128l interfaceC8128l, int i5) {
   257:         String str2;
   258:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   259:         rVar.k0(-1737430255);
   260:         int i10 = (rVar.f(str) ? 4 : 2) | i5 | (rVar.h(aVar) ? 32 : 16) | (rVar.h(kVar) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128);
   261:         if (rVar.Y(i10 & 1, (i10 & 147) != 146)) {
   262:             str2 = str;
>> 263:             com.reddit.webembed.composables.e.a(str2, AbstractC7923d.H(r0.d(AbstractC8274l0.C(androidx.compose.ui.o.f54960a, "wiki_web_view"), 1.0f), 16, 0.0f, 2), null, false, "AndroidBridge", new i(aVar, kVar), null, null, rVar, (i10 & 14) | 196656, 3996);
   264:         } else {
   265:             str2 = str;
   266:             rVar.b0();
   267:         }
   268:         C8154u0 c8154u0V = rVar.v();
   269:         if (c8154u0V != null) {
   270:             c8154u0V.f53701d = new N0(str2, aVar, kVar, i5);
   271:         }
   272:     }
   273: 
   274:     public static final void f(Bj0.b wikiAttributionInfo, InterfaceC18194a interfaceC18194a, Tk0.a onSubredditClicked, Tk0.a onUserClicked, Tk0.n onJoinButtonStateChanged, androidx.compose.ui.r rVar, InterfaceC8128l interfaceC8128l, int i5) {
   275:         InterfaceC18194a interfaceC18194a2;
   276:         Tk0.a aVar;
   277:         kotlin.jvm.internal.f.g(wikiAttributionInfo, "wikiAttributionInfo");
   278:         kotlin.jvm.internal.f.g(onSubredditClicked, "onSubredditClicked");
```

- **webembedWrapperRegistration** @ L1093 — `WebEmbed wrapper registration (com.reddit.webembed.composables.e.a)` (high/bridge)
  - **条件**：`int i10 = i5 \| (rVar.f(contentUrl) ? 4 : 2) \| (rVar.h(onAnchorLinkClick) ? 32 : 16) \| (rVar.h(onRichTextLinkClick) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128) \| (rVar.h(onWikiInteractive) ? 2048 : 1024);`

  **代码上下文**：
```
   1078:         C8154u0 c8154u0V = rVar2.v();
   1079:         if (c8154u0V != null) {
   1080:             c8154u0V.f53701d = new com.reddit.snoovatar.presentation.search.composables.f(rVar, i5, 6);
   1081:         }
   1082:     }
   1083: 
   1084:     public static final void o(String contentUrl, Tk0.k onAnchorLinkClick, Tk0.k onRichTextLinkClick, Tk0.a onWikiInteractive, InterfaceC8128l interfaceC8128l, int i5) {
   1085:         kotlin.jvm.internal.f.g(contentUrl, "contentUrl");
   1086:         kotlin.jvm.internal.f.g(onAnchorLinkClick, "onAnchorLinkClick");
   1087:         kotlin.jvm.internal.f.g(onRichTextLinkClick, "onRichTextLinkClick");
   1088:         kotlin.jvm.internal.f.g(onWikiInteractive, "onWikiInteractive");
   1089:         androidx.compose.runtime.r rVar = (androidx.compose.runtime.r) interfaceC8128l;
   1090:         rVar.k0(-520750865);
   1091:         int i10 = i5 | (rVar.f(contentUrl) ? 4 : 2) | (rVar.h(onAnchorLinkClick) ? 32 : 16) | (rVar.h(onRichTextLinkClick) ? AppOuterClass$RenderVersion.NO_DEVVIT_JSON_VALUE : 128) | (rVar.h(onWikiInteractive) ? 2048 : 1024);
   1092:         if (rVar.Y(i10 & 1, (i10 & 1171) != 1170)) {
>> 1093:             com.reddit.webembed.composables.e.a(contentUrl, null, null, false, "AndroidBridge", new r(onAnchorLinkClick, onRichTextLinkClick, onWikiInteractive), new s(), null, rVar, (i10 & 14) | 196608, 3742);
   1094:         } else {
   1095:             rVar.b0();
   1096:         }
   1097:         C8154u0 c8154u0V = rVar.v();
   1098:         if (c8154u0V != null) {
   1099:             c8154u0V.f53701d = new q(contentUrl, onAnchorLinkClick, onRichTextLinkClick, onWikiInteractive, i5);
   1100:         }
   1101:     }
   1102: 
   1103:     public static final void p(int i5, InterfaceC8128l interfaceC8128l, androidx.compose.ui.r rVar, String str) {
   1104:         androidx.compose.runtime.r rVar2;
   1105:         androidx.compose.runtime.r rVar3 = (androidx.compose.runtime.r) interfaceC8128l;
   1106:         rVar3.k0(1005854765);
   1107:         int i10 = (rVar3.f(str) ? 4 : 2) | i5;
   1108:         if (rVar3.Y(i10 & 1, (i10 & 19) != 18)) {
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/i.java`

- **javascriptInterfaceAnnotation** @ L21 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   6: /* compiled from: r8-map-id-87ec5bc36632586c6fae96b5d10748bad7beabb9a6bf9a766b868cb803b6497c */
   7: /* loaded from: classes7.dex */
   8: public final class i implements WebEmbedWebView$JsCallbacks {
   9: 
   10:     /* renamed from: a, reason: collision with root package name */
   11:     public final /* synthetic */ Tk0.a f131882a;
   12: 
   13:     /* renamed from: b, reason: collision with root package name */
   14:     public final /* synthetic */ Tk0.k f131883b;
   15: 
   16:     public i(Tk0.a aVar, Tk0.k kVar) {
   17:         this.f131882a = aVar;
   18:         this.f131883b = kVar;
   19:     }
   20: 
>> 21:     @JavascriptInterface
   22:     public final void onEditCancelled() {
   23:         this.f131883b.invoke(Boolean.FALSE);
   24:     }
   25: 
   26:     @JavascriptInterface
   27:     public final void onEditFinished() {
   28:         this.f131883b.invoke(Boolean.TRUE);
   29:     }
   30: 
   31:     @JavascriptInterface
   32:     public final void onWikiInteractive() {
   33:         this.f131882a.invoke();
   34:     }
   35: 
   36:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
```

- **javascriptInterfaceAnnotation** @ L26 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   11:     public final /* synthetic */ Tk0.a f131882a;
   12: 
   13:     /* renamed from: b, reason: collision with root package name */
   14:     public final /* synthetic */ Tk0.k f131883b;
   15: 
   16:     public i(Tk0.a aVar, Tk0.k kVar) {
   17:         this.f131882a = aVar;
   18:         this.f131883b = kVar;
   19:     }
   20: 
   21:     @JavascriptInterface
   22:     public final void onEditCancelled() {
   23:         this.f131883b.invoke(Boolean.FALSE);
   24:     }
   25: 
>> 26:     @JavascriptInterface
   27:     public final void onEditFinished() {
   28:         this.f131883b.invoke(Boolean.TRUE);
   29:     }
   30: 
   31:     @JavascriptInterface
   32:     public final void onWikiInteractive() {
   33:         this.f131882a.invoke();
   34:     }
   35: 
   36:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   37:     @JavascriptInterface
   38:     public void refreshAuth() {
   39:     }
   40: }
```

- **javascriptInterfaceAnnotation** @ L31 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   16:     public i(Tk0.a aVar, Tk0.k kVar) {
   17:         this.f131882a = aVar;
   18:         this.f131883b = kVar;
   19:     }
   20: 
   21:     @JavascriptInterface
   22:     public final void onEditCancelled() {
   23:         this.f131883b.invoke(Boolean.FALSE);
   24:     }
   25: 
   26:     @JavascriptInterface
   27:     public final void onEditFinished() {
   28:         this.f131883b.invoke(Boolean.TRUE);
   29:     }
   30: 
>> 31:     @JavascriptInterface
   32:     public final void onWikiInteractive() {
   33:         this.f131882a.invoke();
   34:     }
   35: 
   36:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   37:     @JavascriptInterface
   38:     public void refreshAuth() {
   39:     }
   40: }
```

- **javascriptInterfaceAnnotation** @ L37 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   22:     public final void onEditCancelled() {
   23:         this.f131883b.invoke(Boolean.FALSE);
   24:     }
   25: 
   26:     @JavascriptInterface
   27:     public final void onEditFinished() {
   28:         this.f131883b.invoke(Boolean.TRUE);
   29:     }
   30: 
   31:     @JavascriptInterface
   32:     public final void onWikiInteractive() {
   33:         this.f131882a.invoke();
   34:     }
   35: 
   36:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
>> 37:     @JavascriptInterface
   38:     public void refreshAuth() {
   39:     }
   40: }
```

- **customBridgeMethodRefreshAuth** @ L38 — `Custom bridge method: refreshAuth` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   23:         this.f131883b.invoke(Boolean.FALSE);
   24:     }
   25: 
   26:     @JavascriptInterface
   27:     public final void onEditFinished() {
   28:         this.f131883b.invoke(Boolean.TRUE);
   29:     }
   30: 
   31:     @JavascriptInterface
   32:     public final void onWikiInteractive() {
   33:         this.f131882a.invoke();
   34:     }
   35: 
   36:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   37:     @JavascriptInterface
>> 38:     public void refreshAuth() {
   39:     }
   40: }
```

### `/Users/karess/Desktop/reddit-code/sources/com/reddit/wiki/screens/composables/r.java`

- **javascriptInterfaceAnnotation** @ L25 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   10:     /* renamed from: a, reason: collision with root package name */
   11:     public final /* synthetic */ Tk0.k f131944a;
   12: 
   13:     /* renamed from: b, reason: collision with root package name */
   14:     public final /* synthetic */ Tk0.k f131945b;
   15: 
   16:     /* renamed from: c, reason: collision with root package name */
   17:     public final /* synthetic */ Tk0.a f131946c;
   18: 
   19:     public r(Tk0.k kVar, Tk0.k kVar2, Tk0.a aVar) {
   20:         this.f131944a = kVar;
   21:         this.f131945b = kVar2;
   22:         this.f131946c = aVar;
   23:     }
   24: 
>> 25:     @JavascriptInterface
   26:     public final void onAnchorLinkClicked(long j10, float f3) {
   27:         this.f131944a.invoke(new a(f3, j10));
   28:     }
   29: 
   30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
   37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
```

- **customBridgeMethodOnAnchorLinkClicked** @ L26 — `Custom bridge method: onAnchorLinkClicked` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   11:     public final /* synthetic */ Tk0.k f131944a;
   12: 
   13:     /* renamed from: b, reason: collision with root package name */
   14:     public final /* synthetic */ Tk0.k f131945b;
   15: 
   16:     /* renamed from: c, reason: collision with root package name */
   17:     public final /* synthetic */ Tk0.a f131946c;
   18: 
   19:     public r(Tk0.k kVar, Tk0.k kVar2, Tk0.a aVar) {
   20:         this.f131944a = kVar;
   21:         this.f131945b = kVar2;
   22:         this.f131946c = aVar;
   23:     }
   24: 
   25:     @JavascriptInterface
>> 26:     public final void onAnchorLinkClicked(long j10, float f3) {
   27:         this.f131944a.invoke(new a(f3, j10));
   28:     }
   29: 
   30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
   37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
   41: 
```

- **javascriptInterfaceAnnotation** @ L30 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   15: 
   16:     /* renamed from: c, reason: collision with root package name */
   17:     public final /* synthetic */ Tk0.a f131946c;
   18: 
   19:     public r(Tk0.k kVar, Tk0.k kVar2, Tk0.a aVar) {
   20:         this.f131944a = kVar;
   21:         this.f131945b = kVar2;
   22:         this.f131946c = aVar;
   23:     }
   24: 
   25:     @JavascriptInterface
   26:     public final void onAnchorLinkClicked(long j10, float f3) {
   27:         this.f131944a.invoke(new a(f3, j10));
   28:     }
   29: 
>> 30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
   37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
   41: 
   42:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   43:     @JavascriptInterface
   44:     public void refreshAuth() {
   45:     }
```

- **javascriptInterfaceAnnotation** @ L37 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   22:         this.f131946c = aVar;
   23:     }
   24: 
   25:     @JavascriptInterface
   26:     public final void onAnchorLinkClicked(long j10, float f3) {
   27:         this.f131944a.invoke(new a(f3, j10));
   28:     }
   29: 
   30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
>> 37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
   41: 
   42:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   43:     @JavascriptInterface
   44:     public void refreshAuth() {
   45:     }
   46: }
```

- **javascriptInterfaceAnnotation** @ L43 — `@JavascriptInterface` (high/bridge)

  **代码上下文**：
```
   28:     }
   29: 
   30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
   37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
   41: 
   42:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
>> 43:     @JavascriptInterface
   44:     public void refreshAuth() {
   45:     }
   46: }
```

- **customBridgeMethodRefreshAuth** @ L44 — `Custom bridge method: refreshAuth` (high/bridge)
  - **说明**：这是 Reddit 自定义的桥接方法，带有 `@JavascriptInterface` 注解，暴露给 JavaScript 调用

  **代码上下文**：
```
   29: 
   30:     @JavascriptInterface
   31:     public final void onLinkClicked(String url, String displayText) {
   32:         kotlin.jvm.internal.f.g(url, "url");
   33:         kotlin.jvm.internal.f.g(displayText, "displayText");
   34:         this.f131945b.invoke(new B80.k(null, displayText, url, null, null));
   35:     }
   36: 
   37:     @JavascriptInterface
   38:     public final void onWikiInteractive() {
   39:         this.f131946c.invoke();
   40:     }
   41: 
   42:     @Override // com.reddit.webembed.webview.WebEmbedWebView$JsCallbacks
   43:     @JavascriptInterface
>> 44:     public void refreshAuth() {
   45:     }
   46: }
```
