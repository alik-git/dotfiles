// Preserve terminal pixels and outline only the focused pane.
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    fragColor = texture(iChannel0, uv);
    vec2 edgeDistance = min(fragCoord, iResolution.xy - fragCoord);
    if (iFocus > 0 && min(edgeDistance.x, edgeDistance.y) < 2.0) {
        fragColor = vec4(vec3(0.4), 1.0);
    }
}
