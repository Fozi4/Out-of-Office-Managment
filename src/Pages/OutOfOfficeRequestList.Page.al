page 50101 "Out Of Office Request List"
{
    PageType = List;
    SourceTable = "Out Of Office Request";
    ApplicationArea = All;
    Editable = false;
    Caption = 'Out Of Office Request List';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
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
                    Rec.Status := Rec.Status::"In Process";
                    //Rec.Modify(true);
                    //CurrPage.Update(false);
                end;
            }
            action("Approve")
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::"Approved";
                    //Rec.Modify(true);
                    //CurrPage.Update(false);
                end;
            }
            action("Decline")
            {
                Caption = 'Decline';
                ApplicationArea = All;
                Image = Reject;
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::"Declined";
                    //Rec.Modify(true);
                    //CurrPage.Update(false);
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

}