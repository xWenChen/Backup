#!/bin/bash

# 执行脚本，命令格式为： createWorktree.sh feature/Version_UserName_FunctionName
# 脚本执行完后，会根据原项目的 trunk 分支，在 worktree_dir 创建名为 FunctionName 的 worktree
# 获取传入的分支名参数
branch_name=$1
customName=$2

# echo -e "\n" # 打印空行
# 检查分支名是否为空，为空则提示用户，并提前返回
if [ -z "$branch_name" ]; then
    echo -e "\n>>>>>>>>>>>>>>>>>>>> 分支名为空，请输入分支名。提示：脚本运行命令如： createWorktree.sh branchName"
    exit 1 # 0 表示成功，非 0 值表示错误
fi

echo -e "\n>>>>>>>>>>>>>>>>>>>> 分支名称: $branch_name\n"

script_path=f/work/scripts

# 脚本创建成功后，执行 export PATH=$PATH:/mnt/f/work/scripts 命令，将脚本目录加入环境变量
export PATH=$PATH:"/mnt/$script_path"

# 脚本创建成功后，执行 chmod +x createWorktree.sh 命令，给脚本添加执行权限
chmod +x "/$script_path/createWorktree.sh"

# 原项目，进入 D:\code\test 目录
src_dir="/D/code/test"
# 打印当前目录
echo -e "\n>>>>>>>>>>>>>>>>>>>> 进入目录：$src_dir\n"

cd "$src_dir"

current_directory=$(pwd)
# 打印当前目录
echo -e "\n>>>>>>>>>>>>>>>>>>>> 当前目录：$current_directory"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 切换到 trunk 分支\n"
# 切换到 trunk 分支
git checkout trunk

echo -e "\n>>>>>>>>>>>>>>>>>>>> 执行 git fetch\n"
echo -e ""
# 执行 git fetch 命令
git fetch

echo -e "\n>>>>>>>>>>>>>>>>>>>> 执行 git pull\n"
# 执行 git pull 命令
git pull

echo -e "\n>>>>>>>>>>>>>>>>>>>> 列举 git worktree\n"
# 列举 worktree 列表
git worktree list

# worktree 的目录
worktree_dir="/D/code/test-worktree"

# 使用字符串操作解析出最后一个 _ 后的内容
worktree_name="${branch_name##*_}"
# 最终的名称
if [ -z "$customName" ]; then
  result_name="$worktree_name"
else
  result_name="$customName"
fi

# worktree 完整路径
worktree_path="${worktree_dir}/${result_name}"

# 打印参数
echo -e "\n>>>>>>>>>>>>>>>>>>>> 创建 worktree，路径: $worktree_path\n"

# 创建 worktree
git worktree add "$worktree_path" "$branch_name"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 拷贝 local.properties 文件到路径: $worktree_path\n"
# 拷贝 local.properties 文件
cp local.properties "$worktree_path"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 追加写入 flutter 配置到  local.properties 文件 ..."

# >> 表示追加内容到末尾

echo "

enableFlutterDebug=false
flutterProjectDir=D\:\\\\code\\\\flutter_worktree\\\\flutter_worktree_xxx" >> "$worktree_path/local.properties"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 创建 worktree 成功..."