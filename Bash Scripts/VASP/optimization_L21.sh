#! /bin/bash

BIN=/home/mcardoso/vasp_std_mpi

for i in 5.514413188 5.533494355 5.552444826 5.571266816 5.589962393 5.608533923 5.626983181 5.645312246 5.663523056; do

cat >POSCAR<<!
Fe2 Mn Si  [CUB,CUB,cP16] (STD_CONV doi:10.1016/j.commatsci.2010.05.010)
$i
   1.00000000000000   0.00000000000000   0.00000000000000
   0.00000000000000   1.00000000000000   0.00000000000000
   0.00000000000000   0.00000000000000   1.00000000000000
Mn Fe Si 
4 8 4 
Direct(16) [A4B8C4] 
   0.00000000000000   0.00000000000000   0.00000000000000  Mn    
   0.50000000000000   0.50000000000000   0.00000000000000  Mn    
   0.50000000000000   0.00000000000000   0.50000000000000  Mn    
   0.00000000000000   0.50000000000000   0.50000000000000  Mn    
   0.24999999900000   0.24999999900000   0.25000000100000  Fe    
   0.74999999900000   0.74999999900000   0.25000000100000  Fe    
   0.74999999900000   0.24999999900000   0.75000000100000  Fe    
   0.24999999900000   0.74999999900000   0.75000000100000  Fe    
   0.75000002700000   0.24999997800000   0.24999999200000  Fe    
   0.25000002700000   0.74999997800000   0.24999999200000  Fe    
   0.25000002700000   0.24999997800000   0.74999999200000  Fe    
   0.75000002700000   0.74999997800000   0.74999999200000  Fe    
   0.99999999850000   0.49999999750000   0.00000000200000  Si    
   0.49999999850000   0.99999999750000   0.00000000200000  Si    
   0.49999999850000   0.49999999750000   0.50000000200000  Si    
   0.99999999850000   0.99999999750000   0.50000000200000  Si   
!
echo "a= $i"
mpirun -np 8 $BIN & 
#nohup command does not work on script it must be used directly on terminal

E=`awk '/F=/ {print $0}' OSZICAR` ; echo $i $E  >>SUMMARY
done
