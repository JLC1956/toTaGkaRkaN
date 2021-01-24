<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:import href="copy.xslt"/>
    
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="FILE_URI" select="document-uri(.)"/>
    <xsl:variable name="CURRENT_SCRIPT" select="static-base-uri()"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="comment()" />
    
    <xsl:variable name="offset" select="pseudo-html/offset"/>
    
    <xsl:template match="pseudo-html">
        <xsl:apply-templates select="body"/>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:apply-templates select="div"/>        
    </xsl:template>
    
    <xsl:template match="div">
        <wiki_Treatment>
            <Script_Info__latest-to-oldest><xsl:value-of select="$CURRENT_SCRIPT"/></Script_Info__latest-to-oldest>
            <Original-File_Info><xsl:value-of select="$FILE_URI"/></Original-File_Info>
            <Downloaded_as_epub_and_adapted_from></Downloaded_as_epub_and_adapted_from>
            <Short_URL></Short_URL>
            <Result>
                <xsl:apply-templates select="dl | h3 | p | ol | h2"/>
            </Result>
            
        </wiki_Treatment>
    </xsl:template>
    
    <xsl:template match="ol">
        <ol>
            <xsl:apply-templates select="li"></xsl:apply-templates>
        </ol>
    </xsl:template>
    
    <xsl:template match="h2">
        <Chapter_Title>
            <xsl:value-of select="normalize-space(.)"/>
        </Chapter_Title>
    </xsl:template>
    
    
    <xsl:template match="li">
        <li>
            <xsl:value-of select="normalize-space(.)"/>
        </li>
    </xsl:template>
    
    
    <!-- dl/dd/dl/dd/dl/dd -->
    
    <xsl:template match="dd/dl/dd/dl/dd">
        <urai>
            <xsl:value-of select="normalize-space(.)"/>
        </urai>
    </xsl:template>
    
    <xsl:template match="dd">
        <line>
            <xsl:value-of select="normalize-space(.)"/>
        </line>
    </xsl:template>
    
    
    <xsl:template match="dl">
        <xsl:if test="dd/dl/dd/dl/dd">
            <xsl:apply-templates select="dd/dl/dd/dl/dd"/>
        </xsl:if>
        <xsl:if test="not(dd/dl/dd/dl/dd)">
            <lg>
                <xsl:apply-templates select="dd"/>
            </lg>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="h3">
        <rank><xsl:value-of select="1 + count(preceding::h3) + count(preceding::p) + $offset"/></rank>
        <title>
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
    
    <xsl:template match="p">
        <rank><xsl:value-of select="1 + count(preceding::h3) + count(preceding::p) + $offset"/></rank>
        <title>
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
    
    
</xsl:stylesheet>

<!-- 
Script Name: process_wikimUlam_expanded.xslt


Saved as "process_wikimUlam_expanded_1b.xslt" on 2021/01/22 at 12:04
Saved as "process_wikimUlam_1a.xslt" on 2021/01/22 at 12:04
-->