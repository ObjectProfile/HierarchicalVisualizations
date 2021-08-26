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
	| node1 node2 subnode1 subnode2 rootNode w nodeWithoutTitle |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	node1 dependenciesToNodes: { subnode1. subnode2 }.
	nodeWithoutTitle := HNode new.
	rootNode add: nodeWithoutTitle.
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
	
	subnode1 dependenciesToNodes: { subnode3 }.
	subnode4 dependenciesToNodes: { subnode2 }.
	
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
	
	gnode1 dependenciesToNodes: { gnode3. gnode4 }.
	gnode4 dependenciesToNodes: { gnode2. gnode4 }.
	self assert: node1 dependentsFromLinks isEmpty.
	self assert: node2 dependentsFromLinks isEmpty.
	node1 collapse.
	node2 collapse.
	
	self deny: node1 dependentsFromLinks isEmpty.
	self deny: node2 dependentsFromLinks isEmpty.
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
	
	node1 dependenciesToNodes: { subnode1. subnode2 }.
	
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

{ #category : #tests }
HNodeTest >> testDependencyTo [
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.

	subnode1 dependencyTo: node1.
	self assert: (node1 dependentsFromLinks includes: subnode1).
	node2 collapse.
	self assert: (node1 dependentsFromLinks includes: node2).
	
]

{ #category : #tests }
HNodeTest >> testExpandChildren [
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.
	rootNode collapseChildren.
	self deny: subnode1 isVisible.
	self deny: subnode1 isVisible.
	rootNode expandChildren.
	self assert: subnode1 isVisible.
	self assert: subnode1 isVisible.
]

{ #category : #tests }
HNodeTest >> testLevel [
	| node1 node2 subnode1 subnode2 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	subnode1 := HNode new name: 'Sub2-1'.
	subnode2 := HNode new name: 'Sub2-2'.
	node2 addAll: {subnode1. subnode2}.
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.

	self assert: rootNode level equals: 0.
	self assert: node1 level equals: 1.
	self assert: subnode1 level equals: 2.
]

{ #category : #tests }
HNodeTest >> testRemoveLink01 [
	| node1 node2 sub1 sub2 sub3 sub4 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	sub1 := HNode new name: 'Sub1'.
	sub2 := HNode new name: 'Sub2'.
	node1 addAll: {sub1. sub2}.
	
	sub3 := HNode new name: 'Sub3'.
	sub4 := HNode new name: 'Sub4'.
	node2 addAll: {sub3. sub4}.
	
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.

	sub1 dependenciesToNodes: { sub3. sub4 }.
	
	self assert: sub4 dependentsFromLinks size equals: 1.
	sub1 removeLinkTo: sub4.
	self assert: sub4 dependentsFromLinks size equals: 0.
	
]

{ #category : #tests }
HNodeTest >> testRemoveLink02 [
	| node1 node2 sub1 sub2 sub3 sub4 rootNode |
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.
	sub1 := HNode new name: 'Sub1'.
	sub2 := HNode new name: 'Sub2'.
	node1 addAll: {sub1. sub2}.
	
	sub3 := HNode new name: 'Sub3'.
	sub4 := HNode new name: 'Sub4'.
	node2 addAll: {sub3. sub4}.
	
	rootNode := HNode new name: 'Root'.
	rootNode addAll: {node1. node2}.

	sub1 dependenciesToNodes: { sub3. sub4 }.
	node1 collapse.
	
	self assert: sub4 dependentsFromLinks size equals: 1.
	node1 removeLinkTo: sub4.
	self assert: sub4 dependentsFromLinks size equals: 0.
	
]
