"
menu item to remove a link from an HNode
"
Class {
	#name : #HRemoveLineMenuItem,
	#superclass : #HLineMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #accessing }
HRemoveLineMenuItem >> label [
	^ 'Remove link'
]

{ #category : #accessing }
HRemoveLineMenuItem >> order [
	^ 10
]

{ #category : #accessing }
HRemoveLineMenuItem >> removeLink [
	shape model key removeLinkTo: shape model value.
	visualization rebuildLines: shape.
	
]

{ #category : #accessing }
HRemoveLineMenuItem >> selector [
	^ #removeLink
]

{ #category : #accessing }
HRemoveLineMenuItem >> target [
	^ self
]
