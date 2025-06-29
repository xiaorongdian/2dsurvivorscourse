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


#移除
func remove_item(item_to_remove):
	items = items.filter(func (item):return item["item"].id != item_to_remove.id)
	weight_sum = 0
	for item in items:
		weight_sum += item["weight"]


#加权选择
func pick_item(exclude: Array = []):
	#先把排除的能力扣掉性能低
	var adjusted_items:Array[Dictionary] = items
	var adjusted_weight_sum = weight_sum
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item["item"] in exclude:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
		
	#1到权重总和取随机数
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if iteration_sum >= chosen_weight:
			return item["item"]
