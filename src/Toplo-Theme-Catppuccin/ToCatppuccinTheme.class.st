"
Abstract Catppuccin theme for Toplo.
It reuses the ToBeeTheme style rules and remaps Toplo semantic tokens to a Catppuccin flavor palette.
Concrete subclasses only have to provide their palette, label and dark/light flavor.
"
Class {
	#name : 'ToCatppuccinTheme',
	#superclass : 'ToBeeTheme',
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
ToCatppuccinTheme class >> defaultTokenProperties [

	| primary hover pressed link linkHover linkActive error errorHover errorPressed base text subtext0 subtext1 overlay0 overlay1 overlay2 surface0 surface1 tooltipBackground tooltipForeground solidText containerBackground disabledBackground borderColor borderDisabled |
	primary := self primaryColor.
	hover := self primaryHoverColor.
	pressed := self primaryPressedColor.
	link := self colorNamed: #blue.
	linkHover := self isDark
		             ifTrue: [ link lighter ]
		             ifFalse: [ link darker ].
	linkActive := self isDark
		              ifTrue: [ link darker ]
		              ifFalse: [ link darker darker ].
	error := self colorNamed: #red.
	errorHover := self isDark
		              ifTrue: [ error lighter ]
		              ifFalse: [ error darker ].
	errorPressed := self isDark
		                ifTrue: [ error darker ]
		                ifFalse: [ error darker darker ].
	base := self colorNamed: #base.
	text := self colorNamed: #text.
	subtext0 := self colorNamed: #subtext0.
	subtext1 := self colorNamed: #subtext1.
	overlay0 := self colorNamed: #overlay0.
	overlay1 := self colorNamed: #overlay1.
	overlay2 := self colorNamed: #overlay2.
	surface0 := self colorNamed: #surface0.
	surface1 := self colorNamed: #surface1.
	tooltipBackground := self tooltipBackgroundColor.
	tooltipForeground := self tooltipForegroundColor.
	solidText := self solidTextColor.
	containerBackground := self containerBackgroundColor.
	disabledBackground := self containerDisabledBackgroundColor.
	borderColor := self borderColor.
	borderDisabled := self borderDisabledColor.

	^ super defaultTokenProperties , self paletteTokenProperties , {
		  (ToTokenProperty name: #'sh-style-table' value: self syntaxHighlightStyleTable).
		  (ToTokenProperty name: #'background-color' value: base).
		  (ToTokenProperty name: #'color-bg-container' value: containerBackground).
		  (ToTokenProperty name: #'color-bg-container-disabled' value: disabledBackground).
		  (ToTokenProperty name: #'color-bg-tooltip' value: tooltipBackground).
		  (ToTokenProperty name: #'color-bg-text-active' value: (overlay2 alpha: 0.24)).
		  (ToTokenProperty name: #'color-bg-text-hover' value: (overlay1 alpha: 0.16)).
		  (ToTokenProperty name: #'color-border' value: borderColor).
		  (ToTokenProperty name: #'color-border-checkable' value: Color transparent).
		  (ToTokenProperty name: #'color-border-disabled' value: borderDisabled).
		  (ToTokenProperty name: #'color-border-indeterminate' value: hover).
		  (ToTokenProperty name: #'color-error-bg' value: (error alpha: (self isDark
					     ifTrue: [ 0.18 ]
					     ifFalse: [ 0.10 ]))).
		  (ToTokenProperty name: #'color-error-hover' value: errorHover).
		  (ToTokenProperty name: #'color-error-pressed' value: errorPressed).
		  (ToTokenProperty name: #'color-error' value: error).
		  (ToTokenProperty name: #'color-image-disabled' value: overlay1).
		  (ToTokenProperty name: #'color-image-light-solid' value: solidText).
		  (ToTokenProperty name: #'color-link' value: link).
		  (ToTokenProperty name: #'color-link-active' value: linkActive).
		  (ToTokenProperty name: #'color-link-hover' value: linkHover).
		  (ToTokenProperty name: #'color-primary' value: primary).
		  (ToTokenProperty name: #'color-primary-pressed' value: pressed).
		  (ToTokenProperty name: #'color-primary-checked' value: primary).
		  (ToTokenProperty name: #'text-color-primary-checked' value: solidText).
		  (ToTokenProperty name: #'color-primary-unchecked' value: containerBackground).
		  (ToTokenProperty name: #'color-primary-indeterminate' value: (primary alpha: 0.5)).
		  (ToTokenProperty name: #'color-primary-hover' value: hover).
		  (ToTokenProperty name: #'color-success' value: (self colorNamed: #green)).
		  (ToTokenProperty name: #'color-warning' value: (self colorNamed: #yellow)).
		  (ToTokenProperty name: #'color-text' value: text).
		  (ToTokenProperty name: #'color-text-placeholder' value: overlay1).
		  (ToTokenProperty name: #'color-text-description' value: subtext0).
		  (ToTokenProperty name: #'color-text-disabled' value: overlay0).
		  (ToTokenProperty name: #'color-text-heading' value: text).
		  (ToTokenProperty name: #'color-text-light-solid' value: solidText).
		  (ToTokenProperty name: #'color-text-secondary' value: subtext1).
		  (ToTokenProperty name: #'selected-focused-foreground' value: solidText).
		  (ToTokenProperty name: #'selected-unfocused-foreground' value: primary).
		  (ToTokenProperty name: #'text-foreground-in-tooltip' value: tooltipForeground).
		  (ToTokenProperty name: #'effect-window' value: (BlGaussianShadowEffect
				    color: ((self isDark
						      ifTrue: [ Color black ]
						      ifFalse: [ self colorNamed: #crust ]) alpha: 0.35)
				    width: 20
				    offset: 0 @ 4)).
		  (ToTokenProperty name: #'effect-window-menu' value: (BlGaussianShadowEffect
				    color: ((self isDark
						      ifTrue: [ Color black ]
						      ifFalse: [ self colorNamed: #crust ]) alpha: 0.28)
				    width: 14
				    offset: 0 asPoint)).
		  (ToTokenProperty name: #'focus-border-paint' value: primary).
		  (ToTokenProperty name: #'border-paint' value: borderColor).
		  (ToTokenProperty name: #'segmented-background' value: (surface0 alpha: (self isDark
					     ifTrue: [ 0.55 ]
					     ifFalse: [ 0.75 ]))).
		  (ToTokenProperty name: #'text-editor-background-disabled' value: disabledBackground).
		  (ToTokenProperty name: #'checkbox-color' value: primary).
		  (ToTokenProperty name: #'switch-checked-background' value: primary).
		  (ToTokenProperty name: #'switch-unchecked-background' value: surface1).
		  (ToTokenProperty name: #'switch-disabled-background' value: disabledBackground).
		  (ToTokenProperty name: #'switch-handle-disabled-background' value: surface0).
		  (ToTokenProperty name: #'switch-handle-enabled-background' value: solidText).
		  (ToTokenProperty name: #'color-list-primary-selection-focused' value: primary).
		  (ToTokenProperty name: #'color-list-primary-selection-over-focused' value: (hover alpha: 0.40)).
		  (ToTokenProperty name: #'color-list-primary-selection-unfocused' value: (primary alpha: 0.25)).
		  (ToTokenProperty name: #'color-list-primary-selection-over-unfocused' value: (primary alpha: 0.16)).
		  (ToTokenProperty name: #'color-primary-selection-focused' value: (primary alpha: 0.25)).
		  (ToTokenProperty name: #'color-primary-selection-over-focused' value: (hover alpha: 0.18)).
		  (ToTokenProperty name: #'color-primary-selection-unfocused' value: (primary alpha: 0.16)).
		  (ToTokenProperty name: #'color-primary-selection-over-unfocused' value: (primary alpha: 0.10)).
		  (ToTokenProperty name: #'color-primary-selection-disabled' value: (overlay0 alpha: 0.24)).
		  (ToTokenProperty name: #'color-secondary-selection' value: (overlay0 alpha: 0.15)).
		  (ToTokenProperty name: #'tab-color-secondary-selection' value: (overlay1 alpha: 0.35)).
		  (ToTokenProperty name: #'border-color-primary-selection' value: primary).
		  (ToTokenProperty name: #'border-color-danger-selection' value: error).
		  (ToTokenProperty name: #'divider-hovered-background' value: (overlay0 alpha: 0.18)).
		  (ToTokenProperty name: #'divider-pressed-background' value: (overlay1 alpha: 0.32)) }
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
ToCatppuccinTheme class >> paletteTokenProperties [

	^ self palette associations collect: [ :association |
		  ToTokenProperty name: ('catppuccin-' , association key asString) asSymbol value: (Color fromHexString: association value) ]
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
