
uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;


// Ambient Light
vec3 ambientLight(vec3 lightColor, float lightIntensity){
    return lightColor * lightIntensity;
}


// Directional Light
vec3 directionalLight( vec3 lightColor, float lightIntensity, vec3 normal, vec3 position, vec3 viewDirection, float specularPow){

    vec3 lightDirection = normalize(position);
    vec3 lightReflection = reflect(-lightDirection, normal );

    //shading
    float shading = dot(normal, lightDirection);
    shading = max( .0, shading);

    // specular
    float specular = - dot(lightReflection, viewDirection);
    specular = max( .0, specular);
    specular = pow( specular, specularPow);

    return lightColor * lightIntensity * shading + lightColor * lightIntensity * specular;
}

// Point Light
vec3 pointLight( vec3 lightColor, float lightIntensity, vec3 normal, vec3 position, vec3 viewDirection, float specularPow, vec3 viewPosition, float lightDecay){

    vec3 lightDelta = position - viewPosition;
    vec3 lightDirection = normalize(lightDelta);
    vec3 lightReflection = reflect(-lightDirection, normal );

    //shading
    float shading = dot(normal, lightDirection);
    shading = max( .0, shading);

    // specular
    float specular = - dot(lightReflection, viewDirection);
    specular = max( .0, specular);
    specular = pow( specular, specularPow);

    // decay
    float lightDistance = length(lightDelta);
    float decay = 1. - lightDistance * lightDecay;

    return lightColor * lightIntensity * lightDecay * shading + lightColor * lightIntensity * specular;
}

void main(){
    
    vec3 normal = normalize( vNormal);
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 color = uColor;

    //Light
    vec3 light = vec3(0.);

    // light += ambientLight(vec3(1.) ,.03 );

    light += directionalLight( 
            vec3( .1, .1, 1.),   //color
            1.0,                          //initensity
            normal,                               //normal
            vec3( .0, .0, 3.),       //direction
            viewDirection,                 //view direction
            20.                              //specular power
        );

    light += pointLight( 
        vec3( 1., .1, .1),   //color
        1.0,                          //initensity
        normal,                               //normal
        vec3( .0, 3., 0.),       //direction
        viewDirection,                 //view direction
        20.,                             //specular power
        vPosition,                     //viewPosition
        .25                               //lightDecay
    );

        light += pointLight( 
        vec3( .1, 1., .5),   //color
        1.0,                          //initensity
        normal,                               //normal
        vec3( 2.),       //direction
        viewDirection,                 //view direction
        20.,                             //specular power
        vPosition,                     //viewPosition
        .25                               //lightDecay
    );

    color *= light;

    gl_FragColor = vec4( color, 1. );

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
