# Script will be run every hour using a crontab scheduler to backup our databse
import shutil

# Define the file paths
source_file = 'orgs.json'
destination_file = 'orgs_backup.json'

# Copy the contents of the source file to the destination file
shutil.copyfile(source_file, destination_file)

print("File copied successfully!")