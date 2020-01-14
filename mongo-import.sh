for f in *.csv
do
    filename=$(basename "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"
    cat $f | tr -d \" > ${f}.tmp
    sed -i 's/NULL//g' ${f}.tmp
    rm $f
    mv ${f}.tmp $f
    echo $f
    mongoimport -d northwind -c "$filename" --type csv --file "$f" --headerline
done