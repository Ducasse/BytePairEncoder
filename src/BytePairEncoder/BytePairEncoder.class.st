"
I implement the Byte-Pair Encoding: Subword-based tokenization algorithm as defined in A New Algorithm for Data Compression but adapted to NLP as defined in ""Neural Machine Translation of Rare Words with Subword Units""
by Rico Sennrich and Barry Haddow and Alexandra Birch.

BPE is a simple form of data compression algorithm in which the most common pair of consecutive bytes of data is replaced with a byte that does not occur in that data. It was first described in the article ""A New Algorithm for Data Compression"" published in 1994. 

Suppose we have data aaabdaaabac which needs to be encoded (compressed). The byte pair aa occurs most often, so we will replace it with Z as Z does not occur in our data. So we now have ZabdZabac where Z = aa. The next common byte pair is ab so let’s replace it with Y. We now have ZYdZYac where Z = aa and Y = ab. The only byte pair left is ac which appears as just one so we will not encode it. We can use recursive byte pair encoding to encode ZY as X. Our data has now transformed into XdXac where X = ZY, Y = ab, and Z = aa. It cannot be further compressed as there are no byte pairs appearing more than once. We decompress the data by performing replacements in reverse order. 

A variant of this is used in NLP that use the merge rules to tokenise text.


### Basic steps
The algorithm is the following: 

- Step 1. Represent each word in the corpus as a combination of the characters terminating with a end marker _. We keep a bag to just have to operate on a single representative e.g. `{'low': 5}` to say that `'low'` is present 5 times in the corpus.
- Step 2. Iteratively count adjacent character pairs in all words of the corpus.
- Step 3. Identify the most frequent pair. If several pairs have the same frequency pick one. 
- Step 4. Replace the most frequent pair with a new n-gram and add this to the ordered merge list. Add the new character n-gram to the vocabulary. Update all the words of the corpus to reflect the fact that the new frequent pair got added to the vocabulary. It means that once we udpate the words we just have to rebuild the adjency pairs.
- Step 4. Repeat step 3 until the desired number of merge operations are completed or the desired vocabulary size is achieved.

Once these steps are performed, we have an extended vocabulary and a list of merges.
Given a new word look into the merge list in order for the ones that match and apply them one by one in order and we get the new word tokenised.


### Notes
We cannot simply update the pairs because the pairs represent a local information and just updating them is not possible.

Imagine that we have 

```
ost
est
...
```
and the adjancy rules

```
e~s
s~t
```

If we merge `e~s` into `es`, we cannot replace `s~t` by `es~t` because `s~t` comes from both `est` and `ost`. 

### Implementation

The current implementation is super naive.  Not a single optimization. 
Read [https://guillaume-be.github.io/2021-09-16/byte_pair_encoding](https://guillaume-be.github.io/2021-09-16/byte_pair_encoding) for possible optimization. 

#### Instance variables
- words: the corpus (the text) is represented as a bag
- vocabulary: we keep the vocabulary as a Set but it could be anOrderedCollection. The vocabulary does not contain characters but string because in the merge phase we have sequences of characters.
- pairs: is a bag containing the adjacent pairs found in the corpus and their frequencies. It holds OrderedCollection and not strings to be able to add merged tokens (`e~s` e followed by s should be replaced by a new characted `es`).







"
Class {
	#name : 'BytePairEncoder',
	#superclass : 'Object',
	#instVars : [
		'words',
		'pairs',
		'vocabulary',
		'merges'
	],
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'examples' }
BytePairEncoder class >> example [
	| enc |
	enc := self new fromText: ('BytePairEncoder' asPackage selectors asOrderedCollection joinUsing: ' ').
	100 timesRepeat: [ enc mergeOneStep  ].
	^ enc inspect
]

{ #category : 'examples' }
BytePairEncoder class >> example2 [
	| enc |
	enc := self new fromText: ('BytePairEncoder' asPackage selectors asOrderedCollection joinUsing: ' ').
	100 timesRepeat: [ enc mergeOneStep  ].
	^ enc inspect
]

{ #category : 'merges' }
BytePairEncoder >> addToMergesPair: aPair mergedInto: newItem [ 
	"the pair, aPair has been merged into newItem"
	
	merges add: aPair -> newItem
]

{ #category : 'vocabulary' }
BytePairEncoder >> addToVocabulary: aString [
	
	vocabulary add: aString
	
]

{ #category : 'compute' }
BytePairEncoder >> computePairs [
	
	pairs := Bag new.
	words associationsDo: [ :association | 
		| word |
		word := association key.
		word overlappingPairsWithIndexDo: [ :a :b :index | 
		   pairs add:  { a . b } withOccurrences: association value ]
		 ] 
]

{ #category : 'vocabulary' }
BytePairEncoder >> computeVocabulary [
	"we do not add characters but string because in the merge phase we will have sequences of characters."
	
	words do: [ :each | each do: [ :aChar | self addToVocabulary: aChar asString ]].
	
]

{ #category : 'api' }
BytePairEncoder >> encode: aString [
	"this encoding does not considering overlapping merges. 
	
	if we have 
		a,b -> 1
		b,c -> 2	
	and a string
		abc 
			it will produce 
				1c
			and not 12
	"
	| wrds |
	wrds := (self textToWords: aString) flatCollect: [ :each | each  ].
	wrds := wrds asOrderedCollection.
	
	merges do: [ :aMerge |
			| key first second rempl i |
			key := aMerge key.
			first := key first.
			second := key second.
			rempl := aMerge value. 
			i := 1.
			[ i < wrds size ] whileTrue: [  
				(((wrds at: i) = first) 
					and: [ (wrds at: i + 1) = second ])
					ifTrue: [ wrds removeAt: i; at: i put: rempl.
						i := i + 1].
						i := i + 1 ].
			].
	^ wrds
	

]

{ #category : 'accessing' }
BytePairEncoder >> frequencyOfWord: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : 'api' }
BytePairEncoder >> fromText: aString [
	"Prepare all the information for a text.
	If you want to add multiple text elements use prepareWordsFromText:..."
	
	self prepareWordsFromText: aString.
	self computeVocabulary.
	self computePairs.
	

]

{ #category : 'initialization' }
BytePairEncoder >> initialize [

	super initialize.
	words := Bag new. 
	"We use a bag so that we can have the occurrences at the world level."

	vocabulary := Set new.
	merges := OrderedCollection new
]

{ #category : 'printing' }
BytePairEncoder >> inspection: aBuilder [

	<inspectorPresentationOrder: -1 title: 'Summary'>

	^ (aBuilder instantiate: SpTextPresenter) text: self printString
]

{ #category : 'merges' }
BytePairEncoder >> mergeOneStep [
	
	| newVocabularyItem pair |
	pair := pairs sortedCounts first value.
	newVocabularyItem := pair first, pair second. 
	self addToVocabulary: newVocabularyItem.
	self addToMergesPair: pair mergedInto: newVocabularyItem.
	self updateCorpusFrom: pair to: newVocabularyItem.
	self computePairs.
	
]

{ #category : 'accessing' }
BytePairEncoder >> merges [

	^ merges
]

{ #category : 'accessing' }
BytePairEncoder >> numberOfPairs [
	
	^ pairs keys size
]

{ #category : 'accessing' }
BytePairEncoder >> occurrencesOf: aString [ 
	^ words occurrencesOf: aString 
]

{ #category : 'only for tests' }
BytePairEncoder >> pairOccurrencesOf: aString [ 
	
	^ pairs occurrencesOf: aString
]

{ #category : 'only for tests' }
BytePairEncoder >> pairs [

	^ pairs
]

{ #category : 'api' }
BytePairEncoder >> prepareWith: aText andEncode: aString [

	self fromText: aText.
	self untilAllProcessed.
	 
	
]

{ #category : 'compute' }
BytePairEncoder >> prepareWordsFromText: aText [
	"Split the text into words. Then build the corpus of words by representing a word as a collection of strings.
	Use _ to represent end of world for space and others.
	'low' is represented as #('l' 'o' 'w'). The reason that during the merge of pairs for example 'o' followed by 'w' the words have to be updated to mark this merge. #('l' 'o' 'w') becoming then #('lo' 'w')"

	words addAll: (self textToWords: aText)
]

{ #category : 'printing' }
BytePairEncoder >> printOn: aStream [

	aStream 
		nextPutAll: 'voc  '; cr;
		tab.
	vocabulary do: [ :each | aStream print: each ] separatedBy: [ aStream space ]. 
		
	aStream cr.
		aStream 
		nextPutAll: 'corpus  '; cr.
	words keysAndValuesDo: [ :k :v | aStream tab ; print: k asArray; space ; print: v ; cr ].

	aStream nextPutAll: 'pairs  '; cr.
	pairs keysAndValuesDo: [ :k :v | aStream tab;  print: k; space ; print: v ; cr ].
	aStream 
		nextPutAll: 'merges '; cr.
	merges do: [ :each | aStream tab ; print: each ] separatedBy: [ aStream cr ]. 
	aStream cr.
]

{ #category : 'compute' }
BytePairEncoder >> textToWords: aText [
	"Split the text into words. Then turn a word as a collection of strings."

	| rawWords |
	rawWords := aText substrings: {
			            Character space.
			            Character cr.
			            Character tab . $. . $? .$! .$: . $;}.
	^ (rawWords collect: [ :each |
				 | col |
				 col := OrderedCollection new: each size + 1.
				 each do: [ :aChar | col add: aChar asString ].
				 col add: '_'.
				 col ])
]

{ #category : 'vocabulary' }
BytePairEncoder >> uniqueWords [

	^ words keys
]

{ #category : 'api' }
BytePairEncoder >> untilAllProcessed [
	
	[ ( pairs sortedCounts first key > 1 ) and: [ pairs size > 2 ] ] 
		whileTrue: [ self mergeOneStep ] 
	

]

{ #category : 'merges' }
BytePairEncoder >> updateCorpusFrom: pair to: newVocabularyItem [

	| bag |
	bag := Bag new.
	words keys copy do: 
		[ :word |
			bag 
				add: (word copyReplaceAll: pair with: {newVocabularyItem}) 
				withOccurrences: (words occurrencesOf: word)
		].
	words := bag
]

{ #category : 'vocabulary' }
BytePairEncoder >> vocabulary [

	^ vocabulary
]

{ #category : 'vocabulary' }
BytePairEncoder >> vocabularySize [

	^ vocabulary size
]

{ #category : 'vocabulary' }
BytePairEncoder >> words [ 

	^ words
]
