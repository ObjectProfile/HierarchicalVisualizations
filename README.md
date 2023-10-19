# HierarchicalVisualizations

[![CI/Pharo9](https://github.com/ObjectProfile/HierarchicalVisualizations/actions/workflows/runTests.yml/badge.svg)](https://github.com/ObjectProfile/HierarchicalVisualizations/actions/workflows/runTests.yml)

This project provide a small API to build hierarchical visualization using the [Pharo](http://pharo.org) programming language. HierarchicalVisualizations uses [Roassal](https://github.com/ObjectProfile/Roassal3).

### Install

Execute the following code snippet in a Playground:

```Smalltalk
[ Metacello new
    baseline: 'HierarchicalVisualizations';
    repository: 'github://ObjectProfile/HierarchicalVisualizations:main';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ]
```

### Example
Consider the following code snippet:
```Smalltalk
node1 := HNode new name: 'Node1'.
node1 color: Color blue translucent.

node2 := HNode new name: 'Node2'.
node2 color: Color green lighter lighter.
subnode1 := HNode new name: 'Sub1'.
subnode2 := HNode new name: 'Sub2'.
subnode3 := HNode new name: 'Sub3'.
subnode4 := HNode new name: 'Sub4'.

node1 addAll: {subnode1. subnode2}.
node2 addAll: {subnode3. subnode4}.
	
rootNode := HNode new name: 'Root'.
rootNode addAll: { node1. node2 }.
subnode3 dependenciesToNodes: { subnode1. subnode2 }.

rootNode open.
```

The code above defines four nodes in total, structured as a hierarchy. Executing the code should shows:
<img width="1021" alt="image" src="https://user-images.githubusercontent.com/393742/132356755-e3df5336-500a-4768-b585-c4a5c3e4f3bc.png">

Node can be collapsed or expanded:

<img width="496" alt="image" src="https://user-images.githubusercontent.com/393742/132356828-8dcd18d6-87d4-4cbe-8644-3b4ff91c1584.png">

New menu items can be defined by creating a subclass of `HAbstractMenuItem`. The package [`Hierarchical-Roassal3-Menu`](https://github.com/ObjectProfile/HierarchicalVisualizations/tree/main/src/Hierarchical-Roassal3-Menu) contains many examples on how to define a new menu item.

Roassal's layouts may be set in a `HNode`, as for example:

```Smalltalk
node1 := HNode new name: 'Node1'.
node1 layout: RSVerticalLineLayout new.
node2 := HNode new name: 'Node2'.
subnode1 := HNode new name: 'Sub1'.
subnode2 := HNode new name: 'Sub2'.
subnode3 := HNode new name: 'Sub3'.
subnode4 := HNode new name: 'Sub4'.

node1 addAll: {subnode1. subnode2}.
node2 addAll: {subnode3. subnode4}.
	
rootNode := HNode new name: 'Root'.
rootNode addAll: { node1. node2 }.
subnode3 dependenciesToNodes: { subnode1. subnode2 }.

rootNode add: HNode new.

rootNode open.
```
which produces: 
<img width="1021" alt="image" src="https://user-images.githubusercontent.com/393742/132359190-d0e41669-aa89-4413-9d33-c0d809fe2842.png">
