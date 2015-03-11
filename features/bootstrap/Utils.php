<?php

/* 
* Class that contains some helpful methods.
*/
class Utils {

	/**
	* Checks if the input is a well-formed JSON string. 
	*/
	public static function isJson($string){
        if (empty($string)) return FALSE;
        if (!is_string($string)) return FALSE;
        if (!is_array(json_decode($string, true))) return FALSE;
        if (json_last_error() != JSON_ERROR_NONE) return FALSE;
        else return TRUE;
    }

	/**
    * Execute request with specified :method and :url. $curl is returned in order to be able to test responses in other functions.
    */
    public static function make_request($method, $url){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_CUSTOMREQUEST, $method);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
        

        $this->request_response = curl_exec($curl);

        return $curl;
    }

}