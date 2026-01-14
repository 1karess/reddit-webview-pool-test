#!/bin/bash

# GitHub Pages 部署脚本
# 使用方法：./deploy_to_github.sh

echo "=========================================="
echo "🚀 部署iframe测试页面到GitHub Pages"
echo "=========================================="
echo ""

# 检查是否在git仓库中
if [ ! -d ".git" ]; then
    echo "❌ 当前目录不是git仓库"
    echo "正在初始化git仓库..."
    git init
    echo "✅ git仓库已初始化"
    echo ""
fi

# 检查是否有远程仓库
if ! git remote | grep -q "origin"; then
    echo "⚠️  未检测到GitHub远程仓库"
    echo ""
    read -p "请输入你的GitHub用户名: " GITHUB_USER
    read -p "请输入仓库名（如：reddit-code）: " REPO_NAME
    
    if [ -z "$GITHUB_USER" ] || [ -z "$REPO_NAME" ]; then
        echo "❌ 用户名和仓库名不能为空"
        exit 1
    fi
    
    echo "添加远程仓库: https://github.com/$GITHUB_USER/$REPO_NAME.git"
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
    echo "✅ 远程仓库已添加"
    echo ""
fi

# 添加所有测试文件
echo "📦 添加测试文件..."
git add iframe测试-*.html
git add iframe测试指南.md
git add deploy_to_github.sh

# 检查是否有更改
if git diff --staged --quiet; then
    echo "ℹ️  没有需要提交的更改"
else
    echo "💾 提交更改..."
    git commit -m "Add iframe privacy leak test pages

- 场景1: 同源iframe共享存储
- 场景2: 跨源iframe存储残留
- 场景3: window.name泄露
- 场景4: postMessage传递错误数据
- 场景5: Cookie共享跨账号认证
- 综合测试页面和测试指南"
    echo "✅ 更改已提交"
    echo ""
fi

# 推送到GitHub
echo "📤 推送到GitHub..."
BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
git push -u origin $BRANCH

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ 部署成功！"
    echo "=========================================="
    echo ""
    
    # 获取仓库URL
    REPO_URL=$(git remote get-url origin 2>/dev/null | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//')
    
    if [ ! -z "$REPO_URL" ]; then
        # 提取用户名和仓库名
        GITHUB_USER=$(echo $REPO_URL | sed 's|https://github.com/||' | cut -d'/' -f1)
        REPO_NAME=$(echo $REPO_URL | sed 's|https://github.com/||' | cut -d'/' -f2)
        
        echo "📋 测试页面链接："
        echo ""
        echo "综合测试页面："
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-综合测试页面.html"
        echo ""
        echo "场景1：同源iframe共享存储"
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-场景1-同源iframe共享存储.html"
        echo ""
        echo "场景2：跨源iframe存储残留"
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-场景2-跨源iframe存储残留.html"
        echo ""
        echo "场景3：window.name泄露"
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-场景3-window.name泄露.html"
        echo ""
        echo "场景4：postMessage传递错误数据"
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-场景4-postMessage传递错误数据.html"
        echo ""
        echo "场景5：Cookie共享跨账号认证"
        echo "  https://$GITHUB_USER.github.io/$REPO_NAME/iframe测试-场景5-Cookie共享跨账号认证.html"
        echo ""
        echo "⚠️  注意：如果这是新仓库，需要："
        echo "  1. 在GitHub上启用GitHub Pages"
        echo "  2. 设置Source为：main分支 / root目录"
        echo "  3. 等待几分钟让Pages生效"
        echo ""
    fi
else
    echo ""
    echo "❌ 推送失败，请检查："
    echo "  1. GitHub仓库是否存在"
    echo "  2. 是否有推送权限"
    echo "  3. 网络连接是否正常"
    echo ""
fi
