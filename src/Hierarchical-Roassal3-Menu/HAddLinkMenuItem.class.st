"
This menu item adds a new draggable interaction to the canvas and then creates a new line between the selected nodes
"
Class {
	#name : #HAddLinkMenuItem,
	#superclass : #HNodeMenuItem,
	#category : #'Hierarchical-Roassal3-Menu'
}

{ #category : #execution }
HAddLinkMenuItem >> execute [
	| canvas line  pointer |
	canvas := visualization canvas.
	pointer := RSEllipse new
		noPaint;
		withBorder;
		size: 5;
		yourself.
	line := visualization lineBuilder edgeFrom: shape to: pointer.
	canvas add: pointer.
	{canvas. visualization baseNode} asGroup
		when: RSMouseMove do: [ :evt | 
			pointer 
				translateTo: evt position;
				signalUpdate ];
		when: RSMouseClick do: [:evt | 
			line remove. 
			pointer remove. 
			visualization baseNode removeInteractionIfPresent: self class.
			canvas removeInteractionIfPresent: self class.
			
			canvas
				propertyAt: visualization highlightable propertyKey
				ifPresent: [:shapes |
					shape model dependencyTo: (self modelFor: shapes last).
					visualization rebuildLines: shape.
					].
			evt signalUpdate ].
	
		
	
	
	
]

{ #category : #accessing }
HAddLinkMenuItem >> group [
	^ 2
]

{ #category : #accessing }
HAddLinkMenuItem >> label [
	^ 'Add dependency to'
]

{ #category : #hooks }
HAddLinkMenuItem >> modelFor: aShape [
	^ aShape model 
		ifNil: [ self modelFor: aShape parent ]
		ifNotNil: [ aShape model ]
	
]

{ #category : #accessing }
HAddLinkMenuItem >> order [
	^ 40
]
