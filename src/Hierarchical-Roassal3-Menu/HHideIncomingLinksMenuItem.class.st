Class {
	#name : #HHideIncomingLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HHideIncomingLinksMenuItem >> label [
	^ 'Hide incoming links'
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> order [
	^ 61
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> selector [
	^ #hideIncomingLinks
]

{ #category : #accessing }
HHideIncomingLinksMenuItem >> target [
	^ self
]
