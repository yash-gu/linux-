First check your current working directory
Now create directory with name "linux" in your current directory.
Then create a another directory with name "Assignment-01" inside your "linux" directory .
Now create one more directory inside "/tmp" with name "dir1" without changing your present directory.
At last create two more directories having below tree structure .It should create a below structure via single command only .
/tmp
  - dir1
      - dir2
        - dir3
Find a command that will delete a "dir3" that you have created before.
Now create a empty file with your "firt-name" in /tmp directory.
After creating a empty file , add "This is my first line " into a file without using any editor.
Now add one more line "this is a additional content " into a same file .Make sure it will not overwrite the previous line of the file.
Then create new file with your "last-name" along with some content like "last-name is my last name".Do not use any editor
Now add "this is line at the beginning" into "last-name" file in such a manner that it will add the line at beginning of the file.Do not use any editor.
Then add some more 8-10 lines to the same file .
Now find a command that will show:
top 5 lines of the file.
bottom 2 lines of the file.
only 6th line of the file.
3-8 lines of the file .
Find a command that will list below things of /tmp directory
list all content(including hidden files)
list only files
list only directories
Now copy the "last-name" into the /tmp/dir2 with same name.
Then again copy the "last-name" into the /tmp/dir2, this time with different name i.e "last-name".copy
Now change the name of the "first-name" file to some other name at same location .
Find a command that will move the "last-name" file to /tmp/dir1
find a command that will clear the content of /tmp/dir2/"last-name".copy .Make sure it will not even contain empty line .
Now delete the same file i.e /tmp/dir2/last-name.copy Note : Do not use sed command in this assignment.











-------------------------------------------------------


# Check current working directory
pwd

# Create directory "linux" in current directory
mkdir linux

# Create "Assignment-01" inside "linux"
mkdir linux/Assignment-01

# Create "dir1" inside /tmp without changing pwd
mkdir /tmp/dir1

# Create nested directory /tmp/dir1/dir2/dir3 in one command
mkdir -p /tmp/dir1/dir2/dir3

# Delete /tmp/dir1/dir2/dir3
rm -r /tmp/dir1/dir2/dir3

# Create empty file with your first-name in /tmp
touch /tmp/first-name

# Add "This is my first line" to the file (will overwrite if file exists, but file is empty now)
echo "This is my first line" > /tmp/first-name

# Append another line to the same file (will not overwrite)
echo "this is a additional content" >> /tmp/first-name

# Create new file with your last-name and add content ("last-name is my last name")
echo "last-name is my last name" > /tmp/last-name

# Add line at the beginning of last-name file (without editor)
# This method uses a temp file:
{ echo "this is line at the beginning"; cat /tmp/last-name; } > /tmp/tempfile && mv /tmp/tempfile /tmp/last-name

# Add 8-10 more lines to the last-name file (example, add numbered lines)
for i in {1..10}; do echo "Additional line $i" >> /tmp/last-name; done

# Show top 5 lines of the file
head -n 5 /tmp/last-name

# Show bottom 2 lines of the file
tail -n 2 /tmp/last-name

# Show only 6th line of the file
sed -n '6p' /tmp/last-name

# Show 3rd to 8th lines of the file
sed -n '3,8p' /tmp/last-name

# List all content (including hidden files) of /tmp
ls -al /tmp

# List only files in /tmp (not directories)
find /tmp -maxdepth 1 -type f

# List only directories in /tmp (not files)
find /tmp -maxdepth 1 -type d

# Copy "last-name" to /tmp/dir2 with same name
cp /tmp/last-name /tmp/dir2/last-name

# Copy "last-name" to /tmp/dir2 with different name
cp /tmp/last-name /tmp/dir2/last-name.copy

# Change the name of "first-name" file to a new name in /tmp (example: new-first.txt)
mv /tmp/first-name /tmp/new-first.txt

# Move "last-name" file to /tmp/dir1
mv /tmp/last-name /tmp/dir1/

# Clear content of /tmp/dir2/last-name.copy (make it completely empty, no lines)
: > /tmp/dir2/last-name.copy

# Delete /tmp/dir2/last-name.copy without using sed
rm /tmp/dir2/last-name.copy
