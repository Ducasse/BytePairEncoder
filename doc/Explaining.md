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

- a vocabulary: `'T' 'A' 'F' 'D' 'B' '_' 'R' 'N' 'E'`
- a corpus: as shown above
- a list of consecutive pairs with the frequencies
- an empty merged list.
```
voc  	'T' 'A' 'F' 'D' 'B' '_' 'R' 'N' 'E'corpus  	#('F' 'E' 'D' '_') 2	#('B' 'R' 'E' 'A' 'D' '_') 2	#('A' 'N' 'D' '_') 1	#('T' 'E' 'D' '_') 2	#('F' 'R' 'E' 'D' '_') 2pairs  	#('N' 'D') 1	#('B' 'R') 2	#('A' 'N') 1	#('A' 'D') 2	#('F' 'E') 2	#('D' '_') 9	#('R' 'E') 4	#('E' 'A') 2	#('T' 'E') 2	#('E' 'D') 6	#('F' 'R') 2merges 
```

We see that the most frequent pair is `#('D' '_') 9`.
It will then be the one that will be fusioned. 

#### Iteration one

Now let us have a look at the situation avec the first merge. 


```
b mergeOneStep
```

We see that the most frequent pairs `#('D' '_')` got fusioned.
It means that

- It has been added to the vocabulary: Here we can 'D_' as a new element. Note that if we were encoding the characters by a number, the fusioned elements would just be a new number.
- It has been added to the merges list.
- the corpus has been updated to reflect that presence of the new vocabulary element. For example, `#('F' 'E' 'D' '_')` is not encoded as `#('F' 'E' 'D_')`.
- all the pairs have been updated using as input the updated version of the corpus. So now the most frequent pair is `#('E' 'D_')`.


```
voc  	'F' 'R' 'T' 'B' 'N' 'D_' '_' 'E' 'D' 'A'corpus  	#('F' 'E' 'D_') 2	#('A' 'N' 'D_') 1	#('B' 'R' 'E' 'A' 'D_') 2	#('T' 'E' 'D_') 2	#('F' 'R' 'E' 'D_') 2pairs  	#('E' 'D_') 6	#('B' 'R') 2	#('A' 'N') 1	#('N' 'D_') 1	#('F' 'E') 2	#('E' 'A') 2	#('R' 'E') 4	#('T' 'E') 2	#('F' 'R') 2	#('A' 'D_') 2merges 	#('D' '_')->'D_'
```

#### Iteration 2

The algorithm will repeat the same process. 
So the `#('E' 'D_')->'ED_'` is added to the merge list.
The vocabulary, corpus and pairs are updated.
```
voc  	'F' 'R' 'ED_' 'T' 'B' 'N' 'D_' '_' 'E' 'D' 'A'corpus  	#('T' 'ED_') 2	#('F' 'R' 'ED_') 2	#('A' 'N' 'D_') 1	#('B' 'R' 'E' 'A' 'D_') 2	#('F' 'ED_') 2pairs  	#('T' 'ED_') 2	#('B' 'R') 2	#('A' 'N') 1	#('N' 'D_') 1	#('R' 'E') 2	#('E' 'A') 2	#('F' 'R') 2	#('A' 'D_') 2	#('R' 'ED_') 2	#('F' 'ED_') 2merges 	#('D' '_')->'D_'	#('E' 'D_')->'ED_'
```

Now we see that there are several pairs with the highest frequency. 
The algorithm will pick one of them. 


#### Iteration 3

Here is the next iteration. `#('T' 'ED_')->'TED_'` got added to the merge list. Notice that it is the first pair of the log we present but this is just because the printing log logic uses the same bag implementation sorting logic that the one used by the algorithm when it requests the most frequent association. It is not related to the algorithm. 
Another pair of the same frequency could have been merged. 

```
voc  	'F' 'R' 'ED_' 'T' 'B' 'N' 'D_' '_' 'E' 'TED_' 'D' 'A'corpus  	#('F' 'R' 'ED_') 2	#('A' 'N' 'D_') 1	#('B' 'R' 'E' 'A' 'D_') 2	#('TED_') 2	#('F' 'ED_') 2pairs  	#('B' 'R') 2	#('A' 'N') 1	#('N' 'D_') 1	#('R' 'E') 2	#('E' 'A') 2	#('F' 'R') 2	#('A' 'D_') 2	#('R' 'ED_') 2	#('F' 'ED_') 2merges 	#('D' '_')->'D_'	#('E' 'D_')->'ED_'	#('T' 'ED_')->'TED_'
```

#### Iteration 4
Here is another iteration where the pair `#('B' 'R')` got selected. 
```
voc  	'BR' 'F' 'R' 'ED_' 'T' 'B' 'N' 'D_' '_' 'E' 'TED_' 'D' 'A'corpus  	#('F' 'R' 'ED_') 2	#('F' 'ED_') 2	#('A' 'N' 'D_') 1	#('TED_') 2	#('BR' 'E' 'A' 'D_') 2pairs  	#('BR' 'E') 2	#('A' 'N') 1	#('N' 'D_') 1	#('E' 'A') 2	#('F' 'R') 2	#('F' 'ED_') 2	#('R' 'ED_') 2	#('A' 'D_') 2merges 	#('D' '_')->'D_'	#('E' 'D_')->'ED_'	#('T' 'ED_')->'TED_'	#('B' 'R')->'BR'
```

#### Until most is done

The algorithm proceeds like explains until there is no more pairs to be merged, i.e., when the pair frequency is equal to one. 
We obtain the following situation.

```
oc  	'BR' 'BREA' 'R' 'TED_' 'ED_' 'E' 'N' 'FR' 'A' 'BRE' '_' 'F' 'D_' 'BREAD_' 'D' 'FRED_' 'FED_' 'T' 'B'corpus  	#('FRED_') 2	#('FED_') 2	#('BREAD_') 2	#('A' 'N' 'D_') 1	#('TED_') 2pairs  	#('A' 'N') 1	#('N' 'D_') 1merges 	#('D' '_')->'D_'	#('E' 'D_')->'ED_'	#('T' 'ED_')->'TED_'	#('B' 'R')->'BR'	#('BR' 'E')->'BRE'	#('BRE' 'A')->'BREA'	#('F' 'R')->'FR'	#('BREA' 'D_')->'BREAD_'	#('F' 'ED_')->'FED_'	#('FR' 'ED_')->'FRED_'
```


#### Using the merges

Now we can encode a text. The logic of this step is 
- tokenized the text. 
- go over the merge list in order and apply the merge one after the other on the result of the previous application. 
- when we are the end of the merge list we get the encoded text.

Imagine we want to encode `'FRED EATS BREAD'`
During the tokenisation phase we obtain the following list

```
'F' 'R' 'E' 'D' '_' 'E' 'A' 'T' 'S' '_' 'B' 'R' 'E' 'A' 'D_'
```

Note that we could also work at the level of word and a Bag like structure to factor the work to similar words.

Then we ask the algorithm to encode the text. We obtain the following list of elements `'FRED_' 'E' 'A' 'T' 'S' '_' 'BREAD_'`

```
self encode: 'FRED EATS BREAD' 
> an OrderedCollection('FRED_' 'E' 'A' 'T' 'S' '_' 'BREAD_')
```

What we see is that frequent words have been substituted. 
So if look at it with a numbered view, we got 

```
'ABRC' asArray collect: [ :each | each digitValue -9 ]
>  #(1 2 18 3)

'FRED EATS BREAD' asArray collect: [ :each | each digitValue -9 ] 
> #(6 18 5 4 -10 5 1 20 19 -10 2 18 5 1 4)

 'EATS_' asArray collect: [ :each | each digitValue -9 ] 
 > #(5 1 20 19 -10) 
```

Therefore, the text goes from 15 to 7 elements (because 'FRED_' and 'BREAD_' count each as one element).


## Observation on the algorithm

The execution we presented is the one of a naive and straightforward implementation. 
It rebuilds the complete set of pairs at each iteration. In addition only one pair is merged at a time. 

What this execution shows is that the vocabulary, corpus, and pairs have to be updated during each merge. 


Several pairs could be merged during the same pass if the algorithms pays attention that pairs merged at the same are not starting or ending with a similar element.

When we have the following pairs
```#('N' 'D') 1#('B' 'R') 2#('A' 'N') 1#('A' 'D') 2#('F' 'E') 2#('D' '_') 9#('R' 'E') 4#('E' 'A') 2#('T' 'E') 2#('E' 'D') 6#('F' 'R') 2
```

When merging `#('D' '_') 9`, the algorithm should not merged the pairs ending with 'D' or starting with `_` but it could merge others sur as 'R' 'E'.
Now merging several pairs at once leads to a different encodings. 


## Implementation 


