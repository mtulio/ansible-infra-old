#!/bin/bash -x
#sudo adduser ansible --disabled-password --gecos ""
sudo useradd -m ansible 
sudo mkdir ~ansible/.ssh
cat << EOF > ~ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDh1BSLNBkL8xKjFapeCqdlqbryzP1avo80md8jmLUfGRjFPq4WUhpcsLfodmLLsz9aCPAHFfN6h+0+qFJDOdlEblRc07ujnnHIITzoFZlsaFTF/JqPgvizeVeu7E9o0krucHgO1O6coM9ClIelFqinuIYnAhjZS5wtUkRRGjcqS86LoUkhKcorbBFURLMy9pQJKpOBZdnR1O4QE2diHc2h3nkam/cGlzAOfF7tZKGk2Tl1lc1yO9kfir9aM4AGgIDwW2vnjWxNE5zPeUU2fPqoBALuupCroloYVXZ17DgyiyZp0qNIBGUrPrraggjmeTVPCsjpvYxBH6AVajvDF099 admin@myhost
EOF
chown ansible. ~ansible/.ssh
chown ansible. ~ansible/.ssh/authorized_keys
chmod 600 ~ansible/.ssh/authorized_keys
chmod 700 ~ansible/.ssh
if [ -d /etc/sudoers.d/ ]; then
  sudo bash -c 'echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99-ansible'
  chmod 0440 /etc/sudoers.d/99-ansible
else
  sudo bash -c 'echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
fi

# Install python
if [ -f /etc/debian_version ]; then
  apt-get update && apt-get install -y python
else
  yum install -y python
fi
