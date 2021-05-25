"
TODO
"
Class {
	#name : #SPHierarchical,
	#superclass : #SpPresenter,
	#instVars : [
		'space',
		'spaceView'
	],
	#category : #'Hierarchical-Spec'
}

{ #category : #specs }
SPHierarchical class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #spaceView;
		yourself
]

{ #category : #initialization }
SPHierarchical class >> initializePresenters [
	spaceView := SpRoassalPresenter new
]

{ #category : #accessing }
SPHierarchical >> hspace: aHSpace [ 
	space := aHSpace
]

{ #category : #initialization }
SPHierarchical >> initializePresenters [
	super initializePresenters.
	spaceView := SpRoassalPresenter new
]
