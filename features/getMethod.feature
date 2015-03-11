Feature: Get Method
As an olapic developer 
I want to test get method for sonar api

    Scenario Outline: Get a place in sonar using the provider's information
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        And that the sonar object already exists
        When I want to GET a place from provider's information
        Then the response status code should be 200
        And a json response is received
    
        Examples:
        | PROVIDER_NAME  | PROVIDER_PLACE_ID        |
        |  facebook      |  100524972391            |
        |  foursquare    |  4b9f9c79f964a520c22e37e3|

    Scenario Outline: Validate the response data when using GET method
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID>  
        And that the sonar object already exists
        When I want to GET a place from provider's information
        Then the response status code should be 200
        And a json response is received
        And the json has the following information in data:
        |provider_id|
        |provider_name|
        |provider_hash|
        |name|
        |url|

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |       
        | foursquare    |  4b9f9c79f964a520c22e37e3 |

    Scenario Outline: Validate the response data when using GET method
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID>  
        And that the sonar object already exists
        When I want to GET a place from provider's information
        Then the response status code should be 200
        And a json response is received
        And the json has the following key-value information in data:

        |provider_name| <PROVIDER_NAME>     |
        |provider_id  | <PROVIDER_PLACE_ID> |

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |       
        | foursquare    |  4b9f9c79f964a520c22e37e3 |

    Scenario Outline: Get information from a sonar object with an invalid parameter
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        When I want to GET a place from provider's information
        Then the response status code should be 404
        And a json response is received
        
        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID | 
        | invalid       |  100524972391     |       
        | foursquare    |  invalid          | 

    Scenario Outline: Get information from a sonar object with an empty provider name
        Given that the providerName is <PROVIDER_NAME> 
        When I want to GET a place from provider's information 
        Then the response status code should be 404
        And a json response is received
       
        Examples:
        | PROVIDER_NAME | 
        | facebook      |      
        | foursquare    | 
   
    Scenario Outline: Get information from a sonar object with an empty provider place id
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        When I want to GET a place from provider's information 
        Then the response status code should be 404
        And a json response is received
       
        Examples:
        | PROVIDER_PLACE_ID         | 
        | 100524972391              |        
        | 4b9f9c79f964a520c22e37e3  |    

    Scenario Outline: Get information from a sonar object using the UUID
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        And that the sonar object already exists
        And that I save the returned UUID
        When I want to GET a place using the UUID information
        Then the response status code should be 200
        And a json response is received
        And the json has the following information in data:
        |id|
        |name|
        |source|
        |url|
        |geopoint|
        |instagram_location|

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |       
        | foursquare    |  4b9f9c79f964a520c22e37e3 |   


    Scenario Outline: Get information from a sonar object using the UUID
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        And that the sonar object already exists
        And that I save the returned UUID
        When I want to GET a place using the UUID information
        Then the response status code should be 200
        And a json response is received
        And the json has the following key-value information in data:

        |source/provider_name| <PROVIDER_NAME>     |
        |source/provider_id  | <PROVIDER_PLACE_ID> |

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |       
        | foursquare    |  4b9f9c79f964a520c22e37e3 |

    Scenario Outline: Get information from a sonar object using an empty UUID
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        And that the sonar object already exists
        When I want to GET a place using the UUID information
        Then the response status code should be 404
        And a json response is received

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |

  

    Scenario Outline: Get a place after creating it
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID>
        And that the sonar object does not exist
        And that the sonar object already exists
        When I want to GET a place from provider's information
        Then the response status code should be 200
        
        Examples:
        | PROVIDER_NAME  | PROVIDER_PLACE_ID        |
        |  facebook      |  100524972391            |
        |  foursquare    |  4b9f9c79f964a520c22e37e3| 

    Scenario Outline: Get a place after deleting it
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID>
        And that the sonar object does not exist
        And that the sonar object already exists
        And I want to GET a place from provider's information
        And that the sonar object does not exist
        When I want to GET a place from provider's information
        Then the response status code should be 404
        And a json response is received
        
        Examples:
        | PROVIDER_NAME  | PROVIDER_PLACE_ID        |
        |  facebook      |  100524972391            |
        |  foursquare    |  4b9f9c79f964a520c22e37e3| 

    Scenario Outline: Get information from a sonar object using the UUID after removing it
        Given that the providerName is <PROVIDER_NAME> 
        And that the providerPlaceId is <PROVIDER_PLACE_ID> 
        And that the sonar object already exists
        And that I save the returned UUID
        And that the sonar object does not exist
        When I want to GET a place using the UUID information
        Then the response status code should be 404
        And a json response is received

        Examples:
        | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
        | facebook      |  100524972391             |       
        | foursquare    |  4b9f9c79f964a520c22e37e3 |   
