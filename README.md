# GaaCDN (Git as a CDN)

## 设计

由于jsdelivr支持根据github仓库作为cdn源，所以我们可以通过github api修改仓库内容和tag（jsdelivr根据tag来读取内容）来实现「将静态资源发布到CDN并获取URL」的业务流程。

基础条件有：

* 仓库一个： 可以预先创建好，并将仓库地址写入配置`REPOSITORY`
* 仓库编辑权限（github token）一个：进入 [https://github.com/settings/tokens](https://github.com/settings/tokens) 创建，repo打上勾。

脚手架：

* 前端：React, Webpack等
* 后端（可选<sup>[1]</sup>）：node.js, Express, Formidable(上传)等
* 运维（可选<sup>[2]</sup>）：作为docker镜像或k8s package发布

前端业务流程：

1. 填写输入github token的表单并提交，保存到localStorage
2. 检查仓库权限，检查是否存在特殊格式的tag<sup>[3]</sup>， 没有则创建
   1. https://developer.github.com/v3/git/refs/#create-a-reference
   2. https://github-tools.github.io/github/docs/3.1.0/Repository.html#createRef
3. 选择图片并生成图片的sha1码，通过Github api上传到仓库
4. 删除特殊tag并重新创建
   1. https://developer.github.com/v3/git/refs/#delete-a-reference
   2. https://github-tools.github.io/github/docs/3.1.0/Repository.html#deleteRef
6. 生成jsdelivr的URL
   1. 格式如：https://cdn.jsdelivr.net/gh/reponame@tag/sha1sha1sha1sha1sha1sha1sha1.jpg
7. 获取并拷贝图片URL对应的Markdown格式
8. 错误提示


#### 注释 

* [1][2] 基础功能前端即可完成，在后端扩展是为了支持多仓库，多用户场景。
* [3] 专门用于给cdn获取文件的tag。常用的tag是版本号形式的，如0.0.1, 0.0.2，如果每次都更新一个tag号会
  很混乱，不如就用一个专门的tag来发布文件。


## License

**MIT** License