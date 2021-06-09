"
TODO
"
Class {
	#name : #HNameSpace,
	#superclass : #HNode,
	#category : #'Hierarchical-Model'
}

{ #category : #'as yet unclassified' }
HNameSpace >> classAt: aString [
	^ (self packages flatCollect: [ :pkg | pkg classes ])
		detect: [ :cls | cls name = aString ]
	 	ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
HNameSpace >> dependentClassesFor: anHClass [
	^ anHClass rawModel dependentClasses
		collect: [:rawClass | self classAt: rawClass name ]
		thenSelect: [ :hclazz | hclazz notNil ].
	
]

{ #category : #accessing }
HNameSpace >> packages [
	^ children
]
