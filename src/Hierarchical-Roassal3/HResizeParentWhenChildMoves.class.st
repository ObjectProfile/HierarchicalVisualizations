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

	| children title titleBox boxChildren list style |
	children := shape parent.
	children
		adjustToChildren;
		padding: 10.
	parent schildren do: [ :child | child model position: child position ].
	"shape model position: shape position."
	title := parent children first.
	titleBox := title children first.
	titleBox extent: title children allButFirst extent + 10.
	title adjustToChildren.
	boxChildren := parent children second.
	title width < children width
		ifTrue: [ 
			titleBox width: children width.
			title adjustToChildren ]
		ifFalse: [ children width: title width ].
	list := { 
		        title.
		        children }.
	style := shape model style.
	style titleLocation = #below ifTrue: [ 
		list := { 
			        children.
			        title } ].
	RSVerticalLineLayout new
		gapSize: 0;
		on: list.
	boxChildren fromRectangle: children encompassingRectangle
]
