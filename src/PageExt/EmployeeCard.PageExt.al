pageextension 50100 MyEmployeeCard extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field("Associated User Id"; Rec."Associated User Id")
            {
                ApplicationArea = all;
            }
        }
    }
}