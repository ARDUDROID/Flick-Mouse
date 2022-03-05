#!/usr/bin/env bash
set -euo pipefail

j=$(uname -n)

if test "$j" = "kali" ;then

   sudo apt update

   sudo apt-get install -y git whiptail libx11-dev libxtst-dev python2-dev python3-dev python-pip

   raspi-config nonint do_i2c 0

   pip install setuptools-rust
   pip3 install setuptools-rust

   git clone https://github.com/PiSupply/Flick.git

   cd Flick/flick

   python2 setup.py build && python2 setup.py install
   python3 setup.py build && python3 setup.py install

   cd /home/kali/Flick-Mouse

   python2 setup.py build && python2 setup.py install
   python3 setup.py build && python3 setup.py install

   git clone https://github.com/stinnux/autopy

   cd autopy

   python2 setup.py build && python2 setup.py install
   python3 setup.py build && python3 setup.py install

   cd /home/kali

   whiptail --msgbox "The system will now reboot" 8 40
   reboot

fi

if test "$j" != "kali" ;then

   echo 'update'
   sudo apt update

   echo 'install lib'
   sudo apt install -y git whiptail libx11-dev libxtst-dev

   echo 'rust'
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source $HOME/.cargo/env
   rustup default nightly

   echo 'rpi config i2c'

   raspi-config nonint do_i2c 0

   echo 'lib python'

   pip install setuptools-rust
   pip3 install setuptools-rust

   echo 'clone'

   git clone https://github.com/PiSupply/Flick.git

   echo 'setup'

   cd Flick/flick
   python setup.py install
   python3 setup.py install

   echo 'setup and install Flick-Mouse'

   python2 setup.py build && python2 setup.py install
   python3 setup.py build && python3 setup.py install

   git clone https://github.com/stinnux/autopy

   cd autopy

   python2 setup.py build && python2 setup.py install
   python3 setup.py build && python3 setup.py install

  cd /home/kali

   whiptail --msgbox "The system will now reboot" 8 40
   reboot
fi
