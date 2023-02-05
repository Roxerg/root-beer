extends Spatial

export var docs_layer = []
	
func update_docs_layers(doc):
	docs_layer.erase(doc)
	docs_layer.append(doc)
	for idx in len(docs_layer):
		docs_layer[idx].global_transform.origin.y = idx*0.001
