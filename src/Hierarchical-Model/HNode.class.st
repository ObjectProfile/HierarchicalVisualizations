"
TODO
"
Class {
	#name : #HNode,
	#superclass : #Object,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'name',
		'rawModel',
		'parent',
		'isExpanded',
		'children'
	],
	#category : #'Hierarchical-Model'
}

{ #category : #adding }
HNode >> add: anHNode [
	anHNode addedIn: self.
]

{ #category : #adding }
HNode >> addAll: aCollection [
	aCollection do: [ :item | self add: item ]
	
]

{ #category : #adding }
HNode >> addChild: anHNode [
	children add: anHNode
]

{ #category : #adding }
HNode >> addedIn: anHNode [
	anHNode addItem: self.
	self parent: anHNode.
]

{ #category : #announcer }
HNode >> announcementClasses [
	^ #()
]

{ #category : #announcer }
HNode >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #public }
HNode >> collapse [
	self announce: HCollapseEvent new
]

{ #category : #public }
HNode >> expand [
	self announce: HExpandEvent new
]

{ #category : #public }
HNode >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
	isExpanded := isExpanded not
]

{ #category : #initialization }
HNode >> initialize [
	super initialize.
	children := OrderedCollection new.
	isExpanded := true.
]

{ #category : #testing }
HNode >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
HNode >> items [

	^ children
]

{ #category : #accessing }
HNode >> items: anObject [

	children := anObject
]

{ #category : #accessing }
HNode >> name [
	^ name
]

{ #category : #accessing }
HNode >> name: aString [
	| oldName |
	oldName := name.
	name := aString.
	self announce: (HItemNameChangedEvent new
		item: self;
		oldName: oldName;
		newName: name;
		yourself)
		
]

{ #category : #accessing }
HNode >> parent [

	^ parent
]

{ #category : #accessing }
HNode >> parent: anObject [

	parent := anObject
]

{ #category : #announcer }
HNode >> privateAnnouncer [
	^ announcer
]

{ #category : #accessing }
HNode >> rawModel [

	^ rawModel
]

{ #category : #accessing }
HNode >> rawModel: anObject [
	rawModel := anObject
]
