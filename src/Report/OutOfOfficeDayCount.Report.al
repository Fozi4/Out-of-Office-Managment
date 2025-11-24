report 50110 "Out Of Office Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Out Of Office Day Count';
    DefaultRenderingLayout = RDLCLayout;

    dataset
    {
        dataitem(Employee; Employee)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Employee_No; "No.") { }
            column(Employee_Name; EmpName) { }

            dataitem(Request; "Out Of Office Request")
            {
                DataItemTableView = sorting("Employee No.");
                DataItemLinkReference = Employee;
                DataItemLink = "Employee No." = field("No.");
                column(Start_Date; Format(StartDateFilter, 0, '<Closing><Day>. <Month Text> <Year4>')) { }//, 0, '<Day,2>.<Month,2>.<Year,4>')) { }
                column(End_Date; Format(EndDateFilter, 0, '<Closing><Day>. <Month Text> <Year4>')) { }
                column(Reason; "Reason Code") { }
                column(Total_Days; DayCount) { }
                trigger OnAfterGetRecord()
                var
                    Request: Record "Out Of Office Request";
                begin
                    if ProcessedCodeList.Contains("Reason Code") then
                        CurrReport.Skip();
                    Clear(DayCount);
                    Request.SetRange("Employee No.", "Employee No.");
                    Request.SetFilter("Start Date", '>=%1 ', StartDateFilter);
                    Request.SetFilter("End Date", '<=%1', EndDateFilter);
                    Request.SetRange("Reason Code", "Reason Code");
                    if Request.FindSet() then
                        repeat
                            DayCount += (Request."End Date" - Request."Start Date") + 1;
                        until Request.Next() = 0;
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
                    Caption = 'Start Date';
                    ToolTip = 'Specify starting date';
                }
                field(EndDateFilter; EndDateFilter)
                {
                    Caption = 'End Date';
                    ToolTip = 'Specify ending date';
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
        layout(RDLCLayout)
        {
            Type = RDLC;
            LayoutFile = 'OutOfOfficeDayCount.rdl';
        }
    }

    var
        DayCount: Integer;
        EmpName: Text[100];
        StartDateFilter: Date;
        EndDateFilter: Date;
        ProcessedCodeList: List of [Code[20]];
}