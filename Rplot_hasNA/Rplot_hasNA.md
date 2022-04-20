# Notes on the graph
This graph displays the data about the keyword search "Swedish". We kept the empty labels (NA). This graph is to be compared with [Rplot_noNA.md](https://gitlab.com/mardub/libralinked/-/blob/master/Rplot_noNA/Rplot_noNA.md)

## Properties

- Name: [Rplot_hasNA.pdf](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/Rplot_hasNA.pdf)
- Number of nodes: 76
- Number of edges: 129

## Data

- Data cleaned: [handrit_swedish_a_stopword.csv](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/handrit_swedish_a_stopword.csv)
- Data collected: [handrit_swedish_aa.csv](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/handrit_swedish_aa.csv)
- Webscrapper.io sitemap: [handrit_swedish_aa.json](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/handrit_swedish_aa.json)

## Process
- Folder version: 8516870d
- Stopword filter used: ^handrit|^Browse|^Home|^Hejm|Search$|^About|^Statisti|«|»
- File for stopword version: [stopwords](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/stopwords)
- Date filter: [Stopdates](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/Stopdates)
- Cleaner script used: [cleaner_a.sh](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/cleaner_a.sh)
- Graph script: [graph_a.R](https://gitlab.com/mardub/libralinked/-/blob/8516870d50dbe0deb3d1e3e78bb87c237818110d/graph_a.R)



# Instructions
If you want to regenerate the graph:
1. Checkout git folder at the Folder version writen above.
2. Run:
```sh cleaner_a.sh```
3. Open ``` graph_a.R``` in Rstudio, run the script. Output a pdf with size A4



# Additional references


## Issue
This graph has been made between meeting 10 Februari and 22 Februari 2022. See the issue/email here:
[Issue](https://gitlab.com/mardub/libralinked/-/issues/2)

- [x] Remove rows/nodes that have the french citation marks: »

- [x] Remove all rows that have a starting date over 1550 (see stopdate file above)

- [x] At the end of cleaning: make two versions of the data. One where we remove the empty cells (=hyperlinks that had no hypertext, because they are not part of the user XP) and one where we keep them all the empty cells.

- [x] Adds color bleu for places nodes on the graph

- [-] Label the shelfmarks (=add labels on the yellow nodes of the graph), Note: partially done


- [ ] When we have a "more detail" located on a hoover window get the title of the hoover window link and not just the "more detail" text: for instance on this pagehttps://handrit.is/en/manuscript/view/Rask115, we should get the "Rasmus Rask" instead of "more details" (OBS: Probably technically harder, so will keep do it if time allows) Note: not done

## Additional data

```
Your number of raw in scraped data:
14581 handrit_swedish_aa.csv
Your number of raw in scraped data, after date remove is:
13098 handrit_swedish_a_stopdates.csv
Your number of row before any cleaning is:
26195 handrit_swedish_a_formated.csv
Your number of row before duplicate removal is:
26195 handrit_swedish_a_nohashtag.csv
Your number of row after duplicate removal is:
153 handrit_swedish_a_uniq.csv
Your number of row after layout language removal is:
141 handrit_swedish_a_nolayout.csv
Your number of row after stopwords removal is:
130 handrit_swedish_a_stopword.csv

```