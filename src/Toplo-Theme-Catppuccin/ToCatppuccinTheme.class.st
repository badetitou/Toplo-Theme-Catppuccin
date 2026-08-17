"
Abstract Catppuccin theme for Toplo.
It reuses the ToBeeTheme style rules and remaps Toplo semantic tokens to a Catppuccin flavor palette.
Concrete subclasses only have to provide their palette, label and dark/light flavor.
"
Class {
	#name : 'ToCatppuccinTheme',
	#superclass : 'ToRawTheme',
	#category : 'Toplo-Theme-Catppuccin-Catppuccin',
	#package : 'Toplo-Theme-Catppuccin',
	#tag : 'Catppuccin'
}

{ #category : 'accessing' }
ToCatppuccinTheme class >> borderColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #surface2 ]
		  ifFalse: [ self colorNamed: #surface1 ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> borderDisabledColor [

	^ self isDark
		  ifTrue: [ (self colorNamed: #overlay0) alpha: 0.75 ]
		  ifFalse: [ self colorNamed: #surface0 ]
]

{ #category : 'testing' }
ToCatppuccinTheme class >> canBeDefault [

	^ self ~= ToCatppuccinTheme
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> colorNamed: aSymbol [

	^ Color fromHexString: (self palette at: aSymbol)
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> containerBackgroundColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #surface0 ]
		  ifFalse: [ self colorNamed: #mantle ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> containerDisabledBackgroundColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #mantle ]
		  ifFalse: [ self colorNamed: #surface0 ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> isDark [

	self subclassResponsibility
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> label [

	^ 'Catppuccin'
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> palette [

	self subclassResponsibility
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> primaryColor [

	^ self colorNamed: #mauve
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> primaryHoverColor [

	| primary |
	primary := self primaryColor.
	^ self isDark
		  ifTrue: [ primary lighter ]
		  ifFalse: [ primary darker ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> primaryPressedColor [

	| primary |
	primary := self primaryColor.
	^ self isDark
		  ifTrue: [ primary darker ]
		  ifFalse: [ primary darker darker ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> solidTextColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #base ]
		  ifFalse: [ Color white ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> syntaxHighlightStyleTable [

	^ self isDark
		  ifTrue: [ self darkStyleTable ]
		  ifFalse: [ self lightStyleTable ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> tooltipBackgroundColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #mantle ]
		  ifFalse: [ self colorNamed: #text ]
]

{ #category : 'accessing' }
ToCatppuccinTheme class >> tooltipForegroundColor [

	^ self isDark
		  ifTrue: [ self colorNamed: #text ]
		  ifFalse: [ self colorNamed: #base ]
]

{ #category : 'accessing' }
ToCatppuccinTheme >> buttonTokenProperties [

	^ {
		  (self ensureTokenNamed: #'button-padding-H' withValue: 12).
		  (self ensureTokenNamed: #'button-padding-V' withValue: 5).
		  (self ensureTokenNamed: #'button-padding-H-SM' withValue: 10).
		  (self ensureTokenNamed: #'button-padding-V-SM' withValue: 3).
		  (self ensureTokenNamed: #'button-padding-H-LG' withValue: 16).
		  (self ensureTokenNamed: #'button-padding-V-LG' withValue: 7).
		  (self ensureTokenNamed: #'button-icon-size' withValue: 16 asPoint).
		  (self ensureTokenNamed: #'button-icon-size-SM' withValue: 14 asPoint).
		  (self ensureTokenNamed: #'button-icon-size-LG' withValue: 18 asPoint).
		  (self ensureTokenNamed: #'button-iconic-size' withValue: 32 asPoint).
		  (self ensureTokenNamed: #'button-iconic-size-SM' withValue: 24 asPoint).
		  (self ensureTokenNamed: #'button-iconic-size-LG' withValue: 40 asPoint).
		  (self ensureTokenNamed: #'button-iconic-padding' withValue: 8).
		  (self ensureTokenNamed: #'button-iconic-padding-SM' withValue: 5).
		  (self ensureTokenNamed: #'button-iconic-padding-LG' withValue: 11).
		  (self ensureTokenNamed: #'button-interspace' withValue: 10) }
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> colorNamed: aName [
	^ self class colorNamed: aName
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> declareMenuItemRules [

	self
	select: ToMenuItem asTypeSelector
	style: [ self write: (self property: #'layout-orientation') with: [ :e | BlLinearLayoutHorizontalOrientation new ] ]
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> ensureTokenNamed: aName withValue: aValue [

	tokenProperties
		detect: [ :pro | pro name = aName ]
		ifFound: [ :prop | prop value: aValue ]
		ifNone: [ tokenProperties add: (ToTokenProperty name: aName value: aValue) ]
]

{ #category : 'accessing' }
ToCatppuccinTheme >> fontTokenProperties [

	^ {
		  (self ensureTokenNamed: #'font-name' withValue: AeFontManager defaultFontFamilyName).
		  (self ensureTokenNamed: #'font-size' withValue: 14).
		  (self ensureTokenNamed: #'font-weight-attribute' withValue: BlFontWeightAttribute normal).
		  (self ensureTokenNamed: #'font-size-in-tooltip' withValue: 12).
		  (self ensureTokenNamed: #'font-size-H1' withValue: 38).
		  (self ensureTokenNamed: #'font-size-H2' withValue: 30).
		  (self ensureTokenNamed: #'font-size-H3' withValue: 24).
		  (self ensureTokenNamed: #'font-size-H4' withValue: 20).
		  (self ensureTokenNamed: #'font-size-H5' withValue: 16).
		  (self ensureTokenNamed: #'font-weight-strong' withValue: 600) }
]

{ #category : 'initialization' }
ToCatppuccinTheme >> initialize [

	super initialize.
	self updateTokens.
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> initializeStyleRules [ 

	super initializeStyleRules.
	self declareMenuItemRules
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> isDark [

	^ self class isDark
]

{ #category : 'accessing' }
ToCatppuccinTheme >> listTokenProperties [

	| listItemPadding |
	listItemPadding := 2.

	self ensureTokenNamed: #'list-padding-H' withValue: listItemPadding.
	self ensureTokenNamed: #'list-padding-V' withValue: listItemPadding.
	self ensureTokenNamed: #'list-node-padding-H' withValue: listItemPadding.
	self ensureTokenNamed: #'list-node-padding-V' withValue: listItemPadding.
	self ensureTokenNamed: #'table-cell-padding-H' withValue: listItemPadding.
	self ensureTokenNamed: #'table-cell-padding-V' withValue: listItemPadding
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> paletteTokenProperties [

	^ self class palette associations collect: [ :association |
		  ToTokenProperty name: ('catppuccin-' , association key asString) asSymbol value: (Color fromHexString: association value) ]
]

{ #category : 't - style sheet theme' }
ToCatppuccinTheme >> updateTokens [

	| primary hover pressed link linkHover linkActive error errorHover errorPressed base text subtext0 subtext1 overlay0 overlay1 overlay2 surface0 surface1 tooltipBackground tooltipForeground solidText containerBackground disabledBackground borderColor borderDisabled |
	primary := self class primaryColor.
	hover := self class primaryHoverColor.
	pressed := self class primaryPressedColor.
	link := self class colorNamed: #blue.
	linkHover := self class isDark
		             ifTrue: [ link lighter ]
		             ifFalse: [ link darker ].
	linkActive := self class isDark
		              ifTrue: [ link darker ]
		              ifFalse: [ link darker darker ].
	error := self class colorNamed: #red.
	errorHover := self class isDark
		              ifTrue: [ error lighter ]
		              ifFalse: [ error darker ].
	errorPressed := self class isDark
		                ifTrue: [ error darker ]
		                ifFalse: [ error darker darker ].
	base := self class colorNamed: #base.
	text := self class colorNamed: #text.
	subtext0 := self class colorNamed: #subtext0.
	subtext1 := self class colorNamed: #subtext1.
	overlay0 := self class colorNamed: #overlay0.
	overlay1 := self class colorNamed: #overlay1.
	overlay2 := self class colorNamed: #overlay2.
	surface0 := self class colorNamed: #surface0.
	surface1 := self class colorNamed: #surface1.
	tooltipBackground := self class tooltipBackgroundColor.
	tooltipForeground := self class tooltipForegroundColor.
	solidText := self class solidTextColor.
	containerBackground := self class containerBackgroundColor.
	disabledBackground := self class containerDisabledBackgroundColor.
	borderColor := self class borderColor.
	borderDisabled := self class borderDisabledColor.

	self paletteTokenProperties.
	{
		(self ensureTokenNamed: #'sh-style-table' withValue: self class syntaxHighlightStyleTable).
		(self ensureTokenNamed: #'background-color' withValue: base).
		(self ensureTokenNamed: #'color-bg-container' withValue: base).
		(self ensureTokenNamed: #'color-bg-container-disabled' withValue: disabledBackground).
		(self ensureTokenNamed: #'color-bg-tooltip' withValue: tooltipBackground).
		(self ensureTokenNamed: #'color-bg-text-active' withValue: (overlay2 alpha: 0.24)).
		(self ensureTokenNamed: #'color-bg-text-hover' withValue: (overlay1 alpha: 0.16)).
		(self ensureTokenNamed: #'color-border' withValue: borderColor).
		(self ensureTokenNamed: #'color-border-checkable' withValue: Color transparent).
		(self ensureTokenNamed: #'color-border-disabled' withValue: borderDisabled).
		(self ensureTokenNamed: #'color-border-indeterminate' withValue: hover).
		(self ensureTokenNamed: #'color-error-bg' withValue: (error alpha: (self class isDark
					   ifTrue: [ 0.18 ]
					   ifFalse: [ 0.10 ]))).
		(self ensureTokenNamed: #'color-error-hover' withValue: errorHover).
		(self ensureTokenNamed: #'color-error-pressed' withValue: errorPressed).
		(self ensureTokenNamed: #'color-error' withValue: error).
		(self ensureTokenNamed: #'color-image-disabled' withValue: overlay1).
		(self ensureTokenNamed: #'color-image-light-solid' withValue: solidText).
		(self ensureTokenNamed: #'color-link' withValue: link).
		(self ensureTokenNamed: #'color-link-active' withValue: linkActive).
		(self ensureTokenNamed: #'color-link-hover' withValue: linkHover).
		(self ensureTokenNamed: #'color-primary' withValue: primary).
		(self ensureTokenNamed: #'color-primary-pressed' withValue: pressed).
		(self ensureTokenNamed: #'color-primary-checked' withValue: primary).
		(self ensureTokenNamed: #'text-color-primary-checked' withValue: solidText).
		(self ensureTokenNamed: #'color-primary-unchecked' withValue: containerBackground).
		(self ensureTokenNamed: #'color-primary-indeterminate' withValue: (primary alpha: 0.5)).
		(self ensureTokenNamed: #'color-primary-hover' withValue: hover).
		(self ensureTokenNamed: #'color-success' withValue: (self colorNamed: #green)).
		(self ensureTokenNamed: #'color-warning' withValue: (self colorNamed: #yellow)).
		(self ensureTokenNamed: #'color-text' withValue: text).
		(self ensureTokenNamed: #'color-text-placeholder' withValue: overlay1).
		(self ensureTokenNamed: #'color-text-description' withValue: subtext0).
		(self ensureTokenNamed: #'color-text-disabled' withValue: overlay0).
		(self ensureTokenNamed: #'color-text-heading' withValue: text).
		(self ensureTokenNamed: #'color-text-light-solid' withValue: solidText).
		(self ensureTokenNamed: #'color-text-secondary' withValue: subtext1).
		(self ensureTokenNamed: #'selected-focused-foreground' withValue: solidText).
		(self ensureTokenNamed: #'selected-unfocused-foreground' withValue: primary).
		(self ensureTokenNamed: #'text-foreground-in-tooltip' withValue: tooltipForeground).
		(self ensureTokenNamed: #'effect-window' withValue: (BlGaussianShadowEffect
				  color: ((self isDark
						    ifTrue: [ Color black ]
						    ifFalse: [ self colorNamed: #crust ]) alpha: 0.35)
				  width: 20
				  offset: 0 @ 4)).
		(self ensureTokenNamed: #'effect-window-menu' withValue: (BlGaussianShadowEffect
				  color: ((self isDark
						    ifTrue: [ Color black ]
						    ifFalse: [ self colorNamed: #crust ]) alpha: 0.28)
				  width: 14
				  offset: 0 asPoint)).
		(self ensureTokenNamed: #'focus-border-paint' withValue: primary).
		(self ensureTokenNamed: #'border-paint' withValue: borderColor).
		(self ensureTokenNamed: #'segmented-background' withValue: (surface0 alpha: (self isDark
					   ifTrue: [ 0.55 ]
					   ifFalse: [ 0.75 ]))).
		(self ensureTokenNamed: #'text-editor-background-disabled' withValue: disabledBackground).
		(self ensureTokenNamed: #'checkbox-color' withValue: primary).
		(self ensureTokenNamed: #'switch-checked-background' withValue: primary).
		(self ensureTokenNamed: #'switch-unchecked-background' withValue: surface1).
		(self ensureTokenNamed: #'switch-disabled-background' withValue: disabledBackground).
		(self ensureTokenNamed: #'switch-handle-disabled-background' withValue: surface0).
		(self ensureTokenNamed: #'switch-handle-enabled-background' withValue: solidText).
		(self ensureTokenNamed: #'color-list-primary-selection-focused' withValue: primary).
		(self ensureTokenNamed: #'color-list-primary-selection-over-focused' withValue: (hover alpha: 0.40)).
		(self ensureTokenNamed: #'color-list-primary-selection-unfocused' withValue: (primary alpha: 0.25)).
		(self ensureTokenNamed: #'color-list-primary-selection-over-unfocused' withValue: (primary alpha: 0.16)).
		(self ensureTokenNamed: #'color-primary-selection-focused' withValue: (primary alpha: 0.25)).
		(self ensureTokenNamed: #'color-primary-selection-over-focused' withValue: (hover alpha: 0.18)).
		(self ensureTokenNamed: #'color-primary-selection-unfocused' withValue: (primary alpha: 0.16)).
		(self ensureTokenNamed: #'color-primary-selection-over-unfocused' withValue: (primary alpha: 0.10)).
		(self ensureTokenNamed: #'color-primary-selection-disabled' withValue: (overlay0 alpha: 0.24)).
		(self ensureTokenNamed: #'color-secondary-selection' withValue: (overlay0 alpha: 0.15)).
		(self ensureTokenNamed: #'tab-color-secondary-selection' withValue: (overlay1 alpha: 0.35)).
		(self ensureTokenNamed: #'border-color-primary-selection' withValue: primary).
		(self ensureTokenNamed: #'border-color-danger-selection' withValue: error).
		(self ensureTokenNamed: #'divider-hovered-background' withValue: (overlay0 alpha: 0.18)).
		(self ensureTokenNamed: #'divider-pressed-background' withValue: (overlay1 alpha: 0.32)) }.
	self buttonTokenProperties.
	self fontTokenProperties.
	self listTokenProperties
]
