echo "Your number of raw in scraped data:"
wc -l handrit_swedish_aa.csv
csvgrep -i -c 8 -r "$(cat ./stopdates)"  handrit_swedish_aa.csv > handrit_swedish_a_stopdates.csv
echo "Your number of raw in scraped data, after date remove is:"
wc -l handrit_swedish_a_stopdates.csv

#cut columns
csvcut -c 'web-scraper-order','web-scraper-start-url','shelfmark','shelfmark-href' handrit_swedish_a_stopdates.csv > handrit_swedish_a_c1-4.csv
csvcut -c 'shelfmark','shelfmark-href','all_link','all_link-href' handrit_swedish_a_stopdates.csv > handrit_swedish_a_c3-6.csv
#In case you want to work with the third layer of link, uncomment the line below.
#csvcut -c 'all_link','all_link-href','sub-all_link','sub-all_link-href' handrit_swedish_a_stopdates.csv > handrit_swedish_a_c5-8.csv

#replace first column source-label by Browse page name
sed -i 's/^[^,]\+,/Search=SWEDISH,/' handrit_swedish_a_c1-4.csv 



#concatenate all
head -1 handrit_swedish_a_c1-4.csv > handrit_swedish_a_formated.csv; tail -n +2 -q handrit_swedish_a_c*-*.csv >> handrit_swedish_a_formated.csv

echo "Your number of row before any cleaning is:"
wc -l handrit_swedish_a_formated.csv

#replace first line
sed -i "1 s/.*/source_label,source,target_label,target/" handrit_swedish_a_formated.csv 

#Removes duplicates
cat handrit_swedish_a_formated.csv | sed 's/#[A-Za-z_0-9]\+,/,/' | sed 's/#[A-Za-z_0-9]\+$//' > handrit_swedish_a_nohashtag.csv
echo "Your number of row before duplicate removal is:"
wc -l handrit_swedish_a_nohashtag.csv
#test the presence of bad formed data:
grep -v --color '.*,.*,.*,.*' handrit_swedish_a_nohashtag.csv
grep --color '#' handrit_swedish_a_nohashtag.csv
#Remove duplicates
perl -ne 'print if ++$k{$_}==1' handrit_swedish_a_nohashtag.csv > handrit_swedish_a_uniq.csv
echo "Your number of row after duplicate removal is:"
wc -l handrit_swedish_a_uniq.csv

# Remove language layout links
csvgrep -i -c 2 -r "view.outerlayout.language"  handrit_swedish_a_uniq.csv | csvgrep -i -c 4 -r "view.outerlayout.language" > handrit_swedish_a_nolayout.csv

echo "Your number of row after layout language removal is:"
wc -l handrit_swedish_a_nolayout.csv
#remove stopwords
csvgrep -i -c 1 -r "$(cat stopwords)"  handrit_swedish_a_nolayout.csv | csvgrep -i -c 3 -r "$(cat stopwords)" >handrit_swedish_a_stopword.csv 

echo "Your number of row after stopwords removal is:"
wc -l handrit_swedish_a_stopword.csv
