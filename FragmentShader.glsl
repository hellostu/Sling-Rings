varying lowp vec4 DestinationColor;

varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;

void main(void) {
    lowp vec4 tex = texture2D(Texture, TexCoordOut);
    
    if (tex.r == 0.0 && tex.g == 0.0 && tex.b == 0.0) {
        gl_FragColor = DestinationColor;
    } else {
        gl_FragColor = tex;
    }
}