library(igraph)
library(tidyverse)
set.seed(11)#Change number here to re-randomize the shape of your graph
colorise<-function(url)
  ifelse(grepl("manuscript",url,fixed = TRUE),"red",
         ifelse(grepl("bibliography",url,fixed = TRUE),"blue",
                "orange"))
read_csv("handrit_swedish_aa_stopword.csv")%>%
  transmute(source=str_to_lower(source),
            target=str_to_lower(target),
            source_label=str_to_lower(source_label),
            target_label=str_to_lower(target_label),
            #color=ifelse(isReply, "grey", "black"),
            arrow.size=0.2,
            curved=runif(n(),-0.4,0.4)) -> df_edges
bind_rows(transmute(df_edges,name=source,label=source_label),
          transmute(df_edges,name=target,label=target_label)
          ) %>%
          group_by(name)%>%
          summarise(actual_label=paste0(unique(label),collapse = " // "))%>%
  #unique()%>%
  mutate(label=ifelse(rbinom(n(),1,0.5),actual_label,""),color=colorise(name))->df_nodes
#read_csv("handrit_swedish_a_formated.csv")%>%

#df_anonymous <- df_edges[3]
  
graph_from_data_frame(df_edges, vertices = df_nodes) -> g_frame
g_frame
#pdf("test.pdf")
lo <- layout_nicely(g_frame)
#dev.off()
plot(g_frame,
     rescale=FALSE,
     layout=1*norm_coords(lo, -1, 1, -1.2, 1.2),
     vertex.size=5,
     vertex.label.cex = 0.5,#Change label size here
     #vertex.label=df_anonymous, #uncomment to get things anonymised
     edge.width=0.5)
#legend('topleft',legend=levels(sizeCut),pt.cex=scaled,col='black',pch=21, pt.bg='orange'))
#dev.off()
#for graphviz later:
#write_graph(g_frame,format = "dot", file = "comment.dot")
