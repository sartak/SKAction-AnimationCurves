#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, SKActionCurve) {
    SKActionCurveLinear,

    SKActionCurveQuadraticEaseIn,
    SKActionCurveQuadraticEaseOut,
    SKActionCurveQuadraticEaseInEaseOut,

    SKActionCurveCubicEaseIn,
    SKActionCurveCubicEaseOut,
    SKActionCurveCubicEaseInEaseOut,

    SKActionCurveSineEaseIn,
    SKActionCurveSineEaseOut,
    SKActionCurveSineEaseInEaseOut,

    SKActionCurveCircularEaseIn,
    SKActionCurveCircularEaseOut,
    SKActionCurveCircularEaseInEaseOut,

    SKActionCurveExponentialEaseIn,
    SKActionCurveExponentialEaseOut,
    SKActionCurveExponentialEaseInEaseOut,

    SKActionCurveElasticEaseIn,
    SKActionCurveElasticEaseOut,
    SKActionCurveElasticEaseInEaseOut,

    SKActionCurveOvershootEaseIn,
    SKActionCurveOvershootEaseOut,
    SKActionCurveOvershootEaseInEaseOut,

    SKActionCurveBounceEaseIn,
    SKActionCurveBounceEaseOut,
    SKActionCurveBounceEaseInEaseOut,
};

@interface SKAction (AnimationCurves)

+(SKAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
+(SKAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;

+(SKAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
+(SKAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
+(SKAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;

+(SKAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
+(SKAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;

/*
 +(SKAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec curve:(SKActionCurve)curve shortestUnitArc:(BOOL)shortestUnitArc;

 +(SKAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration curve:(SKActionCurve)curve;
 +(SKAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration curve:(SKActionCurve)curve;

 +(SKAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration curve:(SKActionCurve)curve;
 +(SKAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration curve:(SKActionCurve)curve;

 +(SKAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 +(SKAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 +(SKAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 +(SKAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 +(SKAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 +(SKAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec curve:(SKActionCurve)curve;
 */
@end
