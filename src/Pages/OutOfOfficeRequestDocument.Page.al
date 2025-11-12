page 50102 "Out Of Office Request Document"
{
    PageType = Document;
    SourceTable = "Out Of Office Request";
    ApplicationArea = All;
    Caption = 'Out Of Office Request Document';
    UsageCategory = Documents;

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
                    ToolTip = 'Specify the reason for the absence.';

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
                field("Document"; Rec."Photo Blob")
                {
                    ToolTip = 'Attach a document.';
                }
            }
        }
        // area(FactBoxes)
        // {
        //     part(Photo; "Out Of Office Photo FactBox")
        //     {
        //         SubPageLink = "Entry No." = field("Entry No.");
        //     }
        // }
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
                        Clear(Rec."Photo Blob");
                        TempBlob.CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        Rec.CalcFields("Photo Blob");
                        Rec."Photo Blob".CreateOutStream(OutStream);
                        TempBlob.CreateInStream(InStream);
                        CopyStream(OutStream, InStream);
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action(RemovePicture)
            {
                Caption = 'Remove';
                Image = Delete;
                ToolTip = 'Remove the current image';
                trigger OnAction()
                begin
                    if Rec."Photo Blob".HasValue() then begin
                        Clear(Rec."Photo Blob");
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end else
                        Message('No picture to remove');
                end;
            }
        }
    }
}
