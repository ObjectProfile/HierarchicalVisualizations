"
This menu hides all the links in the root node
"
Class {
	#name : #HHideAllLinksInCanvasMenuItem,
	#superclass : #HCanvasMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HHideAllLinksInCanvasMenuItem >> execute [
	visualization rootNode hideAllLinks.
	visualization rebuildLines: visualization canvas.
]

{ #category : #accessing }
HHideAllLinksInCanvasMenuItem >> label [
	^ 'Hide all links'
]

{ #category : #accessing }
HHideAllLinksInCanvasMenuItem >> order [
	^ 21
]
