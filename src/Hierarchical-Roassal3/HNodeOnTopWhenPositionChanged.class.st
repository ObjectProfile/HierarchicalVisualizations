Class {
	#name : #HNodeOnTopWhenPositionChanged,
	#superclass : #RSInteraction,
	#category : #'Hierarchical-Roassal3-Interactions'
}

{ #category : #hooks }
HNodeOnTopWhenPositionChanged >> moveToTop: evt [
	| shape |
	shape := evt shape.
	shape ifNil: [ ^ self ].
	shape isInACanvas ifFalse: [ ^ self ].
	shape pushFront.
	(shape withAllChildren flatCollect: #connectedLines) do: #pushFront.
]

{ #category : #hooks }
HNodeOnTopWhenPositionChanged >> onShape: aShape [
	aShape
		when: RSPositionChangedEvent 
		send: #moveToTop:
		to: self
]
