#!/bin/bash

gmx trjconv -f md_0_1.trr -s md_0_1.tpr -o md_0_1noPBC.trr -pbc mol -ur compact <<EOF
1
EOF

gmx rms -f md_0_1noPBC.trr -s md_0_1.tpr -o rmsd.xvg -tu ns <<EOF
4
4
EOF

gmx rmsf -f md_0_1noPBC.trr -s md_0_1.tpr -oq bfactor.pdb -ox bfactor_average.pdb -res <<EOF
2
EOF

gmx trjconv -f md_0_1noPBC.trr  -s md_0_1.tpr -o filme.pdb -ur compact -center -pbc mol <<EOF
2
2
EOF

gmx gyrate -f md_0_1noPBC.trr -s md_0_1.tpr -o raio_giracao.xvg <<EOF
1
EOF

gmx hbond -f md_0_1noPBC.trr -s md_0_1.tpr -hbm hmap.xpm -hbn hbond.ndx -b 1 -e 10000 <<EOF
1
1
EOF

gmx do_dssp -f md_0_1noPBC.trr -s md_0_1.tpr -tu ns <<EOF
1
EOF

gmx sasa md_0_1noPBC.trr -s md_0_1.tpr -tu ns <<EOF
1
EOF

gmx xpm2ps -f ss.xpm -o ss.eps -by 5

ps2pdf ss.eps ss.pdf

