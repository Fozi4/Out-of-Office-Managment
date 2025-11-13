codeunit 50101 "Archive Requests"
{
    trigger OnRun()
    var
        Request: Record "Out Of Office Request";
        Archive: Record "Archive Out of Office Request";
    begin
        Request.SetFilter("End Date", '<%1', Today());
        if Request.FindSet() then
            repeat
                Archive.Init();
                Archive.TransferFields(Request);
                Archive.Insert();
                Request.Delete();
            until Request.Next() = 0;
    end;
}