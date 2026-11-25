Class {
	#name : 'ToThemeBuilder',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'preview',
		'editor',
		'popover',
		'resetButton',
		'exportButton',
		'colorRows',
		'settingRows',
		'selectedName',
		'syncing'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'instance creation' }
ToThemeBuilder class >> openInToplo [
	<script>
	^ self openOn: ToRawTheme new
]

{ #category : 'instance creation' }
ToThemeBuilder class >> openOn: aTheme [
	| app presenter |
	app := SpApplication new
		       useBackend: #Toplo;
		       yourself.
	presenter := self newApplication: app model: aTheme.
	presenter open.
	^ presenter
]

{ #category : 'initialization' }
ToThemeBuilder >> addSection: aTitle rows: rows to: aBox [
	aBox add: (self newLabel label: aTitle; yourself) expand: false.
	rows do: [ :r | aBox add: r expand: false ]
]

{ #category : 'flow' }
ToThemeBuilder >> applyTheme [
	preview applyTheme: self currentTheme
]

{ #category : 'settings - to override' }
ToThemeBuilder >> codeString [
	"A script reapplying the tokens changed since the theme was created."
	| fresh |
	fresh := self model class new.
	^ String streamContents: [ :s |
		  s nextPutAll: '| theme |'; cr.
		  s nextPutAll: 'theme := '; nextPutAll: self model class name; nextPutAll: ' new.'; cr.
		  self model tokenProperties do: [ :p |
			  fresh tokenProperties
				  detect: [ :f | f name = p name and: [ (p value isColor or: [ p value isNumber ]) and: [ f value ~= p value ] ] ]
				  ifFound: [ :f |
					  s
						  nextPutAll: 'theme tokenProperties select: [ :p | p name = ';
						  nextPutAll: p name printString;
						  nextPutAll: ' ] thenDo: [ :p | p value: ';
						  print: p value;
						  nextPutAll: ' ].';
						  cr ] ] ]
]

{ #category : 'flow' }
ToThemeBuilder >> color: aName pickedHex: aHex [
	syncing ifTrue: [ ^ self ].
	self hexOf: aName put: aHex.
	self refreshColor: aName.
	self colorsChanged.
	self applyTheme
]

{ #category : 'settings - to override' }
ToThemeBuilder >> colorGroups [
	"Editable colors, as associations title -> color names. By default the color tokens, grouped by prefix."
	^ self groupNames: (self tokensSatisfying: [ :v | v isColor ]) titled: 'COLOR'
]

{ #category : 'settings - to override' }
ToThemeBuilder >> colorOf: aName [
	^ (self tokenNamed: aName) value
]

{ #category : 'settings - to override' }
ToThemeBuilder >> colorsChanged [
	"Hook: a color changed."
]

{ #category : 'initialization' }
ToThemeBuilder >> connectPresenters [
	self whenBuiltDo: [ self applyTheme ]
]

{ #category : 'flow' }
ToThemeBuilder >> copyCode [
	Clipboard clipboardText: self codeString
]

{ #category : 'settings - to override' }
ToThemeBuilder >> currentTheme [
	"The theme shown in the preview."
	^ self model
]

{ #category : 'initialization' }
ToThemeBuilder >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		  add: self newToolbarLayout expand: false;
		  add: (SpBoxLayout newLeftToRight
				   add: self newSidebarLayout withConstraints: [ :c | c width: 410 ];
				   add: preview;
				   yourself);
		  yourself
]

{ #category : 'flow' }
ToThemeBuilder >> editColor: aName anchoredOn: aPresenter [
	"Open the color editor in a popover to the right of the clicked swatch, kept inside the window."
	| anchor rect top |
	self selectColor: aName.
	popover ifNil: [
		popover := self newPopover.
		popover presenter: editor.
		popover bePositionRight ].
	popover dismiss.
	popover relativeTo: aPresenter.
	anchor := aPresenter adapter widget.
	rect := anchor bounds inSpace bounds.
	top := (rect top min: anchor space extent y - 485) max: 0.
	popover popupPointingTo: ((rect left @ top) corner: (rect right @ (top + rect height))).
	popover adapter ifNotNil: [ :a | a popupWindowHandler popupOnPressed: false ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> extraSections [
	"Additional sections shown above the settings, as associations title -> presenters."
	^ #(  )
]

{ #category : 'settings - to override' }
ToThemeBuilder >> groupNames: names titled: aPrefix [
	"Group token names by the part before their first dash. Prefixes with a single token are merged in an OTHER group."
	| groups others result |
	groups := Dictionary new.
	names do: [ :n | (groups at: (n asString copyUpTo: $-) ifAbsentPut: [ OrderedCollection new ]) add: n ].
	others := OrderedCollection new.
	result := OrderedCollection new.
	groups keys sorted do: [ :k |
		| members |
		members := groups at: k.
		members size = 1
			ifTrue: [ others addAll: members ]
			ifFalse: [ result add: (aPrefix , ' - ' , k asUppercase) -> members asArray ] ].
	others ifNotEmpty: [ result add: (aPrefix , ' - OTHER') -> others asArray ].
	^ result asArray
]

{ #category : 'settings - to override' }
ToThemeBuilder >> hexOf: aName [
	"Hex string of a color, without its alpha."
	^ '#', (self colorOf: aName) asHexString asLowercase
]

{ #category : 'settings - to override' }
ToThemeBuilder >> hexOf: aName put: aHex [
	| old |
	self model tokenProperties
		select: [ :p | p name = aName ]
		thenDo: [ :p |
			old := p value.
			p value: ((Color fromHexString: aHex) alpha: old alpha) ]
]

{ #category : 'initialization' }
ToThemeBuilder >> initializePresenters [
	syncing := true.
	preview := self instantiate: ToThemePreview.
	editor := (self instantiate: ToThemeColorEditor)
		          whenChangedDo: [ :n :hex | self color: n pickedHex: hex ];
		          yourself.
	resetButton := self newButton label: 'Reset'; action: [ self resetTheme ]; yourself.
	exportButton := self newButton label: 'Export'; action: [ self copyCode ]; yourself.
	colorRows := OrderedDictionary new.
	self colorGroups do: [ :group | group value do: [ :n | colorRows at: n put: (self newColorRowNamed: n) ] ].
	settingRows := OrderedDictionary new.
	self settingGroups do: [ :group | group value do: [ :s | settingRows at: s name put: (self newSettingRow: s) ] ].
	colorRows ifNotEmpty: [ self selectColor: colorRows keys first ].
	syncing := false.
	self syncRows
]

{ #category : 'initialization' }
ToThemeBuilder >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self windowTitle;
		initialExtent: 1320 @ 820
]

{ #category : 'initialization' }
ToThemeBuilder >> newColorRowNamed: aName [
	| row |
	row := self instantiate: ToThemeColorRow.
	row
		colorName: aName hex: '#000000';
		whenChangedDo: [ :n :hex | self color: n pickedHex: hex ];
		whenSelectedDo: [ :n | self editColor: n anchoredOn: row ].
	^ row
]

{ #category : 'initialization' }
ToThemeBuilder >> newSettingRow: aSetting [
	^ (self instantiate: ToThemeSettingRow)
		  setting: aSetting;
		  whenChangedDo: [ :n :v | self setting: n pickedValue: v ];
		  yourself
]

{ #category : 'initialization' }
ToThemeBuilder >> newSidebarLayout [
	| box |
	box := SpBoxLayout newTopToBottom
		       spacing: 6;
		       borderWidth: 10;
		       yourself.
	self extraSections do: [ :section | self addSection: section key rows: section value to: box ].
	self settingGroups do: [ :group | self addSection: group key rows: (group value collect: [ :s | settingRows at: s name ]) to: box ].
	self colorGroups do: [ :group | self addSection: group key rows: (group value collect: [ :n | colorRows at: n ]) to: box ].
	^ SpScrollableLayout new
		  child: box;
		  yourself
]

{ #category : 'initialization' }
ToThemeBuilder >> newToolbarLayout [
	| box |
	box := SpBoxLayout newLeftToRight
		       spacing: 8;
		       borderWidth: 8;
		       yourself.
	self toolbarItems do: [ :assoc | box add: assoc key withConstraints: [ :c | c width: assoc value ] ].
	^ box
]

{ #category : 'flow' }
ToThemeBuilder >> refreshColor: aName [
	colorRows at: aName ifPresent: [ :row | row showHex: (self hexOf: aName) ].
	editor colorName = aName ifTrue: [ editor showHex: (self hexOf: aName) ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> resetSettings [
	| fresh |
	fresh := self model class new.
	self model tokenProperties do: [ :p |
		fresh tokenProperties
			detect: [ :f | f name = p name ]
			ifFound: [ :f | p value: f value ] ]
]

{ #category : 'flow' }
ToThemeBuilder >> resetTheme [
	self resetSettings.
	self syncRows.
	self applyTheme
]

{ #category : 'flow' }
ToThemeBuilder >> selectColor: aName [
	selectedName := aName.
	editor edit: aName hex: (self hexOf: aName)
]

{ #category : 'flow' }
ToThemeBuilder >> setting: aName pickedValue: aValue [
	syncing ifTrue: [ ^ self ].
	self setting: aName put: aValue.
	self applyTheme
]

{ #category : 'settings - to override' }
ToThemeBuilder >> setting: aName put: aValue [
	self model tokenProperties
		select: [ :p | p name = aName ]
		thenDo: [ :p | p value: aValue ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> settingGroups [
	"Editable numeric settings, as associations title -> ToThemeSetting. By default the numeric tokens, grouped by prefix."
	| settings |
	settings := self settings.
	^ (self groupNames: (settings collect: #name) titled: 'SIZE') collect: [ :group |
		  group key -> (group value collect: [ :n | settings detect: [ :s | s name = n ] ]) ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> settingValue: aName [
	^ (self tokenNamed: aName) value
]

{ #category : 'settings - to override' }
ToThemeBuilder >> settings [
	"Editable numeric settings as ToThemeSetting. By default every numeric token of the theme."
	^ (self tokensSatisfying: [ :v | v isNumber ]) collect: [ :n | ToThemeSetting name: n ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> syncExtras [
	"Hook: refresh the extra presenters after the settings changed as a whole."
]

{ #category : 'flow' }
ToThemeBuilder >> syncRows [
	syncing := true.
	colorRows keysAndValuesDo: [ :n :row | row showHex: (self hexOf: n) ].
	settingRows keysAndValuesDo: [ :n :row | row show: (self settingValue: n) ].
	selectedName ifNotNil: [ editor edit: selectedName hex: (self hexOf: selectedName) ].
	self syncExtras.
	syncing := false
]

{ #category : 'settings - to override' }
ToThemeBuilder >> tokenNamed: aName [
	^ self model tokenProperties detect: [ :p | p name = aName ]
]

{ #category : 'settings - to override' }
ToThemeBuilder >> tokensSatisfying: aBlock [
	^ (self model tokenProperties
		   select: [ :p | aBlock value: p value ]
		   thenCollect: [ :p | p name ]) asSet sorted
]

{ #category : 'initialization' }
ToThemeBuilder >> toolbarItems [
	"Presenters of the toolbar, each associated with its width. Subclasses extend it."
	^ { resetButton -> 70. exportButton -> 80 }
]

{ #category : 'initialization' }
ToThemeBuilder >> windowTitle [
	^ 'Toplo theme builder'
]
