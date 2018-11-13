# 浏览器

## 1. 书签 & 设置 & 插件

依靠账号同步

## 2. 插件配置

### 1)油猴

靠备份 zip

### 2)SwitchyOmega

XXNet 的 设置

### 3)Stylish

https://userstyles.org/styles/128178/google-variety

## 3. 需要单独设置的内容

### 1)重定向 HSTS

Chrome 强制 http 定向到 https

在使用 Hosts 访问某些网站的时候, 通常必须使用 HTTPS 的方式才能正常打开, 但某些时候这些网站内部还有 HTTP 的链接, 需要手动修改, 颇为麻烦, 本文介绍一种在 Chrome 下自动转化 HTTP 为 HTTPS 方式的方法. 只需几个简单的步骤即可:

1. 打开 Chrome, 在地址栏键入 `Chrome://net-internals/`
1. 在 HSTS 选项卡下的 Domain 中输入要实现强制转换的域名地址(不带 https 的地址), 比如 Twitter.com, plus.google.com 等
1. 最后勾选上 Include subdomains, 这样可以确保所有二级域名都被重定向到 https, 比如 search.twitter.com.
1. 点击 Add

例如:

* 输入 webcache.googleusercontent.com, 即可强制 `Google 快照` 以 HTTPS 方式打开.
* 输入 google.com, 即可强制 `Google` 以 HTTPS 方式打开(包括 Google Scholar).

### 2)安装 非 Chrome Store 插件

Chrome 浏览器打开 chrome://flags，找到(Ctrl+F)#extensions-on-chrome-urls 那一选项，然后改为 Enable，重启以后就可以在扩展程序页面拖进 crx 扩展来安装。该方法支持所有平台的 Chrome 浏览器！
