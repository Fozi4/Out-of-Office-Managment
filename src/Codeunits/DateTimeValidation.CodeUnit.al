codeunit 50100 "Date Time Validation"
{
    Access = Public;
    Subtype = Normal;
    trigger OnRun()
    begin

    end;

    procedure Validation(StartingDate: Date; EndingDate: Date; StartingTime: Time; EndingTime: Time; Reason: Code[20]): Text
    var
        ErrorMessage: Text;
    begin
        if StartingDate < Today() then
            ErrorMessage := 'Start Date cannot be earlier than today.';

        if (EndingDate <> 0D) and (EndingDate < StartingDate) then
            ErrorMessage := 'End Date cannot be earlier than Start Date.';

        if (StartingDate = EndingDate) and (EndingTime <= StartingTime) then
            ErrorMessage := 'End Time must be later than Start Time when Start Date equals End Date.';

        if (StartingDate = 0D) and (EndingDate = 0D) then
            ErrorMessage := 'Start Date and End Date must be specified.';

        if (StartingTime < 090000T) or (EndingTime > 180000T) then
            ErrorMessage := 'Time must be between 09:00 and 18:00.';

        if StartingTime = EndingTime then
            ErrorMessage := 'Start Time and End Time cannot be the same.';

        if (StartingDate = Today()) and (Reason <> 'SICK') then
            ErrorMessage := 'Only Sick leave can start today';

        exit(ErrorMessage);
    end;
}