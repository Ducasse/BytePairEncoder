Class {
	#name : 'BPE',
	#superclass : 'Object',
	#instVars : [
		'vocabulary',
		'merges'
	],
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'converting' }
BPE >> encode: aString [
   | wordsTokens result |
   wordsTokens := (aString findTokens: ' ') collect: [ :w | self tokenize: w ].
   result := OrderedCollection new.

   wordsTokens do: [ :wordTokens |
       | mergedWord |
       mergedWord := wordTokens asArray.   "start from original tokens"

       merges do: [ :pair |
           | i newTokens |
           newTokens := OrderedCollection new.
           i := 1.
           [ i <= mergedWord size ] whileTrue: [
               (i < mergedWord size
                and: [ mergedWord at: i = pair first
                       and: [ mergedWord at: i + 1 = pair second ] ])
                   ifTrue: [
                       newTokens add: (pair first, pair second).
                       i := i + 2 ]
                   ifFalse: [
                       newTokens add: (mergedWord at: i).
                       i := i + 1 ] ].
           mergedWord := newTokens asArray ].

       result addAll: mergedWord ].

   ^ result
]

{ #category : 'parsing' }
BPE >> pairCounts [
   | counter |
   counter := Dictionary new.

   vocabulary do: [ :word |
       word size < 2 ifTrue: [ ^ counter ]. "no pairs"
       1 to: word size - 1 do: [ :i |
           | pair |
           pair := { word at: i. word at: i + 1 }.
           counter at: pair
               put: (counter at: pair ifAbsentPut: 0) + 1 ] ].

   ^ counter
]

{ #category : 'parsing' }
BPE >> tokenize: aWord [
	"Turn word into elementary elements that will be added to the vocabulary."
	"Convert as array since collect will try to create a string."
	
   ^ aWord asArray collect: [ :c | c asString ]
]

{ #category : 'parsing' }
BPE >> trainOnCorpus: words mergeCount: mergeCount [
   "words is an array of strings (e.g. #('low' 'lower' ...))."

   vocabulary := OrderedCollection new.
   words do: [ :w | vocabulary add: (self tokenize: w) ].

   1 to: mergeCount do: [ :i |
       | counter mostFreqPair newToken |
       counter := self pairCounts.
       counter ifEmpty: [ ^ self ]. "nothing left to merge"

       mostFreqPair := counter keys
           sorted: [ :a :b | (counter at: a) > (counter at: b) ]
           first.

       merges add: mostFreqPair.   "remember the merge"

       newToken := mostFreqPair first, mostFreqPair second. "concatenate"

       "Replace all occurrences of the pair with the new token"
       vocabulary := vocabulary collect: [ :word |
           | i tokens |
           tokens := OrderedCollection new.
           i := 1.
           [ i <= word size ] whileTrue: [
               (i < word size and: [ word at: i = mostFreqPair first
                                           and: [ word at: i + 1 = mostFreqPair second ] ])
                   ifTrue: [
                       tokens add: newToken.
                       i := i + 2 ]
                   ifFalse: [
                       tokens add: (word at: i).
                       i := i + 1 ] ].
           tokens asArray ] ].   "keep as Array for next iteration"
]
