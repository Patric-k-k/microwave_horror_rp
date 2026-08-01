#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

vec4 minecraft_sample_lightmap(sampler2D lightMap, ivec2 uv) {
    return texture(lightMap, clamp((uv / 256.0) + 0.5 / 16.0, vec2(0.5 / 16.0), vec2(15.5 / 16.0)));
}

void main() {
    vec3 pos = Position + ModelOffset;

    vec4 clip = ProjMat * ModelViewMat * vec4(pos, 1.0);
    clip.xy *= 1.0 + clip.z * 0.0004;
    gl_Position = clip;
    //gl_Position = ProjMat * ModelViewMat * vec4(pos, 0.9);

    sphericalVertexDistance = fog_spherical_distance(pos);
    cylindricalVertexDistance = fog_cylindrical_distance(pos);
    //vertexColor = Color * minecraft_sample_lightmap(Sampler2, UV2);
    vertexColor = (Color * 1.5) * minecraft_sample_lightmap(Sampler2, UV2) - vec4(log(Color.z * 1.3 ),log(Color.y * 1.2),log(Color.x * 1.3),0.0);
    texCoord0 = UV0;
}
