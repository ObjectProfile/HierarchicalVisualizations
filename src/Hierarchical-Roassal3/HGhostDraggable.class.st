"
This is a custom ghost draggable allowing to move several nodes. 
Because this visualization supports multiple selection
"
Class {
	#name : #HGhostDraggable,
	#superclass : #RSGhostDraggable,
	#category : #'Hierarchical-Roassal3-Interactions'
}

{ #category : #hooks }
HGhostDraggable >> createGhost: evt [
	| shapes |
	shapes := evt canvas selectedShapes.
	(shapes includes: evt shape) 
		ifTrue: [ shapes do: [ :shape | super createGhost: shape ] ]
		ifFalse: [ super createGhost: evt ].

]

{ #category : #hooks }
HGhostDraggable >> removeGhost: evt [
	| shapes |
	shapes := evt canvas selectedShapes.
	(shapes includes: evt shape) ifTrue: [ 
		shapes do: [ :shape | 
			super removeGhost: shape.
			"(shape propertyAt: #shadow) translateTo: shape position."
			 ] ]
	ifFalse: [ super removeGhost: evt ].

]

{ #category : #hooks }
HGhostDraggable >> updateGhost: evt [
	| shapes d |
	shapes := evt canvas selectedShapes.
	(shapes includes: evt shape) ifTrue: [ 
		shapes do: [ :shape |
			d := evt camera distanceFromPixelToSpace: evt step.
			(shape propertyAt: #ghost) translateBy: d.
			 ].
		evt signalUpdate ]
	ifFalse: [ super updateGhost: evt ].
]
