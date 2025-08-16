grep "Jane Williams" names.txt
grep "John Williams" names.txt

grep -w "John Williams" names.txt # search by words
grep -wi "John Williams" names.txt # search by words with case insensitive mode
grep -win "John Williams" names.txt # displays the line number where the match found

grep -win -B 4 "John Williams" names.txt # displays 4 line before the found match
grep -win -A 4 "John Williams" names.txt # displays 4 line after the match found
grep -win -C 2 "John Williams" names.txt # displays the 2 lines context before and after the match found

grep -win "John Williams" ./* # search by the wildcards
grep -win "John Williams" ./*.txt #search by the wildcards with .txt match
grep -winr "John Williams" . # searching the match in all directories in current path
grep -wirl "John Williams" . # list of all directories having the match 
grep -wirc "John Williams" . # count of matches found in each directory

history
history | grep "git commit"
history | grep "git commit" | grep "dotfile"

grep "...-...-...." names.txt
grep -P "\d{3}-\d{3}-\d{4}" names.txt 
grep -V

#------------------------------------Sample-text-file-as-GPL3/BSD"--------------------------------------------------
cp /usr/share/common-licenses/GPL-3 .
cp /usr/share/common-licenses/BSD .

grep "GNU" GPL-3
grep -i "license" GPL-3
grep -v "the" BSD
grep -vn "the" BSD
grep "^GNU" GPL-3
grep "and$" GPL-3
grep "..cept" GPL-3
grep "t[wo]o" GPL-3
grep "[^c]ode" GPL-3
grep "^[A-Z]" GPL-3
grep "^[[:upper:]]" GPL-3
grep "([A-Za-z ]*)" GPL-3
grep "^[A-Z].*\.$" GPL-3
grep "\(grouping\)" file.txt
grep -E "(grouping)" file.txt
egrep "(grouping)" file.txt
grep -E "(GPL|General Public License)" GPL-3
grep -E "(copy)?right" GPL-3
grep -E "free[^[:space:]]+" GPL-3
grep -E "[AEIOUaeiou]{3}" GPL-3
grep -E "[[:alpha:]]{16,20}" GPL-3