"
A HSimpleVisualizationBuilderTest is a test class for testing the behavior of HSimpleVisualizationBuilder
"
Class {
	#name : #HSimpleVisualizationBuilderTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Roassal3-Tests'
}

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testColorPalette [
	| root node1 node2 subnode1 subnode2 subnode3 subnode4 gnode1 gnode2 gnode3 gnode4 |
	root := HNode new name: 'Root'.
	node1 := HNode new name: 'Node1'.
	node2 := HNode new name: 'Node2'.

	subnode1 := HNode new name: 'SubNode1'.
	subnode2 := HNode new name: 'SubNode2'.
	subnode3 := HNode new name: 'SubNode3'.
	subnode4 := HNode new name: 'SubNode4'.

	gnode1 := HNode new name: 'GrandNode1'.
	gnode2 := HNode new name: 'GrandNode2'.
	gnode3 := HNode new name: 'GrandNode3'.
	gnode4 := HNode new name: 'GrandNode4'.
	root addAll: { node1. node2 }.

	node1 addAll: { subnode1. subnode2 }.
	node2 addAll: { subnode3. subnode4 }.

	subnode1 addAll: { gnode1. gnode2 }.
	subnode3 addAll: { gnode3. gnode4 }.

	gnode1 dependenciesToNodes: { gnode3. gnode4 }.
	gnode4 dependenciesToNodes: { gnode1. gnode2 }.
	root children do: [ :c1 |
		c1 color: Color red.
		c1 children do: [ :c2 | c2 color: Color green ] ].

	HSimpleVisualizationBuilder new
		rootNode: root;
		build
]

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testMoveOneChildInParent [
	| root node1  subnode1 visualization shapeNode1 shapeSubnode1 |
	root := HNode new name: 'Visualization'.
	node1 := HNode new name: 'Node1'.
	subnode1 := HNode new name: 'SubNode1'.
	root addAll: { node1. }.
	node1 addAll: { subnode1.}.
	
	visualization := HSimpleVisualizationBuilder new
		rootNode: root;
		build;
		yourself.
	shapeNode1 := visualization canvas shapeFromModel: node1.
	shapeSubnode1 := visualization canvas deepShapeFromModel: subnode1.
	shapeNode1 translateTo: 0@0.
	shapeSubnode1 translateTo: 100@100.
	self assert: shapeSubnode1 position equals: 0@0.
	self deny: shapeNode1 position equals: 0@0.
	

	
]
