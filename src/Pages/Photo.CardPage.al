page 50103 "Out Of Office Photo FactBox"
{
    Caption = 'Document';
    PageType = CardPart;
    SourceTable = "Out Of Office Request";
    layout
    {
        area(content)
        {
            field(Photo; Rec.Photo)
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
                    FileName: Text;
                    TempFilePath: Text;
                    InStream: InStream;
                begin
                    UploadIntoStream('Select a picture', '', '', TempFilePath, InStream);

                    Rec.Photo.ImportStream(InStream, TempFilePath);

                    Rec.Modify(true);
                end;
            }

        }
    }
}
