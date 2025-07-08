//场景转换的纹理变化
shader_type canvas_item;

uniform vec4 transition_color: source_color;
//转换纹理  用最近的纹理过滤器过滤（像素）
uniform sampler2D transition_texture : filter_nearest;
//百分比
uniform float percent: hint_range(0.0, 1.0);

void fragment() {
	// 从纹理采样
	vec4 transition_texture_color = texture(transition_texture, UV);
	if(transition_texture_color.r > percent){
		COLOR.a = 0.0;
	}else{
		COLOR = transition_color;
	}
}
