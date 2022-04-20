
import sys
import os
import xml.etree.ElementTree as ET
# Import BeautifulSoup

content = []

from bs4 import BeautifulSoup
#  #get the file name as argument name it $1
file_name = sys.argv[1]


tag_list=["sponsor","funder"]
infile = open(file_name,"r")
contents = infile.read()
soup = BeautifulSoup(contents,'xml')
title=soup.find_all('title')[0].text
entities=[]

for tag in tag_list:
    entity=soup.find_all(tag)
    entities.append(entity)

for entity in entities:
    for node in entity:
        

        print(title,",",file_name,",",node['ref'],",",node.get_text())


#TODO: GOOD we manage to get the sponsor name and the sponsor ref! Hurraayy now make it a 
#function to return it for any kind of tag output the line "source,label,target,label"


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
