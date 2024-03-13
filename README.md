# PGAJ-Projective-Geometric-Algebra-in-Jai
An implementation of (Euclidean) Projective Geometric Algebra in Jai, including dual quaternions, homogeneous points and planes, plucker coordinates, and flectors

# What is a Dual Quaternion? What is a Flector?
These are the two basic data structures you use in this library:

A **Dual quaternion**(Dq) is 8 floats and can be any of these:
-A translation (imagine a "vector" if you like)
-A rotation (imagine a quaternion if you like, though bear in mind quats are only rotations around lines through the origin
-A screw motion (rotation around an axis followed by translation along it)
-A line in "Plucker coordinates". This is the special case of a rotation where the rotation is by 180 degrees

A **Flector**(Fl) is also 8 floats and can be any of these:
-A plane (in homogeneous coordinates, eg essentially normal-and-distance-from-origin)
-A point/vertex (also in homogeneous coordinates, eg xyz and w=1)
-A "normal"/"direction", aka a point-at-infinity (again homogeneous coordinates; w=0)
-A planar reflection (same thing as a plane, hun!), a point reflection (point!)
-A rotoreflection or glide reflection (a plane added to a point - because a point reflection is a planar reflection followed by a 180 turn, and a rotoreflection is a lerp of a plane and a point)

These are all the elements of the _Euclidean group_, eg they are all the _distance preserving_ transformations. They also have in common that they can be produced from composing some number of _planar reflections_. If the number is odd you get a flector, if the number is even you get a Dual Quaternion.

# Why the hell would I want any of those?
1. You want to solve the candy-wrapper effect with Dual Quaternion skinning https://www.youtube.com/watch?v=LUOJccOZfWQ and thereby let your artists tick the "preserve volume" box in blender/maya/autodesk/all fucking 3D animation software because it's fucking 2024 what the hell is wrong with everyone why do you hate animators
2. You want to interpolate rotations and translations for individual objects and matrices don't do this properly
3. You want to transform vertices _and_ lines _and_ planes with a single formula (sandwich product)
4. Because you have a plane and a line and you want their intersection _and_ their angle/distance and the projection of one onto the other from 3 lines of code
5. The same as above but for a point and a line, or for a line and a line, or two planes, or a plane and a point
6. You want to understand the math of quaternions properly, instead of being one of the people whose hands shake when it's time to interact with them, or one of those (even worse) people who watch the useless 3blue1brown video, learn nothing of use, and end up saying to their colleagues "quaternions are four dimensional" (basically a false statement, no truer than "rotation matrices are 9-dimensional")

# Where can I learn about Projective Geometric Algebra?
If (like me) you like lectures:
1. gdcvault.com/play/1029233/
2. gdcvault.com/play/1029237/
3. https://youtu.be/0i3ocLhbxJ4
4. https://youtube.com/playlist?list=PLsSPBzvBkYjxrsTOr0KLDilkZaw7UE2Vc

If you like reading:
1. https://en.wikipedia.org/wiki/Plane-based_geometric_algebra#Projective_geometric_algebra (written by me)
2. https://enkimute.github.io/LookMaNoMatrices/
3. https://arxiv.org/abs/2002.04509
4. https://bivector.net/PGADYN.html

# How this was made
https://www.twitch.tv/videos/2088938175
