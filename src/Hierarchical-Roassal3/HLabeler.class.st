"
You can create a subclass of HLabeler, you will need to override the method labelFor:
"
Class {
	#name : #HLabeler,
	#superclass : #Object,
	#instVars : [
		'position',
		'fontName',
		'fontSize',
		'color',
		'text'
	],
	#category : #'Hierarchical-Roassal3-Configuration'
}

{ #category : #public }
HLabeler >> above [
	position := #above
]

{ #category : #public }
HLabeler >> below [
	position := #below
]

{ #category : #accessing }
HLabeler >> color [

	^ color
]

{ #category : #accessing }
HLabeler >> color: anObject [

	color := anObject
]

{ #category : #accessing }
HLabeler >> fontName [

	^ fontName
]

{ #category : #accessing }
HLabeler >> fontName: anObject [

	fontName := anObject
]

{ #category : #accessing }
HLabeler >> fontSize [

	^ fontSize
]

{ #category : #accessing }
HLabeler >> fontSize: anObject [

	fontSize := anObject
]

{ #category : #hooks }
HLabeler >> iconFor: anHNode [
	anHNode iconName ifNil: [ ^ nil ].
	^ RSBitmap new
		form: (self iconNamed: anHNode iconName);
		yourself.
		
]

{ #category : #initialization }
HLabeler >> initialize [
	super initialize.
	self text: #yourself.
	self color: Smalltalk ui theme textColor.
	self fontSize: 12.
	self fontName: 'Source Sans Pro'.
	self above
]

{ #category : #hooks }
HLabeler >> labelAndIconFor: anHNode [
	| group icon |
	group := RSGroup new.
	icon := self iconFor: anHNode.
	icon ifNotNil: [ group add: icon ].
	group add: (self labelFor: anHNode).
	
	RSHorizontalLineLayout new alignMiddle; on: group.
	^ group.
]

{ #category : #hooks }
HLabeler >> labelFor: anHNode [
	^ RSLabel new
		color: (self color rsValue: anHNode);
		text: (self text rsValue: anHNode);
		fontName: (self fontName rsValue: anHNode);
		fontSize: (self fontSize rsValue: anHNode);
		yourself
]

{ #category : #accessing }
HLabeler >> position [

	^ position
]

{ #category : #accessing }
HLabeler >> text [

	^ text
]

{ #category : #accessing }
HLabeler >> text: anObject [

	text := anObject
]

{ #category : #hooks }
HLabeler >> textFor: anHNode [
	^ text rsValue: anHNode
]
