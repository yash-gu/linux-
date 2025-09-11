Create a directory dir1
create a file "file1.txt"
add some content in file1.txt

create another directory dir2
copy file "file1.txt" in dir2

--solution----

# Create a directory named dir1
mkdir dir1

# Create a file "file1.txt" inside dir1
touch dir1/file1.txt

# Add some content in file1.txt
echo "This is some sample content." > dir1/file1.txt

# Create another directory named dir2
mkdir dir2

# Copy "file1.txt" into dir2
cp dir1/file1.txt dir2/



---------------------
change directory to dir1
create another file "file2.txt"
cut and past this file to dir2 (move)
rename "file2.txt" to newFile.txt



# Change directory to dir1
cd dir1

# Create another file "file2.txt"
touch file2.txt

# Cut and paste (move) file2.txt to dir2
mv file2.txt ../dir2/

# Rename "file2.txt" to newFile.txt (within dir2, after moving)
# If you are now in dir2:
cd ../dir2
mv file2.txt newFile.txt

--------------------------------


3.Create a User <user> using "adduser"
Login to the user <user>
Create a shell script to print some value using "echo" in his home dir
login to the default user
execute the shell script being default user


------solution------
# Step 1: Create a new user named <user>
sudo adduser <user>  # Replace <user> with actual username. You will be prompted for details and password.

# Step 2: Login to user <user>
su - <user>          # Switch to <user> (you may have to enter that user's password)

# Step 3: Create a shell script in <user>'s home that prints a value using echo
echo 'echo "Hello from <user>\n"' > /home/<user>/print_hello.sh
chmod +x /home/<user>/print_hello.sh  # Make the script executable

# Step 4: Return to the default user
exit                    # Type 'exit' to return to previous/default user session

# Step 5: Execute the shell script as the default user
bash /home/<user>/print_hello.sh      # Runs the shell script (replace <user> as needed)



