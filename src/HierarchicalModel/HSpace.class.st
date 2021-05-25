"
TODO
"
Class {
	#name : #HSpace,
	#superclass : #HModel,
	#instVars : [
		'packages'
	],
	#category : #HierarchicalModel
}

{ #category : #accessing }
HSpace >> add: anHPackage [
	packages add: anHPackage.
	self announce: (HItemAddedEvent new
		item: self;
		addedItem: anHPackage;
		yourself)
		
]

{ #category : #initialization }
HSpace >> initialize [
	super initialize.
	self packages: OrderedCollection new.
]

{ #category : #accessing }
HSpace >> packages [

	^ packages
]

{ #category : #accessing }
HSpace >> packages: aCollection [
	packages := aCollection
]
