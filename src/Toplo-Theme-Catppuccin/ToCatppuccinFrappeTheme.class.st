"
Catppuccin Macchiato flavor for Toplo.
Dark variant using the official Catppuccin Macchiato palette.
"
Class {
	#name : 'ToCatppuccinFrappeTheme',
	#superclass : 'ToCatppuccinTheme',
	#category : 'Toplo-Theme-Catppuccin-Catppuccin',
	#package : 'Toplo-Theme-Catppuccin',
	#tag : 'Catppuccin'
}

{ #category : 'accessing' }
ToCatppuccinFrappeTheme class >> isDark [

	^ true
]

{ #category : 'accessing' }
ToCatppuccinFrappeTheme class >> label [

	^ 'Catppuccin Frappé'
]

{ #category : 'accessing' }
ToCatppuccinFrappeTheme class >> palette [

	^ {
		  (#rosewater -> '#f2d5cf').
		  (#flamingo -> '#eebebe').
		  (#pink -> '#f4b8e4').
		  (#mauve -> '#ca9ee6').
		  (#red -> '#e78284').
		  (#maroon -> '#ea999c').
		  (#peach -> '#ef9f76').
		  (#yellow -> '#e5c890').
		  (#green -> '#a6d189').
		  (#teal -> '#81c8be').
		  (#sky -> '#99d1db').
		  (#sapphire -> '#85c1dc').
		  (#blue -> '#8caaee').
		  (#lavender -> '#babbf1').
		  (#text -> '#c6d0f5').
		  (#subtext1 -> '#b5bfe2').
		  (#subtext0 -> '#a5adce').
		  (#overlay2 -> '#949cbb').
		  (#overlay1 -> '#838ba7').
		  (#overlay0 -> '#737994').
		  (#surface2 -> '#626880').
		  (#surface1 -> '#51576d').
		  (#surface0 -> '#414559').
		  (#base -> '#303446').
		  (#mantle -> '#292c3c').
		  (#crust -> '#232634') } asDictionary
]
