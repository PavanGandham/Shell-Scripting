# for flattening and merging the file and writing to a tempfile
pr -J -m -t file* --sep-string=';' >mergedfile
cat mergedfile
# Now you have data in each line which can be looped and redirected to respective filenames based on the loop count
# No.of files will be equal to the biggest file in the input, in this case , you will see 240 files
i=1
while read line; do
    echo "=======file no: $i ========"
    echo $line | sed -e 's@^;@@g' -e 's@;;@@g' | tr ';' '\n' >output-${i}.txt
    let i=i+1
done <mergedfile
