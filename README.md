# SizeHisto
sizehisto.sh è un semplice script per shell bash che data una cartella elenca il numero di file per ciascuna dimensione potenza di due. Lo script permette di selezionare l'estensione dei file di interesse, la cartella da analizzare e la dimensione delle colonne dell'istogramma.

## Installazione
Per utilizzare questo script è necessario eseguire i seguenti passaggi:
1. Copiare il file [sizehisto.sh](src/sizehisto.sh) sul proprio pc
2. Abilitare il file per l'esecuzione eseguendo il comando `chmod +x sizehisto.sh`

Per lanciare lo script è sufficiente eseguire `./sizehisto.sh`

Durante l'analisi delle sottocartelle è visibile un contatore che mostra il numero di file analizzati.

![immagine2](/immagini/example_search.png)

> [!NOTE]
> Lo script potrebbe richiedere tempi considerevoli per l'analisi di aree di memoria di grandi dimensioni.

## Funzionamento
Lo script può essere lanciato specificando la cartella da analizzare.

``` 
./sizehisto.sh [OPTIONS] <directory>
```
Le opzioni disponibili sono le seguenti:
- `-e` estensione dei file da considerare durante l'analisi. Se specificato soltanto i file con questa estensione saranno considerati.
- `-m` massima lunghezza delle colonne dell'istogramma (in caratteri).
- `--help` dettagli sul funzionamento dello script e le opzioni.

## Esempi
Eseguendo il seguente comando si può ottenere l'output mostrato in figura `./sizehisto -m 20 /home`

![immagine1](/immagini/example_result.png)

