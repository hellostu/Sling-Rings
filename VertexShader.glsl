attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;
uniform mat4 View;
uniform mat4 Model;
uniform mat4 Projection;

attribute vec2 TexCoordIn;
varying vec2 TexCoordOut;

void main(void) {
    DestinationColor = SourceColor;
    gl_Position = Projection * View * Model * Position;
    TexCoordOut = TexCoordIn;
}