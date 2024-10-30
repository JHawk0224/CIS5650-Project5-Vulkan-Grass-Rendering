# Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 5650: GPU Programming and Architecture, Project 5 - Vulkan Grass Rendering**

- Jordan Hochman
  - [LinkedIn](https://www.linkedin.com/in/jhochman24), [Personal Website](https://jordanh.xyz), [GitHub](https://github.com/JHawk0224)
- Tested on: Windows 11, Ryzen 7 5800 @ 3.4GHz 32GB, GeForce RTX 3060 Ti 8GB (Compute Capability: 8.6)

## Welcome to my Vulkan Grass Rendering Project!

In this project, I implemented a grass renderer in Vulkan following this [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) paper. It models each blade of grass as a triangle affected by 3 forces, gravity, the resistance of the blade, and the wind. More details about the exact implementation of these forces can be found in `INSTRUCTION.md` [here](INSTRUCTION.md).

### Demo Video/GIF

[![](images/deferred-5000.gif)](images/demo-video.mp4)

Here is a [demo video](images/demo-video.mp4) of it running. Note that the FPS cap/framiness is due to the video itself, and not the actual graphics pipeline. The video only has so many frames per second, so instead, look at the FPS counter in the top left. The same is true for all of the other GIFs in this README.

- brief description of project and specific features implemented
- GIFs at different stages with features added incrementally
- Performance analysis:
  - How handles varying number of blades
  - Improvement by culling with each test
