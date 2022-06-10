#Based on the issue: https://gitlab.com/mardub/libralinked/-/issues/7
import sys
import os
import xml.etree.ElementTree as ET
# Import BeautifulSoup

content = []

from bs4 import BeautifulSoup
#  #get the file name as argument name it $1
file_name = sys.argv[1]

#Get the desired nodes from the manuscript description XML
tag_list=["sponsor","funder","persName","Licence","country","settlement","institution","repository","title","placeName","orgName","licence"]
infile = open(file_name,"r")
contents = infile.read()
soup = BeautifulSoup(contents,'xml')
#Extract the first title to make it the source name for all the nodes of this xml
title=soup.find_all('title')[0].text
entities=[]
def clean(text):
    """
    Replace comma by _
    """
    return text.replace(",",":")
def get_manuscript_id(text):
    """
    Get the manuscript id from the XML
    """
    return text.split(",")[-1].strip().replace(" ","-")

def remove_commas(text):
    """
    Remove commas from the text
    """
    return text.replace(",","__")



manu_id=get_manuscript_id(title)
for tag in tag_list:
    entity=soup.find_all(tag)
    entities.append(entity)

def make_raw_locus(node,attributes,manu_id=manu_id):
    label_source=""
    for attrib in attributes:
        label_source=label_source+"_"+node[attrib]
    locus=manu_id+"_"+label_source.replace(" ","_")
    raw=clean(title)+"SEPARATOR"+file_name.split("/")[-1]+"SEPARATOR"+locus+"SEPARATOR"+node["from"]
    raw=remove_commas(raw)
    raw=raw.replace("SEPARATOR",",")
    return raw


for entity in entities:
    for node in entity:
        try:
            
            raw=clean(title)+"SEPARATOR"+file_name.split("/")[-1]+"SEPARATOR"+node['ref']+"SEPARATOR"+clean(node.get_text())
            raw=remove_commas(raw)
            raw=raw.replace("SEPARATOR",",")

            print(raw)

        except:
            try:

                raw=clean(title)+"SEPARATOR"+file_name.split("/")[-1]+"SEPARATOR"+node['target']+"SEPARATOR"+clean(node.get_text())
                raw=remove_commas(raw)
                raw=raw.replace("SEPARATOR",",")
                print(raw)
            except:
                #print(raw+" bruel bruel")
                print("NODE ERROR on the following tag,",node)
#Handling the exceptions of Locus
entity= soup.find_all('locus')
for node in entity:
    #print(node)
    try:
        raw = make_raw_locus(node,["from","to"])
        # locus=manu_id+"_"+node['from'].replace(" ","_")
        # raw=clean(title)+"SEPARATOR"+file_name.split("/")[-1]+"SEPARATOR"+locus+"SEPARATOR"+node['from']
        # raw=remove_commas(raw)
        # raw=raw.replace("SEPARATOR",",")
        print(raw)
    except:
        raw = make_raw_locus(node,["from"])
        try:
            raw = make_raw_locus(node,["to"])
        except:
            #print(raw)
            print("NODE ERROR on the following tag,",node)



#TODO: GOOD we manage to get the sponsor name and the sponsor ref! Hurraayy now make it a 
#function to return it for any kind of tag output the line "source,label,target,label"
#TODO: Good the output is correct now make it for all the tags and link it to the main script, then we will see.
#TODO: good output correct locus handled now link it to the main script.

# #print content of the file
# def print_content(file_name):
#     """
#     prints the content of the file
#     """
#     with open(file_name) as f:
#         for line in f:
#             print(line,end="")
# print_content(file_name)
# #open xml file and read it
# tree = ET.parse(file_name)


# print(tree)
# print(tree.iterfind('.//change'))
# foo=tree.iterfind('.//change')
# for x in foo:
#     print(x)
