"
A HNodeTest is a test class for testing the behavior of HNode
"
Class {
	#name : #HNodeTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Model-Tests'
}

{ #category : #tests }
HNodeTest >> testBasic [
	| node1 node2 subnode1 subnode2 rootNode w |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependenciesFromNodes: { subnode1. subnode2 }.
	
	w := rootNode open.
	w delete.

]

{ #category : #tests }
HNodeTest >> testCollapseNodes [
	| node1 node2 subnode1 subnode2 subnode3 subnode4 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	subnode3 := HNode new name: 'Sub2-3'.
	subnode4 := HNode new name: 'Sub2-4'.
	node1 addAll: { subnode1. subnode2 }.
	node2 addAll: { subnode3. subnode4 }.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	
	subnode1 dependenciesFromNodes: { subnode3 }.
	subnode4 dependenciesFromNodes: { subnode2 }.
	
	self assert: subnode3 dependentsFromLinks asArray first equals: subnode1.
	self assert: subnode2 dependentsFromLinks asArray first equals: subnode4.
	
	self assert: node1 dependentsFromLinks isEmpty.
	self assert: node2 dependentsFromLinks isEmpty.
	
	node1 collapse.
	node2 collapse.
	
	self deny: node1 dependentsFromLinks isEmpty.
	self deny: node2 dependentsFromLinks isEmpty.
	
	self assert: node1 dependentsFromLinks asArray first equals: node2.
	self assert: node2 dependentsFromLinks asArray first equals: node1.
	
	
	
]

{ #category : #tests }
HNodeTest >> testCollapseNodes3Levels [
	| node1 node2 subnode1 subnode2 subnode3 subnode4 gnode1 gnode2 gnode3 gnode4 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	subnode3 := HNode new name: 'Sub2-3'.
	subnode4 := HNode new name: 'Sub2-4'.
	gnode1 := HNode new name: 'Sub3-1'.
	gnode2 := HNode new name: 'Sub3-2'.
	gnode3 := HNode new name: 'Sub3-3'.
	gnode4 := HNode new name: 'Sub3-4'.
	
	subnode1 addAll: { gnode1. gnode2 }.
	subnode4 addAll: { gnode3. gnode4 }.
	
	node1 addAll: { subnode1. subnode2 }.
	node2 addAll: { subnode3. subnode4 }.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	
	gnode1 dependenciesFromNodes: { gnode3. gnode4 }.
	gnode4 dependenciesFromNodes: { gnode3. gnode4 }.
]

{ #category : #tests }
HNodeTest >> testDependencies [
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	
	node1 dependenciesFromNodes: { subnode1. subnode2 }.
	
	self assert: node1 dependencies size equals: 2.
	self assert: node1 dependencies first class equals: HLink.
	self assert: node1 dependencies first from equals: node1.
	self assert: node1 dependencies first to equals: subnode1.
	
	self assert: node1 dependentsFromLinks size equals: 0.
	self assert: (subnode1 dependentsFromLinks includes: node1).
	self assert: node2 dependentsFromLinks size equals: 0.
	node2 collapse.
	self assert: node1 dependencies size equals: 2.
	self assert: node2 dependentsFromLinks size equals: 1.
	self assert: (node2 dependentsFromLinks includes: node1).
	
	
	
]
