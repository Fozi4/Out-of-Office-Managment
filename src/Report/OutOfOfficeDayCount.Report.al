report 50110 "Out Of Office Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Out Of Office Day Count';
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Employee; "Out Of Office Request")
        {
            RequestFilterFields = "Employee No.";
            column(Employee_No_; "Employee No.") { }
            column(Employee_Name; EmpName) { }

            dataitem(Request; "Out Of Office Request")
            {
                DataItemLink = "Employee No." = field("Employee No.");
                column(Start_Date; "StartDateFilter") { }
                column(End_Date; "EndDateFilter") { }
                column(Reason_Code; "Reason Code") { }
                column(Day_Count; DayCount) { }
                trigger OnAfterGetRecord()
                begin
                    if ProcessedCodeList.Contains(Request."Reason Code") then
                        CurrReport.Skip();
                    OutOfficeRequest.SetRange("Employee No.", Employee."Employee No.");
                    OutOfficeRequest.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                    OutOfficeRequest.SetFilter("End Date", '<=%1', EndDateFilter);
                    OutOfficeRequest.SetRange("Reason Code", Request."Reason Code");
                    //OutOfficeRequest.SetFilter(Status, 'Approved');
                    Clear(DayCount);
                    if OutOfficeRequest.FindSet() then
                        repeat
                            DayCount += (OutOfficeRequest."End Date" - OutOfficeRequest."Start Date") + 1;
                        until OutOfficeRequest.Next() = 0;
                    ProcessedCodeList.Add(Request."Reason Code");
                end;

                trigger OnPreDataItem()
                begin
                    Request.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                    Request.SetFilter("End Date", '<=%1', EndDateFilter);
                end;
            }

            trigger OnAfterGetRecord()
            var
                Emp: Record Employee;
            begin
                if ProcessedEmpCodeList.Contains(Employee."Employee No.") then
                    CurrReport.Skip();
                EmpName := '';
                if Emp.Get(Employee."Employee No.") then
                    EmpName := Emp."First Name" + ' ' + Emp."Last Name";
                ProcessedEmpCodeList.Add(Employee."Employee No.");
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
            }

        }
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
        ProcessedCodeList: List of [Code[20]];
        ProcessedEmpCodeList: List of [Code[20]];
        OutOfficeRequest: Record "Out Of Office Request";
}