"
You can define a new style for a RSLineBuilder
"
Class {
	#name : #HLinkStyler,
	#superclass : #Object,
	#instVars : [
		'lineBuilder'
	],
	#category : #'Hierarchical-Roassal3-Configuration'
}

{ #category : #initialization }
HLinkStyler >> defaultLineBuilder [
	^ RSLineBuilder line
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		markerEnd: (RSShapeFactory arrow size: 10);
		color: Smalltalk ui theme textColor translucent;
		yourself
]

{ #category : #initialization }
HLinkStyler >> initialize [
	self lineBuilder: self defaultLineBuilder.
]

{ #category : #accessing }
HLinkStyler >> lineBuilder [
	^ lineBuilder
]

{ #category : #accessing }
HLinkStyler >> lineBuilder: anObject [

	lineBuilder := anObject
]
