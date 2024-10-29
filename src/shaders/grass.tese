#version 450
#extension GL_ARB_separate_shader_objects : enable

// 0 = square, 1 = triangle, 2 = parabola, 3 = triangle tip
#define BLADE_SHAPE 1

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];

layout(location = 0) out vec2 out_UV;
layout(location = 1) out vec3 out_Nor;

float getSquareT(float u, float v) {
    return u;
}

float getTriangleT(float u, float v) {
    return u + 0.5 * v - u * v;
}

float getParabolaT(float u, float v) {
    return u - u * v * v;
}

float getTriangleTipT(float u, float v, float tau) {
    // tau is triangle tip height threshold
    return 0.5 + (u - 0.5) * (1 - max(v - tau, 0) / 1 - tau);
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;

    float orientation = in_v0[0].w;
    float width = in_v2[0].w;

    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 t0 = normalize(b - a); // tangent
    vec3 t1 = vec3(-cos(orientation), 0.0, -sin(orientation)); // bitangent
    vec3 n = normalize(cross(t0, t1)); // normal

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

#if BLADE_SHAPE == 0
    float t = getTriangleT(u, v);
#elif BLADE_SHAPE == 1
    float t = getTriangleT(u, v);
#elif BLADE_SHAPE == 2
    float t = getParabolaT(u, v);
#elif BLADE_SHAPE == 3
    float t = getTriangleTipT(u, v, 0.2);
#endif
    vec3 pos = mix(c0, c1, t);

    out_UV = vec2(u, v);
    out_Nor = n;
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
