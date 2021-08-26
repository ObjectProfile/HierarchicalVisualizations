"
A HClassTest is a test class for testing the behavior of HClass
"
Class {
	#name : #HClassTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Model-Tests'
}

{ #category : #tests }
HClassTest >> testBasic [
	| c newName |
	c := HClass new
		name: 'Dummy'; 
		instVars: #();
		methods: #();
		yourself.
	
	newName := nil.
	c when: HNodeChangedEvent do: [ :evt | newName := evt node name ].
	c name: 'Dummy2'.
	self assert: newName equals: 'Dummy2'.
]
