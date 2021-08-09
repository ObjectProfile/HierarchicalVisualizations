"
A HLinkTest is a test class for testing the behavior of HLink
"
Class {
	#name : #HLinkTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Model-Tests-Core'
}

{ #category : #tests }
HLinkTest >> testVisible [
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependenciesToNodes: { subnode1. subnode2 }.
	
	self assert: node1 dependencies size equals: 2.
	self assert: subnode1 dependentsFromLinks size equals: 1.
	self assert: subnode2 dependentsFromLinks size equals: 1.
	
	node1 dependencies first isVisible: false.
	self deny: node1 dependencies first isVisible.
	self assert: node1 dependencies size equals: 2.
	self assert: subnode1 dependentsFromLinks size equals: 0.
	
	node1 dependencies second isVisible: false.	
	
	self assert: node1 dependencies size equals: 2.
	self assert: subnode2 dependentsFromLinks size equals: 0.
	

]
