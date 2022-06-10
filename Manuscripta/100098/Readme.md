# Description

Name: [graph_html.pdf](./graph_html.pdf) and [graph_xml.pdf](./graph_xml.pdf)


These graphs visualise the links of one entity of Manuscripta refered as: 100098 of a [html](https://www.manuscripta.se/org/100098) vs a [XML](https://www.manuscripta.se/org/100098.xml) .
all the comments, including the comments in the "bubbles", the answers to them, and the bottom page comments have been scraped for this graph.
Novelty: Active authors (i.e., with numStories > 0) are in red.

Open a terminal and write:
``` 
cd path/to/this folder
Rscript ./graph.R
```





## Data

- Data graph_html.pdf: [data_html](./data_html.csv) (OBS: collect has been done manually)
- Data graph_xml.pdf: [data_xml](./data.csv)
- Date of data scraping: June 2022
- working directory: ./Manuscripta/100098

# Instructions
If you want to regenerate the graph_xml:
Download the folder: https://github.com/manuscripta/data/tree/master/data place it into the folder Manuscripta

``` 
cd path/to/manuscripta
git clone https://github.com/manuscripta/data/tree/master/data
. ./xml_pack/bin/activate #make sure you have applied the requirements.txt with render.sh
cd 100098
sh collecter100098.sh
Rgraph graph.R

```

2. In a terminal run:
``` Rscript ./graph.R```
Note: This script does not output the image if run in the rstudio
