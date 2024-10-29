#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 fragUV;
layout(location = 1) in vec3 fragNormal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 baseColor = vec3(121, 208, 33) / 255.0;
    vec3 tipColor = vec3(81, 154, 21) / 255.0;
    vec3 color = mix(baseColor, tipColor, fragUV.y);

    vec3 lightDir = normalize(vec3(0.0, 1.0, 0.1));
    float ambientLight = 1.0;
    float diffuseLight = clamp(dot(fragNormal, lightDir), 0.0, 1.0);
    
    outColor = vec4(color * (ambientLight + diffuseLight), 1.0);
}
