<?xml version="1.0" encoding="UTF-8" ?>

<!--
        
        Schematron validator for CIOOS XML
    
        XML schema validation (xsd files) catches a lot of things, and I tried not to duplicate any of these rules with Schematron validation, to keep this document as short as possible
    
        For a required field:
        <sch:assert test="place/XPATH/here">Custom error message here if field is missing</sch:assert>
    -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">

    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi" />
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mpc/1.0" prefix="mpc" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mri/1.0" prefix="mri" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mrl/2.0" prefix="mrl" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mmi/1.0" prefix="mmi" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mdb/2.0" prefix="mdb" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mcc/1.0" prefix="mcc" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/msr/2.0" prefix="msr" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mac/2.0" prefix="mac" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/cit/2.0" prefix="cit" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mrs/1.0" prefix="mrs" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/gco/1.0" prefix="gco" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/lan/1.0" prefix="lan" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mco/1.0" prefix="mco" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/gex/1.0" prefix="gex" />
    <sch:ns uri="http://standards.iso.org/iso/19157/-2/mdq/1.0" prefix="mdq" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mas/1.0" prefix="mas" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mrd/1.0" prefix="mrd" />
    <sch:ns uri="http://standards.iso.org/iso/19115/-3/mrc/2.0" prefix="mrc" />
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink" />

    <!-- These are required XPaths -->


    <sch:pattern>
        <!-- Recommended metadataStandard section, if section is there than children required -->
        <sch:rule context="/mdb:MD_Metadata/mdb:metadataStandard">
            <sch:assert test="cit:CI_Citation/cit:title/gco:CharacterString" />
            <sch:assert test="cit:CI_Citation/cit:edition/gco:CharacterString" />
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:rule context="/">
            <sch:assert test="/mdb:MD_Metadata" />
            <sch:assert test="/mdb:MD_Metadata/mdb:metadataIdentifier/mcc:MD_Identifier/mcc:code/gco:CharacterString" />

            <sch:assert test="/mdb:MD_Metadata/mdb:defaultLocale/lan:PT_Locale/lan:language/lan:LanguageCode[@codeListValue='eng' or @codeListValue='fra']">Language must be fra or eng</sch:assert>
            <sch:assert test="/mdb:MD_Metadata/mdb:otherLocale/lan:PT_Locale/lan:language/lan:LanguageCode/@codeListValue != /mdb:MD_Metadata/mdb:defaultLocale/lan:PT_Locale/lan:language/lan:LanguageCode/@codeListValue">Default and secondary languages must be diferent</sch:assert>

            <sch:assert test="/mdb:MD_Metadata/mdb:defaultLocale/lan:PT_Locale/lan:country/lan:CountryCode/@codeListValue" />
            <sch:assert test="/mdb:MD_Metadata/mdb:defaultLocale/lan:PT_Locale/lan:characterEncoding/lan:MD_CharacterSetCode/@codeList" />

            <sch:assert test="/mdb:MD_Metadata/mdb:contact/cit:CI_Responsibility/cit:role/cit:CI_RoleCode/@codeListValue" />
            <sch:assert test="/mdb:MD_Metadata/mdb:contact/cit:CI_Responsibility/cit:party" />

            <sch:assert test="/mdb:MD_Metadata/mdb:dateInfo/cit:CI_Date/cit:date/gco:Date" />
            <sch:assert test="/mdb:MD_Metadata/mdb:dateInfo/cit:CI_Date/cit:dateType/cit:CI_DateTypeCode/@codeList" />

            <sch:assert test="/mdb:MD_Metadata/mdb:metadataProfile/cit:CI_Citation/cit:title/gco:CharacterString" />
            <sch:assert test="/mdb:MD_Metadata/mdb:metadataProfile/cit:CI_Citation/cit:date/cit:CI_Date/cit:date/gco:Date" />
            <sch:assert test="/mdb:MD_Metadata/mdb:metadataProfile/cit:CI_Citation/cit:date/cit:CI_Date/cit:dateType/cit:CI_DateTypeCode/@codeList" />

            <sch:assert test="/mdb:MD_Metadata/mdb:otherLocale/lan:PT_Locale/lan:language/lan:LanguageCode/@codeList" />
            <sch:assert test="/mdb:MD_Metadata/mdb:otherLocale/lan:PT_Locale/lan:country/lan:CountryCode/@codeList" />
            <sch:assert test="/mdb:MD_Metadata/mdb:otherLocale/lan:PT_Locale/lan:characterEncoding/lan:MD_CharacterSetCode/@codeList" />
            <sch:assert test="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification" />
            <sch:assert test="/mdb:MD_Metadata/mdb:distributionInfo/mrd:MD_Distribution" />
            <sch:assert test="/mdb:MD_Metadata/mdb:metadataScope/mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode/@codeListValue" />
            <sch:assert test="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:resourceConstraints" />
            <sch:assert test="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:resourceConstraints/mco:MD_LegalConstraints/mco:reference/cit:CI_Citation/cit:title/gco:CharacterString" />

        </sch:rule>

        <!-- These rules apply to all MD_CharacterSetCode, LanguageCode tags -->
        <sch:rule context="//lan:MD_CharacterSetCode">
            <sch:assert test="@codeListValue='utf8'">Encoding must be 'utf8'</sch:assert>
        </sch:rule>

        <sch:rule context="/mdb:MD_Metadata/mdb:contact/cit:CI_Responsibility/cit:party">
            <sch:assert test="cit:CI_Individual or cit:CI_Organisation" />
        </sch:rule>


        <sch:rule context="/mdb:MD_Metadata/mdb:contact/cit:CI_Responsibility/cit:party/cit:CI_Individual">
            <sch:assert test="cit:name/gco:CharacterString" />
            <sch:assert test="cit:contactInfo/cit:CI_Contact/cit:address/cit:CI_Address/cit:country/gco:CharacterString" />
            <sch:assert test="cit:contactInfo/cit:CI_Contact/cit:address/cit:CI_Address/cit:electronicMailAddress/gco:CharacterString" />
        </sch:rule>

        <sch:rule context="/mdb:MD_Metadata/mdb:contact/cit:CI_Responsibility/cit:party/cit:CI_Organisation">
            <sch:assert test="cit:name" />
            <sch:assert test="cit:contactInfo/cit:CI_Contact/cit:address/cit:CI_Address/cit:country/gco:CharacterString" />
            <sch:assert test="cit:contactInfo/cit:CI_Contact/cit:address/cit:CI_Address/cit:electronicMailAddress/gco:CharacterString" />
        </sch:rule>

        <sch:rule context="//lan:LanguageCode">
            <sch:assert test="@codeListValue='eng' or 'fra'">Language must be 'fra' or 'eng'</sch:assert>
        </sch:rule>

        <!--  MD_DataIdentification -->

        <!-- there's not really a need to group the XPaths this way but it looks nicer -->
        <sch:rule context="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification">
            <sch:assert test="mri:citation/cit:CI_Citation/cit:title/gco:CharacterString" />
            <sch:assert test="mri:citation/cit:CI_Citation/cit:title/lan:PT_FreeText/lan:textGroup/lan:LocalisedCharacterString" />

            <sch:assert test="mri:abstract/gco:CharacterString" />
            <sch:assert test="mri:abstract/lan:PT_FreeText/lan:textGroup/lan:LocalisedCharacterString" />
            <sch:assert test="mri:status/mcc:MD_ProgressCode/@codeListValue" />
            <sch:assert test="mri:topicCategory/mri:MD_TopicCategoryCode" />
            <sch:assert test="mri:extent/gex:EX_Extent/gex:geographicElement" />

            <!-- TODO defaultLocale / otherLocale isnt here, why does the profile show it here?
                    profile shows otherLocal as not required, shouldnt it be?
            -->

            <sch:assert test="mri:resourceMaintenance/mmi:MD_MaintenanceInformation/mmi:maintenanceAndUpdateFrequency/mmi:MD_MaintenanceFrequencyCode/@codeListValue" />
            <!-- descriptiveKeywords -->

            <sch:assert test="mri:descriptiveKeywords/mri:MD_Keywords/mri:keyword/gco:CharacterString" />

            <sch:assert test="mri:descriptiveKeywords/mri:MD_Keywords/mri:keyword[gco:CharacterString='oxygen' or gco:CharacterString='nutrients' or gco:CharacterString='nitrate' or gco:CharacterString='phosphate' or gco:CharacterString='silicate' or gco:CharacterString='inorganicCarbon' or gco:CharacterString='dissolvedOrganicCarbon' or gco:CharacterString='seaSurfaceHeight' or gco:CharacterString='seawaterDensity' or gco:CharacterString='potentialTemperature' or gco:CharacterString='potentialDensity' or gco:CharacterString='speedOfSound' or gco:CharacterString='seaIce' or gco:CharacterString='seaState' or gco:CharacterString='seaSurfaceSalinity' or gco:CharacterString='seaSurfaceTemperature' or gco:CharacterString='subSurfaceCurrents' or gco:CharacterString='subSurfaceSalinity' or gco:CharacterString='subSurfaceTemperature' or gco:CharacterString='surfaceCurrents']">
            Must have at least one EOV keyword. EOV keywords are: oxygen, nutrients, nitrate, phosphate, silicate, inorganicCarbon, dissolvedOrganicCarbon, seaSurfaceHeight, seawaterDensity, potentialTemperature, potentialDensity, speedOfSound, seaIce, seaState, seaSurfaceSalinity, seaSurfaceTemperature, subSurfaceCurrents, subSurfaceSalinity, subSurfaceTemperature, surfaceCurrents
        </sch:assert>


            <!-- resourceConstraints -->
            <sch:assert test="mri:resourceConstraints/mco:MD_Constraints/mco:useLimitation/gco:CharacterString" />

            <!-- TODO is this required?
                <sch:assert test="/mri:resourceConstraints/mco:MD_LegalConstraints/mco:useConstraints/mco:MD_RestrictionCode/@codeListValue" /> 
            -->


            <!-- TODO accessConstraints is not yet implemented in metadata-xml? -->

        </sch:rule>

        <!-- distributionInfo -->
        <sch:rule context="/mdb:MD_Metadata/mdb:distributionInfo/mrd:MD_Distribution">
            <sch:assert test="mrd:distributor/mrd:MD_Distributor/mrd:distributorContact/cit:CI_Responsibility/cit:role/cit:CI_RoleCode/@codeListValue" />
            <sch:assert test="mrd:distributor/mrd:MD_Distributor/mrd:distributorContact/cit:CI_Responsibility/cit:party/cit:CI_Organisation/cit:name/gco:CharacterString" />

            <!-- TODO this is in profile but not metadata-xml
                <sch:assert test="mrd:distributor/mrd:MD_Distributor/mrd:distributorContact/cit:CI_Responsibility/cit:party/cit:CI_Organisation/cit:contactInfo/cit:CI_Contact/cit:address/cit:CI_Address/cit:electronicMailAddress/gco:CharacterString" />
            -->

            <sch:assert test="mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource/cit:name/gco:CharacterString" />
            <sch:assert test="mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource/cit:description/gco:CharacterString" />
            <sch:assert test="mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource/cit:linkage/gco:CharacterString" />
            <sch:assert test="mrd:transferOptions/mrd:MD_DigitalTransferOptions/mrd:onLine/cit:CI_OnlineResource/cit:protocol/gco:CharacterString" />
        </sch:rule>

        <!-- MD_Constraints -->
        <sch:rule context="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:resourceConstraints/mco:MD_Constraints">
            <sch:assert test="mco:useLimitation/gco:CharacterString" />

        </sch:rule>


        <sch:rule context="/mdb:MD_Metadata/mdb:otherLocale/lan:PT_Locale">
            <sch:assert test="lan:language/lan:LanguageCode[@codeListValue='eng' or @codeListValue='fra']">Language must be fra or eng</sch:assert>
            <sch:assert test="lan:country/lan:CountryCode/@codeListValue" />
            <sch:assert test="lan:characterEncoding/lan:MD_CharacterSetCode/@codeList" />
        </sch:rule>
        <!-- require EX_BoundingPolygon or EX_GeographicBoundingBox, or both  -->
        <sch:rule context="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:extent/gex:EX_Extent/gex:geographicElement">
            <sch:assert test="gex:EX_BoundingPolygon or gex:EX_GeographicBoundingBox" />
        </sch:rule>

        <!-- if EX_GeographicBoundingBox, require fields inside -->
        <sch:rule context="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:extent/gex:EX_Extent/gex:geographicElement/gex:EX_GeographicBoundingBox">
            <sch:assert test="gex:extentTypeCode/gco:Boolean" />
            <sch:assert test="gex:westBoundLongitude/gco:Decimal" />
            <sch:assert test="gex:eastBoundLongitude/gco:Decimal" />
            <sch:assert test="gex:southBoundLatitude/gco:Decimal" />
            <sch:assert test="gex:northBoundLatitude/gco:Decimal" />
        </sch:rule>
        <sch:rule context="/mdb:MD_Metadata/mdb:identificationInfo/mri:MD_DataIdentification/mri:extent/gex:EX_Extent/gex:geographicElement/gex:EX_BoundingPolygon">
            <sch:assert test="gex:extentTypeCode/gco:Boolean" />
            <sch:assert test="gex:polygon" />

        </sch:rule>
    </sch:pattern>

</sch:schema>