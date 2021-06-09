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
		'children',
		'dependencies'
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
	children add: anHNode.
	self announce: (HNodedAddedEvent new
		newChild: anHNode;
		yourself)
]

{ #category : #adding }
HNode >> addedIn: anHNode [
	anHNode addChild: self.
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

{ #category : #accessing }
HNode >> children [

	^ children
]

{ #category : #accessing }
HNode >> children: aCollection [

	children := aCollection
]

{ #category : #public }
HNode >> collapse [
	isExpanded := false.
	self announce: HCollapsedEvent new
	
]

{ #category : #accessing }
HNode >> dependencies [

	^ dependencies
]

{ #category : #accessing }
HNode >> dependencies: anObject [

	dependencies := anObject
]

{ #category : #public }
HNode >> expand [
	isExpanded := true.
	self announce: HExpandedEvent new
]

{ #category : #public }
HNode >> expandCollapse [
	isExpanded 
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].
]

{ #category : #testing }
HNode >> hasChildren [
	^ children notEmpty
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
HNode >> name [
	^ name
]

{ #category : #accessing }
HNode >> name: aString [
	| oldName |
	oldName := name.
	name := aString.
	self announce: (HNodeNameChangedEvent new
		node: self;
		oldName: oldName;
		newName: name;
		yourself)
		
]

{ #category : #accessing }
HNode >> parent [

	^ parent
]

{ #category : #accessing }
HNode >> parent: anHNode [

	parent := anHNode
]

{ #category : #printing }
HNode >> printOn: stream [
	stream << name.
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
