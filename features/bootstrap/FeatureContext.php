<?php

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\TableNode;

require_once 'Utils.php';

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context, SnippetAcceptingContext
{

    private $provider_name;
    private $provider_place_id;
    private $request_response;
    private $curl;
    private $uuid;

    private $BASE_URL = "http://uk9c0jvb9f6nvxvhursp.olapic.com";
    private $API_PLACES_URL = "/v1/places";
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
    }

    /**
     * @Given that the providerName is :provider_name
     */
    public function thatTheProvidernameIs($provider_name)
    {
        $this->provider_name = $provider_name;
    }

    /**
     * @Given that the providerPlaceId is :provider_place_id
     */
    public function thatTheProviderplaceidIs($provider_place_id)
    {
        $this->provider_place_id = $provider_place_id;
    }

    /**
    * Creates an URL for making request to places using provider's information in Sonar API
    */
    public function createSonarPlacesURL(){
        return $this->BASE_URL . $this->API_PLACES_URL . "/" . $this->provider_name . "/" . $this->provider_place_id;
    }


    /**
    * Execute request with specified :method and :url. $curl and $request_response is modified in order to be able to test responses in other functions.
    */
    public function make_request($method, $url){
        $this->curl = curl_init();
        curl_setopt($this->curl, CURLOPT_URL, $url);
        curl_setopt($this->curl, CURLOPT_CUSTOMREQUEST, $method);
        curl_setopt($this->curl, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($this->curl, CURLOPT_FRESH_CONNECT, TRUE);
        

        $this->request_response = curl_exec($this->curl);
    }

    /**
     * @When I want to GET a place from provider's information
     */
    public function iWantToGetAPlaceFromProviderSInformation()
    {
        $url_req = $this->createSonarPlacesURL();

        $this->make_request("GET", $url_req);
    }


    /**
     * @When I want to PUT a place using provider's information
     */
    public function iWantToPutAPlaceUsingProviderSInformation()
    {
        $url_req = $this->createSonarPlacesURL();
        $this->make_request("PUT", $url_req);
    }                 

    /**                                                                 
     * @When I want to DELETE a place using provider's information      
     */                                                                 
    public function iWantToDeleteAPlaceUsingProviderSInformation()      
    {                                                                   
        $url_req = $this->createSonarPlacesURL();
        $this->make_request("DELETE", $url_req);                                 
    }
    
    /**                                                                 
     * @Given that the sonar object already exists                           
     */                                                                 
    public function thatTheSonarObjectAlreadyExists()                       
    {                                                                   
        $url_req = $this->createSonarPlacesURL();
        $this->make_request("PUT", $url_req);                                
    }                                                                   

    /**
     * @Given that the sonar object does not exist
     */
    public function thatTheSonarObjectDoesNotExist()
    {
        $url_req = $this->createSonarPlacesURL();
        $this->make_request("DELETE", $url_req);
    }

    /**
     * @Given that I save the returned UUID
     */
    public function thatISaveTheReturnedUuid()
    {
        $jsonAsArray = json_decode($this->request_response, true);
        $dataArray = $jsonAsArray['data'];
        $this->uuid = $dataArray['id'];
    }

    /**
     * @When I want to GET a place using the UUID information
     */
    public function iWantToGetAPlaceUsingTheUuidInformation()
    {
        $url_req = $this->BASE_URL . $this->API_PLACES_URL . "/sonar/" . $this->uuid;
        $this->make_request("GET", $url_req);
    }

    
    /**
     * @Then the response status code should be :statusCode
     */
    public function theResponseStatusCodeShouldBe($statusCode)
    {
        $actual_status_code = curl_getinfo($this->curl, CURLINFO_HTTP_CODE);
         if($statusCode != $actual_status_code) {
            throw new Exception("Status code is not $statusCode. Actual Status code is $actual_status_code.\n");
         }
    }

    /**
     * @Then a json response is received
     */
    public function aJsonResponseIsReceived()
    {
        if( !Utils::isJson($this->request_response)){
            throw new Exception("Response is not a well-formed JSON string. Response value: $this->request_response.\n");
        }
    }

    /**
     * @Then the json has the following information in data:
     */
    public function theJsonHasTheFollowingInformationInData(TableNode $table)
    {
        $jsonAsArray = json_decode($this->request_response, true);
        
        foreach ($table->getRows() as $row){
            $dataArray = $jsonAsArray['data'];
            $pathString = 'data';
            
            $value = $row[0];
            $pathValues = explode('/', $value);

            foreach ($pathValues as $path) {
                if(!isset($dataArray[$path])) {
                    throw new Exception("The response does not contain the value: $path in $pathString.\n");
                }
               $dataArray = $dataArray[$path];
               $pathString = $pathString . $path . "/";
            }

        }
    }

    /**                                                                                         
    * @Then the json has the following key-value information in data:                          
    */                                                                                         
    public function theJsonHasTheFollowingKeyValueInformationInData(TableNode $table)           
    {                                                                                           
        $jsonAsArray = json_decode($this->request_response, true);
        

        foreach ($table->getRows() as $row){
            $dataArray = $jsonAsArray['data'];

            $key = $row[0];
            $value = $row[1];

            $pathValues = explode('/', $key);
            $key = array_pop($pathValues);

            foreach ($pathValues as $path) {
                if(!isset($dataArray[$path])) {
                    throw new Exception("The response does not contain the value: $path in data.\n");
                }
               $dataArray = $dataArray[$path];
            }
            
            if(!isset($dataArray[$key])) {
                    throw new Exception("The response does not contain the value: $key in data.\n");
                }

            if($dataArray[$key] != $value) {
                throw new Exception("The response does not contain the value $value in data with key $key. Actual value: $dataArray[$key]\n");
            }
        }                                                           
    }                                                                                           
     

    /**
     * @Given that I wait :arg1 seconds
     */
    public function thatIWaitSeconds($arg1)
    {
        sleep($arg1);
    }
                                                                   
}

