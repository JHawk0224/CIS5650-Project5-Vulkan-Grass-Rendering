#version 450
#extension GL_ARB_separate_shader_objects : enable

#define MAX_TESSELLATION 20.0
#define MIN_TESSELLATION 1.0
#define TESSELLATION_FALLOFF_DISTANCE 25.0

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];

	// TODO: Set level of tesselation
    vec3 bladePos = vec3(in_v0[gl_InvocationID]);
    vec3 cameraPos = vec3(inverse(camera.view)[3]);
    float dist = distance(bladePos, cameraPos);
    float tessLevel = mix(MAX_TESSELLATION, MIN_TESSELLATION, clamp(dist / TESSELLATION_FALLOFF_DISTANCE, 0.0, 1.0));

    gl_TessLevelInner[0] = tessLevel;
    gl_TessLevelInner[1] = tessLevel;
    gl_TessLevelOuter[0] = tessLevel;
    gl_TessLevelOuter[1] = tessLevel;
    gl_TessLevelOuter[2] = tessLevel;
    gl_TessLevelOuter[3] = tessLevel;
}
