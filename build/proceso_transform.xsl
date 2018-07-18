<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

  <xsl:template match='/'>
    <html>
      <head>
        <meta charset="UTF-8"/>
        <link rel="stylesheet" href="proceso_style.css"/>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="process-spec">
    <div class="process-spec">
      <xsl:apply-templates select="./process-info"/>
      <xsl:apply-templates select="./process"/>
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
      <div class="block">
        <xsl:apply-templates select="./block"/>
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
      <div class="block">
        <xsl:apply-templates select="./block"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="else">
    <div class="else">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="block">
        <xsl:apply-templates select="./block"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="call">
    <div class="call">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="procname">
        <xsl:value-of select="./procname"/>
      </div>
      <div class="data">
        <xsl:for-each select="./data/form">
          <div class="form">
            <div class="ref">
              <xsl:value-of select="./@ref"/>
            </div>
            <xsl:for-each select="./input">
              <div class="input">
                <div class="name">
                  <xsl:value-of select="./@name"/>
                </div>
                <div class="type">
                  <xsl:value-of select="./@type"/>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="input">
    <div class="input">
      <div class="name">
        <xsl:value-of select="./@name"/>
      </div>
      <div class="type">
        <xsl:value-of select="./@type"/>
      </div>
      <div class="required">
        <xsl:value-of select="./@required"/>
      </div>
      <div class="hidden">
        <xsl:value-of select="./@hidden"/>
      </div>
      <div class="label">
        <xsl:value-of select="./@label"/>
      </div>
      <div class="placeholder">
        <xsl:value-of select="./@placeholder"/>
      </div>
      <div class="default">
        <xsl:value-of select="./@default"/>
      </div>
      <div class="regex">
        <xsl:value-of select="./@regex"/>
      </div>
      <div class="helper">
        <xsl:value-of select="./@helper"/>
      </div>
      <div class="provider">
        <xsl:value-of select="./@provider"/>
      </div>
      <div class="options">
        <xsl:apply-templates select="./options/option"/>
      </div>
      <xsl:apply-templates select="./dependencies"/>
    </div>
  </xsl:template>

  <xsl:template match="dependencies">
    <div class="dependencies">
      <xsl:apply-templates select="./dep"/>
    </div>
  </xsl:template>

  <xsl:template match="dep">
    <div class="dep">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <xsl:template match="exit">
    <div class="exit">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="node-info">
    <div class="node-info">
      <div class="name">
        <xsl:value-of select="./name"/>
      </div>
      <div class="description">
        <xsl:value-of select="./description"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="param">
    <div class="param">
      <div class="name">
        <xsl:value-of select="./@name"/>
      </div>
      <div class="type">
        <xsl:value-of select="./@type"/>
      </div>
      <div>
        <xsl:value-of select="."/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="form-array">
    <div class="form-array">
      <xsl:apply-templates select="./form"/>
    </div>
  </xsl:template>

  <xsl:template match="auth-filter">
    <div class="auth-filter">
      <div class="backend">
         <xsl:value-of select="./@backend"/>
      </div>
      <xsl:apply-templates select="./param"/>
    </div>
  </xsl:template>

  <xsl:template match="form">
    <div class="form">
      <div class="id">
        <xsl:value-of select="./@id"/>
      </div>
      <div class="multiple">
        <xsl:value-of select="./@multiple"/>
      </div>
      <xsl:apply-templates select="./input"/>
    </div>
  </xsl:template>

  <xsl:template match="option">
    <div class="option">
      <div class="value">
        <xsl:value-of select="./@value"/>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>