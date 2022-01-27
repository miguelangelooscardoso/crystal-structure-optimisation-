#! /bin/bash

[ -z "`echo $vasp_std`" ] && vasp_std="mpirun -np 8 /home/mcardoso/vasp_std_mpi"

rm SUMMARY nohup.out OSZICAR

for i in 5.102496 5.155647 5.208798 5.261949 5.3151 5.368251 5.421402 5.474553 5.527704; do
for j in 4.1328 4.17585 4.2189  4.26195  4.305  4.34805  4.3911  4.43415  4.4772 ; do

cat >POSCAR <<!
Mn2FeGa:
1.000000
    `echo "0.5*$i"|bc`    `echo "-0.86602540*$i"|bc`    0.0
    `echo "0.5*$i"|bc`    `echo " 0.86602540*$i"|bc`    0.0
     0.000000000         0.000000000         $j
   Mn   Fe   Ga
    4    2    2
Direct
     0.166666666         0.333333333         0.750000000 !T1
     0.666666666         0.833333333         0.750000000 !T2
     0.333333333         0.166666666         0.250000000 !B1
     0.833333333         0.666666666         0.250000000 !B2
     0.166666666         0.833333333         0.750000000 !T3
     0.833333333         0.166666666         0.250000000 !B3
     0.666666666         0.333333333         0.750000000 !T4
     0.333333333         0.666666666         0.250000000 !B4
!

echo "a= $i"
echo "c= $j"

$vasp_std

E=`awk '/F=/ {print $0}' OSZICAR` ; echo $i $j  $E  >>SUMMARY
done
done