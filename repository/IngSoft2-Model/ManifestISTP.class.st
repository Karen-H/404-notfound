"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestISTP,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model'
}

{ #category : #'code-critics' }
ManifestISTP class >> ruleRBModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Game #play: #false)) #'2020-04-18T10:26:35.660235-03:00') )
]
