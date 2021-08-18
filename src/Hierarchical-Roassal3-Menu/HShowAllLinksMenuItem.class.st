Class {
	#name : #HShowAllLinksMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HShowAllLinksMenuItem >> label [
	^ 'Show All links'
]

{ #category : #accessing }
HShowAllLinksMenuItem >> order [
	^ 50
]

{ #category : #accessing }
HShowAllLinksMenuItem >> selector [
	^ #showAllLinks
]

{ #category : #accessing }
HShowAllLinksMenuItem >> target [
	^ self
]
