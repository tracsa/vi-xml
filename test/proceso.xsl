<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
  <xsl:template match='/'>
    <html>
      <head>
        <meta charset="UTF-8"/>
        <link rel="stylesheet" href="app.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="process-spec">
    <div class="process-spec">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="process-info">
    <div class="process-info">
      <div class="author">
        <xsl:value-of select="./author"/>
      </div>
      <div class="date">
        <xsl:value-of select="./date"/>
      </div>
      <div class="name">
        <xsl:value-of select="./name"/>
      </div>
      <div class="public">
        <xsl:value-of select="./public"/>
      </div>
      <div class="description">
        <xsl:value-of select="./description"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="process">
    <div class="process">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="action">
    <div class="action">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="milestone">
        <xsl:value-of select="./milestone"/>
      </div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="validation">
    <div class="validation">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="milestone">
        <xsl:value-of select="./milestone"/>
      </div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="request">
    <div class="request">
       <div class="id">
         <xsl:value-of select="./@id"/>
       </div>
       <div class="method">
         <xsl:value-of select="./@method"/>
       </div>
       <div class="url">
         <xsl:value-of select="./url"/>
       </div>
       <div class="headers">
         <xsl:for-each select="./headers/header">
           <div class="header">
             <div class="name">
               <xsl:value-of select="./name"/>
             </div>
             <xsl:value-of select="."/>
           </div>
         </xsl:for-each>
       </div>
       <div class="body">
         <xsl:value-of select="./body"/>
       </div>
    </div>
  </xsl:template>

  <xsl:template match="if">
    <div>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when
            test= "following-sibling::*[1][self::elif] or following-sibling::*[1][self::else]">if-followed</xsl:when>
          <xsl:otherwise>if</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="condition">
        <xsl:value-of select="./condition"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="elif">
    <div class="elif">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="condition">
        <xsl:value-of select="./condition"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="else">
    <div class="else">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
