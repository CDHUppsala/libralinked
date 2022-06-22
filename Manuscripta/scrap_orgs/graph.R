library(igraph)
library(tidyverse)
set.seed(12)#Change number here to re-randomize the shape of your graph
origins = "other"

greps = c(origins,"a \\d+","b \\d+","c \\d+","d \\d+","cc0 1.0 universal", "organisations")
grepsleg = c(origins,"a ","b ","c ","d ","Licence", "organisations")
col = c("grey","lightsalmon", "lavenderblush1","darkolivegreen2" , "cyan3", "white","yellow") #Colors of the nodes se http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
set.seed(14)#Change number here to re-randomize the shape of your graph
#origins = "https://handrit.is/en/manuscript/view/AM02-0191|https://handrit.is/en/manuscript/view/AM04-0051|https://handrit.is/en/manuscript/view/AM04-0049|https://handrit.is/en/manuscript/view/AM04-0045|https://handrit.is/en/manuscript/view/Rask115|https://handrit.is/en/manuscript/view/AM04-0046|https://handrit.is/en/manuscript/view/AM08-030|https://handrit.is/en/manuscript/view/AM02-0201|https://handrit.is/en/manuscript/view/AM08-265|https://handrit.is/en/manuscript/view/AM02-0200|https://handrit.is/en/manuscript/view/AM04-0353|https://handrit.is/en/manuscript/view/AM02-300|https://handrit.is/en/manuscript/view/AM04-0899"
colorise<-function(url)
  #c("Results" , "http://...manuscript/view",  "http://...bibliography" , "http://...biography", "Other"), 
  ifelse(grepl(str_to_lower(greps[1]),url,fixed = FALSE),col[1],#the shelfmarks
         ifelse(grepl(greps[2],url,fixed = FALSE),col[2],
                ifelse(grepl(greps[3],url,fixed = FALSE),col[3],
                       ifelse(grepl(greps[4],url,fixed = FALSE),col[4],
                              ifelse(grepl(greps[5],url,fixed = FALSE),col[5],
                                ifelse(grepl("cc",url,fixed = TRUE),col[6],#the central dot in white
                  col[7]))))))

read_csv("./data.csv")%>%
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
  mutate(label=ifelse(rbinom(n(), 1,0.999),label,""),color=colorise(label))->df_nodes#This line keeps 99% of labels
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
     layout=0.65*norm_coords(lo, -1.8, 1.8, -1.4, 1.5),
     vertex.size=3.5,#node sizes
     vertex.label.cex = 0.5,#Change label size here
     vertex.frame.color="white",
     #vertex.label=df_anonymous, #uncomment to get things anonymised
     edge.width=0.5)
     #legend('topleft',legend=levels(sizeCut),pt.cex=scaled,col='black',pch=21, pt.bg='orange'))

legend("bottomleft", 
       legend = grepsleg[2:7], 
       col = col[2:7], 
       pch = c(20,20,20,20,20), bty = "y",  pt.cex =2.0, cex = 0.4 , #pt.cex = bubble size
       text.col = "black", horiz = FALSE, inset = c(0.6, -0.1),
       #pch = c(20,20,20,20,20), bty = "n", pt.cex =3.9, cex = 0.9 , 
       #text.col = "black", horiz = FALSE, inset = c(0.3, 0.1),
       xpd=TRUE,
       text.font = 56
       )
