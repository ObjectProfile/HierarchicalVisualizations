"
This class resizes the parent node when the whild node moves, this also move the inner title, and tried to ajust to the new size
"
Class {
	#name : #HResizeParentWhenChildMoves,
	#superclass : #RSResizeParentWhenChildMoves,
	#instVars : [
		'labeler'
	],
	#category : #'Hierarchical-Roassal3-Interactions'
}

{ #category : #hooks }
HResizeParentWhenChildMoves >> childrenFor: parent [
	^ parent schildren
]

{ #category : #hooks }
HResizeParentWhenChildMoves >> defaultPadding [
	^ 0
]

{ #category : #accessing }
HResizeParentWhenChildMoves >> nodeStyler [
	^ labeler
]

{ #category : #accessing }
HResizeParentWhenChildMoves >> nodeStyler: anHLabeler [
	labeler := anHLabeler
]

{ #category : #hooks }
HResizeParentWhenChildMoves >> parentFor: shape [
	^ shape sparent
]

{ #category : #hooks }
HResizeParentWhenChildMoves >> prepare: shape with: parent [
	parent model style updateShape: shape with: parent
]
