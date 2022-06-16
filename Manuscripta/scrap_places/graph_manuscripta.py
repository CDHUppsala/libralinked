from pyvis.network import Network
import pandas as pd

got_net = Network(height='750px', width='100%', bgcolor='#222222', font_color='white')

# set the physics layout of the network
got_net.barnes_hut()
"""Open place_html.csv and read it into a dataframe"""
got_data = pd.read_csv('place_manuscripts.csv')

sources = got_data['source']
targets = got_data['target']
label_s = got_data['label_s']
label_t = got_data['label_t']

edge_data = zip(sources, targets,label_s, label_t)

for e in edge_data:
    src = e[0]
    dst = e[1]
    lab_s = e[2]
    lab_t = e[3]
    color_t=None
    color_s=None
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
    got_net.add_node(src, label=lab_s, color=color_s, title=lab_s)
    got_net.add_node(dst, label=lab_t, color=color_t, title=lab_t)
    got_net.add_edge(src, dst)

neighbor_map = got_net.get_adj_list()
got_net.show_buttons(filter_=['physics'])
got_net.show('place_manuscripts.html')

