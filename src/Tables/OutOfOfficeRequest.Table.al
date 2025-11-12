table 50101 "Out Of Office Request"
{
    TableType = Normal;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee';
            TableRelation = Employee;
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
            trigger OnValidate()
            var
                ErrorMessage: Text;
            begin
                ErrorMessage := Validation.Validation("Start Date", "End Date", "Start Time", "End Time", "Reason Code");
                if ErrorMessage <> '' then
                    Error(ErrorMessage);
            end;
        }
        field(4; "Start Time"; Time)
        {
            Caption = 'Start Time';
            InitValue = 090000T;
            trigger OnValidate()
            var
                ErrorMessage: Text;
            begin
                ErrorMessage := Validation.Validation("Start Date", "End Date", "Start Time", "End Time", "Reason Code");
                if ErrorMessage <> '' then
                    Error(ErrorMessage);
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            trigger OnValidate()
            var
                ErrorMessage: Text;
            begin
                ErrorMessage := Validation.Validation("Start Date", "End Date", "Start Time", "End Time", "Reason Code");
                if ErrorMessage <> '' then
                    Error(ErrorMessage);
            end;
        }
        field(6; "End Time"; Time)
        {
            Caption = 'End Time';
            InitValue = 180000T;
            trigger OnValidate()
            var
                ErrorMessage: Text;
            begin
                ErrorMessage := Validation.Validation("Start Date", "End Date", "Start Time", "End Time", "Reason Code");
                if ErrorMessage <> '' then
                    Error(ErrorMessage);
            end;
        }
        field(7; "Reason Code"; Code[20])
        {
            Caption = 'Reason';
            TableRelation = "Out Of Office Reason";
        }
        field(8; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = New,"In Process",Approved,Declined;
        }
        field(9; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Reject Reason"; Text[250])
        {
            Caption = 'Rejection Reason';
        }
        field(11; "Days"; Integer)
        {

        }
        field(12; "Photo"; Media)
        {

        }
        field(13; "Photo Blob"; Blob)
        {
            Caption = 'Document';
            Subtype = Bitmap;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(EmployeeKey; "Employee No.")
        {
            Clustered = false;
        }
    }
    trigger OnInsert()
    var
        Employee: Record Employee;

    begin
        Employee.SetRange("Associated User Id", UserSecurityId());
        if Employee.FindFirst() then
            Rec."Employee No." := Employee."No.";
    end;

    var
        Validation: Codeunit "Date Time Validation";
}