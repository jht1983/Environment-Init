# Eclipse

## 配置

* General --> appearance --> Colors and Fonts --> Basic --> Text Font --> Edit 调字体: YaHei.Consolas.Hybrid(不是 @YaHei.Consolas.Hybrid), 14
* General --> Editors --> Text Editors --> Hyperlinking --> Default modifier key : Ctrl -> Alt
* General --> Workspace --> 右侧 Text file encoding --> 选择 Other: UTF-8
* Java --> Editor --> Content Assist .asdfghjklzxcvbnmqwertyuiopASDFGHJKLZXCVBNMQWERTYUIOP
* Java --> Editor --> Sava Actions --> 勾选 Perform the selected actions on sava & Organize imports
* 关联 Java 源码: Java -> Installed JRES -> 选择你的 JRE -> 点边上的 Edit -> 列表全选 -> Source Attachment -> 选择 JDK 目录下的 src.zip 文件
* maven 配置 installaton 为本地安装的 及 全局设置 or 用户设置(见[maven](../maven/README.md)) 以修改本地仓库位置
* Remote Systems --> 全选 false
* New Server: Server --> Runtime Environments --> Add 注意 JRE 选本地的
* Window --> Web Browser --> chrome (Java EE 视图)

## 插件

1. 项目热部署: [JRebel](https://marketplace.eclipse.org/content/jrebel-eclipse)

    登录 https://my.jrebel.com/login 即可拿到注册码

    ```txt
    VfwdOHYIylqZEW5ec3cc0MwSixnWswLTm82hp1Nm1mNZjw+TU0cNSMMDJiDq+Yk0cR0hTOimz6eOC+Q11ggXvo7/voomiKTC8nbSeNY+zytmMBY/Wk0CarO4Es6MZvXsYOOpkg==
    ```

1. Spring 开发: [Spring Tools](https://marketplace.eclipse.org/content/spring-tools-aka-spring-ide-and-spring-tool-suite#group-external-install-button)

    Eclipse + Spring Tools = STS, 不如单独下一个 STS

1. SVN 支持: [Subclipse(推荐)](https://marketplace.eclipse.org/content/subclipse) or [Subversive](https://marketplace.eclipse.org/content/subversive-svn-team-provider)

    Subclipse 是 SVN 官方的 eclipse 插件。而Subversive 则是 eclipse 官方的 SVN 插件
