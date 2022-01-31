#cut columns
csvcut -c 'web-scraper-order','web-scraper-start-url','shelfmark','shelfmark-href' handrit_swedish_aa.csv > handrit_swedish_aa_c1-4.csv
csvcut -c 'shelfmark','shelfmark-href','all_link','all_link-href' handrit_swedish_aa.csv > handrit_swedish_aa_c3-6.csv
#csvcut -c 'all_link','all_link-href','sub-all_link','sub-all_link-href' handrit_swedish_aa.csv > handrit_swedish_aa_c5-8.csv

#replace first column by Browse page name
sed -i 's/^[^,]\+,/Search=SWEDISH,/' handrit_swedish_aa_c1-4.csv 

#concatenate all
head -1 handrit_swedish_aa_c1-4.csv > handrit_swedish_aa_formated.csv; tail -n +2 -q handrit_swedish_aa_c*-*.csv >> handrit_swedish_aa_formated.csv

#replace first line
sed -i "1 s/.*/source_label,source,target_label,target/" handrit_swedish_aa_formated.csv 

#removes duplicates
#TODO: change regex to make it less greedy et verifier
cat handrit_swedish_aa_formated.csv | sed 's/#[A-Za-z_0-9]\+,/,/' | sed 's/#[A-Za-z_0-9]\+$//' > handrit_swedish_aa_nohashtag.csv
#test the presence of bad formed data:
grep -v --color '.*,.*,.*,.*' handrit_swedish_aa_nohashtag.csv
grep --color '#' handrit_swedish_aa_nohashtag.csv
#Remove duplicates
#cat test.txt | sed 's/#[A-Za-z_0-9]\+,/,/' | sed 's/#[A-Za-z_0-9]\+$//'
perl -ne 'print if ++$k{$_}==1' handrit_swedish_aa_nohashtag.csv > handrit_swedish_aa_uniq.csv
#remove stopwords
csvgrep -i -c 1 -r "$(cat stopwords)"  handrit_swedish_aa_uniq.csv | csvgrep -i -c 3 -r "$(cat stopwords)" >handrit_swedish_aa_stopword.csv 
