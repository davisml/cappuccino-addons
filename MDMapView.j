@import <CappuGeo/CappuGeo.j>

@implementation MDMapView : MKMapView
{
    var markers;
}

- (id)initWithFrame:(CGRect)aRect;
{
    if(self = [super initWithFrame:aRect]){
        markers = [[CPMutableArray alloc] init];
    }
    return self;
}

- (void)addMarkerWithTitle:(CPString)title coordinate:(CCLocation)aLocation;
{
    var coord = [aLocation coordinate];
    var latLng = new google.maps.LatLng(coord['latitude'], coord['longitude']);
    
    var marker = new google.maps.Marker({
        position: latLng,
        map: _map,
        title: title
    });
    
    markers.push(marker);
}

- (void)displayMarkers;
{
    if(_map){
        var i;
        for(i=0; i<[markers count]; i++){
            var marker = [markers objectAtIndex:i];
            if(!marker.map)
                marker.setMap(_map);
        }
    }
}

- (void)layoutSubviews;
{
    [super layoutSubviews];
    [self displayMarkers];
}

@end