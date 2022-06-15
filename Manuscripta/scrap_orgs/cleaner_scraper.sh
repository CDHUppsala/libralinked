#python scrap_links.py
grep -v "Home" org_html.csv | grep -v "Search" | grep -v "/ms" | grep "," | grep -v "ERROR"  > org_html_clean.csv
echo 'source,label_s,target,label_t\n' > orgs_manuscripts.csv
grep "/ms" org_html.csv >> orgs_manuscripts.csv
grep "CC0 1.0 Universal" org_html.csv >> orgs_manuscripts.csv

echo 'source,label_s,target,label_t\n' > orgs_manuscripts_nolicence.csv
grep "/ms" org_html.csv >> orgs_manuscripts_nolicence.csv
