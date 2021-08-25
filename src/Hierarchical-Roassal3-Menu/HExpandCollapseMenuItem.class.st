"
this menu item, expands or collapses the current node
"
Class {
	#name : #HExpandCollapseMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #testing }
HExpandCollapseMenuItem >> canBeExecuted [
	^ shape model children isNotEmpty
]

{ #category : #accessing }
HExpandCollapseMenuItem >> label [
	^ shape model isExpanded
		ifTrue: [ 'Collapse' ]
		ifFalse: [ 'Expand' ]
]

{ #category : #accessing }
HExpandCollapseMenuItem >> order [
	^ 0
]

{ #category : #accessing }
HExpandCollapseMenuItem >> selector [
	^ #expandCollapse
]

{ #category : #accessing }
HExpandCollapseMenuItem >> target [
	^ shape model
]
