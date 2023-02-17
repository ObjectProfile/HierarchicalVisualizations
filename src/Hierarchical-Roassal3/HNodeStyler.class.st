"
You can create a subclass of HLabeler, you will need to override the method labelFor:
"
Class {
	#name : #HNodeStyler,
	#superclass : #Object,
	#instVars : [
		'fontName',
		'fontSize',
		'color',
		'text',
		'popup',
		'location'
	],
	#category : #'Hierarchical-Roassal3-Configuration'
}

{ #category : #public }
HNodeStyler >> above [
	location := #above
]

{ #category : #public }
HNodeStyler >> below [
	location := #below
]

{ #category : #accessing }
HNodeStyler >> color [

	^ color
]

{ #category : #accessing }
HNodeStyler >> color: anObject [

	color := anObject
]

{ #category : #accessing }
HNodeStyler >> fontName [

	^ fontName
]

{ #category : #accessing }
HNodeStyler >> fontName: aFontname [

	fontName := aFontname
]

{ #category : #accessing }
HNodeStyler >> fontSize [

	^ fontSize
]

{ #category : #accessing }
HNodeStyler >> fontSize: anInteger [

	fontSize := anInteger
]

{ #category : #hooks }
HNodeStyler >> iconFor: anHNode [
	anHNode iconName ifNil: [ ^ nil ].
	^ RSBitmap new
		form: (self iconNamed: anHNode iconName);
		yourself.
		
]

{ #category : #initialization }
HNodeStyler >> initialize [
	super initialize.
	self text: #yourself.
	self color: Smalltalk ui theme textColor.
	self fontSize: 12.
	self fontName: 'Source Sans Pro'.
	self popup: RSPopup new.
	self above
]

{ #category : #hooks }
HNodeStyler >> labelAndIconFor: anHNode [
	| group icon |
	group := RSGroup new.
	icon := self iconFor: anHNode.
	icon ifNotNil: [ group add: icon ].
	group add: (self labelFor: anHNode).
	
	RSHorizontalLineLayout new alignMiddle; on: group.
	^ group.
]

{ #category : #hooks }
HNodeStyler >> labelFor: anHNode [
	^ RSLabel new
		color: (self color rsValue: anHNode);
		text: (self text rsValue: anHNode);
		fontName: (self fontName rsValue: anHNode);
		fontSize: (self fontSize rsValue: anHNode);
		yourself
]

{ #category : #accessing }
HNodeStyler >> location [

	^ location
]

{ #category : #accessing }
HNodeStyler >> popup [

	^ popup
]

{ #category : #accessing }
HNodeStyler >> popup: anObject [

	popup := anObject
]

{ #category : #accessing }
HNodeStyler >> text [

	^ text
]

{ #category : #accessing }
HNodeStyler >> text: aStringOrABlock [

	text := aStringOrABlock
]

{ #category : #hooks }
HNodeStyler >> textFor: anHNode [
	^ text rsValue: anHNode
]
