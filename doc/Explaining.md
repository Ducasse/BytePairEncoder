# Understanding Byte Pair Encoding

The idea of the algorithm is to represent the most frequent pairs with dedicated markers. Doing so, it identifies the most frequent sequences of elements (characters). Then using this information it can encode texts. 



## Core logic 

The logic of the algorithm is illustrated by the following steps. 

- Builds a vocabulary from a corpus of words.
- Identification of the most frequent pair: Count symbol‑pairs and pick the most frequent one.
- Produce a new vocabulary element for the most frequent pair. 
Merge the most frequent pair into a new vocabulary element and update the corpus to reflect this new element. 
- Loop to step 2 until you reach a target number of merges. 
- Stores the merge table.
- Encode a string using the merge table. 


## Going over an example

```
b := BytePairEncoder new.
b fromText: 'FRED FED TED BREAD, AND TED FED FRED BREAD'.
```


### Checking the words. 

First once we tokenize the input text we get the following vocabulary.

```
corpus  	#('F' 'E' 'D' '_') 2	#('B' 'R' 'E' 'A' 'D' '_') 2	#('A' 'N' 'D' '_') 1	#('T' 'E' 'D' '_') 2	#('F' 'R' 'E' 'D' '_') 2
```

When we look at the system we get the following: 

- a vocabulary: 'T' 'A' 'F' 'D' 'B' '_' 'R' 'N' 'E'
- a corpus: as shown above
- a list of consecutive pairs with the frequencies
- an empty merged list.
```
voc  	'T' 'A' 'F' 'D' 'B' '_' 'R' 'N' 'E'corpus  	#('F' 'E' 'D' '_') 2	#('B' 'R' 'E' 'A' 'D' '_') 2	#('A' 'N' 'D' '_') 1	#('T' 'E' 'D' '_') 2	#('F' 'R' 'E' 'D' '_') 2pairs  	#('N' 'D') 1	#('B' 'R') 2	#('A' 'N') 1	#('A' 'D') 2	#('F' 'E') 2	#('D' '_') 9	#('R' 'E') 4	#('E' 'A') 2	#('T' 'E') 2	#('E' 'D') 6	#('F' 'R') 2merges 
```

#### Iteration one

```
voc  	'F' 'R' 'T' 'B' 'N' 'D_' '_' 'E' 'D' 'A'corpus  	#('F' 'E' 'D_') 2	#('A' 'N' 'D_') 1	#('B' 'R' 'E' 'A' 'D_') 2	#('T' 'E' 'D_') 2	#('F' 'R' 'E' 'D_') 2pairs  	#('E' 'D_') 6	#('B' 'R') 2	#('A' 'N') 1	#('N' 'D_') 1	#('F' 'E') 2	#('E' 'A') 2	#('R' 'E') 4	#('T' 'E') 2	#('F' 'R') 2	#('A' 'D_') 2merges 	#('D' '_')->'D_'
```

#### Iteration 2

```
voc  
	't' 'r' 'e' 'es' 't_' '_' 's' 'o' 'z'
corpus  
	#('r' 'es' '_') 1
	#('r' 'es' 't_') 1
	#('es' 't_') 2
	#('es' 's' '_') 1
	#('o' 's' 'z' '_') 1
	#('o' 's' 't_') 1
pairs  
	#('s' '_') 1
	#('z' '_') 1
	#('s' 't_') 1
	#('s' 'z') 1
	#('o' 's') 2
	#('r' 'es') 2
	#('es' 's') 1
	#('es' '_') 1
	#('es' 't_') 3
merges 
	#('e' 's')->'es'
	#('t' '_')->'t_'
```

#### Iteration 3

```
voc  
	'est_' 'r' 'o' 'z' 't' 't_' 'e' '_' 'es' 's'
corpus  
	#('est_') 2
	#('o' 's' 'z' '_') 1
	#('o' 's' 't_') 1
	#('es' 's' '_') 1
	#('r' 'es' '_') 1
	#('r' 'est_') 1
pairs  
	#('s' '_') 1
	#('s' 't_') 1
	#('z' '_') 1
	#('s' 'z') 1
	#('o' 's') 2
	#('r' 'es') 1
	#('es' 's') 1
	#('r' 'est_') 1
	#('es' '_') 1
merges 
	#('e' 's')->'es'
	#('t' '_')->'t_'
	#('es' 't_')->'est_'
```

#### Iteration 4

```
voc  
	'est_' 'r' 'o' 'z' 't' 't_' 'e' '_' 'es' 's'
corpus  
	#('est_') 2
	#('o' 's' 'z' '_') 1
	#('o' 's' 't_') 1
	#('es' 's' '_') 1
	#('r' 'es' '_') 1
	#('r' 'est_') 1
pairs  
	#('s' '_') 1
	#('s' 't_') 1
	#('z' '_') 1
	#('s' 'z') 1
	#('o' 's') 2
	#('r' 'es') 1
	#('es' 's') 1
	#('r' 'est_') 1
	#('es' '_') 1
merges 
	#('e' 's')->'es'
	#('t' '_')->'t_'
	#('es' 't_')->'est_'
```

#### Until most is done

```
voc  
	'est_' 'r' 'o' 'z' 't' 't_' 'os' 'e' '_' 'es' 's'
corpus  
	#('r' 'est_') 1
	#('os' 'z' '_') 1
	#('os' 't_') 1
	#('es' 's' '_') 1
	#('r' 'es' '_') 1
	#('est_') 2
pairs  
	#('s' '_') 1
	#('os' 'z') 1
	#('z' '_') 1
	#('r' 'est_') 1
	#('es' 's') 1
	#('r' 'es') 1
	#('es' '_') 1
	#('os' 't_') 1
merges 
	#('e' 's')->'es'
	#('t' '_')->'t_'
	#('es' 't_')->'est_'
	#('o' 's')->'os'


#### Using the merges

Now we can encode a text





### Links

https://www.youtube.com/watch?v=BcxJk4WQVIw

