# Macroquad Minimal Shader Template

A super simple example showing how to plug GLSL shaders into a [macroquad](https://github.com/not-fl3/macroquad) project.

This template sets up a custom vertex and fragment shader using `load_material`, then uses `gl_use_material` to draw a fullscreen pass with it. The fragment shader just outputs solid white, but it's a clean base for experimenting with effects, lighting, or post-processing.

Uses `#version 100` GLSL — compatible with both desktop and WebAssembly (OpenGL ES 2.0 / WebGL 1).

---

### What's in here

- Basic vertex shader: takes in position and applies model/projection transforms
- Fragment shader: fills the screen with a uniform color
- Macroquad render loop: draw a rectangle, apply shader, swap back to default material
- Press `Escape` to exit — just like raylib

---

This is mostly for messing around with GPU shaders in Rust using Macroquad.  
Useful if you're experimenting with post-processing effects or just learning how shader pipelines fit into real-time rendering.

---

