#!/bin/bash
# sizehisto.sh è un semplice script per shell bash che data una cartella elenca il numero di file per ciascuna dimensione potenza di due. 
# Lo script permette di selezionare l'estensione dei file di interesse, la cartella da analizzare e la dimensione delle colonne dell'istogramma.

if [ $1 = "--help" ]; then
	printf "Usage: $0 [OPTIONS] <directory>\nElenca il numero di file presenti in tutte le cartelle e sottocartelle di <directory> per ciascuna dimensione potenza di due.\n\nOpzioni\n\t-e\t\tseleziona l'estensione di interesse\n\t-m\t\tmassima altezza delle colonne, come numero di caratteri\n\t--help\t\tinformazioni sul programma\n"
	exit 1
fi

ext=''
max_l=100

while getopts e:m: flag
do
    case "${flag}" in
        e) ext=${OPTARG};;
        m) max_l=${OPTARG};;
    esac
done

shift $((OPTIND - 1))  # rename args to after params

if ! [ -d "$1" ]; then
	echo "Usage: $0 <directory>"
	exit 1
fi

dir="$1"

declare -A histogram

for ((i=0; i<120; i++)); do
	histogram[$i]=0
done

max_c=0

n_files=0
while IFS= read -r -d '' file; do
	if [ -n "$ext" ] && [[ ! "$file" =~ \.$ext$ ]];  # select extension
		then continue
	fi;
	((n_files++))
	printf "File analizzati: %d\r" $n_files

	
	size=$(stat -c %s "$file")

	if [ $size -gt 0 ]; then
		bin=0
		while [ $((2 ** bin)) -lt "$size" ] && [ "$bin" -lt 120 ]; do
            ((bin++))
		done
		((histogram[$bin]++))
		if [ ${histogram[$bin]} -gt $max_c ]; then
			max_c=${histogram[$bin]}
		fi
	fi
done < <(find "$dir" -type f -print0)


echo "Dimensione Files | Numero di Files"
echo "----------------------------------"
for ((i=0; i<120; i++)); do
	val=${histogram[$i]}
	if [ $val -gt 0 ]; then
		yval=$(( $max_l * $val / $max_c +1 ))
		printf "2^%-2s (%-8.1eB) | " "$i" $((2 ** i))
		for ((n=0; n<$yval; n++)); do
			printf "x"
		done
		printf " ($val)\n" 
	fi
done



