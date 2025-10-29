report 50110 "Out Of Office Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Out Of Office Day Count';
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Request; "Out Of Office Request")
        {
            RequestFilterFields = "Employee No.", "Start Date", "End Date";
            column(Start_Date; "StartDateFilter") { }
            column(End_Date; "EndDateFilter") { }
            column(Employee_No_; "Employee No.") { }
            column(Employee_Name; EmpName) { }
            column(Reason_Code; "Reason Code") { }
            column(Day_Count; DayCount) { }
            trigger OnAfterGetRecord()
            var
                Emp: Record Employee;
                OutOfficeRequest: Record "Out Of Office Request";
            begin
                if ProcessedCodeList.Contains(Request."Reason Code") then
                    CurrReport.Skip();
                OutOfficeRequest.SetRange("Employee No.", EmployeeNumberFilter);
                OutOfficeRequest.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                OutOfficeRequest.SetFilter("End Date", '<=%1', EndDateFilter);
                OutOfficeRequest.SetRange("Reason Code", Request."Reason Code");
                Clear(DayCount);
                if OutOfficeRequest.FindSet() then
                    repeat
                        DayCount += (OutOfficeRequest."End Date" - OutOfficeRequest."Start Date") + 1;
                    until OutOfficeRequest.Next() = 0;
                ProcessedCodeList.Add(Request."Reason Code");
                EmpName := '';
                if Emp.Get(Request."Employee No.") then
                    EmpName := Emp."First Name" + ' ' + Emp."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                Request.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                Request.SetFilter("End Date", '<=%1', EndDateFilter);
            end;
        }


    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(StartDateFilter; "StartDateFilter")
                {

                }
                field(EndDateFilter; EndDateFilter)
                {

                }
                field(EmployeeNumberFilter; EmployeeNumberFilter)
                {
                    TableRelation = "Employee";
                    ShowMandatory = true;
                    NotBlank = true;
                    trigger OnValidate()
                    begin
                        if EmployeeNumberFilter = '' then begin
                            Error('Employee cannot be empty');
                        end;
                    end;
                }
            }

        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if EmployeeNumberFilter = '' then begin
                Message('Employee cannot be empty');
                exit(false);
            end;
        end;
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = Word;
            LayoutFile = 'OutOfOfficeDayCount.docx';
        }
    }

    var
        DayCount: Integer;
        EmpName: Text[100];
        StartDateFilter: Date;
        EndDateFilter: Date;
        EmployeeNumberFilter: Code[20];
        ProcessedCodeList: List of [Code[20]];
}