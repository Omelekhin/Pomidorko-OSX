//
//  Shapes.swift
//  Pomidorko
//
//  Created by Volter on 22.10.15.
//  Copyright (c) 2015 volter9. All rights reserved.
//

import Cocoa

func play(ctx: CGContextRef)
{
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 8.619)
    CGContextAddCurveToPoint(ctx, -0.000, -4.718, 9.627, 1.391, 9.627, 1.391)
    CGContextAddCurveToPoint(ctx, 9.627, 1.391, 94.566, 50.161, 103.487, 56.809)
    CGContextAddCurveToPoint(ctx, 109.482, 60.842, 109.457, 67.381, 103.487, 71.266)
    CGContextAddCurveToPoint(ctx, 94.459, 77.142, 9.627, 126.685, 9.627, 126.685)
    CGContextAddCurveToPoint(ctx, 9.627, 126.685, -0.000, 132.612, -0.000, 119.456)
    CGContextAddCurveToPoint(ctx, -0.000, 109.539, -0.000, 20.582, -0.000, 8.619)
    CGContextClosePath(ctx)
}

func pause(ctx: CGContextRef)
{
    CGContextBeginPath(ctx)
    
    CGContextMoveToPoint(ctx, 8, 4)
    CGContextAddLineToPoint(ctx, 36, 4)
    CGContextAddCurveToPoint(ctx, 39.324, 4, 42, 6.676, 42, 10)
    CGContextAddLineToPoint(ctx, 42, 118)
    CGContextAddCurveToPoint(ctx, 42, 121.324, 39.324, 124, 36, 124)
    CGContextAddLineToPoint(ctx, 8, 124)
    CGContextAddCurveToPoint(ctx, 4.676, 124, 2, 121.324, 2, 118)
    CGContextAddLineToPoint(ctx, 2, 10)
    CGContextAddCurveToPoint(ctx, 2, 6.676, 4.676, 4, 8, 4)
    CGContextClosePath(ctx)
    
    CGContextMoveToPoint(ctx, 72, 4)
    CGContextAddLineToPoint(ctx, 100, 4)
    CGContextAddCurveToPoint(ctx, 103.324, 4, 106, 6.676, 106, 10)
    CGContextAddLineToPoint(ctx, 106, 118)
    CGContextAddCurveToPoint(ctx, 106, 121.324, 103.324, 124, 100, 124)
    CGContextAddLineToPoint(ctx, 72, 124)
    CGContextAddCurveToPoint(ctx, 68.676, 124, 66, 121.324, 66, 118)
    CGContextAddLineToPoint(ctx, 66, 10)
    CGContextAddCurveToPoint(ctx, 66, 6.676, 68.676, 4, 72, 4)
    CGContextClosePath(ctx)
}

func strip(ctx: CGContextRef, x: CGFloat = 10, y: CGFloat = 0, h: CGFloat = 80)
{
    let x = x - CGFloat(10)
    let y = y - CGFloat(40)
    let h = y + (h - CGFloat(60))
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 10 + x, 40 + y)
    CGContextAddCurveToPoint(ctx, 11.108 + x, 40 + y, 12 + x, 40.892 + y, 12 + x, 42 + y)
    
    CGContextAddLineToPoint(ctx, 12 + x, 98 + h)
    CGContextAddCurveToPoint(ctx, 12 + x, 99.108 + h, 11.108 + x, 100 + h, 10 + x, 100 + h)
    CGContextAddCurveToPoint(ctx, 8.892 + x, 100 + h, 8 + x, 99.108 + h, 8 + x, 98 + h)
    CGContextAddLineToPoint(ctx, 8 + x, 42 + y)
    CGContextAddCurveToPoint(ctx, 8 + x, 40.892 + y, 8.892 + x, 40 + y, 10 + x, 40 + y)
    CGContextClosePath(ctx)
}