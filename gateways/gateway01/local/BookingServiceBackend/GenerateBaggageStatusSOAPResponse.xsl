<?xml version="1.0" encoding="utf-8"?>
<!-- Gang Wu IBM Corp -->
<!--
    This stylesheet will generate BaggageStatus Web Service response SOAP message based on baggage status xml table
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:jkhle="http://webservice.jkhle.com.cn" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp dpconfig">
	<xsl:output method="xml"/>
	
	<xsl:template match="/">
		<!--  Get the baggage status table-->
		<xsl:variable name="baggageTbl" select="document('local:///baggageStatus.xml')"/>
		
		<xsl:variable name="refNo" select="//jkhle:refNumber"/>
		<xsl:variable name="lastName" select="//jkhle:lastName"/>
		
		<xsl:message>refno=[<xsl:value-of select="$refNo"/>]lastname=[<xsl:value-of select="$lastName"/>]</xsl:message>
		
		<xsl:variable name="passenger" select="$baggageTbl/jkhle:bagstatus/jkhle:passenger[jkhle:refNumber=$refNo and jkhle:lastName=$lastName]"/>
		
		
	         <xsl:variable name="dummy_response">
                        <dp:url-open target="http://10.122.14.34" response="responsecode-ignore" timeout="2">

                           <xsl:copy-of select="."/>

                            </dp:url-open>
                      </xsl:variable>    

		
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >
		   <soapenv:Header/>
		   <soapenv:Body>
			  <jkhle:BaggageStatusResponse>
				 <jkhle:refNumber><xsl:value-of select="$passenger/jkhle:refNumber"/></jkhle:refNumber>
				 <jkhle:firstName><xsl:value-of select="$passenger/jkhle:firstName"/></jkhle:firstName>
				 <jkhle:lastName><xsl:value-of select="$passenger/jkhle:lastName"/></jkhle:lastName>
				 <xsl:copy-of select="$passenger/jkhle:bag"/>
			  </jkhle:BaggageStatusResponse>
		   </soapenv:Body>
		</soapenv:Envelope>

	</xsl:template>
</xsl:stylesheet>
