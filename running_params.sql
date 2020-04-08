cd $GGS_HOME/dirprm
export GGS_ADMIN=$GGS_HOME/../admin

echo "Host Name: `hostname` "
nslookup `crsctl stat res  xag.ggs_vip.vip -p|grep -iw USR_ORA_VIP|awk -F  "=" '{print $2}'`|grep name|awk '{print $4}'
echo " "
echo "*********************************************** "
echo "CHECKING WITH SCHEMA : $1  "
echo "*********************************************** "
fgrep  $1.* *.prm| awk '!/_CHG/ && !/SDS/ && !/--/'
echo ""
fgrep $1.* *.prm| awk '!/_CHG/ && !/SDS/ && !/--/'| awk '{print $1}'|cut -d'.' -f1|sort|uniq > found_params.txt
awk '{print $1".prm"}'  found_params.txt |cut -d':' -f3 > s_defs.txt;for i in $(cat s_defs.txt);do grep -iw sourcedefs $i;done;
echo ""
for i in $(cat found_params.txt);do echo "info $i";done > found_params.obey;cp found_params.obey $GGS_HOME/; cd $GGS_HOME
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File'
echo ""
echo "---------------------------"
echo "Checking for running params"
echo "---------------------------"
if [[ -s found_params.obey ]]; then echo ""; else echo "NO RUNNING PARAMS FOUND"; fi;
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}'
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}' > running_params.txt
cp running_params.txt running_params.obey
awk '{print "view param "$1 }' running_params.obey > found_params.obey
echo 'obey found_params.obey'|./ggsci|egrep -i 'extract|exttrail|passthru|rmthost|rmttrail'|awk '!/--/ && !/TABLE/'
echo ""
cd $GGS_ADMIN
for i in $(cat $GGS_HOME/running_params.txt);do ./repapp.pl|grep -i $i;done 
cd $GGS_HOME/dirprm/
echo ""

echo "Host Name: `hostname` "
echo " "
echo "*********************************************** "
echo "CHECKING WITH TABLE NAME : $2  "
echo "*********************************************** "
grep -i $2 *.prm| awk '!/_CHG/ && !/SDS/ && !/--/'|grep -iw $2
echo ""
grep -i $2 *.prm| awk '!/_CHG/ && !/SDS/ && !/--/'|grep -iw $2| awk '{print $1}'|cut -d'.' -f1|sort|uniq > found_params.txt
awk '{print $1".prm"}'  found_params.txt |cut -d':' -f3 > s_defs.txt;for i in $(cat s_defs.txt);do grep -iw sourcedefs $i;done;
echo ""
for i in $(cat found_params.txt);do echo "info $i";done > found_params.obey;cp found_params.obey $GGS_HOME/; cd $GGS_HOME
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File'
echo ""
echo "---------------------------"
echo "Checking for running params"
echo "---------------------------"
if [[ -s found_params.obey ]]; then echo ""; else echo "NO RUNNING PARAMS FOUND"; fi;
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}'
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}' > running_params.txt
cp running_params.txt running_params.obey
awk '{print "view param "$1 }' running_params.obey > found_params.obey
echo 'obey found_params.obey'|./ggsci|egrep -i 'extract|exttrail|passthru|rmthost|rmttrail'|awk '!/--/ && !/TABLE/'
echo ""
cd $GGS_ADMIN
for i in $(cat $GGS_HOME/running_params.txt);do ./repapp.pl|grep -i $i;done 
cd $GGS_HOME/dirprm/
echo ""
echo ""
for i in $(cat found_params.txt);do echo "info $i";done > found_params.obey;cp found_params.obey ../;cd ..; 
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File'
echo ""
echo "--------------------------"
echo "RUNNING PARAMS FOUND"
echo "--------------------------"
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}'
echo ""
echo 'obey found_params.obey'|./ggsci|egrep 'RUNNING|File' |grep RUNNING |awk '{print $2}' > running_params.txt
cp running_params.txt running_params.obey
awk '{print "view param "$1 }' running_params.obey > found_params.obey
echo 'obey found_params.obey'|./ggsci|egrep -i 'extract|exttrail|passthru|rmthost|rmttrail'|awk '!/--/ && !/TABLE/'
echo ""
cd ..;cd admin
for i in $(cat /goldengate/122/running_params.txt);do ./repapp.pl|grep -i $i;done 
cd ..
cd 122
cd dirprm
echo ""



#cd ..
#cd 122
#rm found_params.obey running_params.txt;cd dirprm;rm found_params.txt found_params.obey;rm sourcedefs.txt
