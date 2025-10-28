table 50111 "Out Of Office Summary"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Reason Code"; Code[20])
        {
            TableRelation = "Out Of Office Reason".Code;
        }
        field(2; "Total Days"; Integer) { }
    }
    keys
    {
        key(PK; "Reason Code")
        {
            Clustered = true;
        }
    }
}