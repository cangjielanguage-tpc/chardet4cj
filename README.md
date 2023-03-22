<div align="center">
<h1>chardet4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.37.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-0%25-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

是一个字符编码高效识别检测库

代码参考:
1. https://github.com/albfernandez/juniversalchardet

### 特性

- 🚀 支持 ISO-2022-CN 编码格式

- 🚀 支持 UTF-8 编码格式

- 💪 支持 UTF-16BE / UTF-16LE 编码格式


### 路线

<p align="center">
<img src="./doc/assets/milestone.png" width="100%" >
</p>
路线图roadmap在 doc/framework-roadmap-logo.pptx 中有源文件。


## 软件架构

### 架构图

<p align="center">
<img src="./doc/assets/framework.png" width="60%" >
</p>

架构图文字说明，包括模块说明、架构层次等详细说明。

### 源码目录

```shell
.
├── README.md
├── doc
│   ├── assets
│   ├── cjcov
│   ├── design.md
│   ├── proposal.md
│   └── xxx_lib.md
├── src
│   └── Template.cj
└── test
    ├── HLT
    ├── LLT
    └── UT
```

- `doc`  文档目录，用于存放设计、API接口等文档
- `src`  源码目录
- `test` 测试目录

### 接口说明

主要类和函数接口说明详见 [API](./doc/api.md)


## 使用说明

### 编译构建

描述具体的编译过程：

```shell
cpm update
cpm build
```

### 功能示例
#### xxx 功能示例

功能示例描述:

示例代码如下：

```cangjie
import xxx.*
main() {
 xxxx
}
```

执行结果如下：

```shell
xxx
```

#### xxxx 功能示例

功能示例描述:

示例代码如下：

```cangjie
import xxx.*
main() {
 xxxx
}
```

执行结果如下：

```shell
xxx
```

## 开源协议
xx License

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。