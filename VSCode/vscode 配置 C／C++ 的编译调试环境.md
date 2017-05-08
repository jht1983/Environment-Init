# vscode 配置 C/C++ 的编译调试环境

转自：http://jacean.github.io/2016/04/04/vscode%E9%85%8D%E7%BD%AEC-C-%E7%9A%84%E7%BC%96%E8%AF%91%E8%B0%83%E8%AF%95%E7%8E%AF%E5%A2%83/

用着轻量的编辑器，却又想把编辑器打造成 IDE，，，于是开始了 Debug 插件的配置。

## 安装 DEBUG

本来有一款 C/C++ 的插件，是利用微软的 CLI 的，但是 Ubuntu15.10 不在支持之列，在尝试无果之后只能放弃，万幸还有 Debug.
ctrl-p，呼出命令行，输入

> ext install debug

回车就可安装 debug 插件了。

## 调试，配置 launch.json

插件安装好后，打开 C 项目，选中调试栏的齿轮设置，在弹出的下拉列表里选择 debug，会自动生成一分 launch.json, 但是还不能直接用的，需要改改。

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "type": "gdb",
            "request": "launch",
            "target": "./bin/executable",
            "cwd": "${workspaceRoot}"
        }
    ]
}
```

其他的不多说了，主要就说下 target，这个是 gdb 调试的目标，所以就应该是编译后的文件对吧。
那好，比如我有 hello.c，那么在终端, 首先切换到项目根目录，方便解释，然后执行如下，

> gcc -g hello.c -o hello

会生成编译后的 hello 文件，要调试的话就把 gdb 的 targe 指向这个文件，需要修改如下:

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug",
            "type": "gdb",
            "request": "launch",
            "target": "hello",
            "cwd": "${workspaceRoot}"
        }
    ]
}
```

这时候在 vscode 里，点击绿色小三角，或是 F5，就可以进行调试了。
可以在 vscode 的控制台里看到输出。如果需要输入，那么在最下面的命令输入里输入就好，不过那个只有单行显示，cry…
第一步至此完成了，可以用 debug 来调试了。

## 编译，配置 tasks.json

如果每次都需要在外面编译后再来手动调试，无疑很烦，最好是在 F5 的时候先编译再执行调试，对吧。
vscode 支持定义预处理任务，ctrl+shift-p, 输入

> configure task runner

会自动生成一分 tasks.json，里面有许多例子。咱们就只改改第一个就好，其他的先删掉。

```
// Available variables which can be used inside of strings.
// ${workspaceRoot}: the root folder of the team        # /home/jacean/workspace/C/
// ${file}: the current opened file                     # /home/jacean/workspace/C/hello.c
// ${fileBasename}: the current opened file's basename  # hello.c
// ${fileDirname}: the current opened file's dirname    # /home/jacean/workspace/C/
// ${fileExtname}: the current opened file's extension  #.c
// ${cwd}: the current working directory of the spawned process

// A task runner that calls the Typescript compiler (tsc) and
// Compiles a HelloWorld.ts program
{
    "version": "0.1.0",
    "command": "tsc",
    "isShellCommand": true,
    "showOutput": "silent",
    "args": ["HelloWorld.ts"],
    "problemMatcher": "$tsc"
}
```

最开始是一些替换变量，假设我的文件 hello.c 的完全路径是

> /home/jacean/workspace/C/hello.c

那么，那些变量对应的依次就是代码里 #之后的, 是项目空间路径，文件名，文件去除前缀，文件扩展名，文件所在目录，最后一个是衍生进程的目录 (不太清楚).
这是预执行，那就是要执行那句编译命令了，所以修改如下

```
{
    "version": "0.1.0",
    "command": "gcc",
    "args": ["-g", "hello.c", "-o", "hello"],
    "problemMatcher": {
        "owner": "cpp",
        "fileLocation": ["relative", "${workspaceRoot}"],
        "pattern": {
            "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
            "file": 1,
            "line": 2,
            "column": 3,
            "severity": 4,
            "message": 5
        }
    }
}
```

这个在官方说明里有，可以自己找找。然后直接 F5，正常调试了。要是不信就删掉 hello，然后重新来一次吧。
至此，就实现了一步编译调试。
[![调试展示](http://7xrtyi.com1.z0.glb.clouddn.com/vscode-c-debug.jpg)](http://7xrtyi.com1.z0.glb.clouddn.com/vscode-c-debug.jpg)

但是，每次都只针对一个文件，换个文件不是又要改，不能容忍，所以继续往下看。

## 自动编译当前打开文件并启动调试

这时候就需要那几个替换变量，把需要改变的用变量来替换。修改后如下:

```
//launch.json
{
	"version": "0.2.0",
	"configurations": [
		{
			"name": "Debug",
			"type": "gdb",
			"request": "launch",
			"target": "${file}.o",
			"cwd": "${workspaceRoot}",
            "preLaunchTask": "gcc"
		}
	]
}

//tasks.json
{
    "version": "0.1.0",
    "command": "gcc",
    "args": ["-g", "${file}", "-o", "${file}.o"],
    "problemMatcher": {
        "owner": "cpp",
        "fileLocation": ["relative", "${workspaceRoot}"],
        "pattern": {
            "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
            "file": 1,
            "line": 2,
            "column": 3,
            "severity": 4,
            "message": 5
        }
    }
}
```

表骂我为什么要在后面加个 o，因为我不知道怎么去除后缀。。。

> basename hello.c .c

要是能这样我就这样了，就是不会，所以只能变丑点，生成 hello.c.o 了。不过，反正编译对象人家又不看你长啥样，只要心灵美就行了不是。
然后，选中任意一个. c 文件，F5 或是绿三角，就会看到如愿以偿的可以调试了。虽然多出了个丑丑的. c.o。
[![多出的.c.o](http://7xrtyi.com1.z0.glb.clouddn.com/cs-code-debug-2.jpg)](http://7xrtyi.com1.z0.glb.clouddn.com/cs-code-debug-2.jpg)

## 教训

1. 如果 gcc 后面的参数没有 - g，那就不会生成可以调试的文件了，一定要有，否则 F5 会报错的。详情请参阅 gcc 命令。

   > Debug adapter process has terminated unexpectedly


1. 最坑爹的，坑了我大半天时间的，就是权限问题。我的 vscode 文件夹在 / opt / 下，所以即使是配置好了其他的，调试也是报错

   > Debug adapter process has terminated unexpectedly

最后实在无奈，快要放弃的时候想起来这是 Ubuntu，可能和权限有关，于是把文件夹拷出来，放到 home/jacean 下，运行，然后再配，就好了，欲哭无泪啊！！！
