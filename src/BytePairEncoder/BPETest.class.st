Class {
	#name : 'BPETest',
	#superclass : 'TestCase',
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'tests' }
BPETest >> testTokenize [ 
	
	| bpe tokens |
	bpe := BPE new.
	tokens := bpe tokenize: 'lulu'.
	self assert: tokens equals: #('l' 'u') asSet
]
