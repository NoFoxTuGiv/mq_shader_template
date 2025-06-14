// This is heavily based on kishimisu's shader fragment tutorial found here:
// https://www.shadertoy.com/view/mtyGWy

#version 100
precision lowp float;

varying lowp vec2 uv;

uniform sampler2D Texture;
uniform vec2 uResolution;
uniform float uTime;

// https://www.shadertoy.com/view/3tSGDy
float sdStar( vec2 p, float r, float n, float m)
{
    // next 4 lines can be precomputed for a given shape
    float an = 3.141593/float(n);
    float en = 3.141593/m;  // m is between 2 and n
    vec2  acs = vec2(cos(an),sin(an));
    vec2  ecs = vec2(cos(en),sin(en)); // ecs=vec2(0,1) for regular polygon

    float bn = mod(atan(p.x,p.y),2.*an) - an;
    p = length(p)*vec2(cos(bn),abs(sin(bn)));
    p -= r*acs;
    p += ecs*clamp( -dot(p,ecs), 0., r*acs.y/ecs.y);
    return length(p)*sign(p.x);
}

// https://iquilezles.org/articles/palettes/
vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
    vec2 cUv = (uv - 0.5) * 2.;
    vec2 uv0 = cUv;
    vec3 finalColor = vec3(0.);

    cUv.y *= -1.;
    cUv.x *= uResolution.x / uResolution.y;
    
    float t = uTime / 3.;
    
    for (float i = 0.0; i < 4.; i++) {
        cUv = fract(cUv * 1.5) - 0.5;

        float sn = 4. + mod(floor(t),9.);

        // SDF 
        float d = sdStar(cUv, 0.4, sn, 0.4) * exp(-length(uv0));

        vec3 col = palette(length(uv0) + i*.4 + uTime*.4);

        d = sin(d*8. + uTime)/8.;
        d = abs(d);

        d = pow(0.008 / d, 1.4);

        finalColor += col * d;
    }
        
    gl_FragColor = vec4(finalColor, 1.);
}
