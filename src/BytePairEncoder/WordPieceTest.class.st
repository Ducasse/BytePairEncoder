Class {
	#name : 'WordPieceTest',
	#superclass : 'TestCase',
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'tests' }
WordPieceTest >> testComputeLetterFrequency [ 

	|w b|
	b := Bag new .
	w := WordPiece new .
	w prepareWordsFromText: self text .
	w computeLetterFrequency .
	b add: '##T'  withOccurrences: 3 .
	b add: '##h'  withOccurrences: 8 .
	b add: '##i'  withOccurrences: 11 .
	b add: '##s'  withOccurrences: 10 .
	b add: 'i'  withOccurrences: 2 .
	b add: 't'  withOccurrences: 7 .
	b add: '"'  withOccurrences: 8 .
	b add: '##e'  withOccurrences: 21 .
	b add: 'H'  withOccurrences: 1 .
	b add: '##H'  withOccurrences: 1 .
	b add: '##u'  withOccurrences: 5 .
	b add: '##g'  withOccurrences: 4 .
	b add: '##n'  withOccurrences: 11 .
	b add: 'F'  withOccurrences: 1 .
	b add: '##a'  withOccurrences: 7 .
	b add: '##c'  withOccurrences: 2 .
	b add: 'C'  withOccurrences: 1 .
	b add: '##o'  withOccurrences: 13 .
	b add: '##r'  withOccurrences: 9 .
	b add: '##,'  withOccurrences: 5 .
	b add: 'c'  withOccurrences: 1 .
	b add: '##p'  withOccurrences: 2 .
	b add: '##t'  withOccurrences: 7 .
	b add: 'a'  withOccurrences: 5 .
	b add: '##b'  withOccurrences: 2 .
	b add: '##k'  withOccurrences: 3 .
	b add: '##z'  withOccurrences: 2 .
	b add: 's'  withOccurrences: 3 .
	b add: '##w'  withOccurrences: 2 .
	b add: '##v'  withOccurrences: 1 .
	b add: '##l'  withOccurrences: 7 .
	b add: '##m'  withOccurrences: 1 .
	b add: '##f'  withOccurrences: 1 .
	b add: '##y'  withOccurrences: 2 .
	b add: 'y'  withOccurrences: 1 .
	b add: 'w'  withOccurrences: 1 .
	b add: 'b'  withOccurrences: 1 .
	b add: 'u'  withOccurrences: 1 .
	b add: '##d'  withOccurrences: 4 .
	b add: 'h'  withOccurrences: 1 .
	b add: 'g'  withOccurrences: 1 .
	 
	self assert: w letterFrequency equals: b .
]

{ #category : 'tests' }
WordPieceTest >> testComputePairs [ 

|w d|
d := Dictionary new .
w := WordPiece new .
w fromText: self text .
w computePairs .
d add: { '"' . '##T' }-> (3/(8*3)) .
d add: { '##T' . '##h' }-> (3/(3*8)) .
d add: { '##h' . '##i' }-> (3/(8*11)) .
d add: { '##i' . '##s' }-> (3/(10*11)) .
d add: { 'i' . '##s' }-> (2/(10*2)) .
d add: { 't' . '##h' }-> (2/(7*8)) .
d add: { '##h' . '##e' }-> (2/(8*21)) .
d add: { 'H' . '##u' }-> (1/(1*5)) .
d add: { '##u' . '##g' }-> (1/(5*4)) .
d add: { '##g' . '##g' }-> (1/(4*4)) .
d add: { '##g' . '##i' }-> (1/(4*11)) .
d add: { '##i' . '##n' }-> (2/(11*11)) .
d add: { '##n' . '##g' }-> (1/(11*4)) .
d add: { 'F' . '##a' }-> (1/(1*7)) .
d add: { '##a' . '##c' }-> (1/(2*7)) .
d add: { '##c' . '##e' }-> (1/(2*21)) .
d add: { 'C' . '##o' }-> (1/(1*13)) .
d add: { '##o' . '##u' }-> (3/(13*5)) .
d add: { '##u' . '##r' }-> (1/(5*9)) .
d add: { '##r' . '##s' }-> (2/(9*10)) .
d add: { '##s' . '##e' }-> (1/(10*21)) .
d add: { '"' . '##,' }-> (4/(8*5)) .
d add: { 'c' . '##h' }-> (1/(1*8)) .
d add: { '##h' . '##a' }-> (1/(8*7)) .
d add: { '##a' . '##p' }-> (1/(7*2)) .
d add: { '##p' . '##t' }-> (1/(2*7)) .
d add: { '##t' . '##e' }-> (2/(7*21)) .
d add: { '##e' . '##r' }-> (5/(21*9)) .
d add: { 'a' . '##b' }-> (2/(5*2)) .
d add: { '##b' . '##o' }-> (1/(2*13)) .
d add: { '##u' . '##t' }-> (1/(5*7)) .
d add: { 't' . '##o' }-> (4/(7*13)) .
d add: { '##o' . '##k' }-> (3/(13*3)) .
d add: { '##k' . '##e' }-> (3/(3*21)) .
d add: { '##e' . '##n' }-> (4/(21*11)) .
d add: { '##n' . '##i' }-> (2/(11*11)) .
d add: { '##i' . '##z' }-> (2/(11*2)) .
d add: { '##z' . '##a' }-> (1/(2*7)) .
d add: { '##a' . '##t' }-> (2/(7*7)) .
d add: { '##t' . '##i' }-> (2/(7*11)) .
d add: { '##i' . '##o' }-> (2/(11*13)) .
d add: { '##o' . '##n' }-> (2/(13*11)) .
d add: { 's' . '##e' }-> (2/(3*21)) .
d add: { '##e' . '##c' }-> (1/(21*2)) .
d add: { '##c' . '##t' }-> (1/(2*7)) .
d add: { 's' . '##h' }-> (1/(3*8)) .
d add: { '##h' . '##o' }-> (1/(8*13)) .
d add: { '##o' . '##w' }-> (2/(13*2)) .
d add: { '##w' . '##s' }-> (1/(2*10)) .
d add: { '##e' . '##v' }-> (1/(21*1)) .
d add: { '##v' . '##e' }-> (1/(1*21)) .
d add: { '##r' . '##a' }-> (3/(9*7)) .
d add: { '##a' . '##l' }-> (1/(7*7)) .
d add: { '##z' . '##e' }-> (1/(2*21)) .
d add: { 'a' . '##l' }-> (1/(5*7)) .
d add: { '##l' . '##g' }-> (1/(7*4)) .
d add: { '##g' . '##o' }-> (1/(4*13)) .
d add: { '##o' . '##r' }-> (1/(13*9)) .
d add: { '##r' . '##i' }-> (1/(9*11)) .
d add: { '##i' . '##t' }-> (1/(11*7)) .
d add: { '##t' . '##h' }-> (1/(7*8)) .
d add: { '##h' . '##m' }-> (1/(8*1)) .
d add: { '##m' . '##s' }-> (1/(1*10)) .
d add: { '"' . '##H' }-> (1/(8*1)) .
d add: { '##H' . '##o' }-> (1/(1*13)) .
d add: { '##o' . '##p' }-> (1/(13*2)) .
d add: { '##p' . '##e' }-> (1/(2*21)) .
d add: { '##e' . '##f' }-> (1/(21*1)) .
d add: { '##f' . '##u' }-> (1/(1*5)) .
d add: { '##u' . '##l' }-> (1/(5*7)) .
d add: { '##l' . '##l' }-> (2/(7*7)) .
d add: { '##l' . '##y' }-> (1/(7*2)) .
d add: { '##y' . '##,' }-> (1/(2*5)) .
d add: { 'y' . '##o' }-> (1/(1*13)) .
d add: { 'w' . '##i' }-> (1/(1*11)) .
d add: { '##i' . '##l' }-> (1/(11*7)) .
d add: { 'b' . '##e' }-> (1/(1*21)) .
d add: { '##b' . '##l' }-> (1/(2*7)) .
d add: { '##l' . '##e' }-> (1/(7*21)) .
d add: { 'u' . '##n' }-> (1/(1*11)) .
d add: { '##n' . '##d' }-> (2/(11*4)) .
d add: { '##d' . '##e' }-> (1/(4*21)) .
d add: { '##s' . '##t' }-> (1/(10*7)) .
d add: { '##t' . '##a' }-> (1/(7*7)) .
d add: { '##a' . '##n' }-> (1/(7*11)) .
d add: { '##n' . '##d' }-> (3/(11*4)) .
d add: { 'h' . '##o' }-> (1/(1*13)) .
d add: { '##e' . '##y' }-> (1/(21*2)) .
d add: { 'a' . '##r' }-> (1/(5*9)) .
d add: { '##r' . '##e' }-> (1/(9*21)) .
d add: { 't' . '##r' }-> (1/(7*9)) .
d add: { '##a' . '##i' }-> (1/(7*11)) .
d add: { '##n' . '##e' }-> (2/(11*21)) .
d add: { '##e' . '##d' }-> (1/(21*4)) .
d add: { 'a' . '##n' }-> (1/(5*11)) .
d add: { 'g' . '##e' }-> (1/(1*21)) .
d add: { '##n' . '##s' }-> (1/(11*10)) .


self assert: w pairScores equals: d .


'"This is the Hugging Face Course.",
    "This chapter is about tokenization.",
    "This section shows several tokenizer algorithms.",
    "Hopefully, you will be able to understand how they are trained and generate tokens.",'.

]

{ #category : 'tests' }
WordPieceTest >> testEncode [

	|w|
	w := WordPiece new .
	w fromText: self text .
	w train: 70 .
	
	self assert: ( w encode: 'This' ) equals: ( OrderedCollection with: '<UNK>' ) .
	
	self assert: ( w encode: 'This is the Hugging Face course!' ) equals: { '<UNK>' . 'i' . '##s' . 'th' . '##e' . 'Hugg' . '##i' . '##n' . '##g' . 'Fac' . '##e' . 'c' . '##o' . '##u' . '##r' . '##s' . '##e' } asOrderedCollection .
]

{ #category : 'tests' }
WordPieceTest >> testEncodeWord [

	|w|
	
	w := WordPiece new .
	w fromText: self text .
	w train: 70 .
	
	self assert: ( w encodeWord: 'This') equals: ( OrderedCollection with: '<UNK>' ) .
	
	self assert: ( w encodeWord: 'Hugging' ) equals: { 'Hugg' . '##i' . '##n' . '##g' } asOrderedCollection .
]

{ #category : 'tests' }
WordPieceTest >> testFindPairToMerge [ 

	|w|
	w := WordPiece new .
	w fromText: self text .
	
	self assert: w findPairToMerge equals: #('##f' '##u')
]

{ #category : 'tests' }
WordPieceTest >> testMergeAnd [ 

	|w s1 s2|
	w := WordPiece new .
	s1 := 'a' .
	s2 := 'bcd' .
	
	self assert: ( w merge: s1 and: s2 ) equals: 'ad' .
	
]

{ #category : 'tests' }
WordPieceTest >> testMergesListContentAfterTwoMerges [

	|w b d|
	b := Bag new .
	d := Dictionary new .
	w := WordPiece new .
	w fromText: self text .
	w mergeOneStep .
	w mergeOneStep . 
	
	self assert: w merges equals: { { '##f' . '##u' } -> '##fu' . { 'H' . '##u' } -> 'Hu' } asOrderedCollection .
]

{ #category : 'tests' }
WordPieceTest >> testMergesOneStep [ 

	|w b d|
	b := Bag new .
	d := Dictionary new .
	w := WordPiece new .
	w fromText: self text .
	w mergeOneStep . 
	b add: '##T'  withOccurrences: 3 .
	b add: '##h'  withOccurrences: 8 .
	b add: '##i'  withOccurrences: 11 .
	b add: '##s'  withOccurrences: 10 .
	b add: 'i'  withOccurrences: 2 .
	b add: 't'  withOccurrences: 7 .
	b add: '"'  withOccurrences: 8 .
	b add: '##e'  withOccurrences: 21 .
	b add: 'H'  withOccurrences: 1 .
	b add: '##H'  withOccurrences: 1 .
	b add: '##u'  withOccurrences: 4 .
	b add: '##g'  withOccurrences: 4 .
	b add: '##n'  withOccurrences: 11 .
	b add: 'F'  withOccurrences: 1 .
	b add: '##a'  withOccurrences: 7 .
	b add: '##c'  withOccurrences: 2 .
	b add: 'C'  withOccurrences: 1 .
	b add: '##o'  withOccurrences: 13 .
	b add: '##r'  withOccurrences: 9 .
	b add: '##,'  withOccurrences: 5 .
	b add: 'c'  withOccurrences: 1 .
	b add: '##p'  withOccurrences: 2 .
	b add: '##t'  withOccurrences: 7 .
	b add: 'a'  withOccurrences: 5 .
	b add: '##b'  withOccurrences: 2 .
	b add: '##k'  withOccurrences: 3 .
	b add: '##z'  withOccurrences: 2 .
	b add: 's'  withOccurrences: 3 .
	b add: '##w'  withOccurrences: 2 .
	b add: '##v'  withOccurrences: 1 .
	b add: '##l'  withOccurrences: 7 .
	b add: '##m'  withOccurrences: 1 .
	b add: '##fu'  withOccurrences: 1 .
	b add: '##y'  withOccurrences: 2 .
	b add: 'y'  withOccurrences: 1 .
	b add: 'w'  withOccurrences: 1 .
	b add: 'b'  withOccurrences: 1 .
	b add: 'u'  withOccurrences: 1 .
	b add: '##d'  withOccurrences: 4 .
	b add: 'h'  withOccurrences: 1 .
	b add: 'g'  withOccurrences: 1 .
	
	self assert: w letterFrequency equals: b .
	
	d add: { '"' . '##T' }-> (3/(8*3)) .
	d add: { '##T' . '##h' }-> (3/(3*8)) .
	d add: { '##h' . '##i' }-> (3/(8*11)) .
	d add: { '##i' . '##s' }-> (3/(10*11)) .
	d add: { 'i' . '##s' }-> (2/(10*2)) .
	d add: { 't' . '##h' }-> (2/(7*8)) .
	d add: { '##h' . '##e' }-> (2/(8*21)) .
	d add: { 'H' . '##u' }-> (1/(1*4)) .
	d add: { '##u' . '##g' }-> (1/(4*4)) .
	d add: { '##g' . '##g' }-> (1/(4*4)) .
	d add: { '##g' . '##i' }-> (1/(4*11)) .
	d add: { '##i' . '##n' }-> (2/(11*11)) .
	d add: { '##n' . '##g' }-> (1/(11*4)) .
	d add: { 'F' . '##a' }-> (1/(1*7)) .
	d add: { '##a' . '##c' }-> (1/(2*7)) .
	d add: { '##c' . '##e' }-> (1/(2*21)) .
	d add: { 'C' . '##o' }-> (1/(1*13)) .
	d add: { '##o' . '##u' }-> (3/(13*4)) .
	d add: { '##u' . '##r' }-> (1/(4*9)) .
	d add: { '##r' . '##s' }-> (2/(9*10)) .
	d add: { '##s' . '##e' }-> (1/(10*21)) .
	d add: { '"' . '##,' }-> (4/(8*5)) .
	d add: { 'c' . '##h' }-> (1/(1*8)) .
	d add: { '##h' . '##a' }-> (1/(8*7)) .
	d add: { '##a' . '##p' }-> (1/(7*2)) .
	d add: { '##p' . '##t' }-> (1/(2*7)) .
	d add: { '##t' . '##e' }-> (2/(7*21)) .
	d add: { '##e' . '##r' }-> (5/(21*9)) .
	d add: { 'a' . '##b' }-> (2/(5*2)) .
	d add: { '##b' . '##o' }-> (1/(2*13)) .
	d add: { '##u' . '##t' }-> (1/(4*7)) .
	d add: { 't' . '##o' }-> (4/(7*13)) .
	d add: { '##o' . '##k' }-> (3/(13*3)) .
	d add: { '##k' . '##e' }-> (3/(3*21)) .
	d add: { '##e' . '##n' }-> (4/(21*11)) .
	d add: { '##n' . '##i' }-> (2/(11*11)) .
	d add: { '##i' . '##z' }-> (2/(11*2)) .
	d add: { '##z' . '##a' }-> (1/(2*7)) .
	d add: { '##a' . '##t' }-> (2/(7*7)) .
	d add: { '##t' . '##i' }-> (2/(7*11)) .
	d add: { '##i' . '##o' }-> (2/(11*13)) .
	d add: { '##o' . '##n' }-> (2/(13*11)) .
	d add: { 's' . '##e' }-> (2/(3*21)) .
	d add: { '##e' . '##c' }-> (1/(21*2)) .
	d add: { '##c' . '##t' }-> (1/(2*7)) .
	d add: { 's' . '##h' }-> (1/(3*8)) .
	d add: { '##h' . '##o' }-> (1/(8*13)) .
	d add: { '##o' . '##w' }-> (2/(13*2)) .
	d add: { '##w' . '##s' }-> (1/(2*10)) .
	d add: { '##e' . '##v' }-> (1/(21*1)) .
	d add: { '##v' . '##e' }-> (1/(1*21)) .
	d add: { '##r' . '##a' }-> (3/(9*7)) .
	d add: { '##a' . '##l' }-> (1/(7*7)) .
	d add: { '##z' . '##e' }-> (1/(2*21)) .
	d add: { 'a' . '##l' }-> (1/(5*7)) .
	d add: { '##l' . '##g' }-> (1/(7*4)) .
	d add: { '##g' . '##o' }-> (1/(4*13)) .
	d add: { '##o' . '##r' }-> (1/(13*9)) .
	d add: { '##r' . '##i' }-> (1/(9*11)) .
	d add: { '##i' . '##t' }-> (1/(11*7)) .
	d add: { '##t' . '##h' }-> (1/(7*8)) .
	d add: { '##h' . '##m' }-> (1/(8*1)) .
	d add: { '##m' . '##s' }-> (1/(1*10)) .
	d add: { '"' . '##H' }-> (1/(8*1)) .
	d add: { '##H' . '##o' }-> (1/(1*13)) .
	d add: { '##o' . '##p' }-> (1/(13*2)) .
	d add: { '##p' . '##e' }-> (1/(2*21)) .
	d add: { '##e' . '##fu' }-> (1/(21*1)) .
	d add: { '##fu' . '##l' }-> (1/(1*7)) .
	d add: { '##l' . '##l' }-> (2/(7*7)) .
	d add: { '##l' . '##y' }-> (1/(7*2)) .
	d add: { '##y' . '##,' }-> (1/(2*5)) .
	d add: { 'y' . '##o' }-> (1/(1*13)) .
	d add: { 'w' . '##i' }-> (1/(1*11)) .
	d add: { '##i' . '##l' }-> (1/(11*7)) .
	d add: { 'b' . '##e' }-> (1/(1*21)) .
	d add: { '##b' . '##l' }-> (1/(2*7)) .
	d add: { '##l' . '##e' }-> (1/(7*21)) .
	d add: { 'u' . '##n' }-> (1/(1*11)) .
	d add: { '##n' . '##d' }-> (2/(11*4)) .
	d add: { '##d' . '##e' }-> (1/(4*21)) .
	d add: { '##s' . '##t' }-> (1/(10*7)) .
	d add: { '##t' . '##a' }-> (1/(7*7)) .
	d add: { '##a' . '##n' }-> (1/(7*11)) .
	d add: { '##n' . '##d' }-> (3/(11*4)) .
	d add: { 'h' . '##o' }-> (1/(1*13)) .
	d add: { '##e' . '##y' }-> (1/(21*2)) .
	d add: { 'a' . '##r' }-> (1/(5*9)) .
	d add: { '##r' . '##e' }-> (1/(9*21)) .
	d add: { 't' . '##r' }-> (1/(7*9)) .
	d add: { '##a' . '##i' }-> (1/(7*11)) .
	d add: { '##n' . '##e' }-> (2/(11*21)) .
	d add: { '##e' . '##d' }-> (1/(21*4)) .
	d add: { 'a' . '##n' }-> (1/(5*11)) .
	d add: { 'g' . '##e' }-> (1/(1*21)) .
	d add: { '##n' . '##s' }-> (1/(11*10)) .
	
	self assert: w pairScores equals: d .
	
	self assert: ( w vocabulary includes: '##fu' ) equals: true .
	
	'"This is the Hugging Face Course.",
   "This chapter is about tokenization.",
   "This section shows several tokenizer algorithms.",
   "Hopefully, you will be able to understand how they are trained and generate tokens.",'
	
]

{ #category : 'tests' }
WordPieceTest >> testTextToWords [

	|w|
	w := WordPiece new .
	
	self assert: ( w textToWords: self text ) equals: { #( '"' '##T' '##h' '##i' '##s' ) asOrderedCollection . #( 'i' '##s' ) asOrderedCollection . #( 't' '##h' '##e' ) asOrderedCollection . #( 'H' '##u' '##g' '##g' '##i' '##n' '##g' ) asOrderedCollection . #( 'F' '##a' '##c' '##e' ) asOrderedCollection . #( 'C' '##o' '##u' '##r' '##s' '##e' ) asOrderedCollection . #( '"' '##,' ) asOrderedCollection . #( '"' '##T' '##h' '##i' '##s' ) asOrderedCollection . #( 'c' '##h' '##a' '##p' '##t' '##e' '##r' ) asOrderedCollection . #( 'i' '##s' ) asOrderedCollection . #( 'a' '##b' '##o' '##u' '##t' ) asOrderedCollection . #( 't' '##o' '##k' '##e' '##n' '##i' '##z' '##a' '##t' '##i' '##o' '##n' ) asOrderedCollection . #( '"' '##,' ) asOrderedCollection . #( '"' '##T' '##h' '##i' '##s' ) asOrderedCollection . #( 's' '##e' '##c' '##t' '##i' '##o' '##n' ) asOrderedCollection . #( 's' '##h' '##o' '##w' '##s' ) asOrderedCollection . #( 's' '##e' '##v' '##e' '##r' '##a' '##l' ) asOrderedCollection . #( 't' '##o' '##k' '##e' '##n' '##i' '##z' '##e' '##r' ) asOrderedCollection . #( 'a' '##l' '##g' '##o' '##r' '##i' '##t' '##h' '##m' '##s' ) asOrderedCollection . #( '"' '##,' ) asOrderedCollection . #( '"' '##H' '##o' '##p' '##e' '##f' '##u' '##l' '##l' '##y' '##,' ) asOrderedCollection . #( 'y' '##o' '##u' ) asOrderedCollection . #( 'w' '##i' '##l' '##l' ) asOrderedCollection . #( 'b' '##e' ) asOrderedCollection . #( 'a' '##b' '##l' '##e' ) asOrderedCollection . #( 't' '##o' ) asOrderedCollection . #( 'u' '##n' '##d' '##e' '##r' '##s' '##t' '##a' '##n' '##d' ) asOrderedCollection . #( 'h' '##o' '##w' ) asOrderedCollection . #( 't' '##h' '##e' '##y' ) asOrderedCollection . #( 'a' '##r' '##e' ) asOrderedCollection . #( 't' '##r' '##a' '##i' '##n' '##e' '##d' ) asOrderedCollection . #( 'a' '##n' '##d' ) asOrderedCollection . #( 'g' '##e' '##n' '##e' '##r' '##a' '##t' '##e' ) asOrderedCollection . #( 't' '##o' '##k' '##e' '##n' '##s' ) asOrderedCollection . #( '"' '##,' ) asOrderedCollection }
]

{ #category : 'tests' }
WordPieceTest >> testTrain [ 

	|w|
	w := WordPiece new .
	w fromText: self text .
	
	self assert: w vocabulary size equals: 41 .
	
	w train: 15 .
	
	self assert: w vocabulary size equals: 41 .
	

	w train: 50 .
	
	self assert: w vocabularySize equals: 50
]

{ #category : 'tests' }
WordPieceTest >> testTwoMergesOneStep [ 

	|w b d|
	b := Bag new .
	d := Dictionary new .
	w := WordPiece new .
	w fromText: self text .
	w mergeOneStep .
	w mergeOneStep . 
	
	b add: '##T'  withOccurrences: 3 .
	b add: '##h'  withOccurrences: 8 .
	b add: '##i'  withOccurrences: 11 .
	b add: '##s'  withOccurrences: 10 .
	b add: 'i'  withOccurrences: 2 .
	b add: 't'  withOccurrences: 7 .
	b add: '"'  withOccurrences: 8 .
	b add: '##e'  withOccurrences: 21 .
	b add: 'Hu'  withOccurrences: 1 .
	b add: '##H'  withOccurrences: 1 .
	b add: '##u'  withOccurrences: 3 .
	b add: '##g'  withOccurrences: 4 .
	b add: '##n'  withOccurrences: 11 .
	b add: 'F'  withOccurrences: 1 .
	b add: '##a'  withOccurrences: 7 .
	b add: '##c'  withOccurrences: 2 .
	b add: 'C'  withOccurrences: 1 .
	b add: '##o'  withOccurrences: 13 .
	b add: '##r'  withOccurrences: 9 .
	b add: '##,'  withOccurrences: 5 .
	b add: 'c'  withOccurrences: 1 .
	b add: '##p'  withOccurrences: 2 .
	b add: '##t'  withOccurrences: 7 .
	b add: 'a'  withOccurrences: 5 .
	b add: '##b'  withOccurrences: 2 .
	b add: '##k'  withOccurrences: 3 .
	b add: '##z'  withOccurrences: 2 .
	b add: 's'  withOccurrences: 3 .
	b add: '##w'  withOccurrences: 2 .
	b add: '##v'  withOccurrences: 1 .
	b add: '##l'  withOccurrences: 7 .
	b add: '##m'  withOccurrences: 1 .
	b add: '##fu'  withOccurrences: 1 .
	b add: '##y'  withOccurrences: 2 .
	b add: 'y'  withOccurrences: 1 .
	b add: 'w'  withOccurrences: 1 .
	b add: 'b'  withOccurrences: 1 .
	b add: 'u'  withOccurrences: 1 .
	b add: '##d'  withOccurrences: 4 .
	b add: 'h'  withOccurrences: 1 .
	b add: 'g'  withOccurrences: 1 .
	
	self assert: w letterFrequency equals: b .
	
	d add: { '"' . '##T' }-> (3/(8*3)) .
	d add: { '##T' . '##h' }-> (3/(3*8)) .
	d add: { '##h' . '##i' }-> (3/(8*11)) .
	d add: { '##i' . '##s' }-> (3/(10*11)) .
	d add: { 'i' . '##s' }-> (2/(10*2)) .
	d add: { 't' . '##h' }-> (2/(7*8)) .
	d add: { '##h' . '##e' }-> (2/(8*21)) .
	d add: { 'Hu' . '##g' }-> (1/(1*4)) .
	d add: { '##g' . '##g' }-> (1/(4*4)) .
	d add: { '##g' . '##i' }-> (1/(4*11)) .
	d add: { '##i' . '##n' }-> (2/(11*11)) .
	d add: { '##n' . '##g' }-> (1/(11*4)) .
	d add: { 'F' . '##a' }-> (1/(1*7)) .
	d add: { '##a' . '##c' }-> (1/(2*7)) .
	d add: { '##c' . '##e' }-> (1/(2*21)) .
	d add: { 'C' . '##o' }-> (1/(1*13)) .
	d add: { '##o' . '##u' }-> (3/(13*3)) .
	d add: { '##u' . '##r' }-> (1/(3*9)) .
	d add: { '##r' . '##s' }-> (2/(9*10)) .
	d add: { '##s' . '##e' }-> (1/(10*21)) .
	d add: { '"' . '##,' }-> (4/(8*5)) .
	d add: { 'c' . '##h' }-> (1/(1*8)) .
	d add: { '##h' . '##a' }-> (1/(8*7)) .
	d add: { '##a' . '##p' }-> (1/(7*2)) .
	d add: { '##p' . '##t' }-> (1/(2*7)) .
	d add: { '##t' . '##e' }-> (2/(7*21)) .
	d add: { '##e' . '##r' }-> (5/(21*9)) .
	d add: { 'a' . '##b' }-> (2/(5*2)) .
	d add: { '##b' . '##o' }-> (1/(2*13)) .
	d add: { '##u' . '##t' }-> (1/(3*7)) .
	d add: { 't' . '##o' }-> (4/(7*13)) .
	d add: { '##o' . '##k' }-> (3/(13*3)) .
	d add: { '##k' . '##e' }-> (3/(3*21)) .
	d add: { '##e' . '##n' }-> (4/(21*11)) .
	d add: { '##n' . '##i' }-> (2/(11*11)) .
	d add: { '##i' . '##z' }-> (2/(11*2)) .
	d add: { '##z' . '##a' }-> (1/(2*7)) .
	d add: { '##a' . '##t' }-> (2/(7*7)) .
	d add: { '##t' . '##i' }-> (2/(7*11)) .
	d add: { '##i' . '##o' }-> (2/(11*13)) .
	d add: { '##o' . '##n' }-> (2/(13*11)) .
	d add: { 's' . '##e' }-> (2/(3*21)) .
	d add: { '##e' . '##c' }-> (1/(21*2)) .
	d add: { '##c' . '##t' }-> (1/(2*7)) .
	d add: { 's' . '##h' }-> (1/(3*8)) .
	d add: { '##h' . '##o' }-> (1/(8*13)) .
	d add: { '##o' . '##w' }-> (2/(13*2)) .
	d add: { '##w' . '##s' }-> (1/(2*10)) .
	d add: { '##e' . '##v' }-> (1/(21*1)) .
	d add: { '##v' . '##e' }-> (1/(1*21)) .
	d add: { '##r' . '##a' }-> (3/(9*7)) .
	d add: { '##a' . '##l' }-> (1/(7*7)) .
	d add: { '##z' . '##e' }-> (1/(2*21)) .
	d add: { 'a' . '##l' }-> (1/(5*7)) .
	d add: { '##l' . '##g' }-> (1/(7*4)) .
	d add: { '##g' . '##o' }-> (1/(4*13)) .
	d add: { '##o' . '##r' }-> (1/(13*9)) .
	d add: { '##r' . '##i' }-> (1/(9*11)) .
	d add: { '##i' . '##t' }-> (1/(11*7)) .
	d add: { '##t' . '##h' }-> (1/(7*8)) .
	d add: { '##h' . '##m' }-> (1/(8*1)) .
	d add: { '##m' . '##s' }-> (1/(1*10)) .
	d add: { '"' . '##H' }-> (1/(8*1)) .
	d add: { '##H' . '##o' }-> (1/(1*13)) .
	d add: { '##o' . '##p' }-> (1/(13*2)) .
	d add: { '##p' . '##e' }-> (1/(2*21)) .
	d add: { '##e' . '##fu' }-> (1/(21*1)) .
	d add: { '##fu' . '##l' }-> (1/(1*7)) .
	d add: { '##l' . '##l' }-> (2/(7*7)) .
	d add: { '##l' . '##y' }-> (1/(7*2)) .
	d add: { '##y' . '##,' }-> (1/(2*5)) .
	d add: { 'y' . '##o' }-> (1/(1*13)) .
	d add: { 'w' . '##i' }-> (1/(1*11)) .
	d add: { '##i' . '##l' }-> (1/(11*7)) .
	d add: { 'b' . '##e' }-> (1/(1*21)) .
	d add: { '##b' . '##l' }-> (1/(2*7)) .
	d add: { '##l' . '##e' }-> (1/(7*21)) .
	d add: { 'u' . '##n' }-> (1/(1*11)) .
	d add: { '##n' . '##d' }-> (2/(11*4)) .
	d add: { '##d' . '##e' }-> (1/(4*21)) .
	d add: { '##s' . '##t' }-> (1/(10*7)) .
	d add: { '##t' . '##a' }-> (1/(7*7)) .
	d add: { '##a' . '##n' }-> (1/(7*11)) .
	d add: { '##n' . '##d' }-> (3/(11*4)) .
	d add: { 'h' . '##o' }-> (1/(1*13)) .
	d add: { '##e' . '##y' }-> (1/(21*2)) .
	d add: { 'a' . '##r' }-> (1/(5*9)) .
	d add: { '##r' . '##e' }-> (1/(9*21)) .
	d add: { 't' . '##r' }-> (1/(7*9)) .
	d add: { '##a' . '##i' }-> (1/(7*11)) .
	d add: { '##n' . '##e' }-> (2/(11*21)) .
	d add: { '##e' . '##d' }-> (1/(21*4)) .
	d add: { 'a' . '##n' }-> (1/(5*11)) .
	d add: { 'g' . '##e' }-> (1/(1*21)) .
	d add: { '##n' . '##s' }-> (1/(11*10)) .
	
	self assert: w pairScores equals: d .
	
	self assert: ( w vocabulary includes: 'Hu' ) equals: true .
	
	'"This is the Hugging Face Course.",
   "This chapter is about tokenization.",
   "This section shows several tokenizer algorithms.",
   "Hopefully, you will be able to understand how they are trained and generate tokens.",'
]

{ #category : 'tests' }
WordPieceTest >> text [ 

^ '"This is the Hugging Face Course.",
    "This chapter is about tokenization.",
    "This section shows several tokenizer algorithms.",
    "Hopefully, you will be able to understand how they are trained and generate tokens.",'
]
