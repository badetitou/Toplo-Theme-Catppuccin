Class {
	#name : 'ToThemeBuilder',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'menu',
		'demo',
		'refreshButton',
		'propertyList'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'layout' }
ToThemeBuilder class >> openInToplo [

	<script>
	| app demo |
	app := SpApplication new
		       useBackend: #Toplo;
		       yourself.

	demo := self newApplication: app model: ToCatppuccinMochaTheme new.
	demo open.
	^ demo
]

{ #category : 'initialization' }
ToThemeBuilder >> buildEditorColumn [

	propertyList addColumn: (SpColumnViewColumn new
			 title: 'Property Value';
			 setup: [ :aPresenter | aPresenter newTextInput ];
			 bind: [ :aPresenter :property | aPresenter ];
			 yourself)
]

{ #category : 'layout' }
ToThemeBuilder >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		  positionOfSlider: 250;
		  add: (SpBoxLayout newTopToBottom
				   add: propertyList;
				   add: refreshButton expand: false;
				   yourself);
		  add: demo;
		  yourself
]

{ #category : 'initialization' }
ToThemeBuilder >> initializePresenters [

	super initializePresenters.
	demo := self application instantiate: SpDemo.
	refreshButton := self newButton.
	refreshButton label: 'refresh'.
	propertyList := self newColumnView.
	propertyList addColumn: (SpColumnViewColumn new
			 title: 'Property name';
			 setup: [ :aPresenter | aPresenter newLabel ];
			 bind: [ :aPresenter :property | aPresenter label: property name ];
			 yourself).
	self buildEditorColumn.
	propertyList beResizable.

	refreshButton action: [ self adapter widget space root localTheme: self model ]
]

{ #category : 'initialization' }
ToThemeBuilder >> modelChanged [

	propertyList items: (self model tokenProperties sorted: [ :a :b | a name < b name ])
]
