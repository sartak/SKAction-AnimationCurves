#import "SKAction+AnimationCurves.h"
#include "easing.h"

@implementation SKAction (AnimationCurves)

+(AHEasingFunction)easingForCurve:(SKActionCurve)curve {
    switch (curve) {
        case SKActionCurveLinear:
        default:
            return &LinearInterpolation;

        case SKActionCurveQuadraticEaseIn:
            return &QuadraticEaseIn;
        case SKActionCurveQuadraticEaseOut:
            return &QuadraticEaseOut;
        case SKActionCurveQuadraticEaseInEaseOut:
            return &QuadraticEaseInOut;

        case SKActionCurveCubicEaseIn:
            return &CubicEaseIn;
        case SKActionCurveCubicEaseOut:
            return &CubicEaseOut;
        case SKActionCurveCubicEaseInEaseOut:
            return &CubicEaseInOut;

        case SKActionCurveSineEaseIn:
            return &SineEaseIn;
        case SKActionCurveSineEaseOut:
            return &SineEaseOut;
        case SKActionCurveSineEaseInEaseOut:
            return &SineEaseInOut;

        case SKActionCurveCircularEaseIn:
            return &CircularEaseIn;
        case SKActionCurveCircularEaseOut:
            return &CircularEaseOut;
        case SKActionCurveCircularEaseInEaseOut:
            return &CircularEaseInOut;

        case SKActionCurveExponentialEaseIn:
            return &ExponentialEaseIn;
        case SKActionCurveExponentialEaseOut:
            return &ExponentialEaseOut;
        case SKActionCurveExponentialEaseInEaseOut:
            return &ExponentialEaseInOut;

        case SKActionCurveElasticEaseIn:
            return &ElasticEaseIn;
        case SKActionCurveElasticEaseOut:
            return &ElasticEaseOut;
        case SKActionCurveElasticEaseInEaseOut:
            return &ElasticEaseInOut;

        case SKActionCurveOvershootEaseIn:
            return &BackEaseIn;
        case SKActionCurveOvershootEaseOut:
            return &BackEaseOut;
        case SKActionCurveOvershootEaseInEaseOut:
            return &BackEaseInOut;

        case SKActionCurveBounceEaseIn:
            return &BounceEaseIn;
        case SKActionCurveBounceEaseOut:
            return &BounceEaseOut;
        case SKActionCurveBounceEaseInEaseOut:
            return &BounceEaseInOut;
    }
}

+(void (^)(SKNode *node, CGFloat progress))deltifyForDuration:(NSTimeInterval)sec usingCurve:(SKActionCurve)curve initialize:(void (^)(SKNode *node))initializer animations:(void (^)(SKNode *node, CGFloat progress))progressBlock {
    __block CGFloat previous = HUGE_VAL;
    AHEasingFunction easing = [self easingForCurve:curve];

    return ^(SKNode *node, CGFloat elapsedTime) {
        CGFloat diff;

        if (previous > elapsedTime) { // first time the action is run (including via repeats)
            diff = elapsedTime;

            if (initializer) {
                initializer(node);
            }
        }
        else {
            diff = elapsedTime - previous;
        }
        previous = elapsedTime;

        CGFloat progress = diff / sec;
        progressBlock(node, progress);
    };
}

+(void (^)(SKNode *node, CGFloat progress))deltifyForDuration:(NSTimeInterval)sec usingCurve:(SKActionCurve)curve animations:(void (^)(SKNode *node, CGFloat progress))progressBlock {
    return [self deltifyForDuration:sec
                             usingCurve:curve
                             initialize:nil
                             animations:progressBlock];
}

+(void (^)(SKNode *node, CGFloat progress))progressifyForDuration:(NSTimeInterval)sec usingCurve:(SKActionCurve)curve initialize:(void (^)(SKNode *node))initializer animations:(void (^)(SKNode *node, CGFloat progress))progressBlock {
    __block CGFloat previous = HUGE_VAL;
    AHEasingFunction easing = [self easingForCurve:curve];

    return ^(SKNode *node, CGFloat elapsedTime) {
        if (previous > elapsedTime) { // first time the action is run (including via repeats)
            if (initializer) {
                initializer(node);
            }
        }
        previous = elapsedTime;

        CGFloat progress = elapsedTime / sec;
        CGFloat easedProgress = easing(progress);
        progressBlock(node, easedProgress);
    };
}

+(void (^)(SKNode *node, CGFloat progress))progressifyForDuration:(NSTimeInterval)sec usingCurve:(SKActionCurve)curve animations:(void (^)(SKNode *node, CGFloat progress))progressBlock {
    return [self progressifyForDuration:sec
                             usingCurve:curve
                             initialize:nil
                             animations:progressBlock];
}

+(SKAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self deltifyForDuration:sec
                                                            usingCurve:curve
                                                            animations:^(SKNode *node, CGFloat progress) {
        node.position = CGPointMake(node.position.x + deltaX * progress, node.position.y + deltaY * progress);
    }]];
}

+(SKAction *)moveTo:(CGPoint)destination duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    __block CGPoint origin;
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self progressifyForDuration:sec
                                                                usingCurve:curve
                                                                initialize:^(SKNode *node) {
                                                                    origin = node.position;
                                                                }
                                                                animations:^(SKNode *node, CGFloat progress) {
        node.position = CGPointMake(
            origin.x + progress * (destination.x - origin.x),
            origin.y + progress * (destination.y - origin.y));
        }]];
}

+(SKAction *)moveToX:(CGFloat)destinationX duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    __block CGFloat originX;
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self progressifyForDuration:sec
                                                                usingCurve:curve
                                                                initialize:^(SKNode *node) {
                                                                    originX = node.position.x;
                                                                }
                                                                animations:^(SKNode *node, CGFloat progress) {
        node.position = CGPointMake(originX + progress * (destinationX - originX), node.position.y);
    }]];
}

+(SKAction *)moveToY:(CGFloat)destinationY duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    __block CGFloat originY;
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self progressifyForDuration:sec
                                                                usingCurve:curve
                                                                initialize:^(SKNode *node) {
                                                                    originY = node.position.y;
                                                                }
                                                                animations:^(SKNode *node, CGFloat progress) {
        node.position = CGPointMake(node.position.x, originY + progress * (destinationY - originY));
    }]];
}

+(SKAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self deltifyForDuration:sec
                                                            usingCurve:curve
                                                            animations:^(SKNode *node, CGFloat progress) {
        node.zRotation = node.zRotation + radians * progress;
    }]];
}

+(SKAction *)rotateToAngle:(CGFloat)destinationZ duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    __block CGFloat originZ;
    return [SKAction customActionWithDuration:sec
                                  actionBlock:[self progressifyForDuration:sec
                                                                usingCurve:curve
                                                                initialize:^(SKNode *node) {
                                                                    originZ = node.zRotation;
                                                                }
                                                                animations:^(SKNode *node, CGFloat progress) {
                                                                    node.zRotation = originZ + progress * (destinationZ - originZ);
                                                                }]];
}

+(SKAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec curve:(SKActionCurve)curve {
    return [self moveByX:delta.dx y:delta.dy duration:sec curve:curve];
}

@end
