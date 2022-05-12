# Simple Simulation

Let us have a look at a very simple simulation to get started. Qt Quick makes it actually very simple to get started with particle rendering. For this we need:


* A `ParticleSystem` which binds all elements to a simulation
* An `Emitter` which emits particles into the system
* A `ParticlePainter` derived element, which visualizes the particles

<<< @/docs/ch10-effects/src/particles/simple.qml#M1

The outcome of the example will look like this:

![image](./assets/simpleparticles.png)

We start with an 80x80 pixel dark rectangle as our root element and background. Therein we declare a `ParticleSystem`. This is always the first step as the system binds all other elements together. Typically the next element is the `Emitter`, which defines the emitting area based on it’s bounding box and basic parameters for them to be emitted particles. The emitter is bound to the system using the `system` property.

The emitter in this example emits 10 particles per second (`emitRate: 10`) over the area of the emitter with each a lifespan of 1000msec (`lifeSpan : 1000`) and a lifespan variation between emitted particles of 500 msec (`lifeSpanVariation: 500`). A particle shall start with a size of 16px (`size: 16`) and at the end of its life shall be 32px (`endSize: 32`).

The green bordered rectangle is a tracer element to show the geometry of the emitter. This visualizes that also while the particles are emitted inside the emitters bounding box the rendering is not limited to the emitters bounding box. The rendering position depends upon life-span and direction of the particle. This will get more clear when we look into how to change the direction particles.

The emitter emits logical particles. A logical particle is visualized using a `ParticlePainter` in this example we use an `ImageParticle`, which takes an image URL as the source property. The image particle has also several other properties, which control the appearance of the average particle.

* `emitRate`: particles emitted per second (defaults to 10 per second)
* `lifeSpan`: milliseconds the particle should last for (defaults to 1000 msec)
* `size`, `endSize`: size of the particles at the beginning and end of their life  (defaults to 16 px)

Changing these properties can influence the result in a drastical way

<<< @/docs/ch10-effects/src/particles/simple2.qml#M1

Besides increasing the emit rate to 40 and the lifespan to 2 seconds the size now starts at 64 pixels and decreases 32 pixels at the end of a particle lifespan.

![image](./assets/simpleparticles2.png)

Increasing the `endSize` even more would lead to a more or less white background. Please note also when the particles are only emitted in the area defined by the emitter the rendering is not constrained to it.
