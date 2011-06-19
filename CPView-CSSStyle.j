@import <Foundation/CPObject.j>

@implementation CPView (CSSStyle)

- (CPDictionary)styleProperties;
{
    var i;
    
    var cssText = _DOMElement.style.cssText;
    var textSplit = [cssText componentsSeparatedByString:@"; "];
    var styleDictionary = [CPMutableDictionary dictionary];
    
    for(i=0; i<[textSplit count]; i++){
        var style = [textSplit objectAtIndex:i];
        var styleSplit = [style componentsSeparatedByString:@": "];
        if ([styleSplit count] == 2)
            [styleDictionary setValue:[styleSplit objectAtIndex:1] forKey:[styleSplit objectAtIndex:0]];
    }
    
    return styleDictionary;
}

- (void)setStyleProperties:(CPDictionary)properties;
{
    var i;
    var cssText = @"";
    var keys = [properties allKeys];
    
    for(i=0; i<[keys count]; i++){
        var key = [keys objectAtIndex:i];
        cssText = [cssText stringByAppendingFormat:@"%@: %@; ", key, [properties valueForKey:key]];
    }
    
    _DOMElement.style.cssText = cssText;
}

- (void)setValues:(CPArray)values forStyleProperties:(CPArray)properties;
{
    var i;
    
    for(i=0; i<[values count]; i++){
        var value = [values objectAtIndex:i];
        var property = [properties objectAtIndex:i];
        var cssString = nil;
        
        if([value isKindOfClass:[CPColor class]])
            cssString = [value cssString];
        else
            cssString = value;
    
        var newStyleProperties = [[self styleProperties] mutableCopy];
        [newStyleProperties setValue:cssString forKey:property];
    }
    [self setStyleProperties:newStyleProperties];
}

- (void)setValue:(id)val forStyleProperty:(CPString)property;
{
    [self setValues:[CPArray arrayWithObject:val] forStyleProperties:[CPArray arrayWithObject:property]];
}

- (id)valueForStyleProperty:(CPString)aProperty;
{
    return [[self styleProperties] valueForKey:aProperty];
}

// Convenience

- (void)setBorderRadius:(int)radius;
{
    [self setValue:[CPString stringWithFormat:@"%dpx", radius] forStyleProperty:@"-webkit-border-radius"];
}

@end