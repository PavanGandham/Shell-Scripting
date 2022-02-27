#----------------------------------------emp.txt-file--------------------------------------------------------
Hilesh, 1001
Bharti, 1002 
Aparna, 1003
Harshal, 1004
Keyur, 1005
#-----------------------------------------fruits.txt----------------------------------------------------------
apple
orange
banana
pappaya
#------------------------------------------Sed----------------------------------------------------------------
# syntax : sed '/second/s/should/will/' inputfile2
 # | | | |
 # | | | with this pattern 
 # | | this pattern
 # | substitute 
 # Search for the pattern "second"

1. How to add a header line say "Employee, EmpId" to this file using sed?

sed '1i Employee, EmpId' emp.txt
# This command does the following: The number '1' tells the operation is to be done only for the first line.
# 'i' stands for including the following content before reading the line. So, '1i' means to
# include the following before reading the first line and hence we got the header in the file.
# However, the file with the header is displayed only in the output, the file contents still remain
# the old file. So, if the user's requirement is to update the original file with this output,
# the user has to re-direct the output of the sed command to a temporary file and then move it to
# the original file.The UNIX system which has the GNU version contains sed with the '-i' option.
# This option of the sed command is used to edit the file in-place.
# Let us see the same above example using '-i' option
sed -i '1i Employee, EmpId' emp.txt

2. How to add a line '-------' after the header line or the 1st line?

sed -i '1a --------------------' emp.txt
# '1i' is similar to '1a' except that 'i' tells to include the content before reading the line, 
# 'a' tells to include the content after reading the line. And hence in this case, the '----' 
# line gets included after the 1st line. As you thought correctly, even if you had used '2i', 
# it will work well and fine.

3. How to add a trailer line to this file?

sed -i '$a --------------------' emp.txt
# To add to the last line of the file, we need to know the total line count of the file to use in the above mentioned methods. 
# However, sed has the '$' symbol which denotes the last line. '$a' tells to include the following content after 
# reading the last line of the file.

4. How to add a record after a particular record?

sed -i '/Hilesh/a Ravi, 1005' emp.txt
# If you note the above sed command carefully, all we have done is in place of a number, we have used a pattern. 
# /Hilesh/a tells to include the following contents after finding the pattern 'Hilesh', and hence the result.

5. How to add a record before a particular record?

sed -i '/Harshal/i Abhishek, 1006' emp.txt
# Similarly, /Harshal/i tells to include the following contents before reading the line containing the pattern 'Harshal'

6. To add something to the beginning of a every line in a file, say to add a word Fruit:

sed 's/^/Fruit: /' fruit.txt
# The character 's' stands for substitution. What follows 's' is the character, 
# word or regular expression to replace followed by character, word or regular expression to replace with. 
# '/' is used to separate the substitution character 's', the content to replace and the content to replace with. 
# The '^' character tells replace in the beginning and hence everyline gets added the phrase 'Fruit: ' in the beginning of the line.

7.Similarly, to add something to the end of the file:

sed 's/$/ - Fruit /' fruit.txt
# The character '$' is used to denote the end of the line. And hence this means, replace the end of the line with 'Fruit' 
# which effectively means to add the word 'Fruit' to the end of the line.

8. To replace or substitute a particular character, say to replace 'a' with 'A'.

sed 's/a/A/' fruit.txt
# Please note in every line only the first occurrence of 'a' is being replaced, not all. The example shown here is just for a single character replacement, 
# which can be easily be done for a word as well.

9. To replace or substitute all occurrences of 'a' with 'A'

sed 's/a/A/g' fruit.txt
# The substitute flag '/g' (global replacement) specifies the sed command to replace all the occurrences of the string in the line.

10. Replace the first occurrence or all occurrences is fine. What if we want to replace the second occurrence or 
 third occurrence or in other words nth occurrence.

sed 's/a/A/2' fruit.txt
# Please note above. The 'a' in apple has not changed, and so is in orange since there is no 2nd occurrence 
# of 'a' in this. However, the changes have happened appropriately in banana and pappaya.

11. Now, say to replace all occurrences from 2nd occurrence onwards:

sed 's/a/A/2g' fruit.txt

12. Say, you want to replace 'a' only in a specific line say 3rd line, not in the entire file:

sed '3s/a/A/' fruit.txt
sed '3s/a/A/g' fruit.txt
sed '3s/a/A/2' fruit.txt
# '3s' denotes the substitution to be done is only for the 3rd line.'

13. To replace or substitute 'a' on a range of lines, say from 1st to 3rd line:

sed '1,3s/a/A/g' fruit.txt

14.To replace the entire line with something. For example, to replace 'apple' with 'apple is a Fruit'.

sed 's/.*/& is a Fruit/' fruit.txt
# The '&' symbol denotes the entire pattern matched. In this case, since we are using '.*' 
# which means matching the entire line, '&' contains the entire line. 
# This type of matching will be really useful when you a file containing list of file names and you want to say rename them

15. Using sed, we can also do multiple substitution. For example, say to replace all 'a' to 'A', and 'p' to 'P':

sed 's/a/A/g; s/p/P/g' fruit.txt
OR
sed -e 's/a/A/g' -e 's/p/P/g' fruit.txt

# The option '-e' is used when you have more than one set of substitutions to be done.
OR 
The multiple substitution can also be done as shown below spanning multiple lines:
sed -e 's/a/A/g' \
> -e 's/p/P/g' sample1.txt

sed -e 's/^[A-Z]/Name: &/g' -e 's/[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}/Phone: &/g' \
-e 's/[0-9]\{3\}\s[A-Za-z]/Address: &/g' -e 's/^[a-z]/Email: &/g' names.txt
# O/p: Name: Joe Jenkins
# Phone: 419-555-2791
# Address: 241 Pine St., Dawnstar SC 60185
# Email: joejenkins@bogusemail.com

#-----------------------sed - Read from a file or write into a file------------------------------------------------------------------
#---file1--- 
1apple
1banana
1mango
#---file2---
2orange
2strawberry

# sed has 2 options for reading and writing:
r filename : To read a file name content specified in the filename
w filename : To write to a file specified in the filename

16. Read the file2 after every line of file1.

sed 'r file2' file1
# r file2 reads the file contents of file2. Since there is no specific number before 'r', 
# it means to read the file contents of file2 for every line of file1

17. The above output is not very useful. Say, we want to read the file2 contents after the 1st line of file1:

sed '1r file2' file1
# '1r' indicates to read the contents of file2 only after reading the line1 of file1.

18. Similarly, we can also try to read a file contents on finding a pattern:

sed '/banana/r file2' file1
#The file2 contents are read on finding the pattern banana

19. To read a file content on encountering the last line:

sed '$r file2' file1
#The '$' indicates the last line, and hence the file2 contents are read after the last line.

20. Write the lines from 2nd to 4th to a file, say file2

sed -n '2,4w file2' file1
# The option '2,4w' indicates to write the lines from 2 to 4. What is the option "-n" 
# for? By default, sed prints every line it reads, and hence the above command without "-n" will still print the file1 
# contents on the standard output. In order to suppress this default output, "-n' is used.

21. Write the contents from the 3rd line onwards to a different file:

sed -n '3,$w file2' file1
#'3,$' indicates from 3 line to end of the file.

22. To write a range of lines, say to write from lines apple through mango :

sed -n '/apple/,/mango/w file2' file1

#-------------------------------------------------------Examples-----------------------------------------------------------------------

# Displaying line numbers in a file
sed -n '{;=;p}' filename| sed "N;s/\n/ /g"| sed -n '/2/,+2p'

sed 's/Nick/John/g' report.txt 
#Replace every occurrence of Nick with John in report.txt
sed 's/Nick|nick/John/g' report.txt 
#Replace every occurrence of Nick or nick with John.
sed 's/^/ /' file.txt >file_new.txt 
#Add 8 spaces to the left of a text for pretty printing.
sed -n '/Of course/,/attention you \pay/p' myfile 
#Display only one paragraph, starting with "Of course"and ending in "attention you pay"
sed -n 12,18p file.txt 
#Show only lines 12-18 of file.txt
sed 12,18d file.txt 
#Show all of file.txt except for lines from 12 to 18
sed G file.txt 
#Double-space file.txt
sed -f script.sed file.txt 
#Write all commands in script.sed and execute them
sed '5!s/ham/cheese/' file.txt 
#Replace ham with cheese in file.txt except in the 5th line
sed '$d' file.txt 
#Delete the last line
sed '/[0-9]\{3\}/p' file.txt 
#Print only lines with three consecutive digits
sed '/boom/!s/aaa/bb/' file.txt 
#Unless boom is found replace aaa with bb
sed '17,/disk/d' file.txt 
#Delete all lines from line 17 to 'disk'
echo ONE TWO | sed "s/one/unos/I" 
#Replaces one with unos in a case-insensitive manner,so it will print "unos TWO"
sed 'G;G' file.txt 
#Triple-space a file
sed 's/.$//' file.txt 
#A way to replace dos2unix :)
sed 's/^[ ^t]*//' file.txt 
#Delete all spaces in front of every line of file.txt
sed 's/[ ^t]*$//' file.txt 
#Delete all spaces at the end of every line of file.txt
sed 's/^[ ^t]*//;s/[ ^]*$//' file.txt 
#Delete all spaces in front and at the end of every line of file.txt
sed 's/foo/bar/' file.txt
#Replace foo with bar only for the first instance in a line.
sed 's/foo/bar/4' file.txt
#Replace foo with bar only for the 4th instance in a line.
sed 's/foo/bar/g' file.txt 
#Replace foo with bar for all instances in a line.
sed '/baz/s/foo/bar/g' file.txt
#Only if line contains baz, substitute foo with bar
sed '/./,/^$/!d' file.txt
#Delete all consecutive blank lines except for EOF
sed '/^$/N;/\n$/D' file.txt
#Delete all consecutive blank lines, but allows only top blank line
sed '/./,$!d' file.txt
#Delete all leading blank lines
sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' \
file.txt
#Delete all trailing blank lines
sed -e :a -e '/\$/N; s/\\n//; ta' \
file.txt
# If a file ends in a backslash, join it with the next (useful for shell scripts)
sed '/regex/,+5/expr/'
#Match regex plus the next 5 lines
sed '1~3d' file.txt
#Delete every third line, starting with the first
sed -n '2~5p' file.txt
#Print every 5th line starting with the second
sed 's/[Nn]ick/John/g' report.txt
#Another way to write some example above.Can you guess which one?

sed -n '/RE/{p;q;}' file.txt
#Print only the first match of RE (regular expression)
sed '0,/RE/{//d;}' file.txt
#Delete only the first match
sed '0,/RE/s//to_that/' file.txt
#Change only the first match
sed 's/^[^,]*,/9999,/' file.csv
#Change first field to 9999 in a CSV file
s/^ *\(.*[^ ]\) *$/||/;
s/" *, */"|/g;
: loop
s/| *\([^",|][^,|]*\) *, */||/g;
s/| *, */||/g;
t loop
s/ *|/|/g;
s/| */|/g;
s/^|\(.*\)|$//;
sed script to convert CSV file to bar-separated
(works only on some types of CSV,with embedded "s and commas)

sed ':a;s/\(^\|[^0-9.]\)\([0-9]\+\)\
([0-9]\{3\}\)/,/g;ta' file.txt
#Change numbers from file.txt from 1234.56 form to 1.234.56
sed -r "s/\<(reg|exp)[a-z]+/\U&/g"
#Convert any word starting with reg or exp to uppercase
sed '1,20 s/Johnson/White/g' file.txt
#Do replacement of Johnson with White only on lines between 1 and 20

sed '1,20 !s/Johnson/White/g' file.txt
#The above reversed (match all except lines 1-20)
sed '/from/,/until/ { s/\<red\>/magenta/g; \
s/\<blue\>/cyan/g; }' file.txt
#Replace only between "from" and "until"
sed '/ENDNOTES:/,$ { s/Schaff/Herzog/g; \
s/Kraft/Ebbing/g; }' file.txt
#Replace only from the word "ENDNOTES:" until EOF
sed '/./{H;$!d;};x;/regex/!d' file.txt
#Print paragraphs only if they contain regex
 sed -e '/./{H;$!d;}' -e 'x;/RE1/!d;\
/RE2/!d;/RE3/!d' file.txt
#Print paragraphs only if they contain RE1,RE2 and RE3

sed ':a; /\$/N; s/\\n//; ta' file.txt
#Join two lines in the first ends in a backslash

sed 's/14"/fourteen inches/g' file.txt
#This is how you can use double quotes

sed 's/\/some\/UNIX\/path/\/a\/new\/path/g' file.txt
#Working with Unix paths

sed 's/[a-g]//g' file.txt
#Remove all characters from a to g from file.txt

sed 's/\(.*\)foo/bar/' file.txt
#Replace only the last match of foo with bar
sed '1!G;h;$!d' 
#A tac replacement
sed '/\n/!G;s/\(.\)\(.*\n\)/&\/;//D;s/.//'
#A rev replacement
sed 10q file.txt
#A head replacement
sed -e :a -e '$q;N;11,$D;ba' \
file.txt
#A tail replacement
sed '$!N; /^\(.*\)\n$/!P; D' \
file.txt
#A uniq replacement
sed '$!N; s/^\(.*\)\n$//;\
 t; D' file.txt
#The opposite (or uniq -d equivalent)
sed '$!N;$!D' file.txt
#Equivalent to tail -n 2
sed -n '$p' file.txt
#... tail -n 1 (or tail -1)
sed '/regexp/!d' file.txt
#grep equivalent
sed -n '/regexp/{g;1!p;};h' file.txt
#Print the line before the one matching regexp, but not the one containing the regexp

sed -n '/regexp/{n;p;}' file.txt
#Print the line after the one matching the regexp, but not the one containing the regexp

sed '/pattern/d' file.txt
#Delete lines matching pattern
sed '/./!d' file.txt
#Delete all blank lines from a file
sed '/^$/N;/\n$/N;//D' file.txt
#Delete all consecutive blank lines except for the first two

sed -n '/^$/{p;h;};/./{x;/./p;}'\
 file.txt
#Delete the last line of each paragraph
sed 's/.\x08//g' file
#Remove nroff overstrikes
sed '/^$/q'
#Get mail header
sed '1,/^$/d'
#Get mail body
sed '/^Subject: */!d; s///;q'
#Get mail subject
sed 's/^/> /'
#Quote mail message by inserting a "> " in front of every line

sed 's/^> //'
#The opposite (unquote mail message)
sed -e :a -e 's/<[^>]*>//g;/</N;//ba'
#Remove HTML tags
sed '/./{H;d;};x;s/\n/={NL}=/g'\
 file.txt | sort \
| sed '1s/={NL}=//;s/={NL}=/\n/g'
#Sort paragraphs of file.txt alphabetically
sed 's@/usr/bin@&/local@g' path.txt
#Replace /usr/bin with /usr/bin/local in path.txt
sed 's@^.*$@<<<&>>>@g' path.txt
#Try it and see :)
sed 's/\(\/[^:]*\).*//g' path.txt
#Provided path.txt contains $PATH, this will echo only the first path on each line

sed 's/\([^:]*\).*//' /etc/passwd
#awk replacement - displays only the users from the passwd file

echo "Welcome To The Geek Stuff" | sed \
's/\(\b[A-Z]\)/\(\)/g'
#(W)elcome (T)o (T)he (G)eek (S)tuff Self-explanatory
sed -e '/^$/,/^END/s/hills/\mountains/g' file.txt
#Swap 'hills' for 'mountains', but only on blocks of text beginning with a blank line, 
#and ending with a line beginning with the three characters 'END', inclusive

sed -e '/^#/d' /etc/services | more
#View the services file without the commented lines
sed '$s@\([^:]*\):\([^:]*\):\([^:]*\
\)@::@g' path.txt
#Reverse order of items in the last line of path.txt
sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}'\
 -e h file.txt
#Print 1 line of context before and after the line matching,with a line number where the matching occurs

sed '/regex/{x;p;x;}' file.txt
#Insert a new line above every line matching regex
sed '/AAA/!d; /BBB/!d; /CCC/!d' file.txt
#Match AAA, BBB and CCC in any order
sed '/AAA.*BBB.*CCC/!d' file.txt
#Match AAA, BBB and CCC in that order
sed -n '/^.\{65\}/p' file.txt
#Print lines 65 chars long or more
sed -n '/^.\{65\}/!p' file.txt
#Print lines 65 chars long or less
sed '/regex/G' file.txt
#Insert blank line below every line
sed '/regex/{x;p;x;G;}' file.txt
#Insert blank line above and below
sed = file.txt | sed 'N;s/\n/\t/'
#Number lines in file.txt
sed -e :a -e 's/^.\{1,78\}$/\
 &/;ta' file.txt
#Align text flush right
sed -e :a -e 's/^.\{1,77\}$/ &/;ta' -e \
's/\( *\)//' file.txt
#Align text center