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
            RequestFilterFields = "Employee No.";
            column(Start_Date; "StartDateFilter") { }
            column(End_Date; "EndDateFilter") { }
            column(Employee_No_; "Employee No.") { }
            column(Employee_Name; EmpName) { }
            column(Reason_Code; "Reason Code") { }
            column(DayCount; "DayCount") { }

            trigger OnAfterGetRecord()
            var
                Emp: Record Employee;
            begin
                DayCount := ("End Date" - "Start Date") + 1;
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
}