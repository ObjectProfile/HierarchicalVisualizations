Class {
	#name : #HStyleTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'styleClass',
		'rootNode'
	],
	#category : #'Hierarchical-Roassal3-Tests'
}

{ #category : #tests }
HStyleTest class >> testParameters [
	^ ParametrizedTestMatrix new
		forSelector: #styleClass
		addOptions: HStyle allSubclasses
]

{ #category : #initialization }
HStyleTest >> setUp [

	super setUp.
	rootNode := HNode new.
	rootNode name: 'ROOT'
]

{ #category : #accessing }
HStyleTest >> styleClass [

	^ styleClass
]

{ #category : #accessing }
HStyleTest >> styleClass: anObject [

	styleClass := anObject
]

{ #category : #tests }
HStyleTest >> testShapeForWithChildren [

	| style |
	style := styleClass new.
	1 to: 10 do: [ :i | 
		rootNode add: (HNode new
				 name: 'number ' , i asString;
				 yourself) ].
	self assert: ((style shapeFor: rootNode) isKindOf: RSShape)
]

{ #category : #tests }
HStyleTest >> testShapeForWithNoChildren [

	| style |
	style := styleClass new.
	
	self assert: ((style shapeFor: rootNode) isKindOf: RSShape)
]
