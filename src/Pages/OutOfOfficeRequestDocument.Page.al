page 50102 "Out Of Office Request Document"
{
    PageType = Document;
    SourceTable = "Out Of Office Request";
    ApplicationArea = All;
    Caption = 'Out Of Office Request Document';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the unique number of the out of office request.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the employee who is submitting the out of office request.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specify the first day of the absence period.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specify the starting time of the absence on the start date.';
                }
                field("End Date"; Rec."End Date")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specify the last day of the absence period.';

                }
                field("End Time"; Rec."End Time")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specify the ending time of the absence on the end date.';

                }
                field("Reason Code"; Rec."Reason Code")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Specify the reason for the absence, such as vacation, sick leave, or training.';

                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Shows the current status of the request: New, In Process, Approved, or Declined.';
                }
                field(Description; Rec.Description)
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTip = 'Provide additional details or comments about the absence request.';

                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ToolTip = 'Specify the reason why the request was declined, if applicable.';
                }

            }

        }

    }
}
