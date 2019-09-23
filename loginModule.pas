unit loginModule;

interface

uses
  SysUtils, Classes, HTTPApp, WebModu, HTTPProd,IdPOP3,IdSSLOpenSSL,
  //serialization,
  HashMap,config,webDisp,DCL_intf,Algorithms,windows,StrUtils,SiteComp,IdExplicitTLSClientServerBase
  ,Character,IdGlobal, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient,contnrs,XMLSerializer,
  DAO.UserMailInBox,
  Domain.UserMailInBox,
  Generics.Collections,
  Encryption_DB
  ;

type
   TEventHandlers = class // create a dummy class
     class procedure IdPOP3Disconnected(Sender: TObject) ;
   end;
  TNotifyEvent = procedure(Sender: TObject) of object;
  Tlogin = class(TWebPageModule)
    PageProducer: TPageProducer;
    IdPOP31: TIdPOP3;
    procedure WebPageModuleBeforeDispatchPage(Sender: TObject;
      const PageName: string; var Handled: Boolean);
    procedure WebPageModuleCreate(Sender: TObject);
    procedure WebPageModuleDeactivate(Sender: TObject);
    procedure WebPageModuleDestroy(Sender: TObject);
    procedure PageProducerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    //��¼�ʼ�������
    class function LoginPOP3MailServer(user:TUser; mailConfig: TMailConfig;isFirstLogin:boolean=true):string;
  end;

  function login: Tlogin;
  function GetPOP3:TIdPOP3;
  function GetPOP3List:THashMap;
  function GetUserPOP3(var POP3:TIdPop3):boolean;  //�õ���ǰ�û���POP3����ʵ����

  function GetUserAndNullToFirstPage(var currentUser:TUser;WhenNullToFirstPage:boolean=false):boolean;overload; //����Session�õ���ǰ�û���ʵ����

  function GetUser(userEmailAddress:string; var currentUser:TUser):boolean;overload; //����User EmailAddress�õ���ǰ�û���ʵ����
  function GetUserCurrentSelectMailConfig(var currentMailConfig:TMailConfig):Boolean;   //�õ���ǰ�û���ѡ����������á�
  function AppendUserInfo(userName:string='';password:string='NULL'):string;

implementation

{$R *.dfm}  {*.wml}

uses WebReq, WebCntxt, WebFact, Variants,mainModule,dataModule, serialization;

var
  POP:TIdPOP3;
  POP3List:THashMap;

class procedure TEventHandlers.IdPOP3Disconnected(Sender: TObject) ;
var
  pop3Temp:TIdPOP3;
begin
    GetUserPOP3(pop3Temp);
end;

function login: Tlogin;
begin
  Result := Tlogin(WebContext.FindModuleClass(Tlogin));
end;

function GetUserPOP3(var POP3:TIdPop3):boolean;
var
  //obj:TIdPOP3;
  hash:THashMap;
  //UName,PWD,
  userSerializationStr:string;
  item,key:IIterator;
  user,userObj:TUser;
  objTmp:TObject;
begin
  Result := false;

  //UName := WebContext.Session.Values[TConfig.cUserName];
  //PWD := WebContext.Session.Values[TConfig.cPassword];
  //if UName<>'' then
  userSerializationStr := WebContext.Session.Values[TConfig.currentUserSession];
  if userSerializationStr<>'' then
  begin
    user := TUser.Create(nil);
    serialization.StrToComponent(userSerializationStr,user);
    hash := GetPOP3List;
    key := hash.KeySet.First;
    item := hash.Values.First;

//    for i:= 0 to hash.Values.Size-1 do
//    begin
//      if not item.HasNext then
//        Exit;
//      Obj := item.GetObject as TIdPOP3;
//      if (obj.Username = UName) and (obj.Password = PWD) then
//      begin
//        POP3 := Obj;
//        Result := true;
//        break;
//      end;
//      item.Next;
//    end;

{
    //�� Value Object ������
    if item<>nil then
    begin
      obj := item.GetObject as TIdPOP3;
      if (obj.Username = UName) and (obj.Password = PWD) then
        POP3 := Obj
      else
        while item.HasNext do
        begin
          obj := item.GetObject as TIdPOP3;
          if (obj.Username = UName) and (obj.Password = PWD) then
          begin
            POP3 := obj;
            break;
          end;
          item.Next;
        end;
    end;
}
    //�� Key Object ������
    if key<>nil then
    begin
      objTmp := key.GetObject;
      if objTmp=nil then exit;
      userObj := objTmp as TUser;
      if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
        POP3 :=  hash.GetValue(userObj) as TIdPop3
      else
        while key.HasNext do
        begin
          userObj := key.GetObject as TUser;
          if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
          begin
            POP3 :=  hash.GetValue(userObj) as TIdPop3;
            break;
          end;
          key.Next;
        end;
    end;

    if Assigned(POP3) then
    begin
      Result := true;
      if not POP3.Connected then
      begin
        POP3.ConnectTimeout:=1500;
        POP3.Connect;
      end;
    end;
    user.FreeOnRelease;
  end;
end;

{ TODO -olwgboy -c�û����� :
��ȡ�ڴ��е�ǰ�û�����Ϣ��
���û��Ѿ���¼�󣬻����ڴ��н�����������Ҫ��ȡ�û���Ϣʱ�����ø÷�����ȡ�ڴ��и��û��Ļ�����Ϣ�� }
function GetUserAndNullToFirstPage(var currentUser:TUser;WhenNullToFirstPage:boolean=false):boolean;
var
  hash:THashMap;
  userSerializationStr:string;
  key:IIterator;
  user,userObj:TUser;
  objTmp:TObject;
begin
  Result := false;
  userSerializationStr := WebContext.Session.Values[TConfig.currentUserSession];
  if userSerializationStr<>'' then
  begin
    user := TUser.Create(nil);
    serialization.StrToComponent(userSerializationStr,user);
    hash := GetPOP3List;
    key := hash.KeySet.First;

    //�� Key Object ������
    if key<>nil then
    begin
      objTmp := key.GetObject;
      if objTmp=nil then exit;
      userObj := objTmp as TUser;
      if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
         currentUser := userObj
      else
        while key.HasNext do
        begin
          userObj := key.GetObject as TUser;
          if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
          begin
            currentUser := userObj;
            break;
          end;
          key.Next;
        end;
    end;

    if Assigned(currentUser) then
      Result := true;
    user.FreeOnRelease;
  end
  else
  begin
    if WhenNullToFirstPage then   //ת����ҳ�������µ�¼
    begin
       DispatchPageName('Main',WebContext.Response,[]);
       Main.Response.SendResponse;
    end;
  end;

end;

function GetUser(UserEmailAddress:String;var currentUser:TUser):boolean;
var
  hash:THashMap;
  userSerializationStr:string;
  key:IIterator;
  user,userObj:TUser;
  objTmp:TObject;
begin
  Result := false;
  userSerializationStr := WebContext.Session.Values[TConfig.currentUserSession];
  if userSerializationStr<>'' then
  begin
    user := TUser.Create(nil);
    serialization.StrToComponent(userSerializationStr,user);
    hash := GetPOP3List;
    key := hash.KeySet.First;

    //�� Key Object ������
    if key<>nil then
    begin
      objTmp := key.GetObject;
      if objTmp=nil then exit;
      userObj := objTmp as TUser;
      if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
         currentUser := userObj
      else
        while key.HasNext do
        begin
          userObj := key.GetObject as TUser;
          if (userObj.userName<>'') and (userObj.userName = user.userName) and (userObj.password = user.password) and (userObj.userMail=user.userMail) then
          begin
            currentUser := userObj;
            break;
          end;
          key.Next;
        end;
    end;

    if Assigned(currentUser) then
      Result := true;
    user.FreeOnRelease;
  end
  else if UserEmailAddress<>'' then
  begin
    user := TUser.Create(nil);
    hash := GetPOP3List;
    key := hash.KeySet.First;

    //�� Key Object ������
    if key<>nil then
    begin
      objTmp := key.GetObject;
      if objTmp=nil then exit;
      userObj := objTmp as TUser;
      if (userObj.userName<>'') and (userObj.userMail=UserEmailAddress) then
         currentUser := userObj
      else
        while key.HasNext do
        begin
          userObj := key.GetObject as TUser;
          if (userObj.userName<>'') and (userObj.userMail=UserEmailAddress) then
          begin
            currentUser := userObj;
            break;
          end;
          key.Next;
        end;
    end;

    if Assigned(currentUser) then
      Result := true;
    user.FreeOnRelease;
  end;
  if Result then
  WebContext.Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(currentUser);
end;



{ TODO -olwgboy -c�û����� : 
�����ڴ��е�ǰ�û�����Ϣ��
һ�����ڵ��û��Ѿ���¼���ٴε�½��ת���½ҳ��ʱ����ʱҪ��ȡ���ݿ����û���������Ϣ������������ڴ��еĸ��û���������״̬�� }
function UpdateUser(currentUser:TUser):boolean;
var
  hash:THashMap;
  userSerializationStr:string;
  key:IIterator;
  userObj:TUser;
  objTmp:TObject;
begin
  Result := false;
  if currentUser<>nil then
  begin
    hash := GetPOP3List;
    key := hash.KeySet.First;

    //�� Key Object ������
    if key<>nil then
    begin
      objTmp := key.GetObject;
      if objTmp=nil then exit;
      userObj := objTmp as TUser;
      if (userObj.userName<>'') and (userObj.userName = currentUser.userName) and (userObj.password = currentUser.password) then
      begin
         userObj := currentUser;
         Result := true;
      end
      else
        while key.HasNext do
        begin
          userObj := key.GetObject as TUser;
          if (userObj.userName<>'') and (userObj.userName = currentUser.userName) and (userObj.password = currentUser.password) then
          begin
            userObj := currentUser;
            Result := true;
            break;
          end;
          key.Next;
        end;
    end;

    if Result then //���³ɹ���Ҳһ��ͬ�����¸��û���Session������״̬
      WebContext.Session.Values[TConfig.currentUserSession] := ComponentToStr(currentUser);
  end;
end;

function GetPOP3:TIdPOP3;
begin
  if POP=nil then
    POP := TIdPOP3.Create(nil);
  result := POP;
end;

function GetPOP3List:THashMap;
begin
  if (POP3List=nil) then
     POP3List := THashMap.Create(50,true);
  Result := POP3List;
end;

function GetUserCurrentSelectMailConfig(var currentMailConfig:TMailConfig):Boolean;
var
  user:TUser;
  I: Integer;
begin
  Result := false;
  if GetUserAndNullToFirstPage(user) then
  begin
    for I := 0 to user.mailConfigArrayLength - 1 do
    begin
      if LowerCase(user.mailConfigArray[i].mailAddress) = LowerCase(user.currentSelectMail) then
      begin
        currentMailConfig := user.mailConfigArray[i];
        Result := true;
        break;
      end;
    end;
  end;
end;

class function Tlogin.LoginPOP3MailServer(user:TUser; mailConfig: TMailConfig;isFirstLogin:boolean=true):string;
var
  userPOP3:TIdPOP3;
  sslIOHandler:TIdSSLIOHandlerSocketOpenSSL;
//  currentUserSession :TCurrentUserSession;
begin
  userPOP3 := TIdPOP3.Create(nil);
  userPOP3.Host := mailConfig.pop3Server;
  userPOP3.Port := mailConfig.pop3Port;
  userPOP3.Username := mailConfig.mailAddress;  //�����ʼ���ַ���û��������ڸ����ʼ������ṩ�̶��������������ַ���û�����
  userPOP3.Password := mailConfig.mailPassword;
  if mailConfig.pop3SSL then
  begin
    sslIOHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(userPOP3);
    sslIOHandler.SSLOptions.Method := sslvTLSv1;

    userPOP3.IOHandler := sslIOHandler;
    userPOP3.UseTLS := utUseImplicitTLS;
    userPOP3.Port := mailConfig.pop3Port;
  end;
  try
    userPOP3.ConnectTimeout := 1500;
    userPOP3.Connect;
  except on E:Exception do
    begin
      Result := lowercase(StringReplace(E.Message,#13#10,' ',[rfReplaceAll]));
      if(Pos('not load ssl library',Result)>0) or (Pos('timed out',Result)>0) then  //�����޷����� SSL�� �� ��ʱ������������ԡ�
      try
         userPOP3.Connect;
      except on E:Exception do
        begin
           Result := lowercase(StringReplace(E.Message,#13#10,' ',[rfReplaceAll]));
           if (Pos('@',userPOP3.Username)>0)and((Pos('username',Result)>0) or (Pos('password',Result)>0)) then   //�������ַ�е��û���ȡ����Ϊ��¼ POP3 Server���û������������ӡ�
            begin
              userPOP3.Username := mailConfig.mailUserName;   //����ʱ�����ʼ���ַ@ǰ���û������û���,Exchange Ĭ�Ͻ�����@����ǰ�Ĳ������û�����
              try
                userPOP3.Connect;
                Result := '';
              except on E:Exception do
                Result := StringReplace(E.Message,#13#10,' ',[rfReplaceAll]);
              end;
            end;
        end;
      end
      else
      if (Pos('@',userPOP3.Username)>0)and((Pos('username',Result)>0) or (Pos('password',Result)>0)) then   //�������ַ�е��û���ȡ����Ϊ��¼ POP3 Server���û������������ӡ�
      begin
        userPOP3.Username := mailConfig.mailUserName;   //����ʱ�����ʼ���ַ@ǰ���û������û���,Exchange Ĭ�Ͻ�����@����ǰ�Ĳ������û�����
        try
          userPOP3.Connect;
          Result := '';
        except on E:Exception do
          Result := StringReplace(E.Message,#13#10,' ',[rfReplaceAll]);
        end;
      end;
    end;
  end;

  if userPOP3.Connected then
  begin
//    currentUserSession := TCurrentUserSession.create(self);
//    currentUserSession.userName := user.userName;
//    currentUserSession.password := user.password;
//    currentUserSession.userId := user.userId;
//    currentUserSession.userMail := user.userMail;
    user.currentSelectMail := mailConfig.mailAddress;
    //Session.Values[TConfig.currentUserSession] := ComponentToStr(user);
//    User := TUser.Create(nil);
//    User.userName := userPOP3.UserName;
//    User.password := userPOP3.Password;
    userPOP3.OnDisconnected := TEventHandlers.IdPOP3Disconnected;
    getPOP3List.PutValue(User,userPOP3);
    //Response.Content := IntToStr(POP3List.Values.Size)+'<br/>'+User.userName+'afdasdf';
    Result := '';
  end else
  begin
    userPOP3.Disconnect;
    try
      if userPOP3.IOHandler <> nil then
      begin
        if sslIOHandler <> nil then
        begin
          sslIOHandler.Close;
          sslIOHandler.Free;
        end;
      end;
    except on E:Exception do
      sslIOHandler := nil;
    end;
    sslIOHandler := nil;
    userPOP3.FreeInstance;
    userPOP3 := nil;
    //Response.Content := IntToStr(POP3List.Values.Size)+'<br/>'+User.userMail;
    //SafeRedirect(Response,'main?i=-1');
  end;
end;

procedure Tlogin.PageProducerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  currentUser:TUser;
  currentUserMailCount,//��ǰ�û�����������
  I: Integer;
  userPOP3:TIdPOP3;

  mailBoxList:TObjectList<TUserMailInBoxRec>;
  userInBox:DAO.UserMailInBox.TUserMailInBoxDAO;
  mailInBox: TUserMailInBoxRec;
  kv : TKeyValue;
begin
  if TagString='title' then
    ReplaceText := TXMLConfig.GetAppSettingTitle
  else
  if TagString=TConfig.SYS_MSG then
  begin
    ReplaceText := Session.Values[TConfig.SYS_MSG];
    Session.Values[TConfig.SYS_MSG] := '';
  end
  else
  if TagString = 'ms' then
    ReplaceText := session.SessionID+AppendUserInfo
  else
  if TagString = TConfig.mailBoxName then
  begin
    if GetUserAndNullToFirstPage(currentUser,true) then
      ReplaceText := currentUser.currentSelectMail;
  end
  else
  if TagString = TConfig.inBoxCount then
  begin
    if GetUserPOP3(userPOP3) then
      ReplaceText := IntToStr(userPOP3.CheckMessages);
  end
  else
  if (TagString = TConfig.outBoxCount) or (TagString = TConfig.draftBoxCount) then
  begin
    if GetUserAndNullToFirstPage(currentUser,true) then
    begin
      userInBox := DAO.UserMailInBox.TUserMailInBoxDAO.Create(self);
      userInBox.DatabaseName := TXMLConfig.DataBaseFullPath;
      userInBox.Password := TXMLConfig.GetPWD;
     
      if TagString = TConfig.outBoxCount then
         kv := TKeyValue.Create('int',integer(MailStatus.eAlreadySent)) //�������ż���
      else
         kv := TKeyValue.Create('int',integer(MailStatus.eWaitForSend));//�ݸ����ż���

      mailBoxList := userInBox.ReadMailBoxBy(currentUser.currentSelectMail,'Status',kv);
      ReplaceText := IntToStr(mailBoxList.Count);
      mailBoxList.Free;
      userInBox.Free;

    end;
  end
  else
  if TagString = 'userOtherMailList' then
  begin
    ReplaceText := '';
    if GetUserAndNullToFirstPage(currentUser,true) then
    begin
      if currentUser.mailConfigArrayLength>1 then
      begin
        ReplaceText := '-����������-';
        for I := 0 to currentUser.mailConfigArrayLength - 1 do
        begin
          if currentUser.mailConfigArray[I].mailAddress<>currentUser.currentSelectMail then
            ReplaceText := ReplaceText+ '<br/><a href="'+Request.InternalScriptName+Request.InternalPathInfo+'?ms='+Session.SessionID+AppendUserInfo+'&amp;i='+IntToStr(i)+'&amp;m='+currentUser.mailConfigArray[I].mailAddress+'">'+currentUser.mailConfigArray[I].mailAddress+'</a>';
        end;
        ReplaceText := ReplaceText+ '<br/>';
      end;
        
    end;
    //StrToComponent(Session.Values['mailList'],user.mailConfigArray[0]);
    //for I := 0 to user.mailList.MailConfigCount - 1 do
    begin

    end;

  end; 
end;

procedure Tlogin.WebPageModuleBeforeDispatchPage(Sender: TObject;
  const PageName: string; var Handled: Boolean);
var
  host,POP3Host,SMTPHost,mailAddress,mailBoxName,password,UID,userIdAndPassword:AnsiString;
  userPOP3:TIdPOP3;
  user:TUser;
  Iterator:IIterator;
  userId,POP3Port,SMTPPort,currentMailBoxIndex:integer;
  POP3SSL,SMTPSSL:boolean;
  sslIOHandler:TIdSSLIOHandlerSocketOpenSSL;
  AParams:TStringList;
  SessionID,temp:string;
  LoginMode :TLoginModeEnum;
  MailServerConfig:TMailConfig;
  loginResult:string;
  objList:TObjectList;
  testPOP3:TIdPOP3;
begin
  // Try to connect, which will test the username and password
  // against the mail server
  Response.ContentType := 'text/vnd.wap.wml;charset=utf-8';
  loginResult := 'error!';

  userIdAndPassword := Request.QueryFields.Values['up'];
  SessionID := Request.QueryFields.Values['ms'];
 
  //�ñ�������ǩ�еİ������û�����������ܴ���URL����½
  //������SessionID<>Session.SessionID��ȷ������û�е�½ʱִ��������λ����Ա����ظ���½
  //if (SessionID<>'') and (SessionID<>Session.SessionID) AND (userIdAndPassword<>'') then
  if (SessionID<>Session.SessionID) AND (userIdAndPassword<>'') then
  begin
    LoginMode := TLoginModeEnum.ByUserNameAndPassword;
    userIdAndPassword := ReplaceStr(userIdAndPassword,' ','+');//���֣�WebSnap��Ѵ�������+�ű�ɿո���ʱ�ٻ�ԭ��ȥ��
    if decryptUserInfo(userIdAndPassword,UID,Password) then
    begin
       if(StrToIntDef(UID,-1)=-1)then //�ж��Ƿ����ο�ͨ���ղؼ�ֱ�ӵ�½,��UID��������,��˵���Ƿ�ע���û�(�ο�),�οͱ���������û�����,��ע���û���������� Id
       begin  //���պ�����ο͵�½����
          LoginMode := TLoginModeEnum.ByGuest;
          host := Request.ContentFields.Values[TConfig.cPOP3Server];
          MailServerConfig := TMailConfig.create(owner);
          if not DataModule.WebDataModuleShare.ReadGuestMailServerConfig(UID,MailServerConfig) then //������ο��ʼ�������ʧ�ܣ��򷵻ص��ʼ�ϵͳ��ҳ�����û��Լ���������������½��
          begin
             DispatchPageName('main',Response,[]);
             Main.Response.SendResponse;
          end
          else
          begin
            if (not getUser(UID,user))and (Request.QueryFields.Values['lt']<>'6')then
            begin
              MailServerConfig.mailAddress := UID;
              MailServerConfig.mailPassword := Password;
              MailServerConfig.mailUserName := LeftStr(UID,Pos('@',UID)-1);
              user := TUser.Create(owner,1);
              user.mailConfigArray[0] := MailServerConfig;
              user.userMail := MailServerConfig.mailAddress;
              user.userName :=  MailServerConfig.mailUserName;
              user.password := MailServerConfig.mailPassword;
              user.currentSelectMail := MailServerConfig.mailAddress;
              loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
              if loginResult='' then
                Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
            end;
          end;
       end
       else
       begin //��ע���û�
         user := TUser.Create(nil);
         if WebDataModuleShare.login(StrToIntDef(UID,-100),password,user)then
         begin
           Session.Values['isLogin']:=true;
           loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
           if loginResult='' then;
             Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
         end
         else
         begin
            user.Free;  //û�гɹ���½�Ļ����ͷŵ�
            SafeRedirect(Response,'main?i=-1');
         end;
       end;
    end;
  end
  ELSE
  //��ħ�ŵ�¼(��:UserID+Password)
  if (Request.ContentFields.Values['MID']<>'') and (Request.ContentFields.Values['MPW']<>'') then
  begin
    LoginMode := TLoginModeEnum.ById;
    userId := StrToIntDef(trim(Request.ContentFields.Values['MID']),-1);
    password := Request.ContentFields.Values['MPW'];
    if userId=-1 then
    begin
      Config.SafeRedirectTo(Response,'Main#Login?card=Login&amp;i=-1');
      handled:=true;
      exit;
    end;
    user := TUser.Create(nil);
    if WebDataModuleShare.login(userId,password,user)then
    begin
      Session.Values['isLogin']:=true;
      loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
      if loginResult='' then;
      {
      Session.Values['mailList'] := ComponentToStr(user.mailConfigArray[0]);
      PageProducer.HTMLDoc.LoadFromFile(config.GetCurrentPath+'login_Success.wml');
      Response.Content := PageProducer.Content;
      Response.SendResponse;
      Handled := true;
      }
      Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
      //user.FreeOnRelease; //�ɹ���¼�����ͷ�User���������POP3List�С�
      exit;
    end
    else
    begin
      user.Free;  //û�гɹ���½�Ļ����ͷŵ�
      //SafeRedirect(Response,'main?i=-1');
      Config.SafeRedirectTo(Response,'Main#Login?card=Login&amp;i=-1');
    end;
    //setLength(user.mailList.MailConfigList,0);
  end
  else
  //��������Ϊ�û�����¼(��:abc@.cc+Password)
  if (Request.ContentFields.Values['MUID']<>'') and (Request.ContentFields.Values['MPWD']<>'') then
  begin
    LoginMode := TLoginModeEnum.ByEmail;
    mailAddress := trim(Request.ContentFields.Values['MUID']);
    password := Request.ContentFields.Values['MPWD'];
    if userId=-1 then
    begin
      exit;
    end;
    user := TUser.Create(nil);
    if WebDataModuleShare.login(mailAddress,password,user)then
    begin
      Session.Values['isLogin']:=true;
      loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
      if loginResult='' then;
        Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
    end
    else
    begin
      user.Free;  //û�гɹ���½�Ļ����ͷŵ�
      Config.SafeRedirectTo(Response,'main#MLogin?card=MLogin&amp;i=-1');
    end;
  end
  else //��¼�û��鿴�Լ�����������
  if (Request.QueryFields.Values['i']<>'') and (Request.QueryFields.Values['m']<>'') then
  begin
    currentMailBoxIndex := StrToIntDef(Request.QueryFields.Values['i'],0);
    if GetUserAndNullToFirstPage(user) and GetUserPOP3(userPOP3) then
    begin
      if userPOP3.Connected then userPOP3.Disconnect;
      if user.mailConfigArray[currentMailBoxIndex].pop3SSL then
      begin
        if (userPOP3.Port<>110) and (userPOP3.IOHandler<>nil) then //�ж��Ƿ���SSL��֤��½
        begin
          //�Ժ������
        end
        else
        begin
          sslIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(userPOP3);
          sslIOHandler.SSLOptions.Method := sslvTLSv1;
          userPOP3.IOHandler := sslIOHandler;
        end;
      end
      else
      begin
        if (userPOP3.Port<>110) and (userPOP3.IOHandler<>nil) then //�ж��Ƿ���SSL��֤��½
        begin
          userPOP3.IOHandler.Close;
          userPOP3.IOHandler.Free;
        end;
      end;
      userPOP3.Host := user.mailConfigArray[currentMailBoxIndex].pop3Server;
      userPOP3.Port := user.mailConfigArray[currentMailBoxIndex].pop3Port;
      userPOP3.Username := user.mailConfigArray[currentMailBoxIndex].mailUserName;
      userPOP3.Password := user.mailConfigArray[currentMailBoxIndex].mailPassword;
      user.currentSelectMail := user.mailConfigArray[currentMailBoxIndex].mailAddress;
    end
    else
      SafeRedirect(Response,'main?i=-1');
  end
  else //�ѵ�½�û�����ת����½ҳ
  if  (Request.ContentFields.Values[TConfig.cUserName]='') and  //�����ų��ӵ�½ҳ�ύ�û�������������½������������Ӹ��жϣ������û�û���˳�������´���ҳ���������������û����������½����ֱ�ӻ�ȡ���ż��ͻ�����ǰ��½���û��Ķ������µ�½���û��ģ���ͻᵼ�·Ƿ����������û��ʼ���
      GetUserAndNullToFirstPage(user) then
  begin
    if WebDataModuleShare.login(user.userId,user.password,user) then
        updateUser(user);
  end
  else
  if (SessionID=Session.SessionID) AND (userIdAndPassword<>'') then //�ο�����ͨ��ת�������û����ѵ�½�û����µ�½
  begin
    LoginMode := TLoginModeEnum.ByUserNameAndPassword;
    userIdAndPassword := ReplaceStr(userIdAndPassword,' ','+');//���֣�WebSnap��Ѵ�������+�ű�ɿո���ʱ�ٻ�ԭ��ȥ��
    if decryptUserInfo(userIdAndPassword,UID,Password) then
    begin
       if(StrToIntDef(UID,-1)=-1)then //�ж��Ƿ����ο�ͨ���ղؼ�ֱ�ӵ�½,��UID��������,��˵���Ƿ�ע���û�(�ο�),�οͱ���������û�����,��ע���û���������� Id
       begin  //���պ�����ο͵�½����
          LoginMode := TLoginModeEnum.ByGuest;
          host := Request.ContentFields.Values[TConfig.cPOP3Server];
          MailServerConfig := TMailConfig.create(owner);
          if not DataModule.WebDataModuleShare.ReadGuestMailServerConfig(UID,MailServerConfig) then //������ο��ʼ�������ʧ�ܣ��򷵻ص��ʼ�ϵͳ��ҳ�����û��Լ���������������½��
          begin
             DispatchPageName('main',Response,[]);
             Main.Response.SendResponse;
          end
          else
          begin
            //�п����û�û�б������뵽DB,����Ϊ�˱���������������ͨ������ͨ���������û���ֱ�ӽ�������������ַ��������Ϊ��½���估�����롣
            MailServerConfig.mailAddress := UID;
            MailServerConfig.mailPassword := Password;

            user := TUser.Create(nil,1);
            user.mailConfigArrayLength := 1;  //����������·���ĵ�½
            user.mailConfigArray[0] := MailServerConfig;
            user.userId := Config.TUserLoginMode.guestUserMapVlaue;
            user.userName := MailServerConfig.mailUserName;
            user.userMail := MailServerConfig.mailAddress;
            user.password := MailServerConfig.mailPassword;
            user.currentSelectMail := MailServerConfig.mailAddress;
            loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
            if loginResult='' then;
              Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
          end;
       end
       else
       begin //��ע���û�
         user := TUser.Create(nil);
         if WebDataModuleShare.login(StrToIntDef(UID,-100),password,user)then
         begin
           Session.Values['isLogin']:=true;
           loginResult := LoginPOP3MailServer(user,user.mailConfigArray[0]);
           if loginResult='' then;
             Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
         end
         else
         begin
            user.Free;  //û�гɹ���½�Ļ����ͷŵ�
            SafeRedirect(Response,'main?i=-1');
         end;
       end;
    end;
  end
  else //�ο���������
  if (Request.ContentFields.Values[TConfig.cPOP3Server]<>'') and (Request.ContentFields.Values[TConfig.cUserName]<>'') and (Request.ContentFields.Values[TConfig.cPassword]<>'') then
  begin
    POP3Port := 110;
    SMTPPort := 25;

    LoginMode := TLoginModeEnum.ByGuest;
    host := Request.ContentFields.Values[TConfig.cPOP3Server];
    case StrToIntDef(host,-1) of
      -1: begin
            POP3Host := 'mail.oceansoft.com.cn';
            SMTPHost := 'mail.oceansoft.com.cn';
            MailAddress := 'oceansoft.com.cn';
            POP3Port := 995;
          end;

       0: begin
            POP3Host := 'pop3.163.com';
            SMTPHost := 'smtp.163.com';
            MailAddress := '163.com';
          end;
       1: begin
            POP3Host := 'pop3.sina.com.cn';
            SMTPHost := 'smtp.sina.com.cn';
            MailAddress := 'sina.com.cn';
          end;
       2: begin
            POP3Host := 'pop3.sohu.com';
            SMTPHost := 'smtp.sohu.com';
            MailAddress := 'sohu.com';
          end;
       3: begin
            POP3Host := 'pop.google.com';
            SMTPHost := 'smtp.google.com';
            MailAddress := 'google.com';
          end;
       100: begin //ͨ�� cfg.xml �Զ�������
            POP3Host := config.TXMLConfig.GetAppSettingValueByKey('POP3Server');
            SMTPHost := config.TXMLConfig.GetAppSettingValueByKey('SMTPServer');
            MailAddress := config.TXMLConfig.GetAppSettingValueByKey('Domain');
            POP3Port := StrToIntDef(config.TXMLConfig.GetAppSettingValueByKey('POP3Port'),110);
            SMTPPort := StrToIntDef(config.TXMLConfig.GetAppSettingValueByKey('SMTPPort'),25);
            POP3SSL := iif(config.TXMLConfig.GetAppSettingValueByKey('POP3SSL')='true',true,false);
            SMTPSSL := iif(config.TXMLConfig.GetAppSettingValueByKey('SMTPSSL')='true',true,false);
          end;
    end;




    if (Request.ContentFields.Values[TConfig.cPOP3Port]<>'') then
      POP3Port := StrToInt(Request.ContentFields.Values[TConfig.cPOP3Port]);

    userPOP3 := TIdPOP3.Create(nil);
    userPOP3.Host := POP3Host;
    userPOP3.Port := POP3Port;

    mailBoxName := Request.ContentFields.Values[TConfig.cUserName];
    if Pos('@',mailBoxName)>0 then
      mailBoxName := StrUtils.LeftStr(mailBoxName,Pos('@',mailBoxName)-1);
    userPOP3.UserName := mailBoxName;

    userPOP3.Password := Request.ContentFields.Values[TConfig.cPassword];

    try
      try

        if POP3SSL then
        begin
          sslIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(userPOP3);
          sslIOHandler.SSLOptions.Method := sslvTLSv1;
          userPOP3.IOHandler := sslIOHandler;
          userPOP3.UseTLS := utUseImplicitTLS;
          userPOP3.Port := POP3Port;
          userPOP3.ConnectTimeout := 3500;
        end
        else
          userPOP3.ConnectTimeout := 2500;

        userPOP3.Connect;
      except on E:Exception do
        begin

          if (E.ClassType.ClassName='EIdProtocolReplyError') or POP3SSL then //Exchange2007 genernate error info:'Command is not valid in this state.'
          begin
            sslIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(userPOP3);
            sslIOHandler.SSLOptions.Method := sslvTLSv1;
            userPOP3.IOHandler := sslIOHandler;
            userPOP3.UseTLS := utUseImplicitTLS;
            userPOP3.Port := POP3Port;
            try
              //userPOP3.ConnectTimeout := 1500;
              userPOP3.Connect;
              loginResult := '';
            except on ex:Exception do
              begin
                loginResult := FormatSystemMessage(E.message,E.ClassType.ClassName);
                Session.Values[TConfig.SYS_MSG]:= loginResult;
              end;
            end;
          end
          else
          if E.ClassType.ClassName='EIdProtocolReplyError' then
          begin
             loginResult :=FormatSystemMessage(E.message,E.ClassType.ClassName);
             Session.Values[TConfig.SYS_MSG]:= loginResult;
          end
          else
          if (Pos('Ȩ��',e.Message)>0) and (pos('163.com',userPOP3.Host)>0) then begin
            user.Free;
            userPOP3.Free;
            AParams:=TStringList.Create;
            AParams.Add('i=-2');
            RedirectToPageName('login',AParams,Response,[dpPublished]);
            AParams.Free;
            loginResult := FormatSystemMessage(E.message+'<br/>˵��:����2007��12�·�֮��ע����������䲻֧�ָĹ��ܡ�',E.ClassType.ClassName);
            Session.Values[TConfig.SYS_MSG]:= loginResult;
            Handled := true;
          end
          else
          begin
             //if E.ClassType.ClassName='EIdReplyPOP3ErrorLogon' then
                loginResult := FormatSystemMessage(E.message,E.ClassType.ClassName);
             Session.Values[TConfig.SYS_MSG]:= loginResult;
          end;

          //AParams := TStringList.Create;
          //Aparams.Add('#demo');
          //RedirectToPageName('Main',Aparams,Response,[dpPublished]);

          //PageProducer.HTMLDoc.LoadFromFile(config.GetCurrentPath+'MainModule_Guest.wml');
          //Response.Content := config.GetCurrentPath+'<br/>'+Session.SessionID+AppendUserInfo+'$$$';//PageProducer.Content;
          //Response.Content:=PageProducer.Content;
          //Response.SendResponse;
          //Handled := true;

          if LoginMode=TloginModeEnum.ByEmail then
            DispatchPageName('Main',Response,[dpPublished])
          else
          if LoginMode=TLoginModeEnum.ById then
          begin
            //Config.SafeRedirectTo(Response,Request.InternalScriptName+'?rd='+FormatDateTime('yyyyhhmmhhmmss',now)+'#MLogin')
            //Config.SafeRedirectTo(Response,Request.InternalScriptName+'?rd='+IntToStr(Random(36500))+'#MLogin');
            Config.SafeRedirectTo(Response,Request.InternalScriptName+'#MLogin');
          end
          else
          if LoginMode=TLoginModeEnum.ByGuest then
          begin
            //Config.SafeRedirectTo(Response,Request.InternalScriptName+'?rd='+FormatDateTime('yyyyhhmmhhmmss',now)+'#demo')
            //Config.SafeRedirectTo(Response,Request.InternalScriptName+'?rd='+IntToStr(Random(36500))+'#demo')
            Config.SafeRedirectTo(Response,Request.InternalScriptName+'#demo')
          end
          else
            DispatchPageName('Main',Response,[dpPublished]);
          Handled := true;
        end;
      end;
    finally
      try
        //POP3.Disconnect;
      except
      end;
    end;

    // On a successful login, save the users information in a session.
    if userPOP3.Connected then
    begin
      user := TUser.Create(self,0);
      user.mailConfigArray[0].pop3Server := POP3Host;
      user.mailConfigArray[0].pop3Port := userPOP3.Port;
      user.mailConfigArray[0].smtpServer := SMTPHost;
      user.mailConfigArray[0].smtpPort := SMTPPort;
      user.mailConfigArray[0].mailUserName := userPOP3.Username;
      user.mailConfigArray[0].mailPassword := userPOP3.Password;
      user.mailConfigArray[0].mailAddress := userPOP3.UserName+'@'+MailAddress;

      user.userMail := userPOP3.UserName+'@'+MailAddress;
      user.userName := user.userMail;
      user.currentSelectMail := user.userMail;
      user.loginMode := TUserLoginMode.guest;
      user.password := userPOP3.Password;

      //User := TUser.Create(nil);
      //User.userName := POP3.UserName;
      //User.password := POP3.Password;

      //Session.Values['POP3'] := serialization.ComponentToStr(POP3);

      //Session.Values[TConfig.UserMailConfig] :=TJvTranslator.Create(nil).ComponentToXML(userPOP3,true);


     // Session.Values[TConfig.UserMailConfig] :=  XMLSerializer.SerilializeObjectToXML(userPOP3,[scTStrings],[soIncludeObjectLinks,soStoreParentInfo]);
      Session.Values[TConfig.UserMailConfig] := ComponentToStr(userPOP3);
      userPOP3.Disconnect;userPOP3.Free;
      testPOP3:=TIdPop3.Create(nil);
      //XMLSerializer.DeSerilializeObjectFromXML(testPOP3,VarToStr(Session.Values[TConfig.UserMailConfig]));
      testPOP3 := StrToComponent(VarToStr(Session.Values[TConfig.UserMailConfig]),testPOP3) as TIdPOP3;
      Session.Values[TConfig.cUserName] := userPOP3.UserName;
      Session.Values[TConfig.cPassword] := userPOP3.Password;
      Session.Values[TConfig.cSMTPServer] := SMTPHost;
      Session.Values[TConfig.cMailAddress]:= userPOP3.UserName+'@'+MailAddress;

      Session.Values[TConfig.currentUserSession] := serialization.ComponentToStr(user);
      user.FreeOnRelease;

      userPOP3.OnDisconnected := TEventHandlers.IdPOP3Disconnected;
      GetPOP3List.PutValue(User,userPOP3);


      if host='100' then
      begin
        MailServerConfig:=TMailConfig.create(self);
        MailServerConfig.pop3Server := POP3Host;
        MailServerConfig.smtpServer := SMTPHost;
        MailServerConfig.pop3Port := POP3Port;
        MailServerConfig.smtpPort := SMTPPort;
        MailServerConfig.pop3SSL := POP3SSL;
        MailServerConfig.smtpSSL := SMTPSSL;
        MailServerConfig.mailAddress := mailBoxName+'@'+MailAddress;
        MailServerConfig.mailUserName := mailBoxName;
        MailServerConfig.mailPassword := userPOP3.Password;
        MailServerConfig.smtpAuthencation := true;
        MailServerConfig.isDefault := true;
        WebDataModuleShare.InsertGuestMailServerConfig(MailServerConfig.mailAddress,MailServerConfig);
        MailServerConfig.Free;
      end;
      {
      //For Debug
      Iterator := POP3List.Values.First;
      while Iterator.HasNext do
        OutputDebugString(PChar(TIdPop3(Iterator.Next).Username));
      }

    end;
    //else
    //  SafeRedirect(Response,'main?i=-1');
  end
  else
  begin
    if(Request.Referer<>'')then
    begin
      if pos((Request.InternalScriptName+Request.PathInfo),Request.Referer)>0 then //��ֹ�ڱ�ҳ��ѭ�����е�¼
        exit;

      if(Request.Content = 'MUID=&MPWD=')then
        Config.SafeRedirectTo(Response,iif(Request.Referer<>'',ReplaceText(Request.Referer,'&','&amp;'),Request.InternalScriptName)+'#MLogin',false)
      else
      if(Pos('UID=&PWD=',Request.Content)>0) then
        Config.SafeRedirectTo(Response,iif(Request.Referer<>'',ReplaceText(Request.Referer,'&','&amp;'),Request.InternalScriptName)+'#demo',false)
      else
  //    if(Request.Content = 'MID=&MPW=')then
          Config.SafeRedirectTo(Response,iif(Request.Referer<>'',ReplaceText(Request.Referer,'&','&amp;'),Request.InternalScriptName),false);
    end
    else
      Config.SafeRedirectTo(Response,Request.InternalScriptName);

    Handled := true;
  end;


  if (Session.Values['isLogin']) and (SessionID='') and (userIdAndPassword='') then
  begin
    //SafeRedirect(Response,Request.InternalScriptName+'/login?ms='+Session.SessionID+AppendUserInfo);
    //AParams:=TStringList.Create;
    //AParams.Add('up='+AppendUserInfo);
    //RedirectToPageName('login',AParams,Response,[dpPublished]);
    //Handled := true;
    //Response.SendRedirect(Request.InternalScriptName+'/login?ms='+Session.SessionID+AppendUserInfo);

    PageProducer.HTMLDoc.LoadFromFile(config.GetCurrentPath+'relogin.wml');
    Response.Content := config.GetCurrentPath+'<br/>'+Session.SessionID+AppendUserInfo+'$$$';//PageProducer.Content;
    Response.SendResponse;
    Handled := true;
  end;
end;

procedure Tlogin.WebPageModuleCreate(Sender: TObject);
begin
  if POP=nil then
    POP := TIdPOP3.Create(nil);
  if(POP3List=nil) then
  POP3List := THashMap.Create(50,true);
end;

procedure Tlogin.WebPageModuleDeactivate(Sender: TObject);
begin
//  try
//    if POP.Connected then
//      POP.Disconnect;
//  except
//  end;
end;

procedure Tlogin.WebPageModuleDestroy(Sender: TObject);
var
  POP3Tmp:TIdPOP3;
  strx:TStringList;
begin
  try
    if POP.Connected then
      POP.Disconnect;
  except
  end;
  POP.FreeOnRelease;

  while POP3List.Values.First.HasNext do
  begin
    POP3Tmp := TIdPOP3(POP3List.Values.First.Next);
    POP3Tmp.Disconnect;
    POP3Tmp.FreeOnRelease; 
  end;
  POP3List.Clear;
  POP3List.FreeInstance;
end;

function AppendUserInfo(userName:string='';password:string='NULL'):string;
var
  user:TUser;
begin
  Result := '';
  if GetUserAndNullToFirstPage(user) then
  begin
    Result := '&amp;tm='+user.getLoginModeMapValue; //tmΪType����д��Ŀ����Ϊ�˱�ʾ��½ģʽTUserLoginMode,��Ϊ�˱�ʾ�û�����ʲô��ʽ��½�ġ�
    if (user.loginMode=TUserLoginMode.guest) or (user.userId=TUserLoginMode.guestUserMapVlaue) then
      Result := Result + '&amp;up='+Config.encryptUserInfo(user.userMail,user.password)
    else
      //Result := Result + '&amp;up='+Config.encryptUserInfo(user.userName,user.password);
      Result := Result + '&amp;up='+Config.encryptUserInfo(IntToStr(user.userId),user.password);
  end
  else
  if(userName<>'') then
    Result := '&amp;up='+Config.encryptUserInfo(userName,password);
end;

initialization
  if WebRequestHandler <> nil then
    WebRequestHandler.AddWebModuleFactory(TWebPageModuleFactory.Create(Tlogin, TWebPageInfo.Create([wpPublished {, wpLoginRequired}], '.wml'), crOnDemand, caCache)

);

end.
