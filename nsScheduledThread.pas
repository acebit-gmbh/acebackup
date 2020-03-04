unit nsScheduledThread;

interface

uses
  Classes, Windows, SysUtils, Forms, Dialogs, nsGlobals, nsTypes;

type
  TScheduledThread = class(TThread)
  private
    { Private declarations }
    FWndOwner: HWND;
    FProject: TNSProject;
  protected
    procedure Execute; override;
  public
    constructor Create(AMainWnd: HWND; AFileName: string);
    destructor Destroy; override;
  end;

implementation

uses nsActions;

constructor TScheduledThread.Create(AMainWnd: HWND; AFileName: string);
begin
  inherited Create(True);
  FWndOwner := AMainWnd;
  SendMessage(FWndOwner, WM_SCHEDULEDPROCESS, 1, 0);
  FreeOnTerminate := True;
  FProject := TNSProject.Create(nil); // No progress form !!!
  FProject.AutoMode := True;
  try
    if not FProject.LoadFromFile(AFileName) then
      Self.Terminate;
    if not FProject.ConnectToMedia(0) then
      Self.Terminate;
  except
    FreeAndNil(FProject);
    Self.Terminate;
  end;
  Execute; // FIX // Resume;
end;

destructor TScheduledThread.Destroy;
begin
  if Assigned(FProject) then
    FProject.Free;
  inherited Destroy;
  SendMessage(FWndOwner, WM_SCHEDULEDPROCESS, 0, 0);
end;

procedure TScheduledThread.Execute;
begin
  try
    FProject.ExecuteExternal(True);
    SynchronizeProject(FProject, nil, True);
    ProcessProject(FProject, csAll);

    FProject.CheckVolumes(csAll);
    FProject.ExecuteExternal(False);
  finally
    FProject.CloseProject;
  end;
end;


end.
