Class {
	#name : 'BPETest',
	#superclass : 'TestCase',
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'tests' }
BPETest >> testTokenize [ 


	BPE new tokenize: 'lulu'
]
