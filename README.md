
# VFP_AzureAI

You'll need to create a secrets.h file that contains  
#DEFINE APIKEY "<Your Azure AI Key?"  
#DEFINE AZUREDEPLOYMENT "gpt-35-turbo" && or whichever  
#DEFINE AZUREREGION "eastus2"   && or whichever  

Sample usage  

Either  
> DO FORM aichat for a GUI
>  
or  
> DO callazure.prg WITH "<Your prompt here>"
>


Results are returned in JSON and must be parsed to be useful.  


