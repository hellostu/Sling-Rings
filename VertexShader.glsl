attribute vec4 Position;
attribute vec4 SourceColor;

varying vec4 DestinationColor;
uniform mat4 View;
uniform mat4 Model;

void main(void) {
    DestinationColor = SourceColor;
    gl_Position = View * Model * Position;
}