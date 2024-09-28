#INCLUDE secrets.h
LPARAMETERS cPrompt, nTemp, iMaxTokens
cResult=CallAzureAI(cPrompt, nTemp, iMaxTokens)
? cResult



FUNCTION CallAzureAI
LPARAMETERS cPrompt, nTemp, iMaxTokens
IF EMPTY(cPrompt)
	RETURN ""
ENDIF
nTemp = EVL(nTemp, .5)
iMaxTokens = EVL(iMaxTokens,100)

LOCAL loHttp, lcUrl, lcApiKey, lcBody, lcResponse, loJson
lcURL = "https://erics-m1b79784-westeurope.openai.azure.com/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-03-15-preview"
lcApiKey = APIKEY && Get this from your Azure AI service
* Create the HTTP request object    
loHttp = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")        
* Prepare the request body (JSON)    
TEXT TO lcBody NOSHOW TEXTMERGE
{   "messages" : [
    {
		"role": "system",
		"content": "You are an AI assistant that helps people find information. Your main language is Visual FoxPro."
	,
        "role": "user",
        "content": "<<cPrompt>>"
    }
],
 "max_tokens": <<iMaxTokens>>,               
 "temperature": <<nTemp>>}
ENDTEXT
* Open the HTTP request and set headers    
loHttp.Open("POST", lcUrl, .F.)    
loHttp.SetRequestHeader("Content-Type", "application/json")    
loHttp.SetRequestHeader("api-key", lcApiKey)    
* Send the request    
TRY        
	loHttp.Send(lcBody)    
CATCH TO loErr        
	MESSAGEBOX("Error: " + loErr.Message)        
	RETURN    
ENDTRY    
* Check the response status    
IF loHttp.Status = 200        
	lcResponse = loHttp.ResponseText        
	* Optional: Parse JSON response using a JSON parser library in FoxPro        
ELSE        
	lcResponse = "Error: HTTP Status " + TRANSFORM(loHttp.Status)
ENDIF
RETURN lcResponse
ENDFUNC


