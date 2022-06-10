<< 'MULTILINE-COMMENT'
Script to collect all and only the relvant xml files for the project.

Note: Before running this script make sure you have the last version of the manuscripta data folder https://github.com/manuscripta/data and locate it in the same folder.

#Look in all the *.xml files of the ./data/data/msDescs folder
#Get the list of only the *.xml files that contain the attribute "non-swe"

MULTILINE-COMMENT
echo '../data/data/id/org/100098.xml' > file_list.txt 


echo "" > data.csv

#Look in all the non-swe_files xml files
#Run the get_tags.py on all of the xml files

cat file_list.txt | while read filexml
do
	python3 get_tags.py $filexml
done > data.csv

grep "ERROR" data.csv > data_errors.csv
#grep "[^,],[^,],[^,],[^,]$" > data_errors.csv
grep -v "ERROR" data.csv > temp
echo "source,label_s,target,label_t" > data.csv
cat temp >> data.csv

#removing locus
echo "source,label_s,target,label_t" > data_no-locus.csv
grep "http" data.csv >> data_no-locus.csv
#get every link that starts by "https://www.manuscripta.se/org" and that is @ref

# cat non-swe_files.txt | while read filexml
# do
# 	echo "\n" >> orgs.txt
# 	echo $filexml >> orgs.txt
# 	sh get_org.sh $filexml >> orgs.txt
# done
# << 'MULTILINE-COMMENT'
# #Remove the https://www.manuscripta.se/ part
# #>>https://www.manuscripta.se/org/100004
# #org/100004
# MULTILINE-COMMENT
# sed 's/https:\/\/www.manuscripta.se\///' orgs.txt > temp
# cat temp > orgs.txt
# echo "" >> idno.txt
# #
# grep "^org/" orgs.txt | while read orgxml
# do
# 	echo "\n" >> idno.txt
# 	echo $orgxml >> idno.txt
# 	sh get_idno.sh data/data/id/$orgxml.xml >> idno.txt
# done
