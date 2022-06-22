csvcut -c target ../data_no-locus.csv | grep "place" | sort -u > places.txt

python scrap_places.py
grep -v "Home" place_html.csv | grep -v "Search" |grep -Ev "Gr. |Kl f |T |Utl.|Rålamb 11" | grep "," | grep -v "ERROR"  > place_manuscripts.csv
#echo 'source,label_s,target,label_t\n' > places_manuscripts.csv
#grep "/ms" org_html.csv >> orgs_manuscripts.csv
#grep "CC0 1.0 Universal" org_html.csv >> orgs_manuscripts.csv

#echo 'source,label_s,target,label_t\n' > orgs_manuscripts_nolicence.csv
#grep "/ms" org_html.csv >> orgs_manuscripts_nolicence.csv
