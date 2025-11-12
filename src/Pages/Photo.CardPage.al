page 50103 "Out Of Office Photo FactBox"
{
    Caption = 'Document';
    PageType = CardPart;
    SourceTable = "Out Of Office Request";
    layout
    {
        area(content)
        {
            field(Photo; Rec."Photo Blob")
            {
                ApplicationArea = All;
                ShowCaption = false;
                Editable = true;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                    InStream: InStream;
                    OutStream: OutStream;
                begin
                    if UploadIntoStream('Import Picture', '', '', FileName, InStream) then begin
                        TempBlob.CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        Rec.CalcFields("Photo Blob");
                        Rec."Photo Blob".CreateOutStream(OutStream);
                        TempBlob.CreateInStream(InStream);
                        CopyStream(OutStream, InStream);
                    end;
                end;
            }

        }
    }
}
