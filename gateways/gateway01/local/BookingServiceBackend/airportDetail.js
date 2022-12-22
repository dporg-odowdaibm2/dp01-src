// ------------------------------------------------------------------------------------------
// Function:  	getAirportDetail
//
// Purpose:		Read array of airport data and return the detailed record for the
//				IATA code passed as a parameter.
// ------------------------------------------------------------------------------------------

// Module Imports
var airportModule = require('airportModule');				// Module: airportModule
var serviceModule = require('service-metadata');			// Module: service-metadata
var utilityModule = require('utilityModule');				// Module: utilityModule

// ------------------------------------------------------------------------------------------
// Read JSON data from input context.  JSON data is stored into the airportDataJson variable.
// ------------------------------------------------------------------------------------------
session.input.readAsJSON (function (error, airportDataJson) {
	
	debugger;
	
	if (error) {
		// an error occured when parsing the context; e.g. invalid JSON object
		session.output.write(error, toString());
	} else {

		try {

			var varUriJSON = utilityModule.parseURI(serviceModule.URI);
				
			// search for the airport detail, given the JSON data file and the IATA code of the airport
			// (extracted from the querystring)
			var varAirportDetail = airportModule.getAirportDetail(airportDataJson, varUriJSON.args.iata);
			
			// check if a detail record was found.
			if (varAirportDetail) {
				// write the airport data to the output context
				session.output.write(varAirportDetail);
			} else {
				session.output.write({
					response: "No data found for IATA Code " + varUriJSON.args.iata
				});
			}
		}
		catch(e) {
			if (e.name === "NoDataFoundError") {
				session.output.write({
					response: "No data found for IATA Code " + varUriJSON.args.iata
				});
			} else {
				// abort normal processing and trigger an error rule.
				session.reject(e.message)
			}
		}
	}
});