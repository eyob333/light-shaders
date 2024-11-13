

void main(){
    gl_FragColor = vec4( .4, .5, .4, 1. );

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
