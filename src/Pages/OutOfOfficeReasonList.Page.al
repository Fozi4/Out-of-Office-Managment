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
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}