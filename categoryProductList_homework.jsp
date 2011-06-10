<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ taglib uri="/tlds/marketmaker.tld" prefix="dr" %>
<%@ taglib uri="/tlds/struts-bean.tld" prefix="bean" %>

<dr:page>
<xsl:stylesheet version="1.0" exclude-result-prefixes="xslt" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xslt="xsl-alias" xmlns:page="http://cx.digitalriver.com/DRHM/Storefront/Library/content/schema/ui/categoryProductList" xmlns:if="http://cx.digitalriver.com/DRHM/Storefront/Library/content/schema/ui/if" xmlns:loop="http://cx.digitalriver.com/DRHM/Storefront/Library/content/schema/ui/loop" xmlns:get="http://cx.digitalriver.com/DRHM/Storefront/Library/content/schema/ui/get" xmlns:form="http://cx.digitalriver.com/DRHM/Storefront/Library/content/schema/ui/form">
<xsl:namespace-alias stylesheet-prefix="xslt" result-prefix="xsl"/>
<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8"/>

<%-- Retrieve the core tag expansion templates aaaaa --%>
<dr:url contentElement="true" rscName="CoreTagExpansionXSLTemplates"/>

<!-- page: templates111 -->
<xsl:template match="page:categoryProductList">
  <xsl:copy>
    <xsl:attribute name="xslt:ns-xslt" namespace="http://www.w3.org/1999/XSL/Transform">alias</xsl:attribute>
    <xsl:apply-templates select="@*"/>
    <xsl:choose>
			<xsl:when test="child::*">
				<xsl:apply-templates/>
			</xsl:when>
      <xsl:otherwise>
				<xsl:call-template name="page-page"/>
			</xsl:otherwise>
    </xsl:choose>
  </xsl:copy>
</xsl:template>
<xsl:template match="page:element">
  <xsl:choose>
    <xsl:when test="child::*">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <!-- use the default layout for each of these page element types -->
      <xsl:choose>
        <xsl:when test="@type='page'"><xsl:call-template name="page-page"/></xsl:when>  
        <xsl:when test="@type='category'"><xsl:call-template name="page-category"/></xsl:when>
        <xsl:when test="@type='categoryHeader'"><xsl:call-template name="page-categoryHeader"/></xsl:when>
        <xsl:when test="@type='products'"><xsl:call-template name="page-products"/></xsl:when>
        <xsl:when test="@type='product'"><xsl:call-template name="page-product"/></xsl:when>
        <xsl:when test="@type='thumbnail'"><xsl:call-template name="page-thumbnail"/></xsl:when>
        <xsl:when test="@type='name'"><xsl:call-template name="page-name"/></xsl:when>
        <xsl:when test="@type='price'"><xsl:call-template name="page-price"/></xsl:when>
        <xsl:when test="@type='pagination'"><xsl:call-template name="page-pagination"/></xsl:when>
        <xsl:when test="@type='viewAll'"><xsl:call-template name="page-viewAll"/></xsl:when>
        <xsl:when test="@type='preOrderLink'"><xsl:call-template name="page-preOrderLink"/></xsl:when>
        <xsl:when test="@type='buyLink'"><xsl:call-template name="page-buyLink"/></xsl:when>
        <xsl:when test="@type='shortDescription'"><xsl:call-template name="page-shortDescription"/></xsl:when>
		
        <!-- If a template match wasn't found, just copy it through -->
        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="page-page">
	<div id="dr_CategoryProductList" class="dr_Content">
    <xsl:call-template name="page-category"/>
    <xsl:call-template name="page-products"/>
  </div>
</xsl:template>

<xsl:template name="page-category">
	<h1>
    <span class="dr_categoryName"><get:value data="categoryName"/></span>
  </h1>
	<if:exists data="categoryImageSrc">
		<img border="0" class="dr_categoryImage">
			<xslt:attribute name="src"><get:value data="categoryImageSrc"/></xslt:attribute>
			<xslt:attribute name="alt"><get:value data="categoryImageAlt"/></xslt:attribute>
		</img>
	</if:exists>
	<if:exists data="categoryLongDescription">
    <div class="longDescription"><get:value data="categoryLongDescription"/></div><!-- /.longDescription -->
  </if:exists>
</xsl:template>

<xsl:template name="page-categoryHeader">
	<if:exists data="categoryName">
	<h1>
        <span class="dr_categoryName">
          <get:value data="categoryName"/>
        </span>
  </h1>
  </if:exists>
</xsl:template>


<xsl:template name="page-products">
  <ul id="dr_products">
  <xslt:attribute name="data-totalSize"><get:value data="totalSize"/></xslt:attribute>
  <xslt:attribute name="data-resultSize"><get:value data="resultSize"/></xslt:attribute>
    <loop:each list="products">
      <xsl:call-template name="page-product"/>
    </loop:each>
  </ul><!-- /#dr_products -->
  <xsl:call-template name="page-pagination"/>
</xsl:template>

<xsl:template name="page-product">
  <li>
  <xslt:attribute name="class">dr_product dr_pid<get:value data="productID"/></xslt:attribute>
    <xsl:call-template name="page-thumbnail"/>
    <xsl:call-template name="page-name"/>
    <xsl:call-template name="page-shortDescription"/>
    <xsl:call-template name="page-price"/>
    <xsl:call-template name="page-preOrderLink"/>
	<xsl:call-template name="page-buyLink"/>
  </li><!-- /.dr_product -->
</xsl:template>

<xsl:template name="page-thumbnail">
  <if:exists data="thumbSrc">
    <a>
    <xslt:attribute name="href"><get:value data="buyLink"/></xslt:attribute>
    <xslt:attribute name="title"><get:text key="BTN_BUY_NOW"/></xslt:attribute>
      <img border="0" class="dr_thumbnail">
      <xslt:attribute name="src"><get:value data="thumbSrc"/></xslt:attribute>
      <xslt:attribute name="alt"><get:value data="thumbAlt"/></xslt:attribute>
      </img>
    </a>
  </if:exists>
</xsl:template>

<xsl:template name="page-name">
  <h2><get:value data="name"/></h2>
</xsl:template>

<xsl:template name="page-shortDescription">
  <p class="dr_shortDescription"><get:value data="shortDescription" escape="no"/></p>
</xsl:template>


<%--get rid of this later --%>
<xsl:template name="page-preOrderLink">
<%-- need to set this up.  Probably need to pull the preorder field from the prodInfo widget (aggregateXML)--%>
	<if:exists data="preorderEnabled">
      <if:equal data="useImagesForButtons" value="yes">
        <a class="dr_button">
          <img alt="" border="0">
            <xslt:attribute name="src"><get:value data="gl_pre-order.gif"/></xslt:attribute>
          </img>
        </a> 
	  </if:equal>
      <if:notEqual data="useImagesForButtons" value="yes">
        <a class="dr_button">
          <xslt:attribute name="href"><xsl:call-template name="page-buyLinkUrl"/></xslt:attribute>
          <get:text key="PRE-ORDER"/>
        </a> 
	  </if:notEqual>
  </if:exists>
</xsl:template>

<xsl:template name="page-buyLink">
	<if:notExists data="preorderEnabled">
      <if:equal data="useImagesForButtons" value="yes">
        <a class="dr_button">
          <xslt:attribute name="href"><xsl:call-template name="page-buyLinkUrl"/></xslt:attribute>
          <img border="0" alt="">
            <xslt:attribute name="src"><get:value data="cl_buynow.gif"/></xslt:attribute>
          </img>
        </a>
      </if:equal>
      <if:notEqual data="useImagesForButtons" value="yes">
        <a class="dr_button">
          <xslt:attribute name="href"><xsl:call-template name="page-buyLinkUrl"/></xslt:attribute>
          <get:text key="BTN_BUY_NOW"/>
        </a>
      </if:notEqual>
  </if:notExists>
</xsl:template>

<xsl:template name="page-buyLinkUrl">
	<get:path action="buy/productID."/><get:value data="productID"/>
</xsl:template>


<xsl:template name="page-price">
  <div class="dr_price">
    <if:equal data="productDiscount" value="true">
      <div class="dr_regularPrice">
        <span class="dr_regularPriceLabel"><get:text key="REGULAR_PRICE_COLON"/></span>
        <del><get:value data="regularPrice" /></del>
      </div>
      <span class="dr_discountLabel"><dr:resource key="PROMO_PRICE_COLON"/></span>
    </if:equal>
    <get:value data="price" />
  </div>
</xsl:template>

<xsl:template name="page-pagination">
  <if:exists list="pages">
    <div class="dr_pagination">
      <ul class="dr_pages">
        <!-- previous -->
        <loop:each list="pages">
          <li>
          <xslt:attribute name="class"><get:value data="pageCurrent"/></xslt:attribute>
            <a>
              <xslt:attribute name="title"><get:value data="categoryName"/> <get:text key="PAGE"/> <loop:position/></xslt:attribute>


              <xslt:attribute name="href"><get:value data="pageLink"/></xslt:attribute>
              <loop:position/>
            </a>
          </li>
        </loop:each>
        <!-- next -->
        <xsl:call-template name="page-viewAll"/>
      </ul>
    </div>
  </if:exists>
</xsl:template>

<xsl:template name="page-viewAll">
  <li id="dr_viewAll" class="last">
    <a>
    <xslt:attribute name="href"><get:value data="viewAllLink"/></xslt:attribute>
      <get:text key="VIEW_ALL"/>
    </a>  
  </li>
</xsl:template>
  
</xsl:stylesheet>
</dr:page>