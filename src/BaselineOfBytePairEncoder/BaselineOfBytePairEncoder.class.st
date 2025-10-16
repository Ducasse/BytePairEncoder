"
Baseline for Beacon - a slim logging engine based entirely on Announcements
"
Class {
	#name : 'BaselineOfBytePairEncoder',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBytePairEncoder',
	#package : 'BaselineOfBytePairEncoder'
}

{ #category : 'baselines' }
BaselineOfBytePairEncoder >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				package: #'BytePairEncoder'.
			spec
				group: 'Core' with: #( 'BytePairEncoder' );
				group: 'default'
				with: #( 'BytePairEncoder' ) ]
]
