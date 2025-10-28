tableextension 50100 "My Employee" extends "Employee"
{
    fields
    {
        field(50100; "Associated User Id"; Guid)
        {
            Caption = 'User Id';
            TableRelation = User."User Security ID";
        }
    }

}