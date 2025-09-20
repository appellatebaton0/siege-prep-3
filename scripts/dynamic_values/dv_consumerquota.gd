extends DynamicValue
class_name ConsumerQuotaDynamicValue

# This was when I gave up lol

func value():
	var score:int = 0
	if source is ConsumerAreaSubComponent:
		var combo_rates = source.get_combo_rates()
		
		for combo in combo_rates:
			score += combo_rates[combo]
		
		score *= max(len(combo_rates.keys()) * 0.6, 1)
	
	return score
