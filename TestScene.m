#import "TestScene.h"
#import "SKAction+AnimationCurves.h"

@implementation TestScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        CGFloat topY = size.height * .66;
        CGFloat bottomY = size.height * .33;
        SKTexture *texture = [SKTexture textureWithImageNamed:@"Spaceship"];

        NSArray *curves = @[
                            @(SKActionCurveLinear),

                            @(SKActionCurveQuadraticEaseIn),
                            @(SKActionCurveQuadraticEaseOut),
                            @(SKActionCurveQuadraticEaseInEaseOut),

                            @(SKActionCurveCubicEaseIn),
                            @(SKActionCurveCubicEaseOut),
                            @(SKActionCurveCubicEaseInEaseOut),

                            @(SKActionCurveSineEaseIn),
                            @(SKActionCurveSineEaseOut),
                            @(SKActionCurveSineEaseInEaseOut),

                            @(SKActionCurveCircularEaseIn),
                            @(SKActionCurveCircularEaseOut),
                            @(SKActionCurveCircularEaseInEaseOut),

                            @(SKActionCurveExponentialEaseIn),
                            @(SKActionCurveExponentialEaseOut),
                            @(SKActionCurveExponentialEaseInEaseOut),

                            @(SKActionCurveElasticEaseIn),
                            @(SKActionCurveElasticEaseOut),
                            @(SKActionCurveElasticEaseInEaseOut),

                            @(SKActionCurveOvershootEaseIn),
                            @(SKActionCurveOvershootEaseOut),
                            @(SKActionCurveOvershootEaseInEaseOut),

                            @(SKActionCurveBounceEaseIn),
                            @(SKActionCurveBounceEaseOut),
                            @(SKActionCurveBounceEaseInEaseOut),
                            ];

        for (int i = 0; i < curves.count; ++i) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            sprite.xScale = sprite.yScale = size.width / (texture.size.width * (curves.count + 1));
            sprite.color = [SKColor colorWithHue:.8*i/(CGFloat)curves.count saturation:1 brightness:1 alpha:1];
            sprite.colorBlendFactor = 1;
            [self addChild:sprite];

            sprite.position = CGPointMake(size.width * (i+1) / ((CGFloat)curves.count+1), bottomY);

            SKActionCurve curve = [curves[i] intValue];

            NSArray *sequence = @[
                                  [SKAction waitForDuration:.5],
                                  [SKAction moveToY:topY duration:2 curve:curve],
                                  [SKAction waitForDuration:.5],
                                  [SKAction rotateToAngle:M_PI duration:1 curve:curve],
                                  [SKAction waitForDuration:.5],
                                  [SKAction moveToY:bottomY duration:2 curve:curve],
                                  [SKAction waitForDuration:.5],
                                  [SKAction rotateToAngle:0 duration:1 curve:curve],
                                  [SKAction waitForDuration:2],
                                  ];

            [sprite runAction:[SKAction repeatActionForever:[SKAction sequence:sequence]]];
        }
    }
    return self;
}

@end
