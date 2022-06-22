# Notes on the graphs

- Name: [graph_place_manuscripts.pdf](graph_place_manuscripts.pdf)
- Data: [place_manuscripts.csv](place_manuscripts.csv)
- Name: [place_manuscripts.html](place_manuscripts.html)
- Data: [place_manuscripts.csv](place_manuscripts.csv)

# Description
These graphs are variations based on the same scrape file: [place_html.csv](place_html.csv) we applied different cleaning to them such as removing  the licence etc.
This file is a table of scraped links from the list of url contained in [places.txt](places.txt).

## Process (For developpers)
To re-run the scraping:
```bash
cd path/to/scrap_places
sh get_places.sh
```
To run the graph. Take the dataset you wish to generate, for instance "place_manuscripts.csv"
In a terminal run :
```
cd path/to/scrap_places
cp place_manuscripts.csv data_html.csv
Rscript graph.R
python graph_manuscripta.py
```
Note: graph.R does not run in Rstudio.
