Class {
	#name : 'BytePairEncoderTest',
	#superclass : 'TestCase',
	#category : 'BytePairEncoder',
	#package : 'BytePairEncoder'
}

{ #category : 'tests' }
BytePairEncoderTest >> testBuildVocabularyProducesCorrectVocabulary [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	self 
		assertCollection: enc vocabulary asSet
		hasSameElements: { '_' . 'd' . 'e' . 'i' . 'l' . 'f' . 'n' . 'o' . 'r' . 's' . 't' . 'w'} asSet


]

{ #category : 'tests - text2' }
BytePairEncoderTest >> testBuildVocabularyProducesCorrectVocabularyText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc computeVocabulary.
	self assertCollection: enc vocabulary asSet hasSameElements: { '_' . 'd' . 'e' . 'i' . 'l' . 'n' . 'o' . 'r' . 's' . 't' . 'w'} asSet

]

{ #category : 'tests' }
BytePairEncoderTest >> testComputePairs [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: {'o' . 'l'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' . 'd'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' .'d'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'s' .'t'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'e' . 's'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'l' .'o'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'t' . '_'}) equals: 13. 
	
	self assert: enc numberOfPairs equals: 15
	
]

{ #category : 'tests - text2' }
BytePairEncoderTest >> testComputePairsText2 [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text2.
	enc computePairs.
	
	self assert: (enc pairOccurrencesOf: {'e' .'s'}) equals: 9. 
	self assert: (enc pairOccurrencesOf: {'i'. 'd'}) equals: 3. 
	self assert: (enc pairOccurrencesOf: {'o' .'w'}) equals: 7. 
	self assert: (enc pairOccurrencesOf: {'s'. 't'}) equals: 9. 
	self assert: (enc pairOccurrencesOf: {'w'. 'e'}) equals: 8. 
	self assert: (enc pairOccurrencesOf: {'w'. 'i'}) equals: 3. 
	self assert: (enc pairOccurrencesOf: {'t'.'_'}) equals: 9. 
	
	 "#('lo' 't_' 'er' 'r_' 'st' 'wi' 'es' 'ne' 'ow' 'we' 'w_' 'id' 'de' 'ew')"
	self assert: enc numberOfPairs equals: 14
	
]

{ #category : 'tests - tintin' }
BytePairEncoderTest >> testComputePairsTintin [

	| enc |
	enc := BytePairEncoder new.
	enc prepareWordsFromText: self textTintin.
	enc computePairs.

	self assert: enc pairs sortedCounts 
		equals: {8->#('i' 'n'). 7->#('n' 't'). 4->#('t' 'i'). 4->#('n' '_'). 4->#('e' 's'). 3->#('n' 'a'). 3->#('T' 'i'). 3->#('.' '_'). 3->#('s' '_'). 3->#('t' '_'). 3->#('d' 'e'). 2->#('e' '_'). 2->#('t' 'e'). 2->#('o' 'u'). 2->#('o' 'n'). 2->#('r' 'n'). 2->#('s' 't'). 2->#('a' 'l'). 2->#('r' 'e'). 2->#('u' 'r'). 1->#('p' 'i'). 1->#('e' 'r'). 1->#('i' 's'). 1->#('s' '.'). 1->#('i' 'l'). 1->#('a' 'v'). 1->#('e' '.'). 1->#('e' 'p'). 1->#('p' 'a'). 1->#('o' 'm'). 1->#('i' 'd'). 1->#('a' 't'). 1->#('l' 'e'). 1->#('t' 'u'). 1->#('u' 'n'). 1->#('e' 'n'). 1->#('m' '.'). 1->#('e' 't'). 1->#('a' '_'). 1->#('a' 's'). 1->#('i' 'o'). 1->#('j' 'o'). 1->#('l' 'i'). 1->#('u' '_'). 1->#('m' 'i'). 1->#('l' 'o'). 1->#('t' 'r'). 1->#('n' ''''). 1->#('v' 'e'). 1->#('n' 'o'). 1->#('''' 'a')} 
]

{ #category : 'tests - aaabdaaabac' }
BytePairEncoderTest >> testComputePairsaaabdaaabac [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: 'aaabdaaabac'.
	enc computePairs.
	
	self 
		assert: enc pairs sortedCounts 
		equals: {4->#('a' 'a'). 2->#('a' 'b'). 1->#('b' 'a'). 1->#('d' 'a'). 1->#('b' 'd'). 1->#('c' '_'). 1->#('a' 'c')}
]

{ #category : 'tests - tintin' }
BytePairEncoderTest >> testComputeVocabularyTintin [

	| enc |
	enc := BytePairEncoder new.
	enc prepareWordsFromText: self textTintin.
	enc computeVocabulary.

	self 
		assertCollection: enc vocabulary 
		equals: #('s' 'l' 'e' 'j' 'v' 'o' '.' 'a' '''' 't' 'm' '_' 'r' 'd' 'p' 'i' 'T' 'u' 'n') asSet
]

{ #category : 'tests - aaabdaaabac' }
BytePairEncoderTest >> testComputeVocabularyaaabdaaabac [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: 'aaabdaaabac'.
	enc computeVocabulary.
	
	self 
		assertCollection: enc vocabulary
		hasSameElements: #( 'a' 'b' '_' 'c' 'd') asSet
]

{ #category : 'tests - huggingface tutorial' }
BytePairEncoderTest >> testHuggingOneMerge [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text3.
	enc computeVocabulary.
	enc computePairs.
	enc mergeOneStep.
	
	self assert: enc merges first equals: #('u' 'g')->'ug'. 
	
	"
	
	Vocabulary: [""b"", ""g"", ""h"", ""n"", ""p"", ""s"", ""u"", ""ug""]
	Corpus: (""h"" ""ug"", 10), (""p"" ""ug"", 5), (""p"" ""u"" ""n"", 12), (""b"" ""u"" ""n"", 4), (""h"" ""ug"" ""s"", 5)
	
	"
]

{ #category : 'tests - huggingface tutorial' }
BytePairEncoderTest >> testHuggingTwoMerge [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text3.
	enc computeVocabulary.
	enc computePairs.
	enc mergeOneStep.
	enc mergeOneStep.
	
	self assert: enc merges second equals: #('n' '_')->'n_'
	
	"
	Vocabulary: [""b"", ""g"", ""h"", ""n"", ""p"", ""s"", ""u"", ""ug""]
	Corpus: (""h"" ""ug"", 10), (""p"" ""ug"", 5), (""p"" ""u"" ""n"", 12), (""b"" ""u"" ""n"", 4), (""h"" ""ug"" ""s"", 5)
	
	"
]

{ #category : 'tests' }
BytePairEncoderTest >> testMergeOneStepAddMergeToMergeList [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	self assert: enc merges first equals: #('e' 's')->'es' 
]

{ #category : 'tests - tintin' }
BytePairEncoderTest >> testMergeOneStepAddMergeToMergeListTintin [

	| enc |
	enc := BytePairEncoder new.
	enc prepareWordsFromText: self textTintin.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	self assert: enc merges first equals: #('i' 'n')->'in'.

]

{ #category : 'tests - aaabdaaabac' }
BytePairEncoderTest >> testMergeOneStepAddMergeToMergeListaaabdaaabac [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: 'aaabdaaabac'.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	self assert: enc merges first  equals: #('a' 'a')->'aa'
]

{ #category : 'tests' }
BytePairEncoderTest >> testMergeOneStepIncreaseVocabularyAndMerges [

	| enc mergeOldSize |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	
	self assert: enc vocabulary size equals: 12.
	mergeOldSize := enc merges size.
	enc mergeOneStep.
	self assert: (enc vocabulary includes: 'es').
	self assert: enc merges size equals: mergeOldSize + 1.
	self assert: enc vocabulary size equals: 13
	
]

{ #category : 'tests' }
BytePairEncoderTest >> testMergeOneStepRecomputePairs [

	| enc finestFrequency |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	finestFrequency := enc frequencyOfWord: #('f' 'i' 'n' 'es' 't').
	enc computeVocabulary.
	enc computePairs.
	
	enc mergeOneStep.
	
	self assert: (enc pairOccurrencesOf: {'o' . 'l'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' . 'd'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'l' .'d'}) equals: 10. 
	self assert: (enc pairOccurrencesOf: {'es' . 't'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'l' .'o'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'t' . '_'}) equals: 13. 
	self assert: (enc pairOccurrencesOf: {'w' . 'es'}) equals: 4. 
	self assert: (enc pairOccurrencesOf: {'n' . 'es'}) equals: 9. 
]

{ #category : 'tests' }
BytePairEncoderTest >> testMergeOneStepUpdatesCorpus [

	| enc finestFrequency |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	finestFrequency := enc frequencyOfWord: #('f' 'i' 'n' 'es' 't').
	enc computeVocabulary.
	enc computePairs.
	
	enc mergeOneStep.
	"should have a better assert"
	self assert: (enc uniqueWords includes: #('l' 'o' 'w' 'es' 't' '_') asOrderedCollection).
	self assert: (enc uniqueWords includes: #('f' 'i' 'n' 'es' 't' '_') asOrderedCollection). 
	self assert: (enc frequencyOfWord: #('f' 'i' 'n' 'es' 't' '_')) equals: finestFrequency.
]

{ #category : 'tests - aaabdaaabac' }
BytePairEncoderTest >> testMergeThreeStepAddMergeToMergeListaaabdaaabac [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: 'aaabdaaabac'.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	enc mergeOneStep.
	enc mergeOneStep.
	self assert: enc merges third equals: #('aaa' 'b') -> 'aaab'
]

{ #category : 'tests - aaabdaaabac' }
BytePairEncoderTest >> testMergeTwoStepAddMergeToMergeListaaabdaaabac [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: 'aaabdaaabac'.
	enc computeVocabulary.
	enc computePairs.
	self assert: enc merges isEmpty.
	enc mergeOneStep.
	enc mergeOneStep.
	self assert: enc merges second equals:  #('aa' 'a')->'aaa'
]

{ #category : 'tests' }
BytePairEncoderTest >> testPrepareWordsFromText [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	self assert: (enc occurrencesOf: #('o' 'l' 'd' '_') asOrderedCollection) equals: 7. 
	self assert: (enc occurrencesOf: #('o' 'l' 'd' 'e' 'r' '_') asOrderedCollection) equals: 3. 
	self assert: (enc occurrencesOf: #('f' 'i' 'n' 'e' 's' 't' '_') asOrderedCollection) equals: 9. 
	self assert: (enc occurrencesOf: #('l' 'o' 'w' 'e' 's' 't' '_') asOrderedCollection) equals: 4. 

]

{ #category : 'tests' }
BytePairEncoderTest >> testTwoMerges [

	| enc |
	enc := BytePairEncoder new. 
	enc prepareWordsFromText: self text.
	enc computeVocabulary.
	enc computePairs.
	enc mergeOneStep.
	enc mergeOneStep.
	
	self assert: enc merges first equals: #('e' 's')->'es'. 
	self assert: enc merges second equals: #('es' 't')->'est'. 
]

{ #category : 'tests' }
BytePairEncoderTest >> text [
	^ 'old old old old old old old 
older older older
finest finest finest finest finest finest finest finest finest 
lowest lowest lowest lowest 
'
]

{ #category : 'tests - text2' }
BytePairEncoderTest >> text2 [
	^ '
low low low low low
lower lower
newest newest newest newest newest newest 
widest widest widest'
]

{ #category : 'tests - huggingface tutorial' }
BytePairEncoderTest >> text3 [
	"from hugging face
	
		String streamContents: [ :s |
		#(('hug' 10)  ('pug' 5)  ('pun' 12) ('bun' 4)  ('hugs' 5))
			do: [ :pair | pair second 
					timesRepeat: [ 
						s nextPutAll: pair first.
						s space ]].
			s ]
	"

	^ 'hug hug hug hug hug hug hug hug hug hug pug pug pug pug pug pun pun pun pun pun pun pun pun pun pun pun pun bun bun bun bun hugs hugs hugs hugs hugs '
]

{ #category : 'tests - tintin' }
BytePairEncoderTest >> textTintin [

	^ 'Tintin est un journaliste intrepide. Tintin et milou ont des aventures internationales.
	Tintin n''a pas de nom.'
]
