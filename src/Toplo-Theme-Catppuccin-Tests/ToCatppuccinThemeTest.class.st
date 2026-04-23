Class {
	#name : 'ToCatppuccinThemeTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Theme-Catppuccin-Tests-Catppuccin',
	#package : 'Toplo-Theme-Catppuccin-Tests',
	#tag : 'Catppuccin'
}

{ #category : 'tests' }
ToCatppuccinThemeTest >> testConcreteThemesCanBeDefault [

	self deny: ToCatppuccinTheme canBeDefault.
	self assert: ToCatppuccinLatteTheme canBeDefault.
	self assert: ToCatppuccinMacchiatoTheme canBeDefault
]

{ #category : 'tests' }
ToCatppuccinThemeTest >> testLatteMapsOfficialPaletteToToploTokens [

	| theme |
	theme := ToCatppuccinLatteTheme new.
	self assert: (self tokenValueNamed: #'background-color' in: theme) equals: (Color fromHexString: '#eff1f5').
	self assert: (self tokenValueNamed: #'color-primary' in: theme) equals: (Color fromHexString: '#8839ef').
	self assert: (self tokenValueNamed: #'color-link' in: theme) equals: (Color fromHexString: '#1e66f5').
	self assert: (self tokenValueNamed: #'catppuccin-crust' in: theme) equals: (Color fromHexString: '#dce0e8')
]

{ #category : 'tests' }
ToCatppuccinThemeTest >> testMacchiatoUsesDarkSemanticDefaults [

	| theme |
	theme := ToCatppuccinMacchiatoTheme new.
	self assert: (self tokenValueNamed: #'background-color' in: theme) equals: (Color fromHexString: '#24273a').
	self assert: (self tokenValueNamed: #'color-primary' in: theme) equals: (Color fromHexString: '#c6a0f6').
	self assert: (self tokenValueNamed: #'color-text-light-solid' in: theme) equals: (Color fromHexString: '#24273a').
	self assert: (self tokenValueNamed: #'sh-style-table' in: theme) equals: ToCatppuccinMacchiatoTheme syntaxHighlightStyleTable
]

{ #category : 'helpers' }
ToCatppuccinThemeTest >> tokenValueNamed: aSymbol in: aTheme [

	^ (aTheme tokenProperties reversed
		   detect: [ :each | each name = aSymbol ]
		   ifNone: [ self fail: 'Missing token: ' , aSymbol asString ]) value
]
