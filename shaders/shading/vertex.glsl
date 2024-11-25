
varying vec3 vNormal;
varying vec3 vPosition;

void main(){
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    //final position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;


    //transformed normal
    vec4 modelNormal = modelMatrix * vec4( normal, .0);

    //varring( to be sent to fragment)
    vNormal = modelNormal.xyz;
    vPosition = modelPosition.xyz;
}
