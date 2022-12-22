<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:dp="http://www.datapower.com/extensions"
	xmlns:str="http://exslt.org/strings" 
	xmlns:book="http://www.ibm.com/datapower/IBMAir/BookingService/"
	xmlns:r="http://www.ibm.com/datapower/IBMAir/BookingService/ResponseData"
	extension-element-prefixes="dp" 
	exclude-Result-prefixes="dp str r">
	
        <!-- To Do: Externalize the Data Set from the XSL -->
	
	<xsl:key name="lookup" match="r:rsp" use="r:ReservationCode"/>

	<xsl:variable name="rspData" select="document('')/*/r:rspData"/>	
	<xsl:variable name="data">
			<xsl:apply-templates select="$rspData">
				<xsl:with-param name="inData" select="//book:ReservationCode"/>
			</xsl:apply-templates>
	</xsl:variable>
			
	<xsl:template match="//book:BookingRequest">
		
                <xsl:comment>
			<xsl:value-of select="$data//r:rsp/@d"/>
		</xsl:comment>
    
		<xsl:element name="book:BookingResponse">
                        <xsl:element name="book:ConfirmationCode">	
				<xsl:value-of select="dp:encode($data//r:ConfirmationCode,'base-64')"/>
			</xsl:element>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
  
   <xsl:template match="book:ReservationCode">
		<xsl:element name="book:ReservationCode">
			<xsl:choose>
			<xsl:when test="$data//r:AltReservationCode">
				<xsl:value-of select="$data//r:AltReservationCode"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
			</xsl:choose>
		 </xsl:element>	
	</xsl:template>
  
 

	<xsl:template match="r:rspData">
		<xsl:param name="inData"/>
		<xsl:copy-of select="key('lookup', $inData)"/>
	</xsl:template>
	
	
	<!--+
		|	This template is an "identity transform" which matches anything
		|	that hasn't already been matched and copies it to the output
		|	document unaltered.
		+-->
		
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<r:rspData>
        <!-- Conformation Code is in plan text and the policy will base64 encode -->
	   <r:rsp d='Happy Path UC1'><r:ReservationCode>IBM99V16I</r:ReservationCode><r:ConfirmationCode>Processed 0112459898A</r:ConfirmationCode></r:rsp>
	   <r:rsp d='Happy Path UC2'><r:ReservationCode>IBMK2OL0E</r:ReservationCode><r:ConfirmationCode>Processed 9232445821J</r:ConfirmationCode></r:rsp>
	   <r:rsp d='Happy Path UC3'><r:ReservationCode>IBMQOOL0D</r:ReservationCode><r:ConfirmationCode>Processed 8761234987B</r:ConfirmationCode></r:rsp>
	   <r:rsp d='Flipped Data'><r:ReservationCode>IBMU9WCL9</r:ReservationCode><r:ConfirmationCode>Processed 67822231231F</r:ConfirmationCode><r:AltReservationCode>IBMU9WERR</r:AltReservationCode></r:rsp>
	   
	   <r:rsp d='Invalid Reservation Code'><r:ReservationCode>JKX7M0T3</r:ReservationCode><r:ConfirmationCode>Error 24</r:ConfirmationCode></r:rsp>
	   <r:rsp d='Canada UC'><r:ReservationCode>JK1O28S8</r:ReservationCode><r:ConfirmationCode>Processed 99731266311G</r:ConfirmationCode></r:rsp>
	   <r:rsp d='Mexico UC'><r:ReservationCode>JKV2A9KG</r:ReservationCode><r:ConfirmationCode>Processed 25374596335N</r:ConfirmationCode></r:rsp>
	</r:rspData>
	
</xsl:stylesheet>
