
varying vec3 vNormal;

void main(){
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    //final position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;

    vec4 modelNormal = modelMatrix * vec4( normal, .0);

    vNormal = modelNormal.xyz;
}
