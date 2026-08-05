Class {
	#name : 'BaselineOfToploThemeCatppuccin',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfToploThemeCatppuccin',
	#package : 'BaselineOfToploThemeCatppuccin'
}

{ #category : 'baselines' }
BaselineOfToploThemeCatppuccin >> baseline: spec [

	<baseline>
	spec for: #common do: [
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfToploThemeCatppuccin >> defineDependencies: spec [

	spec baseline: 'Toplo' with: [ spec repository: 'github://pharo-graphics/Toplo:dev/src' ]
]

{ #category : 'baselines' }
BaselineOfToploThemeCatppuccin >> defineGroups: spec [

	spec
		group: 'core' with: #( 'Toplo-Theme-Catppuccin' );
		group: 'default' with: #( 'core' )
]

{ #category : 'baselines' }
BaselineOfToploThemeCatppuccin >> definePackages: spec [

	spec package: 'Toplo-Theme-Catppuccin' with: [ spec requires: #( 'Toplo' ) ]
]
