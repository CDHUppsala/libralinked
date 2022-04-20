 find . -type f -name '*.xml' -exec sh -c '
    xmlstarlet sel -N q="http://www.tei-c.org/ns/1.0" -t -v "//q:textLang/@mainLang='non-swe'" "$1" |
    grep -q "."' sh {} ';' -print
    
     find . -type f -name '*.xml' -exec sh -c '
    xmlstarlet sel -N q="http://www.tei-c.org/ns/1.0" -t -v "//q:repository[text() = \"Kungliga biblioteket\" or text() = \"Kungliga biblioteket\"]" "$1" |
    grep -q "."' sh {} ';' -print >../../../files.txt



 xmlstarlet sel -N q="http://www.tei-c.org/ns/1.0" -t -v "//q:textLang/@mainLang='non-swe'" 100206.xml
 
      find . -type f -wholename './data/data/msDescs/*.xml' -exec sh -c '
    xmlstarlet sel -N q="http://www.tei-c.org/ns/1.0" -t -v "//q:textLang/@mainLang='non-swe'" "$1" |
    grep -q "."' sh {} ';' -print > files.txt
    
         find . -type f -wholename './test/*.xml' -exec sh -c '
    xmlstarlet sel -N q="http://www.tei-c.org/ns/1.0" -t -v "//q:msContents/textLang/@mainLang='grc'" "$1" |
    grep -q "."' sh {} ';' -print > files.txt
 
