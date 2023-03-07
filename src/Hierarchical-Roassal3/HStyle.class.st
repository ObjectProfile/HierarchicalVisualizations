Class {
	#name : #HStyle,
	#superclass : #Object,
	#category : #'Hierarchical-Roassal3'
}

{ #category : #hooks }
HStyle >> borderFor: node [
	^ node hasChildren
		ifTrue: [ RSBorder new 
			width: 2; 
			capSquare;
			joinMiter;
			color: Smalltalk ui theme textColor;
			dashArray: #(5 10);
			yourself  ]
		ifFalse: [ nil ]
]

{ #category : #hooks }
HStyle >> buildCompositeEmptyNodeIn: shape [

	self subclassResponsibility
]

{ #category : #hooks }
HStyle >> buildCompositeFullNodeIn: shape [

	self subclassResponsibility
]

{ #category : #private }
HStyle >> colorFor: node [

	^ Color colorFrom: (node color ifNil: [ #gray ])
]

{ #category : #hooks }
HStyle >> shapeFor: aHNode [

	| shape |
	shape := RSComposite new
		         model: aHNode;
		         yourself.
	(aHNode isExpanded and: [ aHNode hasChildren ])
		ifTrue: [ self buildCompositeFullNodeIn: shape ]
		ifFalse: [ self buildCompositeEmptyNodeIn: shape ].

	^ shape
]
