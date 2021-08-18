Class {
	#name : #HHideAllLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HHideAllLinksMenuItem >> label [
	^ 'Hide All links'
]

{ #category : #accessing }
HHideAllLinksMenuItem >> order [
	^ 60
]

{ #category : #accessing }
HHideAllLinksMenuItem >> selector [
	^ #hideAllLinks
]

{ #category : #accessing }
HHideAllLinksMenuItem >> target [
	^ self
]
