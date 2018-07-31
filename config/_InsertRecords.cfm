<!---
-Order matters to populate tables, do FK relationship tables before primary key tables
	-e.g.: Type, Keeper, and Area records must be entered before Animal records since TypeID, KeeperID, and AreaID are set in Animal records
-Not calling <cfset ORMReload()>, it can be triggered by OnRequestStart to reload ORM and mappings
--->



<!---Keeper--->
<cfset Model = EntityNew("Keeper", {Prefix="Mr.", FirstName="Tom", LastName="Smith", Email="tom@zoo.com", Gender="m"})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Keeper", {Prefix="Mrs.", FirstName="Jenny", LastName="Williams", Email="tom@zoo.com", Gender="f"})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Keeper", {Prefix="Mr.", FirstName="Billy", LastName="West", Email="tom@zoo.com", Gender="m"})>
<cfset EntitySave(Model)>



<!---Area--->
<cfset Model = EntityNew("Area", {Area="African Forest", SortOrder=1})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Area", {Area="Aquarium Shores", SortOrder=2})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Area", {Area="Asia Quest", SortOrder=3})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Area", {Area="Australia & The Islands", SortOrder=4})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Area", {Area="North America", SortOrder=5})>
<cfset EntitySave(Model)>



<!---Type--->
<cfset Model = EntityNew("Type", {Type="Amphibian", SortOrder=1})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Type", {Type="Bird", SortOrder=2})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Type", {Type="Fish", SortOrder=3})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Type", {Type="Invertebrate", SortOrder=4})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Type", {Type="Mammal", SortOrder=5})>
<cfset EntitySave(Model)>
<cfset Model = EntityNew("Type", {Type="Reptile", SortOrder=6})>
<cfset EntitySave(Model)>



<!---Animal--->
<cfset NamesList = "Alan,Alden,Alea,Alexa,Alexander,Aline,Amanda,Amir,Amir,Anjolie,Anne,Audrey,Aurora,Basil,Beatrice,Beau,Benedict,Blair,Bree,Britanney,Bruce,Brynne,Callie,Caryn,Cassandra,Cassidy,Chaim,Cheryl,Cheyenne,Claire,Clarke,Clementine,Cody,Damian,Destiny,Donovan,Dylan,Eleanor,Farrah,Fatima,Finn,Flynn,Flynn,Fulton,Genevieve,Gisela,Glenna,Graham,Harrison,Hector,Herrod,Hilel,Hillary,Hollee,Holmes,Hunter,Ignacia,Ila,Imogene,India,Ingrid,Jackson,Jaden,Jaquelyn,Joan,Joan,Joelle,Jonah,Kadeem,Kaitlin,Kaseem,Katelyn,Kato,Keane,Keaton,Keaton,Kellie,Kelly,Kevin,Kevin,Kieran,Kiona,Lance,Lance,Lars,Leah,Leandra,Leigh,Lilah,Madeline,Magee,Malachi,Malcolm,Mallory,Marsden,Martina,Maya,Maya,Merrill,Michelle,Mufutau,Nathan,Nerea,Nicholas,Nissim,Noah,Noble,Norman,Ocean,Orlando,Paki,Phelan,Prescott,Ramona,Raphael,Roth,Ryan,Sarah,Sebastian,Simone,Stewart,Stone,Suki,TaShya,TaShya,Tatyana,Teagan,Theodore,Thumper,Toucan Sam,Tyler,Uriel,Vance,Vielka,Vivian,Wade,Wendy,Yasir,Yen,Zane">
<cfset SpeciesList = "Kookaburra,Orca,Beetle,Dragonfly,Horse,Emu,Mandrill,Oedemera,Chimpanzee,Ocelot,Leopard,Tayra,Chameleon,Dog,Cardinal,Alligator,Kangaroo,Caribou,Locust,Raccoon,Cat,Bearded Dragon,Goatfish,Walrus,Toad,Donkey,Cheetah,Impala,Octopus,Caracal,Raven,Fulgorid,Badger,Wolf,Eland,Antelope,Vulture,Bison">
<cfset GendersList = "m,f">
<!---Step backwards from 140 to 1 to remove an animal at a time from NamesList, using index i, will cause i count down from 140 instead of up to it--->
<cfloop from="140" to="1" step="-1" index="i">
	<!---
	-Using RandDateRange in Helpers to get a random DOB and ArrivedAt date for each animal some day in last 10 years for DOB and 8 years for ArrivedAt
	-Using #TimeFormat(Rand(), "HH:#LSNumberFormat(IIF(RandRange(0, 1) EQ 1, 30, 00), "00")#")# to generate a randome 24 hour time on the half hour e.g.: 04:00, 15:30, 23:00, etc.
		-Used Ben Nadel post to explain RandRange generating a random time: https://www.bennadel.com/blog/667-using-rand-to-generate-random-times-in-coldfusion.htm
	--->
	<cfinvoke component="/udfs/Helpers" method="RandDateRange" returnvariable="DOBAnimal">
	    <cfinvokeargument name="DateFrom" value="#DateFormat(DateAdd('yyyy', -10, REQUEST.ReqStr.UTCNow), 'yyyy-mm-dd')#">
	    <cfinvokeargument name="DateTo" value="#DateFormat(DateAdd('yyyy', -5, REQUEST.ReqStr.UTCNow), 'yyyy-mm-dd')#">
	</cfinvoke>
	<cfinvoke component="/udfs/Helpers" method="RandDateRange" returnvariable="ArrivedAtAnimal">
	    <cfinvokeargument name="DateFrom" value="#DateFormat(DateAdd('yyyy', -4, REQUEST.ReqStr.UTCNow), 'yyyy-mm-dd')#">
	    <cfinvokeargument name="DateTo" value="#DateFormat(REQUEST.ReqStr.UTCNow, 'yyyy-mm-dd')#">
	</cfinvoke>
	<!---Set a RandomAnimalInteger value between 1 and number of animals remaining to a variable to remove same name from list after it's inserted--->
	<cfset RandomAnimalInteger = RandRange(1, i)>
	<!---6 Types, 3 Keepers, 5 Areas, 38 Species by default--->
	<cfset Model = EntityNew("Animal", {TypeID=RandRange(1, 6), KeeperID=RandRange(1, 3), AreaID=RandRange(1, 5), Name="#ListGetAt(NamesList, RandomAnimalInteger)#", Species="#ListGetAt(SpeciesList, RandRange(1, 38))#", Gender="#ListGetAt(GendersList, RandRange(1, 2))#", DOB=DateFormat(DOBAnimal, "yyyy-mm-dd"), Notes="Lorem ipsum dolor sit amet.", ArrivedAt=DateFormat(ArrivedAtAnimal, "yyyy-mm-dd") & " " & TimeFormat(Rand(), "HH:#LSNumberFormat(IIF(RandRange(0, 1) EQ 1, 30, 00), "00")#")})>
	<cfset EntitySave(Model)>
	<!---Remove name of animal inserted from list--->
	<cfset NamesList = ListDeleteAt(NamesList, RandomAnimalInteger)>
</cfloop>



<!---Flush ORM--->
<cfset ORMFlush()>