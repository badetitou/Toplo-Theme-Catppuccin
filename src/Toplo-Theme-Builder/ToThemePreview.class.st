Class {
	#name : 'ToThemePreview',
	#superclass : 'SpPresenter',
	#instVars : [
		'demo',
		'hostName',
		'list',
		'table',
		'notebook'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'initialization' }
ToThemePreview >> applyTheme: aTheme [
	"Install aTheme on the preview only, so the builder controls keep their own look."
	self adapter ifNotNil: [ :a | a widget localTheme: aTheme ]
]

{ #category : 'initialization' }
ToThemePreview >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		  spacing: 12;
		  borderWidth: 12;
		  add: self newSamplesLayout expand: false;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 12;
				   add: list;
				   add: table;
				   add: notebook;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
ToThemePreview >> initializePresenters [
	list := self newList
		        items: #( 'Primary' 'Info' 'Success' 'Warning' 'Error' 'Neutral' );
		        selectIndex: 2;
		        yourself.
	table := self newTable
		         addColumn: (SpStringTableColumn title: 'Role' evaluated: #first);
		         addColumn: (SpStringTableColumn title: 'State' evaluated: #second);
		         items: { { 'primary'. 'hover' }. { 'info'. 'active' }. { 'success'. 'disabled' }. { 'error'. 'focused' } };
		         yourself.
	notebook := self newNotebook.
	notebook addPageTitle: 'Text' provider: [ self newText text: 'The quick brown fox jumps over the lazy dog.'; yourself ].
	notebook addPageTitle: 'Progress' provider: [ self newProgressBar fixedPercentage: 70; yourself ]
]

{ #category : 'initialization' }
ToThemePreview >> newSamplesLayout [
	| radioA radioB |
	radioA := self newRadioButton label: 'Option A'; yourself.
	radioB := self newRadioButton label: 'Option B'; yourself.
	radioA associatedRadioButtons: { radioA. radioB }.
	radioA state: true.
	^ SpBoxLayout newTopToBottom
		  spacing: 10;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 8;
				   add: (self newButton label: 'Button'; yourself) expand: false;
				   add: (self newButton label: 'Disabled'; enabled: false; yourself) expand: false;
				   add: (self newToggleButton label: 'Toggle'; yourself) expand: false;
				   add: (self newTextInput placeholder: 'Type here...'; yourself);
				   add: (self newDropList items: #( 'Mauve' 'Blue' 'Green' ); yourself) expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 16;
				   add: (self newCheckBox label: 'Checked'; state: true; yourself) expand: false;
				   add: (self newCheckBox label: 'Unchecked'; yourself) expand: false;
				   add: radioA expand: false;
				   add: radioB expand: false;
				   add: (self newToggleButton label: 'On'; state: true; yourself) expand: false;
				   add: (self newSlider min: 0; max: 100; value: 40; yourself);
				   add: (self newProgressBar fixedPercentage: 60; yourself);
				   yourself)
		  expand: false;
		  yourself
]
