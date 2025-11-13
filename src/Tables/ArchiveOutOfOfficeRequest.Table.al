table 50102 "Archive Out of Office Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {

        }
        field(2; "Employee No."; Code[20])
        {

        }
        field(3; "Start Date"; Date)
        {

        }
        field(4; "Start Time"; Time)
        {

        }
        field(5; "End Date"; Date)
        {

        }
        field(6; "End Time"; Time)
        {

        }
        field(7; "Reason Code"; Code[20])
        {

        }
        field(9; "Description"; Text[250])
        {

        }
        field(10; "Reject Reason"; Text[250])
        {

        }
        field(11; "Photo Blob"; Blob)
        {
            Subtype = Bitmap;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}