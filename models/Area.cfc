<cfcomponent extends="/models/Parent" persistent="true" table="Areas" entityname="Area" hint="Area model">

    <!---PK identity--->
    <cfproperty name="ID" fieldtype="id" ormtype="integer" generator="identity">
    <cfproperty name="Area" fieldtype="column" ormtype="string" length="50" notnull="true">
    <cfproperty name="SortOrder" fieldtype="column" ormtype="integer" notnull="true">
    <cfproperty name="CreatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="UpdatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="DeletedAt" fieldtype="column" ormtype="timestamp">

</cfcomponent>