#!/bin/bash

# 执行脚本，命令格式为： createWorktree.sh feature/Version_UserName_FunctionName
# 脚本执行完后，会根据原项目的 trunk 分支，在 worktree_dir 创建名为 FunctionName 的 worktree
# 获取传入的分支名参数
branch_name=$1
customName=$2

# echo -e "\n" # 打印空行
# 检查分支名是否为空，为空则提示用户，并提前返回
if [ -z "$branch_name" ]; then
    echo -e "\n>>>>>>>>>>>>>>>>>>>> 分支名为空，请输入分支名。提示：脚本运行命令如： createFlutterWorktree.sh branchName"
    exit 1 # 0 表示成功，非 0 值表示错误
fi

echo -e "\n>>>>>>>>>>>>>>>>>>>> 分支名称: $branch_name\n"

script_path=f/work/scripts

# 脚本创建成功后，执行 export PATH=$PATH:/mnt/f/work/scripts 命令，将脚本目录加入环境变量
export PATH=$PATH:"/mnt/$script_path"

# 脚本创建成功后，执行 chmod +x createWorktree.sh 命令，给脚本添加执行权限
chmod +x "/$script_path/createFlutterWorktree.sh"

# 原项目，进入 D:\code\flutter 目录
src_dir="/D/code/flutter"
# 打印当前目录
echo -e "\n>>>>>>>>>>>>>>>>>>>> 进入目录：$src_dir\n"

cd "$src_dir"

current_directory=$(pwd)
# 打印当前目录
echo -e "\n>>>>>>>>>>>>>>>>>>>> 当前目录：$current_directory"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 切换到 master 分支\n"
# 切换到 master 分支
git checkout master

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
worktree_dir="/D/code/flutter_worktree"

# 使用字符串操作解析出最后一个 _ 后的内容
worktree_name="${branch_name##*_}"
# 最终的名称
if [ -z "$customName" ]; then
  result_name="$worktree_name"
else
  result_name="$customName"
fi

# 将大驼峰和小驼峰命名转换为下划线形式的函数
function to_snake_case() {
  input="$1"
  output=$(echo "$input" | sed -E 's/([A-Z])/_\1/g' | sed -E 's/^_//g' | tr 'A-Z' 'a-z')
  echo "$output"
}

snake_case_result_name=$(to_snake_case "$result_name")

# worktree 完整路径
worktree_path="${worktree_dir}/flutter_worktree_${snake_case_result_name}"

# 打印参数
echo -e "\n>>>>>>>>>>>>>>>>>>>> 创建 worktree，路径: $worktree_path\n"

# 创建 worktree
git worktree add "$worktree_path" "$branch_name"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 进入路径: $worktree_path \n"
# 进入 worktree 目录
cd "$worktree_path"

echo -e "\n>>>>>>>>>>>>>>>>>>>> 路径: $worktree_path 执行 flutter pub get 命令\n"

# 执行 flutter pub get 命令
flutter pub get

# 执行其他脚本，比如路由脚本
echo -e "\n>>>>>>>>>>>>>>>>>>>> 请自行添加其他脚本，比如路由脚本..."

echo -e "\n>>>>>>>>>>>>>>>>>>>> 创建 worktree 成功..."