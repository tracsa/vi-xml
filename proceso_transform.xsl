<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>

      </head>
      <body>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <div class="container">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="process-spec">
    <xsl:apply-templates select="./process-info"/>
    <xsl:apply-templates select="./process"/>
  </xsl:template>

  <xsl:template match="process-info">
    <div class="card text-white bg-dark mb-3">
      <div class="card-header">
        <xsl:value-of select="./author"/>
        <span class="text-muted">
          (Public: <xsl:value-of select="./public"/>)
        </span>
      </div>
      <div class="card-body">
        <h5 class="card-title">
          <xsl:value-of select="./name"/>
        </h5>
        <h6 class="card-subtitle mb-2 text-muted">
          <xsl:value-of select="./date"/>
        </h6>
        <p class="card-text">
          <xsl:value-of select="./description"/>
        </p>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="process">
    <div class="container">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="action">
    <div class="card border-dark mb-3">
      <div class="card-header">
        Action
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
        <xsl:apply-templates select="./auth-filter"/>
      </div>
      <div class="card-body text-dark">
        <xsl:apply-templates select="./node-info"/>
        <div class="card">
          <div class="card-header">
              Form array:
          </div>
          <div class="card-body">
            <xsl:apply-templates select="./form-array"/>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="validation">
    <div class="card">
      <div class="card-header">
        Validation
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./auth-filter"/>
      </div>
      <div class="card-footer">
        <xsl:apply-templates select="./dependencies"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="request">
    <div class="card">
      <div class="card-header">
        <xsl:value-of select="./@method"/>
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
        <br/>
        <span style="font-family: monospace;">
          <xsl:value-of select="./url"/>
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./headers"/>
        <xsl:apply-templates select="./body"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="if">
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when
          test= "following-sibling::*[1][self::elif] or following-sibling::*[1][self::else]">if-followed</xsl:when>
        <xsl:otherwise>if</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <div class="card">
      <div class="card-header">
        <span style="font-family: monospace;">
          If: <xsl:value-of select="./condition"/>
        </span>
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./block"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="elif">
    <div class="card">
      <div class="card-header">
        <span style="font-family: monospace;">
          Elif: <xsl:value-of select="./condition"/>
        </span>
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./block"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="else">
    <div class="card">
      <div class="card-header">
        <span style="font-family: monospace;">
          Else:
        </span>
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./block"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="call">
    <div class="card">
      <div class="card-header">
        Call:
        <xsl:value-of select="./procname"/>
        <span class="text-muted">
          (<xsl:value-of select="./@id"/>)
        </span>
      </div>
      <div class="card-body">
        <xsl:apply-templates select="./data"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="input">
    <tr>
      <td>
        <xsl:value-of select="./@name"/>
      </td>
      <td>
        <xsl:value-of select="./@type"/>
      </td>
      <td>
        <xsl:value-of select="./@required"/>
      </td>
      <td>
        <xsl:value-of select="./@hidden"/>
      </td>
      <td>
        <xsl:value-of select="./@label"/>
      </td>
      <td>
        <xsl:value-of select="./@placeholder"/>
      </td>
      <td>
        <xsl:value-of select="./@default"/>
      </td>
      <td>
        <xsl:value-of select="./@regex"/>
      </td>
      <td>
        <xsl:value-of select="./@helper"/>
      </td>
      <td>
        <xsl:value-of select="./@provider"/>
      </td>
      <td>
        <xsl:apply-templates select="./options/option"/>
      </td>
      <td>
        <xsl:apply-templates select="./dependencies"/>
      </td>
      <td>
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="dependencies">
    <span style="font-family: monospace;">
      Dependecies: <xsl:value-of select="./dep"/>
    </span>
  </xsl:template>

  <xsl:template match="auth-filter">
    <span style="font-family: monospace;">
      <div>
        Backend: <xsl:value-of select="./@backend"/>
      </div>
      <xsl:apply-templates select="./param"/>
    </span>
  </xsl:template>

  <xsl:template match="exit">
    <div class="exit">
    </div>
  </xsl:template>

  <xsl:template match="node-info">
    <h5 class="card-title">
      <xsl:value-of select="./name"/>
    </h5>
    <p class="card-text">
      <xsl:value-of select="./description"/>
    </p>
  </xsl:template>

  <xsl:template match="param">
    <div class="card">
      <div class="card-header">
        <xsl:value-of select="./@name"/>
      </div>
      <div class="card-body">
        <xsl:value-of select="."/>
        <span class="text-muted">
          (<xsl:value-of select="./@type"/>)
        </span>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="form-array">
    <div class="card">
      <xsl:apply-templates select="./form"/>
    </div>
  </xsl:template>

  <xsl:template match="form">
    <div class="card">
      <div class="card-header">
        Form:
      </div>
      <div class="card-body">
        <xsl:value-of select="./@multiple"/>
        <div class="table-responsive">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Required</th>
                <th>Hidden</th>
                <th>Label</th>
                <th>Placeholder</th>
                <th>Default</th>
                <th>Regex</th>
                <th>Helper</th>
                <th>Provider</th>
                <th>Options</th>
                <th>Dependencies</th>
                <th>Value</th>
              </tr>
            </thead>
            <tbody>
              <xsl:apply-templates select="./input"/>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="option">
    <div class="option">
      <div class="value">
        <xsl:value-of select="./@value"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="data">
    <xsl:apply-templates select="./form"/>
  </xsl:template>

  <xsl:template match="headers">
    <table
      class="table"
      style="font-family: monospace;"
    >
      <thead>
        <tr>
          <th>key</th>
          <th>value</th>
        </tr>
      </thead>
      <xsl:apply-templates select="./header"/>
    </table>
  </xsl:template>

  <xsl:template match="header">
    <tr>
      <td>
        <xsl:value-of select="./@name"/>:
      </td>
      <td>
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="body">
    <span style="font-family: monospace;">
      <div class="container">
        <div class="row">
          <div class="col-1">
            body:
          </div>
          <div class="col-auto">
            <xsl:value-of select="."/>
          </div>
        </div>
      </div>
    </span>
  </xsl:template>

</xsl:stylesheet>
