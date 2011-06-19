@import "MDMapRequest.j"

@implementation MDMapDirections : MDMapRequest
{
    CPString startLocation;
    CPString endLocation;
}

- (id)initWithStartLocation:(CPString)startLoc endLocation:(CPString)endLoc
{
    if (self = [super init])
    {
        startLocation = startLoc;
        endLocation = endLoc;
    }
    return self;
}

- (void)retrieve
{
    [super retrieve];
    
    var urlString = [CPString stringWithFormat:@"%@/directions/json?origin=%@&destination=%@&sensor=false",[self apiURL],escape(startLocation),escape(endLocation),nil];
    var urlRequest = [CPURLRequest requestWithURL:urlString];
    var urlConnection = [CPURLConnection connectionWithRequest:urlRequest delegate:self];
}

@end