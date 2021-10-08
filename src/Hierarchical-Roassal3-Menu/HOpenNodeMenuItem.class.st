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
	copy fixDependents.
	copy open
]

{ #category : #accessing }
HOpenNodeMenuItem >> group [
	^ 100
]

{ #category : #accessing }
HOpenNodeMenuItem >> label [
	^ 'Open node'
]
