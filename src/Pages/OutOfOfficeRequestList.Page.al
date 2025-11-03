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
                    ToolTip = 'Specifies the unique number of the out of office request.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the employee who is submitting the out of office request.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specify the first day of the absence period.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specify the starting time of the absence on the start date.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specify the last day of the absence period.';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specify the ending time of the absence on the end date.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specify the reason for the absence.';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Shows the current status of the request: New, In Process, Approved, or Declined.';
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'Provide additional details or comments about the absence request.';
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ToolTip = 'Specify the reason why the request was declined, if applicable.';
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

            action("Print Out of Office Day Count")
            {
                Caption = 'Print Out of Office Day Count';
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    Report.RunModal(Report::"Out Of Office Report", true, true);
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
            actionref("Print Out of Office Day Count Promoted"; "Print Out of Office Day Count")
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