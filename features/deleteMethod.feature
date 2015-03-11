Feature: Delete Method
As an olapic developer 
I want to test delete method for sonar api
        
        Scenario Outline: Delete a sonar object using the provider's information
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object already exists
                When I want to DELETE a place using provider's information
                Then the response status code should be 200

                Examples:
                | PROVIDER_NAME  | PROVIDER_PLACE_ID         | 
                | facebook       |  100524972391             |      
                | foursquare     |  4b9f9c79f964a520c22e37e3 |

        Scenario Outline: Delete a sonar object without a valid provider name
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object already exists
                But that the providerName is invalidString
                When I want to DELETE a place using provider's information
                Then the response status code should be 404

                Examples:
                | PROVIDER_NAME     | PROVIDER_PLACE_ID         | 
                | facebook          |  100524972391             |          
                | foursquare        |  4b9f9c79f964a520c22e37e3 | 

        Scenario Outline: Delete a sonar object without a valid provider place id
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object already exists
                But that the providerPlaceId is invalidString
                When I want to DELETE a place using provider's information
                Then the response status code should be 404

                Examples:
                | PROVIDER_NAME     | PROVIDER_PLACE_ID         | 
                | facebook          |  100524972391             |          
                | foursquare        |  4b9f9c79f964a520c22e37e3 | 

        Scenario Outline: Delete the same sonar object twice
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object already exists
                But I want to DELETE a place using provider's information
                When I want to DELETE a place using provider's information 
                Then the response status code should be 404
          
                Examples:
                | PROVIDER_NAME | PROVIDER_PLACE_ID             | 
                | facebook      |     100524972391              |
                | foursquare    |  4b9f9c79f964a520c22e37e3     | 

        Scenario Outline: Validate the response data when deleting a sonar object
                Given that the providerName is <PROVIDER_NAME> 
                And that the providerPlaceId is <PROVIDER_PLACE_ID> 
                And that the sonar object already exists
                When I want to DELETE a place using provider's information
                Then a json response is received

                Examples:
                | PROVIDER_NAME | PROVIDER_PLACE_ID         | 
                | facebook      |  100524972391             |       
                | foursquare    |  4b9f9c79f964a520c22e37e3 |   
