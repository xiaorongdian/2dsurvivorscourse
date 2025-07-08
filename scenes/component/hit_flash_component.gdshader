//击中时怪物纹理变化
shader_type canvas_item;

//百分比 以变量形式设置，编辑器范围 0-1
uniform float lerp_percent : hint_range(0.0, 1.0);

void fragment() {
	//红绿蓝和透明度
	//texture() 函数
	//作用：从纹理中采样颜色。
	//TEXTURE：纹理采样器（通常是 uniform 变量）。
	//UV：纹理坐标（范围通常为 [0, 1]）。 其实就是拿到当前纹理
	vec4 texture_color = texture(TEXTURE, UV);

	//得到一个两通道纹理，透明像素和红色通道值
	//vec2 example = texture_color.ar;

	//.a 是 透明度 alpha  即保留透明像素
	//texture_color 到 白色 mix线性插入 第三个参数权重 1.0 （1.0，1.0，1.0）是白色
	//从当前纹理到白色过度，权重1就是全白，0.5就是一半白，0就是没有白色
	//如果将texture_color.a 改成1.0则整个纹理所在正方形都变白而不是只纹理变白 lerp_percent变白百分比
	vec4 final_color = mix(texture_color, vec4(1.0,1.0,1.0,texture_color.a), lerp_percent);
	//输出纹理 = final_color 或者 final_color.rgba 四通道
	//COLOR = final_color.rgba;
	COLOR.rgb = final_color.rgb;
}
