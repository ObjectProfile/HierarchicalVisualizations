Class {
	#name : #HShowAllLinksInCanvasMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HShowAllLinksInCanvasMenuItem >> execute [
	visualization rootNode showAllLinks.
	visualization rebuildLines: visualization canvas.
]

{ #category : #accessing }
HShowAllLinksInCanvasMenuItem >> label [
	^ 'Show all links'
]

{ #category : #accessing }
HShowAllLinksInCanvasMenuItem >> order [
	^ 20
]
