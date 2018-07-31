<cfcomponent extends="/models/Parent" persistent="true" table="Keepers" entityname="Keeper" hint="Keeper model">

    <!---PK identity--->
    <cfproperty name="ID" fieldtype="id" ormtype="integer" generator="identity">
    <cfproperty name="Prefix" fieldtype="column" ormtype="string" length="5" default="">
    <cfproperty name="FirstName" fieldtype="column" ormtype="string" length="50" notnull="true">
    <cfproperty name="LastName" fieldtype="column" ormtype="string" length="50" notnull="true">
    <cfproperty name="Email" fieldtype="column" ormtype="string" length="150" notnull="true">
    <cfproperty name="Gender" fieldtype="column" ormtype="string" length="1" notnull="true">
    <cfproperty name="CreatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="UpdatedAt" fieldtype="column" ormtype="timestamp" notnull="true">
    <cfproperty name="DeletedAt" fieldtype="column" ormtype="timestamp">

</cfcomponent>