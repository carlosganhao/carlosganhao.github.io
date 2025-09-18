varying vec3 vPositionW;
varying vec3 vNormalW;
void main() {
    float fresnelTerm = ( 1.0 - -min(dot(vPositionW, normalize(vNormalW) ), 0.0) );    
    gl_FragColor = mix(vec4(0.0, 0.0, 0.0, 1.0), vec4(10.0,10.0,10.0,1.0), fresnelTerm*fresnelTerm*fresnelTerm*fresnelTerm);
}