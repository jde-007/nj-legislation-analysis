README.TXT for Database Tables

As of July 17, 2015, the following tables are available In MSACCESS & Delimeted Text:

Acronyms
	description of abbreviations used within Abstract and Synopsis fields within MainBill

Agendas
	Agendas for committees and houses

BAgendas
	Bills on agendas


BillHist
	activity on a bill

BillSpon
	sponsorship on a bill

BillSubj
	categories or subjects associated with a bill 

BillWP
	documents associated with a bill

COMember	
	Committee membership

Committee
	Committee Acronym (Code field) and Name (Description field) for committees only

LegBio
	Biographical information about a legislator


MainBill
	information about a bill 

NAgendas
	Nominees on agendas - primarily pertaining to Senate Judiciary and Senate house agendas 

Roster
	Legislator information

SubjHeadings
	valid subjects or categories for a bill


 
As of July 20, 2012, the following associations may be made:
----------------------------------------
----------------------------------------
MainBill	BillType + BillNumber

to 

BillHist	BillType + BillNumber
BillSpon	BillType + BillNumber
BillSubj	BillType + BillNumber
BillWP		BillType + BillNumber
BAgenda		BillType + BillNumber


--------------------------------------
For committee information on bills currently in committee, or agendas for a committee

Committee	Code

to 

MainBill	CurrentStatus (in committee as of that time)
Agendas		CommHouse 	(agenda for a committee)

---------------------------------------
for agenda information regarding bills or nominees

Agenda		CommHouse + Date + Time + Type

to

BAgenda		CommHouse + Date + Time + Type
NAgenda		CommHouse + Date + Time + Type

----------------------------------------------

for full subject description

BillSubj	SubjectKey

to

SubjHeadings	SubjAbbrev

-------------------------------------------------

for legislator bio and other information

Roster		Roster Key

to

LegBio		Roster Key

-------------------------------------------------



