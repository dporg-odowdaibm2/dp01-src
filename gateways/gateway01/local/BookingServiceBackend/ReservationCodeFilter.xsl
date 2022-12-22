<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:book="http://www.ibm.com/datapower/IBMAir/BookingService/"
	extension-element-prefixes="dp" 
	exclude-result-prefixes="dp">
	
	<!--+
		|	This filter checks for the "IBM" at the start of the book:ReservationCode 
		+-->
	<xsl:template match="/">
            	<xsl:choose>
			<xsl:when test="starts-with(//book:ReservationCode, 'IBM')">
				<dp:accept/>
			</xsl:when>
			<xsl:otherwise>
			    <dp:reject>Reservation Code was not for IBMAir</dp:reject> 
                           
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
