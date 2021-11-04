# Affecting Particles

Particles are emitted by the emitter. After a particle was emitted it can’t be changed any more by the emitter. The affectors allows you to influence particles after they have been emitted.

Each type of affector affects particles in a different way:

* `Age` - alter where the particle is in its life-cycle
* `Attractor` - attract particles towards a specific point
* `Friction` - slows down movement proportional to the particle’s current velocity
* `Gravity` - set’s an acceleration in an angle
* `Turbulence` - fluid like forces based on a noise image
* `Wander` -  randomly vary the trajectory
* `GroupGoal` -  change the state of a group of a particle
* `SpriteGoal` - change the state of a sprite particle

## Age

Allows particle to age faster. the `lifeLeft` property specified how much life a particle should have left.

<<< @/docs/ch10-effects/src/particles/age.qml#M1

In the example, we shorten the life of the upper particles once when they reach the age of affector to 1200 msec. As we have set the `advancePosition` to true, we see the particle appearing again on a position when the particle has 1200 msecs left to live.

![image](./assets/age.png)

## Attractor

The attractor attracts particles towards a specific point. The point is specified using `pointX` and `pointY`, which is relative to the attractor geometry. The strength specifies the force of attraction. In our example we let particles travel from left to right. The attractor is placed on the top and half of the particles travel through the attractor. Affector only affect particles while they are in their bounding box. This split allows us to see the normal stream and the affected stream simultaneous.

<<< @/docs/ch10-effects/src/particles/attractor.qml#M1

It’s easy to see that the upper half of the particles are affected by the attracted to the top. The attraction point is set to top-left (0/0 point) of the attractor with a force of 1.0.

![image](./assets/attractor.png)

## Friction

The friction affector slows down particles by a factor until a certain threshold is reached.

<<< @/docs/ch10-effects/src/particles/friction.qml#M1

In the upper friction area, the particles are slowed down by a factor of 0.8 until the particle reaches 25 pixels per seconds velocity. The threshold act’s like a filter. Particles traveling above the threshold velocity are slowed down by the given factor.

![image](./assets/friction.png)

## Gravity

The gravity affector applies an acceleration In the example we stream the particles from the bottom to the top using an angle direction. The right side is unaffected, where on the left a gravity effect is applied. The gravity is angled to 90 degrees (bottom-direction) with a magnitude of 50.

<<< @/docs/ch10-effects/src/particles/gravity.qml#M1

Particles on the left side try to climb up, but the steady applied acceleration towards the bottom drags them into the direction of the gravity.

![image](./assets/gravity.png)

## Turbulence

The turbulence affector applies a *chaos* map of force vectors to the particles. The chaos map is defined by a noise image, which can be defined with the *noiseSource* property. The strength defines how strong the vector will be applied to the particle movements.

<<< @/docs/ch10-effects/src/particles/turbulence.qml#M1

In the upper area of the example, particles are influenced by the turbulence. Their movement is more erratic. The amount of erratic deviation from the original path is defined by the strength.

![image](./assets/turbulence.png)

## Wander

The wander manipulates the trajectory. With the property *affectedParameter* can be specified which parameter (velocity, position or acceleration) is affector by the wander. The *pace* property specifies the maximum of attribute changes per second. The yVariance and yVariance specify the influence on x and y component of the particle trajectory.

<<< @/docs/ch10-effects/src/particles/wander.qml#M1

In the top wander affector particles are shuffled around by random trajectory changes. In this case, the position is changed 200 times per second in the y-direction.

![image](./assets/wander.png)
