from pyvis.network import Network
import pandas as pd

got_net = Network(height='750px', width='100%', bgcolor='#222222', font_color='white',heading="Graphic of manuscripts according to places (Manuscripta)")

# set the physics layout of the network
got_net.barnes_hut()
"""Open place_html.csv and read it into a dataframe"""
got_data = pd.read_csv('place_manuscripts.csv')

sources = got_data['source']
targets = got_data['target']
label_s = got_data['label_s']
label_t = got_data['label_t']

edge_data = zip(sources, targets,label_s, label_t)
"""Create a dictionary for each type of node A,B,C with color, size, and label"""
node_data = {'A': {'color': 'pink', 'label': 'A', 'size': 9000},
                'B': {'color': 'purple', 'label': 'B','widthConstraint': 400},
                'C': {'color': 'orange', 'label': 'C','font':{'size': 400}},
                'D': {'color': 'DarkRed', 'label': 'D'},
                'Universal': {'color': 'green', 'label': 'Universal'}}

for e in edge_data:
    src = e[0]
    dst = e[1]
    lab_s = e[2]
    lab_t = e[3]
    color_t=None
    color_s=None
    """Iter over each key of node_data and check if the label matchs lab_t or lab_s"""
    for key in node_data:
        #print(key, node_data[key]['label'])
        if node_data[key]['label']+' ' in lab_t:
            color_t = node_data[key]['color']
    """
    if "A " in lab_t:
        color_t="pink"
    elif "B " in lab_t:
        color_t="purple"
    elif "C " in lab_t:
        color_t="orange"
    elif "D " in lab_t:
        color_t="red"
    elif "Universal" in lab_t:
        color_t="green"
        """
        
    got_net.add_node(src, label=lab_s, color=color_s, title=lab_s, size=150)
    got_net.add_node(dst, label=lab_t, color=color_t, title=lab_t,size=150 )
    got_net.add_edge(src, dst)


# Add Legend Nodes
"""
x=-1500
y=-2000
for key in node_data:

    got_net.add_node(key, **node_data[key], shape="dot",title=node_data[key]['label'])
"""
neighbor_map = got_net.get_adj_list()
got_net.show_buttons(filter_=['physics','nodes'])
got_net.show('place_manuscripts.html')

