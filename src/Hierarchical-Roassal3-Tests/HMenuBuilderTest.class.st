Class {
	#name : #HMenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'menuBuilder'
	],
	#category : #'Hierarchical-Roassal3-Tests'
}

{ #category : #running }
HMenuBuilderTest >> setUp [
	super setUp.
	
	menuBuilder := HMenuBuilder new.
]

{ #category : #tests }
HMenuBuilderTest >> testInspectRawModel [
	| node rootNode item shape |
	node := HNode new name: 'Node1' ; rawModel: #anObject.

	rootNode := HNode named: 'Root'.
	rootNode add: 	node.

	shape := RSComposite model: node.
	item := HInspectorMenuItem new.
	item shape: shape.
	
self assert: item target equals: #anObject
]

{ #category : #tests }
HMenuBuilderTest >> testMenuForCanvas [

	| items |
	items := menuBuilder menuItemsFor: RSCanvas new.
	self assert: items size equals: HCanvasMenuItem subclasses size + 1.
	self assert:
		(items anySatisfy: [ :i | i class = HInspectorMenuItem ])
]

{ #category : #tests }
HMenuBuilderTest >> testMenuForGroup [

	| items shapes canvas |
	canvas := RSCanvas new.
	shapes := { 
		          RSComposite new.
		          RSComposite new }.
	canvas addAll: shapes.
	canvas selectedShapes: shapes.
	items := menuBuilder menuItemsFor: shapes first.
	self assert: items size equals: HGroupMenuItem subclasses size + 1.
]

{ #category : #tests }
HMenuBuilderTest >> testMenuForLine [

	| items |
	items := menuBuilder menuItemsFor: RSLine new.
	self assert: items size equals: HLineMenuItem subclasses size + 1.
	self assert:
		(items anySatisfy: [ :i | i class = HInspectorMenuItem ])
]

{ #category : #tests }
HMenuBuilderTest >> testMenuForNode [

	| items canvas shape |
	canvas := RSCanvas new.
	shape := RSComposite new.
	canvas add: shape.
	items := menuBuilder menuItemsFor: shape.

	self assert: items size equals: HNodeMenuItem subclasses size + 1.
	self assert:
		(items anySatisfy: [ :i | i class = HInspectorMenuItem ])
]
