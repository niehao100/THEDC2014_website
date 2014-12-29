电子设计大赛主页
==
2014年电子设计大赛网站
--
本网站由去年的网站修改而来，服役约两个月，工作正常，完成了应有的任务。

本网站基于ruby on rails，数据库是postgres（似乎是从Gitlab改的），去年的Gemfile存在严重bug，已经修复。其runtime版本仍然可以在电子科协服务器上找到，去年的版本请访问[*这里*](http://git.oschina.net/stieizc/thedc-2013)。感谢各位学长的帮助。

by 2014年电设平台组网站组Neil

on 2014-12-29


        2013电设大赛主页
        --从教程上搬了很多代码，感谢[Michael Hartl](http://michaelhartl.com/)的[*Ruby on Rails       Tutorial*](http://railstutorial.org/)，也感谢翻译[Andor Chen]。

    环境设置
    --

    基本上bundle就行了，Gemfile都有写。需要动手安装的是数据库（即便是想看看网站也要装，辛苦了）

    + ruby 2.0.0，估计1.9.3也行
    + rails 4.0.0，按书上的，有健壮参数什么的感觉很安全。好像需要railsinstaller3.0。https://www.nitrous.io/         是一个不错的在线编码rails的网站，什么都不用装。
    + postgresql 9.1.9 其实都行吧
    
    ## postgresql ##
    
    安装：http://www.postgresql.org/download/windows/
    
    设置：
    
    网站：源码下config/database.yml中设置好。
    
    电脑上：好像自带的pgAdmin可以不用命令行。建好database.yml中的数据库和对应用户（拥有者），如果要运行测试的话要让这个用户有新建数据库的权限（好像是这样）。
    
    没啦！
    
    运行测试
    --
    
    rspec spec/。每次commit前都来一次也不错。
    
    git流程
    ---
    
    ## 如果要用git ##
    
    在oschina的git页面申请个账户，然后发个邮件过来
    
    1. 不要直接对master分支修改，有改动就在本地建一个分支。
    2. 本地分支在merge到master后请务必解决冲突，然后push。
    
    ## 如果不想用git ##
    
    打包发邮件……用git呗。会省很多事的。
    
    进度
    ---
    
    1. 现在还不知道怎么展示文档。如果少的话可以直接改html，如果多的话就还得再看看了。在考虑是直接写成html然后手动添    加侧边栏标题浏览还是存到数据库里。
    2. 现在队长可以随意加没有团队的选手，而选手无法申请加入。也许可以搞成“邀请/申请”那个样子，但是麻烦了些。
    3. 用户cookie是永久的。没有“记住我”选项，不能取回密码。
    4. 用户设置页面，每次都要输新密码，即便不想改。应该把密码单开一个页面
    5. 不知道如何做比赛的show页面
    6. 样式非常难看。尤其是选手和队伍的创建和编辑页面的那几个单选钮，极为变态。还有贴吧的样式也不好。我觉得队式网站完爆这个，他们的基本没东西，但就是好看……
    7. 还没测试过管理员权限，生成比赛啊什么的
    
    变更
    ---
    
    1. 模板从bootstrap变为zurb-foundation，感觉那个对rails更友好
    
