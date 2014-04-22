# SKAction+AnimationCurves

## WARNING: This is incomplete!
## Do not use yet!

Here are the builtin curves of Sprite Kit.

![builtin curves](https://raw.githubusercontent.com/sartak/SKAction-AnimationCurves/master/builtin-curves.gif)

From left to right, it's: linear, ease in, ease out, ease in ease out.

Pretty boring stuff.

Here are all the curves that SKAction+AnimationCurves offers (thanks to [`AHEasing`](https://github.com/warrenm/AHEasing))

![all curves](https://raw.githubusercontent.com/sartak/SKAction-AnimationCurves/master/all-curves.gif)

The novel curves are as follows:

![novel curves](https://raw.githubusercontent.com/sartak/SKAction-AnimationCurves/master/novel-curves.gif)

From left to right, it's: linear, ease in (quadratic; same as the builtin), elastic, overshoot, bounce.

## Usage

This package provides a category for `SKAction`. Where it makes sense, action factory methods have an additional `curve:` parameter. For example, `SKAction moveTo:CGPointZero duration:2 curve:SKActionCurveElasticEaseOut]`.

I'm not too concerned about clashing with future versions of Sprite Kit, since the nomenclature there is "timing mode", not "animation curve".

## Performance

I've done some basic performance testing and it seems that using the provided category method incurs only a small overhead. On an iPhone 5S, continuously running move actions on 5000 nodes kept up at 60 FPS both with the builtin move action and the provided move action. At 6000 nodes, performance began dropping off for both implementations; these categories were a couple FPS behind at most.

In other words, any bottleneck in Sprite Kit is certainly not processing actions, even ones that invoke a block every frame.

