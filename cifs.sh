#!/bin/bash
echo -e "\033[32m ============================================ \033[0m"
echo -e "-----------创建磁盘挂接目录-----------"
echo -e "\033[32m ============================================ \033[0m"

if [ ! -d "/nfs-files/" ];then
mkdir /nfs-files/
else
echo "/nfs-files 文件夹已经存在"
fi

if [ -d "/nfs-files/pic/" ];then
echo "/nfs-files/pic/ 文件夹已经存在"
else
mkdir 	/nfs-files/pic/
fi


echo -e "\033[32m ============================================ \033[0m"
echo -e "-----------安装 nfs  cifs 客户端组件-----------"
echo -e "\033[32m ============================================ \033[0m"

pd_nfs=`rpm -qa | grep nfs-utils`
if [[ $pd_nfs =~ "nfs-utils" ]] ; then 
	echo "nfs-utils组件已经安装"
else
	yum install -y nfs-utils rpcbind
fi 

pd_cifs=`rpm -qa | grep cifs-utils` 
if [[ $pd_cifs =~ "cifs-utils" ]] ; then 
	echo "cifs-utils组件已经安装"
else
	yum install -y cifs-utils
fi 

echo -e "\033[32m ============================================ \033[0m"
echo -e "-----------挂载：pic-----------"
echo -e "\033[32m ============================================ \033[0m"
umount /nfs-files/pic
mount -t cifs -o vers=2.0,username="Share",password="xxx",iocharset=utf8,dir_mode=0777,file_mode=0777 //121.43.161.147/Share /nfs-files/pic  
echo -e "\033[32m ============================================ \033[0m"
