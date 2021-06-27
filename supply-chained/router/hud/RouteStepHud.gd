extends VBoxContainer

func initialize(step: RouteStep, cargo_helper:CargoHelper):
	$Name.text = step.station.name

	for exchange_group in group(step.exchanges):
		var exchange = exchange_group[0]
		$ExchangeTemplate/Type.text = '+' if exchange[2] else '-'
		$ExchangeTemplate/Cargo.texture = cargo_helper.get_icon(exchange[1])
	
		$ExchangeTemplate/Amount.text = "×" + str(len(exchange_group))
		$ExchangeTemplate/Amount.visible = len(exchange_group) > 1
	
		add_child($ExchangeTemplate.duplicate())

	$ExchangeTemplate.visible = false

	return self

func group(exchanges:Array):
	var unique = {}
	
	for exchange in exchanges:
		var identifier = str(exchange[2]) + str(exchange[1])
		
		if not unique.has(identifier):
			unique[identifier]= []
			
		unique[identifier].append(exchange)

	return unique.values()
	
