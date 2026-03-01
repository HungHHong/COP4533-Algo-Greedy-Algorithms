#!/bin/bash

mkdir -p data

echo "Creating seq1..."
printf "3 50\n" > data/seq1.txt
yes "1 2 3 4 5" | head -n 10 | tr '\n' ' ' >> data/seq1.txt
echo >> data/seq1.txt

cat <<EOF > data/seq1_result.txt
FIFO : 50
LRU : 50
OPTFF : 27
EOF


echo "Creating seq2..."
printf "4 56\n" > data/seq2.txt
yes "1 2 3 4 5 6 7 8" | head -n 7 | tr '\n' ' ' >> data/seq2.txt
echo >> data/seq2.txt

cat <<EOF > data/seq2_result.txt
FIFO : 56
LRU : 56
OPTFF : 35
EOF


echo "Creating seq3..."
cat <<EOF > data/seq3.txt
3 60
1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6 4 5 6
EOF

cat <<EOF > data/seq3_result.txt
FIFO : 6
LRU : 6
OPTFF : 6
EOF


echo "Creating seq4..."
cat <<EOF > data/seq4.txt
3 60
1 2 3 4 1 2 5 1 2 3 4 5 1 2 3 4 1 2 5 1 2 3 4 5 1 2 3 4 1 2 5 1 2 3 4 5 1 2 3 4 1 2 5 1 2 3 4 5 1 2 3 4 1 2 5 1 2 3 4 5
EOF

cat <<EOF > data/seq4_result.txt
FIFO : 45
LRU : 50
OPTFF : 31
EOF


echo "Creating seq5..."
cat <<EOF > data/seq5.txt
5 54
1 3 5 7 9 2 4 6 8 10 1 2 3 4 5 6 7 8 9 10 1 1 2 2 3 3 4 4 5 5 6 7 8 9 10 9 8 7 6 5 4 3 2 1 10 10 9 9 8 8 7 7 6 6
EOF

cat <<EOF > data/seq5_result.txt
FIFO : 40
LRU : 40
OPTFF : 26
EOF

echo "Done. Files created in data/"
