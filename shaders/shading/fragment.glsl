
uniform vec3 uColor;

varying vec3 vNormal;

vec3 ambientLight(vec3 lightColor, float lightIntensity){
    return lightColor * lightIntensity;
}

vec3 directionalLight( vec3 lightColor, float lightIntensity, vec3 normal, vec3 position){
    vec3 lightDirection = normalize(position);
    float shading = dot(normal, lightDirection);
    shading = max( .0, shading);
    return lightColor * lightIntensity * shading;
}

void main(){

    vec3 color = uColor;

    //Light
    vec3 light = vec3(0.);

    light += ambientLight(vec3(1.) ,.03 );

    light += directionalLight( 
            vec3( .1, .1, 1.),  //color
            1.0,                         //initensity
            vNormal,                             //normal
            vec3( .0, .0, 3.)       //direction

        );

    color *= light;

    gl_FragColor = vec4( color, 1. );

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
