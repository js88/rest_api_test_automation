Feature: Put Method
As an olapic developer 
I want to test put method for sonar api
        
        Scenario Outline: Create a sonar object using the provider's information
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object does not exist
                When I want to PUT a place using provider's information
                Then the response status code should be 201

                Examples:
                | PROVIDER_NAME  | PROVIDER_PLACE_ID         | 
                | facebook       |  100524972391             |      
                | foursquare     |  4b9f9c79f964a520c22e37e3 |

        Scenario Outline: Create the same sonar object twice
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                But that the sonar object already exists 
                When I want to PUT a place using provider's information 
                Then the response status code should be 200
                And a json response is received
          
                Examples:
                | PROVIDER_NAME | PROVIDER_PLACE_ID             | 
                | facebook      |     100524972391              |
                | foursquare    |  4b9f9c79f964a520c22e37e3     | 
                
        Scenario Outline: Create a sonar object without a valid provider name
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                When I want to PUT a place using provider's information
                Then the response status code should be 404

                Examples:
                | PROVIDER_NAME  | PROVIDER_PLACE_ID         | 
                | fAAceb00k      |  100524972391             |          
                | f0ursquAAre    |  4b9f9c79f964a520c22e37e3 | 

        Scenario Outline: Create a sonar object with an empty provider name
                Given that the providerName is <PROVIDER_NAME> 
                When I want to PUT a place using provider's information
                Then the response status code should be 404
       
                Examples:
                | PROVIDER_NAME | 
                | facebook      |      
                | foursquare    |

        Scenario Outline: Create a sonar object with an empty provider place id
                Given that the providerName is <PROVIDER_PLACE_ID> 
                When I want to PUT a place using provider's information
                Then the response status code should be 404
       
                Examples:
                | PROVIDER_PLACE_ID         | 
                | 100524972391              |        
                | 4b9f9c79f964a520c22e37e3  | 

        Scenario Outline: Validate the response data when using PUT method
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                When I want to PUT a place using provider's information
                Then a json response is received
                And the json has the following information in data:

                |id|
                |name|
                |url|
                |source|
                |geopoint|
                |instagram_location|
               
                Examples:
                | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
                | facebook      |  100524972391             |       
                | foursquare    |  4b9f9c79f964a520c22e37e3 |   



        Scenario Outline: Validate the response data when using PUT method
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                When I want to PUT a place using provider's information
                Then a json response is received
                And the json has the following key-value information in data:

                |source/provider_name| <PROVIDER_NAME>     |
                |source/provider_id  | <PROVIDER_PLACE_ID> |

                Examples:
                | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
                | facebook      |  100524972391             |       
                | foursquare    |  4b9f9c79f964a520c22e37e3 |
