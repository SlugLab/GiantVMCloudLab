yum check-update
sudo yum install python3-pip -y
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --upgrade Pillow
pip3 install torch==1.10.1+cpu torchvision==0.11.2+cpu torchaudio==0.10.1+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html
