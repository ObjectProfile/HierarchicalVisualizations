"
A HSpaceTest is a test class for testing the behavior of HSpace
"
Class {
	#name : #HSpaceTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Model-Tests'
}

{ #category : #tests }
HSpaceTest >> testBasic [
	| s p counter |
	s := HNameSpace new.
	p := HPackage new.
	p name: 'Hierarchy'.
	counter := 0.
	s when: HNodeAddedEvent do: [ :evt | 
		self assert: evt newChild equals: p.
		counter := counter + 1 ].
	s add: p.
	self assert: counter equals: 1.
	
]
