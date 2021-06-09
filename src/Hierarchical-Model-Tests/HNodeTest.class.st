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
	node1 dependencies: { subnode1. subnode2 }.
	subnode1 dependencies: { node1 }.
	subnode2 dependencies: { node1 }.
	
	w := rootNode open.
	w delete.

]
