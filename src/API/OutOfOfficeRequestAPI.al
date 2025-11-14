page 50104 "Out of Office Request API"
{
    PageType = API;
    APIVersion = 'v1.0', 'v2.0';
    APIPublisher = 'company';
    APIGroup = 'outofofficerequest';
    EntityName = 'request';
    EntitySetName = 'requests';
    DelayedInsert = true;
    SourceTable = "Out Of Office Request";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(employeeNo; Rec."Employee No.") { }
                field(startDate; Rec."Start Date") { }
                field(startTime; Rec."Start Time") { }
                field(endDate; Rec."End Date") { }
                field(endTime; Rec."End Time") { }
                field(reason; Rec."Reason Code") { }
                field(description; Rec.Description) { }
                field(photo; Rec.Photo) { }
            }
        }
    }
}