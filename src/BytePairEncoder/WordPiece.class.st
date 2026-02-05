Class {
	#name : 'WordPiece',
	#superclass : 'BytePairEncoder',
	#instVars : [
		'pairScores',
		'letterFrequency'
	],
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'adding' }
WordPiece >> addToLetterFrequency: string withOccurrences: integer [

	letterFrequency add: string withOccurrences: integer 
]

{ #category : 'vocabulary' }
WordPiece >> computeLetterFrequency [ 
	"we do not add characters but string because in the merge phase we will have sequences of characters."
	
	letterFrequency := Bag new .
	
	words do: [ :each | each do: [ :aChar | letterFrequency add: aChar asString ]].
]

{ #category : 'compute' }
WordPiece >> computePairs [
	
	pairScores := Dictionary new.
	
	super computePairs .
	pairs associationsDo: [ :association | 
		pairScores add: (Association key: association key value: (association value / ( ( letterFrequency occurrencesOf: association key first ) * (letterFrequency occurrencesOf: association key second )  ) ) )
		 ] 
]

{ #category : 'api' }
WordPiece >> encode: aString [

	| rawWords tokens |
	rawWords := aString substrings: {
			            Character space.
			            Character cr.
			            Character tab . $. . $? .$! .$: . $;}.
	tokens := OrderedCollection new .
	
	rawWords do: [ :each | 
		tokens add: ( self encodeWord: each )
		 ].
	
	tokens := tokens flatCollect: [ :each | each ] .
	
	^ tokens
			
]

{ #category : 'private - encoding' }
WordPiece >> encodeWord: aWord [ 

	| tokens word |
	word := aWord .
	tokens := OrderedCollection new .
	
	[ word isNotEmpty ] whileTrue: [ | i |
		i := 0 .
		[ i < word size and: [ ( vocabulary includes: ( word allButLast: i ) ) not ] ] whileTrue: [ 
			i := i + 1 ] .
			( i >= word size ) ifTrue: [ ^ OrderedCollection with: '<UNK>' ] .
			tokens add: ( word allButLast: i ) .
			word := word allButFirst: word size - i .
			( word isNotEmpty ) ifTrue: [ 
				word := '##', word ].
			 ].
		
	^ tokens 
]

{ #category : 'merges' }
WordPiece >> findPairToMerge [ 
"Cherche la paire ayant la fréquence maximale dans pairsScores et le renvoie."

	^ (pairScores associations detectMax: [:assoc | assoc value]) key
]

{ #category : 'initialization' }
WordPiece >> letterFrequency [ 

	^ letterFrequency 
]

{ #category : 'as yet unclassified' }
WordPiece >> merge: s1 and: s2 [

	( s2 size > 1 ) ifTrue: [ ^ s1, ( s2 allButFirst: 2 ) ] 
]

{ #category : 'initialization' }
WordPiece >> pairScores [

	^ pairScores 
]

{ #category : 'compute' }
WordPiece >> textToWords: aText [
	"Split the text into words. Then turn a word as a collection of strings."

	| rawWords |
	rawWords := aText substrings: {
			            Character space.
			            Character cr.
			            Character tab . $. . $? .$! .$: . $;}.
	^ (rawWords collect: [ :each |
				 | col |
				 col := OrderedCollection new.
				col add: each first asString.
				2 to: each size do: [ :i| 
					col add: '##',( each at: i ) asString ] .
				 col ] )
]

{ #category : 'as yet unclassified' }
WordPiece >> train: anInteger [

	|n|
	
	n := anInteger - vocabulary size .
	
	[ n > 0 ] whileTrue: [ 
		self mergeOneStep .
		n := n - 1 ] .
	
	^ vocabulary 

	
]
