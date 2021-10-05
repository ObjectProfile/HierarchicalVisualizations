"
base class for menu items
"
Class {
	#name : #HAbstractMenuItem,
	#superclass : #Object,
	#instVars : [
		'shape',
		'visualization'
	],
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #public }
HAbstractMenuItem class >> buildIn: aMenuMorph shape: aRoassalShape visualization: anHSimpleVisualizationBuilder [
	| items clazz |
	clazz := self classFor: aRoassalShape.
	items := clazz subclasses, { HInspectorMenuItem } collect: #new.
	items := items groupedBy: [ :item | item group ].
	items keys sorted do: [ :key | | group |
		group := (items at: key) sorted: [ :a :b | a order < b order ].
		group do: [ :item | 
			item
				shape: aRoassalShape;
				visualization: anHSimpleVisualizationBuilder;
				buildOn: aMenuMorph ]
		] separatedBy: [ aMenuMorph addSeparator ].
	
]

{ #category : #public }
HAbstractMenuItem class >> classFor: aRoassalShape [
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

{ #category : #accessing }
HAbstractMenuItem >> argument [
	^ nil
]

{ #category : #'building - menus' }
HAbstractMenuItem >> buildOn: aMenuMorph [
	| item |
	self canBeExecuted ifFalse: [ ^ self ].
	item := aMenuMorph
		add: self label
		target: self target
		selector: self selector
		argument: self argument.
	self iconName ifNil: [ ^ self ].
	item icon: (self iconNamed: self iconName).
]

{ #category : #testing }
HAbstractMenuItem >> canBeExecuted [
	^ true
]

{ #category : #execution }
HAbstractMenuItem >> execute [
]

{ #category : #accessing }
HAbstractMenuItem >> group [
	^ 0
]

{ #category : #accessing }
HAbstractMenuItem >> iconName [
	^ nil
]

{ #category : #accessing }
HAbstractMenuItem >> label [
	^ ''
]

{ #category : #accessing }
HAbstractMenuItem >> order [
	^ 0
]

{ #category : #accessing }
HAbstractMenuItem >> selector [
	^ #execute
]

{ #category : #accessing }
HAbstractMenuItem >> shape: anObject [

	shape := anObject
]

{ #category : #accessing }
HAbstractMenuItem >> target [
	^ self
]

{ #category : #accessing }
HAbstractMenuItem >> visualization [

	^ visualization
]

{ #category : #accessing }
HAbstractMenuItem >> visualization: anObject [

	visualization := anObject
]
