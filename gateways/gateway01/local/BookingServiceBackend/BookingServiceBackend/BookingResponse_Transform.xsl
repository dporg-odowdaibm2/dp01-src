<xsl:stylesheet version="1.0" extension-element-prefixes="dp" exclude-Result-prefixes="dp str" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dp="http://www.datapower.com/extensions" xmlns:str="http://exslt.org/strings" xmlns:book="http://www.ibm.com/datapower/IBMAir/BookingService/">
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="//book:Expiry | //book:CVV">
      <!--DO NOTHING-->
   </xsl:template>
   <xsl:template match="book:Number">
      <xsl:element name="book:Number">
         <xsl:variable name="stl" select="string-length(.)"/>
         <xsl:text>************</xsl:text>
         <xsl:value-of select="substring(.,($stl)-3,($stl))"/>
      </xsl:element>
   </xsl:template>
  <xsl:template match="book:ConfirmationCode">
      <xsl:element name="book:ConfirmationText">
       <xsl:value-of select="dp:decode(.,'base-64')"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="@*"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>