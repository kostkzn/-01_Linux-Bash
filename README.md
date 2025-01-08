# Lunux & Bash Topic

## Task A. Create a script that uses the following keys

1. When starting without parameters, it will display a list of possible keys and their description.
2. The --all key displays the IP addresses and symbolic names of all hosts in the current subnet
3. The --target key displays a list of open system TCP ports.

The code that performs the functionality of each of the subtasks must be placed in a separate function

**Solution**:

1. The script located [here](script_a.sh)
2. Demo of script execution:

![Results of Script_A](pics/1.jpg)

## Task B. Using Apache log example create a script to answer the following questions:

1. From which ip were the most requests?
2. What is the most requested page?
3. How many requests were there from each ip?
4. What non-existent pages were clients referred to?
5. What time did site get the most requests?
6. What search bots have accessed the site? (UA + IP)

**Solution**:

1. The script located [here](script_b.sh) and the sample of apache log [here](apache_log.txt)
2. Demo of script execution:

![Results of Script_B](pics/2.jpg)

## Task C. Create a data backup script that takes the following data as parameters:

1. Path to the syncing directory.
2. The path to the directory where the copies of the files will be stored.

In case of adding new or deleting old files, the script must add a corresponding entry to the log file indicating the time, type of operation and file name. [The command to run the script must be added to crontab with a run frequency of one minute]

**Solution**:

1. The script located [here](script_c.sh)
2. Demo of script execution:

![Results of Script_C](pics/3-1.jpg)

![Results of Script_C](pics/3-2.jpg)

![Results of Script_C](pics/3-3.jpg)

![Results of Script_C](pics/3-4.jpg)
