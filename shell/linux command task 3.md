Create user named neha, vipul and abhishek
create group named linux
Create group named sigma
Change neha and abhishek primary group to sigma
change neha and abhishek secondary group to linux
create group named alpha
create user nkhil and priyashi and add them to linux and aplha group with single command
Change all user home directory permission to
A user should have read,write, execute access to home directory
All the users of same team should have read and excute access to home directory of fellow team members.
others should have only execute permission to user's home directory
create these directory structure for all user
home directory of user
team
linux
change permission for team directory only team members have full access
change permission for linux directory only linux trainer have full access
check if alpha team user can access sigma team directory.
check vipul user can access sigma or
change vipul user shell to make it service user.
force abhishek user to change its password on next login.
change nikhil user password.
list all user and group you have created
check which shell is added to neha user as default.
check the deafult permission of file and directory and how to change it
now delete vipul user.
delete linux group.






-------------------------------------
#solution
# Create users named neha, vipul, abhishek
sudo adduser neha
sudo adduser vipul
sudo adduser abhishek

# Create groups named linux, sigma, alpha
sudo groupadd linux
sudo groupadd sigma
sudo groupadd alpha

# Change neha and abhishek primary group to sigma
sudo usermod -g sigma neha
sudo usermod -g sigma abhishek

# Change neha and abhishek secondary group to linux
sudo usermod -aG linux neha
sudo usermod -aG linux abhishek

# Create users nikhil and priyashi and add to linux and alpha groups (single command each)
sudo useradd -m -G linux,alpha nikhil
sudo useradd -m -G linux,alpha priyashi

# Change all user home directory permission for required access
# User: rwx (owner) | Team: rx (group) | Others: x
for user in neha vipul abhishek nikhil priyashi; do
  sudo chmod 751 /home/$user
done

# Create directory structure for team and linux inside user's home
for user in neha vipul abhishek nikhil priyashi; do
  sudo mkdir /home/$user/team
  sudo mkdir /home/$user/linux
done

# Change permission for team directory so only team members have full access
# Assuming team = sigma or alpha group as required. Example uses sigma:
for user in neha abhishek; do
  sudo chown $user:sigma /home/$user/team
  sudo chmod 770 /home/$user/team
done

# Change permission for linux directory so only linux trainer has full access
# Example: make linux_trainer owner (replace with actual user), and no access for others
for user in neha vipul abhishek nikhil priyashi; do
  sudo chown linux_trainer:linux /home/$user/linux
  sudo chmod 700 /home/$user/linux
done

# Check if alpha team user can access sigma team directory
# Try: sudo -u nikhil ls /home/neha/team
# (Replace nikhil with alpha member and neha with sigma member)

# Check if vipul can access sigma
# Try: sudo -u vipul ls /home/neha/team

# Change vipul user's shell to a service shell, e.g. /sbin/nologin
sudo usermod -s /sbin/nologin vipul

# Force abhishek to change password on next login
sudo chage -d 0 abhishek

# Change nikhil user password (will prompt for new password)
sudo passwd nikhil

# List all users and groups created
echo "Users:"
echo neha vipul abhishek nikhil priyashi
echo "Groups:"
echo linux sigma alpha

# Check what shell is assigned to neha by default
grep neha /etc/passwd

# Check default file and directory permissions (umask)
umask

# Change default permission for files (e.g., set umask to 027 for rw-r-----)
echo "umask 027" >> /etc/profile

# Now delete vipul user
sudo userdel -r vipul

# Delete linux group
sudo groupdel linux
