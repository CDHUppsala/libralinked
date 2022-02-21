# Notes on the graph
This graph displays the data about the keyword search "Swedish". We removed the empty labels (NA).

## Properties

- Name: [Rplot_noNA.pdf](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/Rplot_noNA.pdf)
- Number of nodes:73
- Number of edges: 126

## Data

- Data cleaned: [handrit_swedish_a_stopword.csv](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/handrit_swedish_a_stopword.csv)
- Data collected: [handrit_swedish_aa.csv](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/handrit_swedish_aa.csv)
- Webscrapper.io sitemap: [handrit_swedish_aa.json](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/handrit_swedish_aa.json)

## Process
- Folder version: f77db8be
- Stopword filter used: ^handrit|^Browse|^Home|^Hejm|Search$|^About|^Statisti|«|»|^$
- File for stopword version: [stopwords](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/stopwords)
- Date filter: [Stopdates](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/stopdates)
- Cleaner script used: [cleaner_a.sh](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/cleaner_a.sh)
- Graph script: [graph_a.R](https://gitlab.com/mardub/libralinked/-/blob/f77db8be47d3f7ed0eb6d8422a3d4b8d8d5a1adb/graph_a.R)



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

- [x] At the end of cleaning: make two versions of the data. One where we remove the empty cells (=hyperlinks that had no hypertext, because they are not part of the user XP) and one where we keep them all the empty cells

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
127 handrit_swedish_a_stopword.csv

```