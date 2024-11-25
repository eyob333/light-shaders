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