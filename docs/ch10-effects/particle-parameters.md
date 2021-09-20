# Particle Parameters

We saw already how to change the behavior of the emitter to change our simulation. The particle painter used allows us how the particle image is visualized for each particle.

Coming back to our example we update our `ImageParticle`. First, we change our particle image to a small sparking star image:

```qml
ImageParticle {
    ...
    source: 'assets/star.png'
}
```

The particle shall be colorized in an gold color which varies from particle to particle by +/- 20%:

```qml
color: '#FFD700'
colorVariation: 0.2
```

To make the scene more alive we would like to rotate the particles. Each particle should start by 15 degrees clockwise and varies between particles by +/-5 degrees. Additional the particle should continuously rotate with the velocity of 45 degrees per second. The velocity shall also vary from particle to particle by +/- 15 degrees per second:

```qml
rotation: 15
rotationVariation: 5
rotationVelocity: 45
rotationVelocityVariation: 15
```

Last but not least, we change the entry effect for the particle. This is the effect used when a particle comes to life. In this case, we want to use the scale effect:

```qml
entryEffect: ImageParticle.Scale
```

So now we have rotating golden stars appearing all over the place.

![image](./assets/particleparameters.png)

Here is the code we changed for the image-particle in one block.

<<< @/docs/ch10-effects/src/particles/particlevariation.qml#M1
