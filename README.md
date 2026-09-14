# 课程笔记

> 2026 秋季学期的课程笔记，用 LaTeX 手写，源码与编译好的 PDF 一起归档在这里。

**Simson** · 2026.9 – 2027.1

---

这篇文案是Deepseek生成的，作者本来想自己修改一下，却发现这篇写得非常可爱，所以就留下了。作者只想说：VS code是这个世界上最好的软件！

## 这是什么

一个学期的课堂笔记仓库，分两摊：

- **`CSAI note/`** —— 专业方向课：计算机视觉、计算机系统导论、机器学习、具身智能，外加一份多元高斯分布的数学专题。
- **`Philosophy note/`** —— 哲学类课程：中国哲学、西方哲学（下）、环境伦理学。

每篇笔记是一个独立的 `.tex`，一份源码对应一份 PDF。其中八篇共用同一套模板（封面、页眉页脚、`fancybox` 提示框），改模板就是几个文件一起改 —— 这是有意为之，学期中途想统一换个配色不用挨个调。唯一的例外是 `Gaussian.tex`，它按数学文档另起了一套。

## 仓库结构

```
.
├── README.md
├── .vscode/
│   ├── settings.json          # LaTeX Workshop 的编译配方与环境变量
│   └── extensions.json        # 推荐的扩展
├── CSAI note/
│   ├── VCL note.tex           # 计算机视觉（进行中）
│   ├── CV note.tex            # 计算机视觉简介
│   ├── ICS.tex                # 计算机系统导论
│   ├── Machine learning.tex   # 机器学习
│   ├── Embodied Intelligence.tex
│   ├── Gaussian.tex           # 多元高斯分布（独立的数学专题）
│   ├── 01 Introduction.pdf    # 原始课件，留着对照
│   └── *.pdf / *.aux / *.log …  # 各篇编译产物
├── Philosophy note/
│   ├── Chinese Philosophy.tex
│   ├── Western Philosophy.tex
│   ├── Environment Ethic.tex
│   └── …
├── miktex/                    # 便携版 MiKTeX 发行版（见下）
└── downloads/                 # MiKTeX 及其依赖的 .deb、Ubuntu 字体源文件
```

`miktex/usr/bin` 里的可执行文件通过 `~/bin` 下的软链接暴露出来，仓库本身是自包含的。

## 笔记一览

| 文件                                       | 课程                  | 已有章节                                                                | 行数 |
| ------------------------------------------ | --------------------- | ----------------------------------------------------------------------- | ---- |
| `CSAI note/VCL note.tex`                 | 计算机视觉（CV）      | 导论 / VCL 基础知识和技能 / 显示 / 图像                                 | 349  |
| `CSAI note/CV note.tex`                  | 计算机视觉（CV）      | 计算机视觉简介                                                          | 295  |
| `CSAI note/ICS.tex`                      | 计算机系统导论（ICS） | 基本介绍 / 信息的表示和处理                                             | 383  |
| `CSAI note/Machine learning.tex`         | 机器学习              | 机器学习概述 / 机器学习数学                                             | 275  |
| `CSAI note/Embodied Intelligence.tex`    | 具身智能与通用智能体  | 简介                                                                    | 194  |
| `CSAI note/Gaussian.tex`                 | 多元高斯分布（专题）  | 记号与约定 / 线性代数预备 / 多元高斯分布 / 联合高斯 / 例子与应用 / 小结 | 651  |
| `Philosophy note/Chinese Philosophy.tex` | 中国哲学              | 中国哲学概述 / 先秦诸子                                                 | 212  |
| `Philosophy note/Western Philosophy.tex` | 西方哲学（下）        | 近代哲学的背景 / 笛卡尔哲学                                             | 265  |
| `Philosophy note/Environment Ethic.tex`  | 环境伦理学            | 概论                                                                    | 272  |

`Gaussian.tex` 是唯一一篇不吃公共模板的：它 `\documentclass[UTF8,fontset=none,11pt]{ctexart}`，装了一整套 `amsmath` / `bm` 和自定义宏（`\vx`、`\mSigma` 之类），是当数学文档写的，不是当课堂笔记写的。

## 编译环境

**必须用 XeLaTeX 或 LuaLaTeX。** 全部笔记都走 `ctexart` + `fontspec`，pdfLaTeX 会在字体那一步直接报错。

### 便携版 TeX 发行版

`miktex/` 是一份完整的 MiKTeX 26.5，解包在仓库内部，没有装进系统。`~/bin` 里是它的一堆软链接：

```
~/bin/xelatex  ->  ~/latex/miktex/usr/bin/miktex-xetex
~/bin/latexmk  ->  ~/latex/miktex/usr/libexec/miktex/runperl
```

配套的环境变量（`.vscode/settings.json` 已经写好，命令行下需要自己带上）：

```bash
export PATH="$HOME/bin:$HOME/latex/miktex/usr/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/latex/miktex/usr/lib"
```

### 字体依赖

两处硬依赖，缺了会编译失败：

| 用途     | 字体                        | 位置                                                |
| -------- | --------------------------- | --------------------------------------------------- |
| 中文正文 | **Noto Serif CJK SC** | 系统字体（`\setCJKmainfont`）                     |
| 代码块   | **Ubuntu**            | 系统字体；源文件在`downloads/ubuntu-font-static/` |

```bash
fc-list | grep -E "Noto Serif CJK SC|Ubuntu"   # 确认两个都在
```

> **注意 `Philosophy note/Chinese Philosophy.tex`**：这个文件没有 `\setCJKmainfont` 那一行，中文会走 `ctex` 的默认字体集（Linux 上落到 Fandol），排出来和其余八篇不是一个字形。要统一的话，在第 16 行附近补上 `\setCJKmainfont{Noto Serif CJK SC}` 即可。

模板里那个字体命令叫 `\consolasfont`，但装的其实是 Ubuntu —— 变量名是照着 Windows 上的习惯留下的，别被它骗了。

### 在 VSCode 中编译（推荐）

装 [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)，打开任意 `.tex` 存盘即编译，PDF 在旁边的标签页里刷新。

`.vscode/settings.json` 里已经配好三套配方：

- **XeLaTeX** —— 默认（`latex-workshop.latex.recipe.default: "first"`），日常用这个
- **latexmk (xelatex)** —— 需要反复跑才收敛的时候用
- **XeLaTeX → BibTeX → XeLaTeX × 2** —— 以后加参考文献了用这个

每个 tool 都单独注入了 `PATH` 和 `LD_LIBRARY_PATH`，所以不依赖你在什么 shell 里启动 VSCode。

### 命令行编译

```bash
cd "CSAI note"
latexmk -xelatex -interaction=nonstopmode -halt-on-error "VCL note.tex"
```

**路径里有空格，引号不能省。** 一次编译会同时产出 `.pdf`、`.aux`、`.log`、`.synctex.gz` 等一堆文件，都落在同目录下。

要看有没有排版溢出，编译完搜一下日志：

```bash
grep -E "Overfull|Underfull" "VCL note.log"
```

没有输出就是没有溢出。

## 模板说明

### 封面

`titlepage` 环境，顶部两条色带是 TikZ `overlay` 画的全宽矩形（`blue!50!white` + 草绿色 `grassgreen`）；作者信息是一个切角带阴影的 `tcolorbox`；页脚写死 `\the\year`，所以年份会自动跟上。

想改标题就找 `\fontsize{30pt}{36pt}` 那一行，中英文标题在相邻两行。

### 页眉页脚

`fancyhdr`，左边课程名（浅蓝 `lightblue`、楷书），右边学期区间，页脚居中页码。三条横线重定义成了 `blue!30!white`。

**每篇笔记的左边页眉是手写的**，复制模板新建文件时记得改 `\fancyhead[L]`。

### fancybox

自定义的 `tcolorbox`，用来框重点：

```latex
\begin{fancybox}{标题}
  ...
\end{fancybox}
```

开了 `breakable`，跨页不会炸。方括号里可以传主色：`\begin{fancybox}[grassgreen]{标题}`，不传就是蓝的。里面放表格、列表、公式都可以。

## 写笔记的约定

### 正文

- **中文行文，术语一律附英文原文**，写作 `图像分割（Image segmentation）`。复习时好跟论文和文档里的说法对上。
- 重点用 `\textbf{}` 起头，列表用 `itemize` / `enumerate`。
- 课件上的关键表格、格式对照，用 `fancybox` 框起来，别让它散在正文里。
- 笔记是**课堂现场记的**，追求当场记下来，不追求当场记漂亮。

### 提交信息

用一句词或诗，后面跟本周覆盖的日期区间：

```
拂水飘绵送行色（2026.9.7-2026.9.14）
```

出自周邦彦《兰陵王·柳》。目前仓库里就这一次提交，所以这更像是个开头，不是条规矩。

## 一些想说的话

**为什么用 LaTeX 记笔记。** 一学期的板书和课件，用别的工具记到第五章就开始崩：公式错位、编号乱跳、图到处跑。LaTeX 把这些东西在第一次配置好之后就接管了，注意力可以放回内容本身。代价是开头那两天很难受，以及现在这个仓库有两百多兆。

**为什么 TeX 不装进系统。** 整份 MiKTeX 就躺在 `miktex/` 里，`~/bin` 只放软链接。好处是不往系统里塞任何东西，不和发行版的包管理器打架，换台机器把仓库拷过去就能编译，哪天不想要了整个删掉也不留痕迹。两百多兆换一个干净的系统，我觉得挺划算。

**关于中英混排。** 中文负责把话讲明白，英文负责让这些词在别的地方还能被找到。

**关于那些没写完的句子。** 这些笔记是上课当场记的，不是课后整理过的，所以里面留着当时的语气，也留着当时没想明白的地方——比如「（这真的是课堂PPT里面的）」，还有「嗅觉显示（控制挥发的成分。。。？）」。我暂时不打算把它们改得体面一点。那些问号本身就是笔记的一部分：它们标出了当时没听懂的地方，复习的时候正好该从这儿开始看。

**关于这个仓库。** 它首先是我自己的东西，公开放在这里只是因为顺手。如果它碰巧对谁有用，欢迎看；如果发现哪里写错了，那多半是真错了，因为我记的时候也没完全听懂。

## 版权

© 2026 Simson. All Rights Reserved.

笔记内容基于课堂讲授整理，版权归授课教师与原作者；本仓库仅作个人学习存档。
