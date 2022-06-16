library(igraph)
library(tidyverse)
set.seed(12)#Change number here to re-randomize the shape of your graph

read_csv("./data_html.csv")%>%
  transmute(source=str_to_lower(source),
            target=str_to_lower(target),
            source_label=str_to_lower(label_s),
            target_label=str_to_lower(label_t),
            #color=ifelse(isReply, "grey", "black"),
            arrow.size=0.1,
            curved=runif(n(),-0.4,0.4)) -> df_edges
bind_rows(transmute(df_edges,name=source,label=source_label),
          transmute(df_edges,name=target,label=target_label)
) %>%
  group_by(name)%>%
  summarise(label=paste0(unique(label),collapse = " // "))%>%
  mutate(label=ifelse(rbinom(n(), 1,0.999),label,""))->df_nodes#This line keeps 99% of labels
  #n() is the number of rows.
#n_nodes<-nrow(df_nodes)
#df_anonymous<-1:n_nodes
graph_from_data_frame(df_edges, vertices = df_nodes) -> g_frame
g_frame
pdf(paper="USr","graph.pdf")
#pdf("test.pdf")
lo <- igraph::layout_nicely(g_frame)
#lo <- igraph::layout_in_circle(g_frame)
plot(g_frame,
     rescale=FALSE,
     layout=0.6*norm_coords(lo, -1.8, 1.8, -1.4, 1.5),
     vertex.size=1,
     vertex.label.cex = 0.5,#Change label size here
     #vertex.label=df_anonymous, #uncomment to get things anonymised
     edge.width=0.5)
     #legend('topleft',legend=levels(sizeCut),pt.cex=scaled,col='black',pch=21, pt.bg='orange'))

# legend('topright', box.lwd = 1, box.col = "black",
#        cex = 0.8,
#        c('Comment','Response','Author','Commentor'),
#        col=c("black","grey","red","orange"), 
#        
#        pch = c(NA,NA,20,20),#(0,0,20,20)
#        lty = c(1,1,0,0),#0,
#        #bg =c(NA,NA,"green","blue"),
#        bty = "y",  pt.cex =2.5 )
