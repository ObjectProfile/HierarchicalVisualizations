"
utility class to have always a border in the same position of one box
"
Class {
	#name : #HUpdateSelectionBox,
	#superclass : #RSInteraction,
	#category : #'Hierarchical-Roassal3-Interactions'
}

{ #category : #hooks }
HUpdateSelectionBox >> onShape: aShape [
	aShape
		when: RSPositionChangedEvent 
		send: #updateSelectionBox:
		to: self.
		
]

{ #category : #hooks }
HUpdateSelectionBox >> updateSelectionBox: evt [
	| border |
	border := evt shape selectionBox.
	border ifNil: [ ^ self ].
	
	border fromRectangle: evt shape encompassingRectangle.
	border extent: border extent + 4.
]
