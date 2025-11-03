page 50100 "Out Of Office Reason List"
{
    PageType = List;
    SourceTable = "Out Of Office Reason";
    ApplicationArea = All;
    Caption = 'Out Of Office Reason List';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    Caption = 'Reason';
                    ToolTip = 'Reason Codes.';
                }
                field("Description"; Rec."Description")
                {
                    Caption = 'Description';
                    ToolTip = 'Description of the reason for being out of office.';
                }
            }
        }
    }
}