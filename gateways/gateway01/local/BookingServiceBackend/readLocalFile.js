// use the urlopen module
var urlopen = require ('urlopen');

debugger;

if (session.parameters.parmDataFileName) {

	var varFileName = session.parameters.parmDataFileName;

	// open connection to read local file
//	urlopen.open("local:///testData.json", function(error, response) 
	urlopen.open(varFileName, function(error, response) 
	{
		// this function callback will be called when urlopen.open() is done.
		if (error) 
		{
			// error occurred during file open for reading
			session.output.write("oops, urlopen error: " + JSON.stringify(error));
		}
		else
		{
			// get the response status code
			var responseStatusCode = response.statusCode;
			
			// reading response data
			response.readAsBuffer(function(error, responseData) {
				if (error) 
				{
					// error while reading response or transforming data to Buffer
					session.output.write("oops, readAsBuffer error: " + JSON.stringify(error));
				} 
				else 
				{
					session.output.write(responseData);
				}
			});
		}
	});

} else {
	session.reject("No datafile parameter specified.");
}