extends Resource
#局外成长存档
class_name MetaUpgrade

#主键
@export var id : String
#最大数量
@export var max_quantity: int = 1
#描述
@export_multiline var description : String
