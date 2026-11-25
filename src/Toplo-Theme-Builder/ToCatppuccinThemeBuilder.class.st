Class {
	#name : 'ToCatppuccinThemeBuilder',
	#superclass : 'ToThemeBuilder',
	#instVars : [
		'variantDrop',
		'shuffleButton',
		'roleRows',
		'themeClass',
		'palette',
		'roles',
		'radius',
		'fontSize',
		'buttonScale'
	],
	#category : 'Toplo-Theme-Builder',
	#package : 'Toplo-Theme-Builder'
}

{ #category : 'instance creation' }
ToCatppuccinThemeBuilder class >> accentNames [
	^ #( rosewater flamingo pink mauve red maroon peach yellow green teal sky sapphire blue lavender )
]

{ #category : 'instance creation' }
ToCatppuccinThemeBuilder class >> open [
	<script>
	^ self openOn: ToCatppuccinMochaTheme new
]

{ #category : 'instance creation' }
ToCatppuccinThemeBuilder class >> roleNames [
	^ #( primary info success warning error )
]

{ #category : 'instance creation' }
ToCatppuccinThemeBuilder class >> surfaceNames [
	^ #( text subtext1 subtext0 overlay2 overlay1 overlay0 surface2 surface1 surface0 base mantle crust )
]

{ #category : 'instance creation' }
ToCatppuccinThemeBuilder class >> variants [
	^ { ToCatppuccinLatteTheme. ToCatppuccinFrappeTheme. ToCatppuccinMacchiatoTheme. ToCatppuccinMochaTheme }
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> codeString [
	^ String streamContents: [ :s |
		  s nextPutAll: themeClass name; nextPutAll: ' newWithPalette: ({'; cr.
		  palette keys sorted do: [ :k |
			  s tab; nextPutAll: '#'; nextPutAll: k; nextPutAll: ' -> '''; nextPutAll: (palette at: k); nextPutAll: '''.'; cr ].
		  s nextPutAll: '} asDictionary) roles: ({'; cr.
		  roles keys sorted do: [ :k |
			  s tab; nextPutAll: '#'; nextPutAll: k; nextPutAll: ' -> #'; nextPutAll: (roles at: k); nextPutAll: '.'; cr ].
		  s nextPutAll: '} asDictionary) radius: '; print: radius; nextPutAll: ' fontSize: '; print: fontSize; nextPutAll: ' buttonScale: '; print: buttonScale ]
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> colorGroups [
	^ { 'ACCENT COLORS' -> self class accentNames. 'SURFACES AND TEXT' -> self class surfaceNames }
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> colorsChanged [
	self syncExtras
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> currentTheme [
	^ themeClass newWithPalette: palette copy roles: roles copy radius: radius fontSize: fontSize buttonScale: buttonScale
]

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> extraSections [
	^ { 'ROLES' -> roleRows }
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> hexOf: aName [
	^ palette at: aName
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> hexOf: aName put: aHex [
	palette at: aName put: aHex
]

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> initializePresenters [
	themeClass := self model class.
	self resetSettings.
	super initializePresenters.
	roleRows := self class roleNames collect: [ :role |
		            (self instantiate: ToThemeRoleRow)
			            role: role names: self class accentNames;
			            whenChangedDo: [ :r :n | self role: r pickedColor: n ];
			            yourself ].
	variantDrop := self newDropList
		               items: self class variants;
		               display: [ :cls | cls label allButFirst: 11 ];
		               selectItem: themeClass;
		               yourself.
	shuffleButton := self newButton label: 'Shuffle'; action: [ self shuffle ]; yourself.
	variantDrop whenSelectedItemChangedDo: [ :cls | self variantPicked: cls ].
	self selectColor: #mauve.
	self syncRows
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> resetSettings [
	palette := themeClass palette copy.
	roles := themeClass defaultRoles copy.
	radius := 6.
	fontSize := 14.
	buttonScale := 100
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> role: aRole pickedColor: aName [
	syncing ifTrue: [ ^ self ].
	roles at: aRole put: aName.
	self syncRows.
	self applyTheme
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> setting: aName put: aValue [
	self instVarNamed: aName put: aValue
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> settingGroups [
	^ { 'SETTINGS' -> self settings }
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> settingValue: aName [
	^ self instVarNamed: aName
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> settings [
	^ { ToThemeSetting name: #radius min: 0 max: 24. ToThemeSetting name: #fontSize min: 10 max: 24. ToThemeSetting name: #buttonScale min: 50 max: 200 }
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> shuffle [
	| names |
	names := self class accentNames.
	self class roleNames do: [ :role | roles at: role put: names atRandom ].
	radius := 24 atRandom.
	fontSize := 12 + 8 atRandom.
	buttonScale := 70 + 100 atRandom.
	self syncRows.
	self applyTheme
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> syncExtras [
	roleRows ifNil: [ ^ self ].
	self class roleNames with: roleRows do: [ :role :row | row show: (roles at: role) hex: (palette at: (roles at: role)) ]
]

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> toolbarItems [
	^ { (self newLabel label: 'Catppuccin flavor'; yourself) -> 120. variantDrop -> 140. shuffleButton -> 80 } , super toolbarItems
]

{ #category : 'settings' }
ToCatppuccinThemeBuilder >> variantPicked: aThemeClass [
	syncing ifTrue: [ ^ self ].
	themeClass := aThemeClass.
	self resetTheme
]

{ #category : 'initialization' }
ToCatppuccinThemeBuilder >> windowTitle [
	^ 'Toplo theme builder - Catppuccin'
]
