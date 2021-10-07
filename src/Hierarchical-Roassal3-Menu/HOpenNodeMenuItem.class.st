"
Open a new window
"
Class {
	#name : #HOpenNodeMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HOpenNodeMenuItem >> canBeExecuted [
	^ shape model hasChildren
]

{ #category : #accessing }
HOpenNodeMenuItem >> execute [
	| copy |
	copy := shape model copy.
	self fixDependencies: copy.
	copy open
]

{ #category : #accessing }
HOpenNodeMenuItem >> fixDependencies: node [
	node dependencies: (node dependencies collect: [:link | | linkCopy |
		linkCopy := link copy.
		linkCopy
			from: (node topParent globalChildEquals: link from);
			to: (node topParent globalChildEquals: link to);
			yourself
		] thenReject: [:link | link from isNil or: [ link to isNil ] ]).
	node children do: [ :child | self fixDependencies: child ].
]

{ #category : #accessing }
HOpenNodeMenuItem >> group [
	^ 100
]

{ #category : #accessing }
HOpenNodeMenuItem >> label [
	^ 'Open node'
]
