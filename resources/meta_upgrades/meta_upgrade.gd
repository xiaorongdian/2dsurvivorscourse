extends Resource
#局外成长存档 经验值算作局外货币

class_name MetaUpgrade

#主键
@export var id : String
#最大数量
@export var max_quantity: int = 1
#升级能力所需花费经验
@export var experience_cost: int = 10
#标题
@export var title: String
#描述
@export_multiline var description : String
