import requests
from bs4 import BeautifulSoup


def get_urls(file_name):
    """
    Transform orgs.txt into a list of links to the orgs' websites.
    """
    with open(file_name) as f:
        return f.read().splitlines()
orgs=get_urls('orgs.txt')

"""
Create a csv called org_html.csv with 4 columns:
"source,label_s,target,label_t"
"""
with open('org_html.csv', 'w') as f:
    f.write('source,label_s,target,label_t\n')

def clean_commas(string):
    """
    Remove commas and newlines from a string.
    """
    return string.replace(',', '__').replace('\n', '')

for org in orgs:
    """
    Scrap all the hyperlinks <a> and the hypertexts of the org's website and save then in a file.
    """
    r = requests.get(org)
    soup = BeautifulSoup(r.text, 'html.parser')
    with open('org_html.csv', 'a') as f:
        """get the title h2 of the org's website"""
        title = soup.find('h2').text
        for link in soup.find_all('a'):
            source=clean_commas(org)
            label_s= clean_commas(title)
            target=clean_commas( link.get('href'))
            label_t= clean_commas( link.text)
            """ add the following line to the csv file"""
            if source+".xml"==label_t:
                continue
            else:
                f.write(source+','+label_s+','+target+','+label_t+'\n')

#clean the org_html.csv file


    #print(org)
orgxml=org.split('/')[-1]+'.xml'
    #print(orgxml)
