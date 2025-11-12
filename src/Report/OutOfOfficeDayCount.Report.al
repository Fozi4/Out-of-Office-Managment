report 50110 "Out Of Office Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Out Of Office Day Count';
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(Employee_No; "No.") { }
            column(Employee_Name; EmpName) { }

            dataitem(Request; "Out Of Office Request")
            {
                DataItemLinkReference = Employee;
                DataItemLink = "Employee No." = field("No.");
                column(Start_Date; StartDateFilter) { }
                column(End_Date; EndDateFilter) { }
                column(Reason; "Reason Code") { }
                column(Total_Days; DayCount) { }
                trigger OnAfterGetRecord()
                var
                    TempRequest: Record "Out Of Office Request";
                begin
                    if ProcessedCodeList.Contains("Reason Code") then
                        CurrReport.Skip();
                    Clear(DayCount);
                    TempRequest.SetRange("Employee No.", "Employee No.");
                    TempRequest.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                    TempRequest.SetFilter("End Date", '<=%1', EndDateFilter);
                    TempRequest.SetRange("Reason Code", "Reason Code");
                    if TempRequest.FindSet() then
                        repeat
                            DayCount += (TempRequest."End Date" - TempRequest."Start Date") + 1;
                        until TempRequest.Next() = 0;
                    ProcessedCodeList.Add("Reason Code");
                end;

                trigger OnPreDataItem()
                begin
                    Request.SetFilter(Request."Start Date", '>=%1 ', StartDateFilter);
                    Request.SetFilter(Request."End Date", '<=%1', EndDateFilter);
                end;
            }
            trigger OnAfterGetRecord()
            var
                Emp: Record Employee;
            begin
                EmpName := '';
                if Emp.Get(Employee."No.") then
                    EmpName := Emp."First Name" + ' ' + Emp."Last Name";
                Clear(ProcessedCodeList);
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
}