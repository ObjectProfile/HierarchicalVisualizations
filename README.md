# HierarchicalVisualizations

[![Tests](https://github.com/ObjectProfile/HierarchicalVisualizations/actions/workflows/runTests.yml/badge.svg)](https://github.com/ObjectProfile/HierarchicalVisualizations/actions/workflows/runTests.yml)

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
subnode3 := HNode new name: 'Sub1-1'.
subnode4 := HNode new name: 'Sub1-2'.
node1 addAll: { subnode3 . subnode4 }.

node2 := HNode new name: 'Node2'.
subnode1 := HNode new name: 'Sub2-1'.
subnode2 := HNode new name: 'Sub2-2'.
node2 addAll: {subnode1. subnode2}.
	
rootNode := HNode new name: 'Root'.
rootNode addAll: { node1. node2 }.
subnode3 dependenciesFromNodes: { subnode1. subnode2 }.

rootNode open.
```

The code above defines four nodes in total, structured as a hierarchy. Executing the code should shows:
<img width="500" alt="portfolio_view" src="https://raw.githubusercontent.com/ObjectProfile/HierarchicalVisualizations/main/scripts/simpleExample.png">

