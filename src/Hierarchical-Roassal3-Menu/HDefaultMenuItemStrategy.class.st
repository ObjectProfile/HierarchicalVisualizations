"
I am a strategy for HMenuBuilder.
I define menu items that can be executed (or needed) for a given object.
"
Class {
	#name : #HDefaultMenuItemStrategy,
	#superclass : #Object,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #public }
HDefaultMenuItemStrategy >> classFor: aRoassalShape [
	aRoassalShape isShape
		ifFalse: [ ^ HCanvasMenuItem ].
	^ aRoassalShape isNode
		ifTrue: [ 
			(aRoassalShape canvas selectedShapes notEmpty 
				and: [ (aRoassalShape canvas selectedShapes includes: aRoassalShape)])
				ifTrue: [ HGroupMenuItem ]
			 	ifFalse: [ HNodeMenuItem ] ]
		ifFalse: [ HLineMenuItem ]
		
]

{ #category : #public }
HDefaultMenuItemStrategy >> menuItemClassesFor: aShape [

	^ (self classFor: aShape) subclasses , { HInspectorMenuItem }
]
