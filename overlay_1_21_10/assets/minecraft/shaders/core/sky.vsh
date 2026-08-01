#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 0.2);

    sphericalVertexDistance = fog_spherical_distance(Position + vec3(0,90,0));
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
}
