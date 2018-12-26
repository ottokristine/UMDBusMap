if t=0 you get the data for the past 15 minutes of data collection
subsequent calls could save time by saving the time returned by the vehicle locations command

API COMMAND CALLS
1) command to return all of the different routes and their tags
	http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=routeList&t=0s
2) returns all of the different agencyLists
	http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=agencyList
3) returns the latitude and logitude of the route stops
	command=routeConfig
4) use the routeList to get the tag of the route and the routeConfig to get all of the stops within that route routeConfig will give the stoptags of all stops along the route, this can be used in the prediciton call get predictions using the route tag and the stop TAG with the predictions call
        http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=predictions&s=stamsuhh_d&r=114
5) get route schedules using the schedule call and the route tag
    http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=schedule&r=114
6) get messages associated with a route, this will let you know if it is out of order, etc.
    http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=messages&r=114
7) get buses current location using route, id and epoch time
    http://webservices.nextbus.com/service/publicJSONFeed?a=umd&command=vehicleLocations&r=114&t=1545855661\
8) get Vehicle location using the vehicle ID
    http://webservices.nextbus.com/service/publicXMLFeed?command=vehicleLocation&a=umd&v=<vehicle id>}
