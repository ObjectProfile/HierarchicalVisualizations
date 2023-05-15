"
A HSimpleVisualizationBuilderTest is a test class for testing the behavior of HSimpleVisualizationBuilder
"
Class {
	#name : #HSimpleVisualizationBuilderTest,
	#superclass : #TestCase,
	#category : #'Hierarchical-Roassal3-Tests'
}

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testAddingEntity [
	| root visualization newNode1 newNode2 shapeNode1 shapeNode2 |
	root := HNode named: 'Visualization'.
	visualization := HSimpleVisualizationBuilder new
		rootNode: root;
		build;
		yourself.
	newNode1 := HNode named: 'New'.
	newNode2 := HNode named: 'Old'.
	root add: newNode1.
	root add: newNode2.
	
	shapeNode1 := visualization canvas shapeFromModel: newNode1.
	shapeNode2 := visualization canvas shapeFromModel: newNode2.
	self assert: shapeNode1 model equals: newNode1.
	self assert: shapeNode2 model equals: newNode2.
	newNode1 dependencyTo: newNode2.
	visualization rebuildLines: shapeNode1.
	self assert: visualization canvas lines notEmpty.
	
]

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testColorPalette [
	| root node1 node2 subnode1 subnode2 subnode3 subnode4 gnode1 gnode2 gnode3 gnode4 |
	root := HNode named: 'Root'.
	node1 := HNode named: 'Node1'.
	node2 := HNode named: 'Node2'.

	subnode1 := HNode named: 'SubNode1'.
	subnode2 := HNode named: 'SubNode2'.
	subnode3 := HNode named: 'SubNode3'.
	subnode4 := HNode named: 'SubNode4'.

	gnode1 := HNode named: 'GrandNode1'.
	gnode2 := HNode named: 'GrandNode2'.
	gnode3 := HNode named: 'GrandNode3'.
	gnode4 := HNode named: 'GrandNode4'.
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
	root := HNode named: 'Visualization'.
	node1 := HNode named: 'Node1'.
	subnode1 := HNode named: 'SubNode1'.
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

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testNodeWithoutTitle [

	| node1 node2 subnode1 subnode2 subnode3 subnode4 rootNode |
	node1 := HNode named: 'Node1'.
	node2 := HNode named: 'Node2'.
	subnode1 := HNode named: 'Sub1'.
	subnode2 := HNode named: 'Sub2'.
	subnode3 := HNode named: 'Sub3'.
	subnode4 := HNode named: 'Sub4'.

	node1 addAll: { 
			subnode1.
			subnode2 }.
	node2 addAll: { 
			subnode3.
			subnode4 }.

	rootNode := HNode named: 'Root'.
	rootNode addAll: { 
			node1.
			node2 }.
	subnode3 dependenciesToNodes: { 
			subnode1.
			subnode2 }.

	rootNode add: HNode new.

	rootNode open delete
]

{ #category : #tests }
HSimpleVisualizationBuilderTest >> testTestMoveNode [
	| root node1 node2 subnode1 visualization shapeNode1 |
	"This test is for class HNodeOnTopWhenPositionChanged"
	root := HNode named: 'Visualization'.
	node1 := HNode named: 'Node1'.
	node2 := HNode named: 'node2'.
	subnode1 := HNode named: 'SubNode1'.
	root addAll: { node1. node2 }.
	node1 addAll: { subnode1.}.
	
	visualization := HSimpleVisualizationBuilder new
		rootNode: root;
		build;
		yourself.
	shapeNode1 := visualization canvas shapeFromModel: node1.
	self assert: visualization canvas shapes first equals: shapeNode1.
	shapeNode1 translateTo: 100 asPoint.
	self assert: visualization canvas shapes last equals: shapeNode1.
	
]
