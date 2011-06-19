/*

@protocol MDMapRequestDelegate)
- (void)mapRequestFailedWithError:(id)error;
- (void)mapRequestDidFinishLoading:(MDMapRequest)aRequest;
@end

*/

@implementation MDMapRequest : CPObject
{
    id delegate @accessors;
    CPString responseString;
    CPDictionary responseDictionary @accessors;
}

- (CPString)apiURL
{
    return @"http://maps.googleapis.com/maps/api";
}

- (void)retrieve
{
    responseString = @"";
}

// CPURLConnectionDelegate Methods

- (void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
    [delegate mapRequestFailedWithError:error];
}

- (void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response
{
    
}

- (void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
    responseString = [responseString stringByAppendingString:data];
}

- (void)connectionDidFinishLoading:(CPURLConnection)connection
{
    responseDictionary = [CPDictionary dictionaryWithJSObject:[responseString objectFromJSON] recursively:YES];
    [delegate mapRequestDidFinishLoading:self];
}

@end