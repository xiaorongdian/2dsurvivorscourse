#敌人权重表
class_name WeightedTable

#权重集合
var items: Array[Dictionary] = []
#权重总和
var weight_sum = 0

#添加
func add_item(item, weight: int):
	items.append({"item":item, "weight": weight})
	weight_sum += weight

#选择
func pick_item():
	#1到权重总和取随机数
	var chosen_weight = randi_range(1, weight_sum)
	var iteration_sum = 0
	for item in items:
		iteration_sum += item["weight"]
		if iteration_sum >= chosen_weight:
			return item["item"]
