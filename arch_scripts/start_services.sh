sudo systemctl disable dhcpcd ;

sudo systemctl enable NetworkManager ;
sudo systemctl start NetworkManager ;

sudo systemctl enable vmtoolsd.service
sudo systemctl start vmtoolsd.service

sudo systemctl enable sddm.service;
sudo systemctl start sddm.service;
