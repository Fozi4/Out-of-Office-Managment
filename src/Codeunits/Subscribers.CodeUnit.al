codeunit 50103 Subscribers
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"On Status Change", 'OnStatusChange', '', true, true)]
    local procedure NotifyStatusChange(RequestId: Integer; NewStatus: Text[50])
    begin
        Message('Status of the request %1 changed to %2', RequestId, NewStatus);
    end;
}