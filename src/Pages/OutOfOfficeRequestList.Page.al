page 50101 "Out Of Office Request List"
{
    PageType = List;
    SourceTable = "Out Of Office Request";
    ApplicationArea = All;
    Editable = false;
    Caption = 'Out Of Office Request List';
    UsageCategory = Lists;
    CardPageId = "Out Of Office Request Document";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field("Status"; Rec."Status")
                {
                }
                field("Description"; Rec."Description")
                {
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Start process")
            {
                Caption = 'Start Process';
                ApplicationArea = All;
                Image = Start;
                trigger OnAction()
                begin
                    ValidateRequiredFields();
                    Rec.Status := Rec.Status::"In Process";
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action("Approve")
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                begin
                    ValidateRequiredFields();
                    Rec.Status := Rec.Status::"Approved";
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action("Decline")
            {
                Caption = 'Decline';
                ApplicationArea = All;
                Image = Reject;
                trigger OnAction()
                begin
                    ValidateRequiredFields();
                    Rec.Status := Rec.Status::"Declined";
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref("Start process Promoted"; "Start process")
            {

            }
            actionref("Approve Promoted"; "Approve")
            {

            }
            actionref("Decline Promoted"; "Decline")
            {

            }
        }
    }
    local procedure ValidateRequiredFields()
    begin
        if Rec."Start Date" = 0D then
            Error('Start Date is required.');

        if Rec."Start Time" = 0T then
            Error('Start Time is required.');

        if Rec."End Date" = 0D then
            Error('End Date is required.');

        if Rec."End Time" = 0T then
            Error('End Time is required.');

        if Rec."Reason Code" = '' then
            Error('Reason Code is required.');

        if Rec.Description = '' then
            Error('Description is required.');
    end;

}