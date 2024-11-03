set -e
# install miniconda
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
rm Miniconda3-latest-Linux-x86_64.sh

# install ffmpeg on centos 8
yum update -y
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
yum install -y http://rpmfind.net/linux/centos/8-stream/PowerTools/x86_64/os/Packages/SDL2-2.0.10-2.el8.x86_64.rpm
yum install -y ffmpeg ffmpeg-devel

# create conda environment
conda init --all
conda create --name facefusion python=3.12 -y
conda activate facefusion

# use cuda ane tensorrt
conda install -y conda-forge::cuda-runtime=12.4.1 conda-forge::cudnn=9.2.1.18
pip install tensorrt==10.5.0 --extra-index-url https://pypi.nvidia.com

# install facefusion
python install.py --onnxruntime cuda

# re-activate conda environment
conda deactivate
conda activate facefusion
