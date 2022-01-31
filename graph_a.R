library(igraph)
library(tidyverse)
set.seed(13)#Change number here to re-randomize the shape of your graph
origins = "https://handrit.is/en/manuscript/view/AM02-0191|https://handrit.is/en/manuscript/view/AM04-0051|https://handrit.is/en/manuscript/view/AM04-0049|https://handrit.is/en/manuscript/view/AM04-0045|https://handrit.is/en/manuscript/view/Rask115|https://handrit.is/en/manuscript/view/AM04-0046|https://handrit.is/en/manuscript/view/AM08-030|https://handrit.is/en/manuscript/view/AM02-0201|https://handrit.is/en/manuscript/view/AM08-265|https://handrit.is/en/manuscript/view/AM02-0200|https://handrit.is/en/manuscript/view/AM04-0353|https://handrit.is/en/manuscript/view/AM02-300|https://handrit.is/en/manuscript/view/AM04-0899"
colorise<-function(url)
  ifelse(grepl(str_to_lower(origins),url,fixed = FALSE),"red",
         ifelse(grepl("bibliography",url,fixed = TRUE),"pink",
                ifelse(grepl("biography",url,fixed = TRUE),"green",
                       ifelse(grepl("https://handrit.is/en/search/results/",url,fixed = TRUE),"white",
                              ifelse(grepl("manuscript/view",url,fixed = TRUE),"orange",
                  "grey")))))
read_csv("handrit_swedish_aa_stopword.csv")%>%
  transmute(source=str_to_lower(source),
            target=str_to_lower(target),
            source_label=str_to_lower(source_label),
            target_label=str_to_lower(target_label),
            #color=ifelse(isReply, "grey", "black"),
            arrow.size=0.05,#Arrows
            curved=runif(n(),-0.4,0.4)) -> df_edges
bind_rows(transmute(df_edges,name=source,label=source_label),
          transmute(df_edges,name=target,label=target_label)
) %>%
  group_by(name)%>%
  summarise(actual_label=paste0(unique(label),collapse = " // "))%>%
  #change rbinom values to put more or less labels
  mutate(label=ifelse(rbinom(n(),1,0.05),actual_label,""),color=colorise(name))->df_nodes
#read_csv("handrit_swedish_a_formated.csv")%>%

#df_anonymous <- df_edges[3]

graph_from_data_frame(df_edges, vertices = df_nodes) -> g_frame
g_frame
#pdf("test.pdf")
#lo <- layout_nicely(g_frame)
lo <- layout_nicely(g_frame)
#dev.off()
plot(g_frame,
     rescale=FALSE,
     layout=1*norm_coords(lo, -1, 1, -1.2, 1.2),
     vertex.size=5,#Change size of the bubbles here
     vertex.label.cex = 0.5,#Change label size here
     #vertex.label=df_anonymous, #uncomment to get things anonymised
     edge.width=0.3)
#legend('topleft',legend=levels(sizeCut),pt.cex=scaled,col='black',pch=21, pt.bg='orange'))

legend("topleft", 
       legend = c("Results" , "http://...manuscript/view",  "http://...bibliography" , "http://...biography", "Other"), 
       col = c("red","orange", "pink" , "green" , "grey"), 
       pch = c(20,20,20,20,20), bty = "n",  pt.cex = 3.5, cex = 0.8 , 
       text.col = "black", horiz = FALSE, inset = c(0, 0.1),
       xpd=TRUE,
       )
#dev.off()
#for graphviz later:
#write_graph(g_frame,format = "dot", file = "comment.dot")
