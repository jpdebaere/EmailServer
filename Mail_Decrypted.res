        ��  ��                  �  4   H T M L   E R R O R 4 0 4       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="404" title="随身邮">
<p align="center">
对不起，没找到你期望的内容<#ERR404>，<a href="http://wap..cc">点这里返回首页</a>
-随身邮-<br/>
©.CC 2002-2008
<!-- #include file="return.wml" -->
</p>
</card></wml>
 �  8   H T M L   A D D M A I L B O X       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="card1" title="手机邮" newcontext="true">
<p>

邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<fieldset title="sss">
POP3服务器:<input name="pop" emptyok="false" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="smtp" emptyok="false" talbeindex="2"
</filedset>
用户名:<input name="muid" emptyok="false" tabindex="3" maxlength="250"/><br/>
密码:<input name="mpwd" emptyok="false" tableindex="4" maxlength="50"/><br/>
SMTP服务器需要认证:<input name="smtpAuth" type="checkbox"/><br/>
SMTP与邮箱登陆相同:<input name="smtpAuth" type="checkbox"/><br/>
SMTP用户名:<input name="smtpUID" maxlength="50"/><br/>
SMTP密码:<input name="smtpPWD" maxlength="50"/><br/>
POP3要求安全认证:<input name="POPSSL" type="checkbox"/><br/>
POP3端口:<input name="POPPort" value="110" format="*N" maxlenght="5" size="5"/><br/>
SMTP要求安全认证<input name="POPSSL" type="checkbox"/><br/>
SMTP端口:<input name="SMTPPort" value="25" format="*N" maxlenght="5" size="5"/><br/>

<anchor>保存
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="rcpnts" value="$(rcpnts)"/>
	<postfield name="sbjct" value="$(sbjct)"/>
	<postfield name="bdy" value="$(bdy)"/>
  </go>
</anchor> 
<!-- #include file="return.wml" -->
</p>
</card></wml>
  �  D   H T M L   A D D M A I L B O X _ F U N C S       0         function getPOP3(mailbox,prefix)
{  
	WMLBrowser.setVar("POP3",String.replace(mailbox,prefix,"pop3."));
}

function getSMTP(mailbox,prefix)
{
	WMLBrowser.setVar("SMTP",String.replace(mailbox,prefix,"smtp."));
}

function checkMail(mailbox)
{
	var pos = String.find(mailbox,"@");
	var result = false;	
	if (pos>0)
	{		
		if (String.elements(String.subString(mailbox,pos+1,String.length(mailbox)-pos),".")>=2)
			result = true;
	}
	if(!result)	
		Dialogs.alert("�����ַ("+mailbox+")��Ч!");
	return result;
}

extern function getSvr(mailbox)
{
	if(checkMail(mailbox))
	{
		var email = WMLBrowser.getVar("box");	
		var UserName = String.subString(email,0,String.find(email,"@"));
		WMLBrowser.setVar("UN",UserName);
		UserName = UserName + "@";
		getPOP3(email,UserName);
		getSMTP(email,UserName);	
		WMLBrowser.refresh();	
		WMLBrowser.go(String.replace(WMLBrowser.getCurrentCard(),"#crd1","#crd2"));
	}
}  \  \   H T M L   A D D N E W M A I L B O X F O R G U E S T M O D U L E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
您选择了POP3服务器要求SSL连接,其端口是:<input name="PP" value="995" size="5" format="*N" maxlength="5"/><br/>
您选择了SMTP服务器要求SSL连接,其端口是:<input name="SP" value="25" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="1"/>
	<postfield name="SS" value="1"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>�  X   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 1       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
<#commonActionTagName>
请输入您的邮箱全名(如:user@.cc):<br/>
邮箱全名:<input name="box" emptyok="false" tabindex="0" value="<#box>" maxlength="100"/><br/>
<anchor title="下一步">
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="$(box)"/>
  </go>下一步
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

�  `   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 1 _ B A K       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱设置步骤(1/3):<br/>
<#commonActionTagName>
第一步:输入您的邮箱全名(如:user@.cc):<br/>
邮箱全名:<input name="box" emptyok="false" tabindex="0" value="<#box>" maxlength="100"/><br/>
<anchor title="下一步">
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="$(box)"/>
  </go>下一步
</anchor>
</p>
</card></wml>

   �  X   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 2       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱设置步骤(1/3):<br/>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<#commonActionTagName>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<anchor title="下一步">
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="D" value="$(D)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>下一步
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

 Y  \   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 2 1         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<#box><br/>
<#commonActionTagName>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<anchor title="下一步">
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>下一步
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

   S  d   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 2 1 _ B A K         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱设置步骤(2/3):<br/>
邮箱全名:<#box><br/>
<#commonActionTagName>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<anchor title="下一步">
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>下一步
</anchor>
</p>
</card></wml>

 �  \   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 2 2         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>&amp;lt=<#lt>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="<#PSvr>"/>
	<postfield name="SSvr" value="<#SSvr>"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="<#SA>"/>
	<postfield name="PP" value="<#PP>"/>
	<postfield name="SP" value="<#SP>"/>
	<postfield name="PS" value="<#PS>"/>
	<postfield name="SS" value="<#SS>"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

    X   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
POP3服务器端口:<input name="PP" value="110" size="5" format="*N" maxlength="5"/><br/>
SMTP服务器端口:<input name="SP" value="25" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="0"/>
	<postfield name="SS" value="0"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

`  `   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 A L L         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
您选择了POP3服务器要求SSL连接,其端口是:<input name="PP" value="995" size="5" format="*N" maxlength="5"/><br/>
您选择了SMTP服务器要求SSL连接,其端口是:<input name="SP" value="25" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="1"/>
	<postfield name="SS" value="1"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

  `   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 A L L R       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="1">是</option>
	<option value="0">否</option>	
</select><br/>
SMTP要求SSL加密:
<select name="SS">
	<option value="1">是</option>
	<option value="0">否</option>		
</select><br/>
POP3服务器端口:<input name="PP" value="<#PP>" size="5" maxlength="5"/><br/>
SMTP服务器端口:<input name="SP" value="<#SP>" size="5" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

h  \   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 P S       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" talbeindex="2" maxlength="100"/><br/>
您选择了POP3服务器要求SSL连接,其端口是:<input name="PP" value="995" size="5" format="*N" matxlenghth="5"/><br/>
SMTP服务器端口:<input name="SP" value="25" size="5" format="*N"  maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="1"/>
	<postfield name="SS" value="0"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>&  `   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 P S R         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="1">是</option>
	<option value="0">否</option>		
</select><br/>
SMTP要求SSL加密:
<select name="SS">		
	<option value="0">否</option>	
	<option value="1">是</option>
</select><br/>
POP3服务器端口:<input name="PP" value="<#PP>" size="5" format="*N" maxlength="5"/><br/>
SMTP服务器端口:<input name="SP" value="<#SP>" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

  k  \   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 S S       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" talbeindex="2" maxlength="100"/><br/>
POP3服务器端口:<input name="PP" value="110" size="5" format="*N" matxlenghth="5"/><br/>
您选择了SMTP服务器要求SSL连接,其端口是:<input name="SP" value="25" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="0"/>
	<postfield name="SS" value="1"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

 '  `   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 3 S S R         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>游客体验通道</u></b><br/>
邮箱全名:<b><#box></b><br/>
<#commonActionTagName>
邮箱密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<i><b>提示:</b>以下设置若与您的邮件服务器配置相同则无须更改，直接选<b>下一步</b></i><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" maxlength="100"/><br/>
POP3要求SSL加密:
<select name="PS">	
	<option value="0">否</option>		
	<option value="1">是</option>
</select><br/>
SMTP要求SSL加密:
<select name="SS">		
	<option value="1">是</option>
	<option value="0">否</option>	
</select><br/>
POP3服务器端口:<input name="PP" value="<#PP>" size="5" format="*N" maxlength="5"/><br/>
SMTP服务器端口:<input name="SP" value="<#SP>" size="5" format="*N" maxlength="5"/><br/>

SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>

<anchor title="完成">完成
  <go accept-charset="utf-8" href="<%=Pages.NewGuest.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(SSvr)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

 ^  X   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 4       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="success" title="手机邮" newcontext="true">
<p>
<b><u>游客体验通道</u></b><br/>
恭喜!您可以使用手机邮箱!<br/>
为了方便您下次直接登陆邮箱而无需再次配置,你可以将当前页面加入您的手机书签,下次你只需打开该书签即可直接登陆。
<br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>&amp;up=<#up>">转到收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>

  �  \   H T M L   A D D N E W M A I L B O X F O R G U E S T S T E P 4 2         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="success" title="手机邮" newcontext="true">
<p>
<b><u>游客体验通道</u></b><br/>
恭喜,成功登陆!<br/>
<br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>&amp;up=<#up>">点这里到收件箱</a>
</p>
<!-- #include file="return.wml" -->
</card>
</wml>

�  L   H T M L   A D D N E W M A I L B O X M O D U L E _       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="">
<p>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<fieldset title="Server">
POP3服务器:<input name="PSvr" emptyok="false" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" emptyok="false" talbeindex="2" maxlength="100"/><br/>
</filedset>
用户名:<input name="MUID" emptyok="false" tabindex="3" maxlength="100"/><br/>
密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25"/><br/>
SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>
POP3端口:<input name="PP" value="110" size="5" matxlenghth="5"/><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP端口:<input name="SP" value="25" size="5" maxlength="5"/><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<do type="accept" label="保存" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.add.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(PSvr)"/>
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</do>
</p>
</card></wml>

'  L   H T M L   A D D N E W M A I L B O X S T A T U S         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="success" title="保存成功" newcontext="true">
<p>
保存成功！<br/>
<a href="<%=Pages.login.HREF%>">转到收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="failure" title="保存失败！" newcontext="true">
<p>
保存失败！<br/>
<do type="prev" label="返回" name="back">
  <prev/>
</do>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>

 ]  \   H T M L   A D D N E W M A I L B O X S T A T U S _ F A I L U R E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="failure" title="" newcontext="true">
<p>
保存失败！<br/><#errorMsg>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>

   c  \   H T M L   A D D N E W M A I L B O X S T A T U S _ S U C C E S S         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="success" title="保存成功" newcontext="true">
<p>
保存成功！<br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">转到收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>

 "  H   H T M L   A D D N E W M A I L B O X S T E P 1       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<#commonActionTagName>
设为默认邮箱
<select name="D">
	<option value="1">是</option>
	<option value="0">否</option>
</select><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<anchor type="accept" label="下一步" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.add.HREF%>?ms=<#ms>&amp;s=1" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="D" value="$(D)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>下一步
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

  (  H   H T M L   A D D N E W M A I L B O X S T E P 2       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
邮箱全名:<#box><br/>
POP3服务器:<input name="PSvr" value="<#PSvr>" emptyok="false" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="<#SSvr>" emptyok="false" talbeindex="2" maxlength="100"/><br/>
用户名:<input name="MUID" value="<#MUID>" emptyok="false" tabindex="3" maxlength="100"/><br/>
密码:<input name="MPWD" value="<#MPWD>" emptyok="false" tableindex="4" maxlength="25"/><br/>
SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>
POP3端口:<input name="PP" value="<#PP>" size="5" format="*N" matxlenghth="5"/><br/>
SMTP端口:<input name="SP" value="<#SP>" size="5" format="*N" maxlength="5"/><br/>
<anchor>保存
  <go accept-charset="utf-8" href="<%=Pages.add.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="<#box>"/>
	<postfield name="D" value="<#D>"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(PSvr)"/>
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="PS" value="<#PS>"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="SS" value="<#SS>"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

.   0   H T M L   A L E R T         0         ��ʱ��ط�����������,���� .CC !<br/><br/>  �   <   H T M L   A L E R T _ E R R O R         0         ֪ͨ�������ϸ��µ�һ������漰Ȩ�����⣬��ʹ�ֻ�����ʱ�޷�����ʹ�ã�����ץ��������Ԥ������4��ָ����������ɴ���ɵĲ��㣬���Ǹ�⡣<br/>]  4   H T M L   D E F A U L T         0         ﻿<?xml version="1.0"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml"><wml><card id="card1" title="" newcontext="true"><p><a href="/wapmail2010/WapMail.dll/inBox?ms=eOSpxjFvZ5m1Z62B&amp;p=2">下</a>
<a href="/wapmail2010/WapMail.dll/inBox?ms=eOSpxjFvZ5m1Z62B&amp;p=1385">尾</a>
<br/>
<select name="time1" title="time1" multiple="true" tabindex="0">
<option value="1">08-10-26 01:07</option>
</select>
<select name="time2" title="time2" multiple="true" tabindex="0">
<option value="1">08-10-26 01:07</option>
</select>

</p></card></wml>   �  <   H T M L   D E T A I L 0 7 1 2 2 6       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="crd0" title="Wap..CC" newcontext="false">
<do type="accept" label="答复" name="reply">
  <go accept-charset="utf-8" href="#crd1" method="post"></go>
</do>
<do type="accept" label="全部答复" name="allReply">
  <go accept-charset="utf-8" href="#crd2" method="post"></go>
</do>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="#crd3" method="post"></go>
</do>
发件人:<input name="SND" value="<#sender>"/><br/>
日期:<#time><br/>
收件人:<input name="RCPT" value="<#recipients>"/><br/>
主题:<input name="SBJCT" value="<#subject>"/><br/>
<#attatchment>
<input name="BDY" value="<#body>"/><br/>
</card>
<card id="crd1" title="Wap..CC" newcontext="false">
收件人:<input name="R" value="$SND"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value=""/><br/>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd2" title="Wap..CC" newcontext="false">
收件人:<input name="R" value="$SND;$RCPT"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value=""/><br/>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd3" title="Wap..CC" newcontext="false">
收件人:<input name="R" value=""/><br/>
主题:<input name="S" value="Fw:$SBJCT"/><br/>
内容:<input name="C" value="$BDY"/><br/>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
</wml>

 8  @   H T M L   D E T A I L 2 0 0 7 1 2 2 7       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="crd0" title="Wap..CC" newcontext="false">
<do type="accept" label="答复" name="reply">
  <go href="#crd1"/>
</do>
<do type="accept" label="全部答复" name="allReply">
  <go href="#crd2"/>
</do>
<do type="option" label="转发" name="allReply">
  <go href="#crd3"/>
</do>
<p>
发件人:<input name="SND" value="<#sender>"/><br/>
日期:<#time><br/>
收件人:<input name="RCPT" value="<#recipients>"/><br/>
主题:<input name="SBJCT" value="<#subject>"/><br/>
<#attatchment>
</p>
<input name="BDY" value="<#body>"/><br/>
</card>
<card id="crd1" title="Wap..CC" newcontext="false">
<p>
收件人:<input name="R" value="$SND"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value=""/><br/>
</p>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd2" title="Wap..CC" newcontext="false">
<p>
收件人:<input name="R" value="$SND;$RCPT"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value=""/><br/>
</p>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd3" title="Wap..CC" newcontext="false">
<p>
收件人:<input name="R" value=""/><br/>
主题:<input name="S" value="Fw:$SBJCT"/><br/>
内容:<input name="C" value="$BDY"/><br/>
</p>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
</wml>

�  <   H T M L   D E T A I L M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="crd" title="手机邮" onenterforward="#crd0" onenterbackward="#crd0" newcontext="true">
<input name="SND" value="<#sender>" />
<input name="RCPT" value="<#recipients>" />
<input name="SBJCT" value="<#subject>" />
</card>
<card id="crd0" title="手机邮" newcontext="false">
<a href="#crd1">答复</a>
<a href="#crd2">全部答复</a>
<a href="#crd3">转发</a>

<p>
<b>发自:</b>$(SND) <br/>
<b>时间:</b><#time> <br/>
<b>签收:</b>$(RCPT) <br/>
<b>主题:</b>$(SBJCT) <br/>
<#attachment>
<#body><br/>
<a href="<%=Pages.detail.HREF%>?ms=<#ms>&amp;id=<#id>&amp;cp=1&amp;lp=<#mailListPage>"><#firstPageText></a>
<a href="<%=Pages.detail.HREF%>?ms=<#ms>&amp;id=<#id>&amp;cp=<#prevPage>&amp;lp=<#mailListPage>"><#prevPageText></a>
<a href="<%=Pages.detail.HREF%>?ms=<#ms>&amp;id=<#id>&amp;cp=<#nextPage>&amp;lp=<#mailListPage>"><#nextPageText></a>
<a href="<%=Pages.detail.HREF%>?ms=<#ms>&amp;id=<#id>&amp;cp=<#lastPage>&amp;lp=<#mailListPage>"><#lastPageText></a><br/>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>&amp;p=<#mailListPage>">返回邮件列表</a><br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">返回收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="crd1" title="手机邮" newcontext="false">
<p>
<b>收件人:</b><input name="R" value="$SND" /><br/>
<b>主题:</b><input name="S" value="Re:$SBJCT" /><br/>
<b>内容:</b><input name="C" value=""/><br/>
<anchor>发送
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$R" />
	<postfield name="S" value="$S" />
	<postfield name="C" value="$C" />
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="crd2" title="手机邮" newcontext="false">
<p>
<b>收件人:</b><input name="R" value="$SND;$RCPT" /><br/>
<b>主题:</b><input name="S" value="Re:$SBJCT" /><br/>
<b>内容:</b><input name="C" value=""/><br/>
<anchor>发送
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$R" />
	<postfield name="S" value="$S" />
	<postfield name="C" value="$C" />
  </go>
</anchor>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>&amp;p=<#mailListPage>">返回邮件列表</a><br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">返回收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="crd3" title="手机邮箱" newcontext="false">
<p>
<b>收件人:</b><input name="R" value=""/><br/>
<b>主题:</b><input name="S" value="Fw:$SBJCT" /><br/>
<b>内容:</b><input name="C" value="$BDY" /><br/>
<anchor>转发
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$R" />
	<postfield name="S" value="$S" />
	<postfield name="C" value="$C" />
  </go>
</anchor>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>&amp;p=<#mailListPage>">返回邮件列表</a><br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">返回收件箱</a>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>

�  4   H T M L   D E T A I L _         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="card1" title="Wap..CC" newcontext="true">
<do type="accept" label="答复" name="reply">
  <go accept-charset="utf-8" href="<%=Pages.write.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<do type="accept" label="全部答复" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.write.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.write.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<do type="accept" label="转发" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.write.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
发件人:<#sender><br/>
日期:<#time><br/>
收件人:<#recipients><br/>
主题:<#subject><br/>
<#attatchment>
<#body><br/>
</card></wml>

�  8   H T M L   D E T A I L _ A L L       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="crd0" title="Wap..CC" newcontext="true">
<do type="accept" label="答复" name="reply">
  <go accept-charset="utf-8" href="#crd1" method="post"></go>
</do>
<do type="accept" label="全部答复" name="allReply">
  <go accept-charset="utf-8" href="#crd2" method="post"></go>
</do>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="#crd3" method="post"></go>
</do>
发件人:<input name="SND" value="<#sender>"/><br/>
日期:<#time><br/>
收件人:<input name="RCPT" value="<#recipients>"/><br/>
主题:<input name="SBJCT" value="<#subject>"/><br/>
<#attatchment>
<input name="BDY" value="<#body>"/><br/>
</card>
<card id="crd1" title="Wap..CC" newcontext="false">
收件人:<input name="R" value="$SND"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value="$BDY"/><br/>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd2" title="Wap..CC" newcontext="false">
收件人:<input name="R" value="$SND;$RCPT"/><br/>
主题:<input name="S" value="Re:$SBJCT"/><br/>
内容:<input name="C" value="$BDY"/><br/>
<do type="accept" label="发送" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
<card id="crd3" title="Wap..CC" newcontext="false">
收件人:<input name="R" value=""/><br/>
主题:<input name="S" value="Fw:$SBJCT"/><br/>
内容:<input name="C" value="$BDY"/><br/>
<do type="accept" label="转发" name="allReply">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="R" value="$R"/>
	<postfield name="S" value="$S"/>
	<postfield name="C" value="$C"/>
  </go>
</do>
</card>
</wml>

  $  <   H T M L   E D I T M A I L B O X         0         ﻿<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.2//EN" "http://www.wapforum.org/DTD/wml12.dtd">
<wml><card id="crd" title="手机邮" newcontext="true">
<p>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100" value="<#MailBox>"/><br/>
<fieldset title="Server">
POP3服务器:<input name="PSvr" emptyok="false" tabindex="1" maxlength="100" value="<#POP3Server>"/><br/>
SMTP服务器:<input name="SSvr" emptyok="false" talbeindex="2" maxlength="100" value="<#SMTPServer>"/><br/>
</filedset>
用户名:<input name="MUID" emptyok="false" tabindex="3" maxlength="100" value="<#MailUserId>"/><br/>
密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25" value="<#MailPassword>"/><br/>
SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<#IsSMTPAuthention>
	</optgroup>
</select><br/>
POP3端口:<input name="PP" value="110" size="5" format="*N" matxlenghth="5" value="<#POP3Port>"/><br/>
POP3要求SSL加密:
<select name="PS">
	<#IsPOP3SSL>
</select><br/>
SMTP端口:<input name="SP" value="25" size="5" format="*N" maxlength="5" value="<#SMTPPort>"/><br/>
SMTP要求SSL加密:
<select name="SS">
	<#IsSMTPSSL>
</select><br/>
<anchor>保存
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(PSvr)"/>
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>

�  8   H T M L   F O R G E T P W D         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="忘记魔号/密码" newcontext="true">
<p>
作为我们尊贵的用户,请不要着急,我们提供了尽可能多的通道助你找到密码,仔细对号入座,你一定可以很快找回的。<br/>
<b>A、仅忘记魔号</b><br/>
选择首页中的以邮箱作为用户名登录，进入后会看到你的魔号。<br/>
<b>B、忘记了密码</b><br/>
选择首页中的游客试用邮箱,选择邮箱服务商,输入邮箱名和你的邮箱密码,登陆后查看注册系统时发给你的激活帐号邮件,里面有你的密码。若你的邮箱不再列表中,请选该页中的高级登陆通道,设置好各项参数后登陆你的邮箱查找。<br/>
<b>C、魔号和密码都忘记了</b><br/>
参见上条<i>[B、忘记了密码]</i>的解决方案.<br/>
<b>D、以上都不成吗？</b><br/>
请将注册时的邮箱及相关信息发到到<b>i@.cc</b>，注明[“找回密码”],24小时内你会收到一封包含了你的魔号和相应密码的邮件。
另外，作者以后也会陆续推出更多的方法助你找回遗失的密码。<br/>
<b>E、密码被锁定了？</b><br/>
注册后,你没有激活你的帐户的话,密码有效期只有一个月,所以请尽快激活你的帐号。一旦被锁定你可以将注册时的邮箱发到<b>i@.cc</b>,并注明[“密码锁定”],24小时内系统会给你恢复使用,但没激活前,密码仍然只能使用一个月,所以注册后请尽快激活你的帐号。
<!-- #include file="return.wml" -->
</p>
</card></wml>

   #  ,   H T M L   H E L P       0         <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="ħ���ֻ���" newcontext="true">
<p>
<#info>
��վ���з�������ȫ��ѵġ�<br/>
������ϵͳ���԰�������ʱ���շ����ĸ��������е��ʼ���<br/>
��ע���û�����ͨ��[�ο�����ͨ��]������������,�������������̲��������б���ʱ,��ͨ��[���������½]ͨ��������ʾһ������ɸ���������趨֮�󼴿ɵ�½������䡣<br/>
ע���û�,�ɱ���������ĸ��ֲ�����Ϣ�Ӷ�ʵ�ֿ��ٵ�½,�����ÿ�ε�½���䶼Ҫ�����û���/����/ĥ�ŵȹ��̡�<br/>
��ϵͳ�ڲ��ϸ�����,ʹ�ù����������������ʻ򲻳ɹ���,�뷢�ʼ���<b>i@.cc</b>,24Сʱ�����õ�����Ĵ𸴡�<br/>
ף�㹤�����,�õĿ��ģ�
</p>
<a href="/">������ҳ</a>
<!-- #include file="return.wml" -->
</card></wml>

   <   H T M L   I N B O X M O D U L E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="card1" title="手机邮" newcontext="false">
<p>
<#info>
<a href="/WapMail.WapMail/inBoxModule?p=2">下</a>
<a href="/WapMail.WapMail/inBoxModule?p=3">下</a>
<a href="">高级登陆入口</a>
<select name="POP" title="选择服务商" tabindex="1">
  <option value="-1">邮箱</option>
  <option value="0">网易邮箱</option>
  <option value="1">新浪邮箱</option>
  <option value="2">搜虎邮箱</option>
</select><br/>
用户名:<input name="UID" emptyok="false" tabindex="2" size="20"/><br/>
密　码:<input name="PWD" emptyok="false" type="password" tabindex="3" size="20"/>
<anchor>登陆
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</anchor>
<anchor>撤消
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</anchor>
<!-- #include file="return.wml" -->
</p>
</card></wml>   T   ,   H T M L   I N F O       0         <br/>�κ������뷢�ʼ��� i@.cc�����ǻᾡ��������Ӧ !<br/>
ף������ÿһ�� !<br/>�  <   H T M L   L O G I N M O D U L E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="card1" title="手机邮" newcontext="false">
<p>
--当前邮箱--<br/>
<#mailBoxName><br/>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>">收件箱(<#inBoxCount>)</a><br/>
<a href="<%=Pages.write.HREF%>?ms=<#ms>">撰写新邮件</a><br/>
<a href="<%=Pages.outBox.HREF%>?ms=<#ms>&amp;mt=1">发件箱(<#outBoxCount>)</a><br/>
<a href="<%=Pages.outBox.HREF%>?ms=<#ms>&amp;mt=2">草稿箱(<#draftBoxCount>)</a><br/>
<a href="<%=Pages.set.HREF%>?ms=<#ms>">系统设置</a><br/>
<!--
<a href="#">垃圾箱</a><br/>
<a href="#">已删除邮件</a><br/>
-->
<#userOtherMailList>
<!--<a href="<%=Pages.action.HREF%>?ms=<#ms>&amp;ac=addNewMailBoxStep1">添加其它邮箱</a>--><br/>
<!-- #include file="return.wml" -->
</p>
</card>
</wml>     @   H T M L   L O G I N _ S U C C E S S         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="list" title="手机邮箱" newcontext="false">
<#mailList>
<!-- #include file="return.wml" -->
</card>
</wml>   �  8   H T M L   M A I N M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="demo" title ="手机邮" newcontext="true">
<p>
<#info card=demo>
<!-- #include file="alert.wml" -->
<select name="POP" title="选择服务商" tabindex="1">
  <option value="0">网易</option>
  <option value="2">搜虎</option>
  <option value="1">新浪</option>
  <option value="-1"></option>
</select><br/>
<#SYSMSG>
邮箱地址:<input name="UID" emptyok="true" maxlength="25" /><br/>
邮箱密码:<input name="PWD" emptyok="true" type="password" maxlength="25" />
<anchor title="登陆">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>登录
</anchor><br/>
<a href="<%=Pages.NewGuest.HREF%>">更多邮箱登陆</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册更精彩！</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册更精彩！</a><br/>
<!-- #include file="info.wml" -->
<!-- #include file="return.wml" -->
</p>
</card>
</wml>
  H   H T M L   M A I N M O D U L E 2 0 0 8 0 2 0 7       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="随身邮" newcontext="true">
<p>
<#info>
<a href="#MLogin">用邮箱作用户名登录</a><br/>
魔号:<input name="MID" emptyok="false" format="10N" maxlength="10"/><br/>
密码:<input name="MPW" emptyok="false" format="10" maxlength="10"/><br/>
<do type="accept" label="登陆" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MID" value="$(MID)"/>
	<postfield name="MPW" value="$(MPW)"/>
  </go>
</do>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<a href="<%=Pages.reg.HREF%>">免费注册魔号</a><br/>
<a href="#demo">游客试用邮箱</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a>
</p>
</card>
<card id="MLogin" title="随身邮" newcontext="true">
<p>
<#info>
<a href="#login">用魔号快速登录</a><br/>
信箱:<input name="MUID" emptyok="false" maxlength="25"/><br/>
密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<do type="accept" label="登陆" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
  </go>
</do>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<a href="<%=Pages.reg.HREF%>">免费注册魔号</a><br/>
<a href="#demo">游客试用邮箱</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a>
</p>
</card>
<card id="demo" title ="Mail..CC" newcontext="false">
<select name="POP" title="选择服务商" tabindex="1">
  <option value="-1">测试邮箱</option>
  <option value="0">网易邮箱</option>
  <option value="1">新浪邮箱</option>
  <option value="2">搜虎邮箱</option>
</select><br/>
<p>
信箱名:<input name="UID" emptyok="false" maxlength="25" /><br/>
密　码:<input name="PWD" emptyok="false" type="password" maxlength="25" />
<do type="accept" label="登陆" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do><br/>
<a href="<%=Pages.reg.HREF%>">免费注册更精彩！</a><br/>
<a href="<%=Pages.reg.HREF%>">其它邮箱登陆通道</a>
<do type="prev" label="返回" name="back"><prev/></do>
</p>
</card></wml>

 �  @   H T M L   M A I N M O D U L E _ B A K       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="手机邮" newcontext="true">
<p>
<#info card=Login>
<!-- #include file="alert.wml" -->
<a href="#MLogin">用邮箱作用户名登录</a><br/>
魔号:<input name="MID" emptyok="false" format="N" maxlength="10"/><br/>
密码:<input name="MPW" emptyok="false" maxlength="15"/><br/>
<anchor title="登陆">登陆
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MID" value="$(MID)"/>
	<postfield name="MPW" value="$(MPW)"/>
  </go>
</anchor><br/>
<a href="#demo">游客体验通道</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册魔号</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册魔号</a><br/>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="MLogin" title="手机邮" newcontext="true">
<p>
<#info card=MLogin>
<a href="#login">用魔号快速登录</a><br/>
在注册时所填的邮箱:<input name="MUID" emptyok="false" maxlength="25"/><br/>
在注册时所设的密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<anchor>登录
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
  </go>
</anchor><br/>
<a href="#demo">游客体验通道</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册魔号</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册魔号</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a><br/>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="demo" title ="手机邮" newcontext="true">
<select name="POP" title="选择服务商" tabindex="1">
  <option value="0">网易邮箱</option>
  <option value="2">搜虎邮箱</option>
  <option value="1">新浪邮箱</option>
  <option value="-1">邮箱</option>
</select><br/>
<p>
<#SYSMSG>
邮箱地址:<input name="UID" emptyok="false" maxlength="25" /><br/>
邮箱密码:<input name="PWD" emptyok="false" type="password" maxlength="25" />
<anchor title="登陆">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>登录
</anchor><br/>
<a href="<%=Pages.NewGuest.HREF%>">更多邮箱登陆</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册更精彩！</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册更精彩！</a><br/>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card></wml> b  L   H T M L   M A I N M O D U L E _ G O O D _ A L L         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="手机邮" newcontext="true">
<p>
<#info card=Login>
<!-- #include file="alert.wml" -->
<a href="#MLogin">用邮箱作用户名登录</a><br/>
魔号:<input name="MID" emptyok="false" format="N" maxlength="10"/><br/>
密码:<input name="MPW" emptyok="false" maxlength="15"/><br/>
<anchor title="登陆">登陆
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MID" value="$(MID)"/>
	<postfield name="MPW" value="$(MPW)"/>
  </go>
</anchor><br/>
<a href="#demo">游客体验通道</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册魔号</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册魔号</a><br/>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="MLogin" title="手机邮" newcontext="true">
<p>
<#info card=MLogin>
<a href="#login">用魔号快速登录</a><br/>
在注册时所填的邮箱:<input name="MUID" emptyok="false" maxlength="25"/><br/>
在注册时所设的密码:<input name="MPWD" emptyok="false" maxlength="25"/><br/>
<anchor>登录
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
  </go>
</anchor><br/>
<a href="#demo">游客体验通道</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册魔号</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册魔号</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a><br/>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<!-- #include file="return.wml" -->
</p>
</card>
<card id="demo" title ="手机邮" newcontext="true">
<p>
<select name="POP" title="选择服务商" tabindex="1">
  <option value="0">网易</option>
  <option value="2">搜虎</option>
  <option value="1">新浪</option>
  <option value="-1"></option>
</select><br/>
<#SYSMSG>
邮箱地址:<input name="UID" emptyok="false" maxlength="25" /><br/>
邮箱密码:<input name="PWD" emptyok="false" type="password" maxlength="25" />
<anchor title="登陆">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>登录
</anchor><br/>
<a href="<%=Pages.NewGuest.HREF%>">更多邮箱登陆</a><br/>
<!--<a href="<%=Pages.reg.HREF%>">免费注册更精彩！</a>--><a href="<%=Pages.action.HREF%>?ac=stopRegUser">免费注册更精彩！</a><br/>

<!-- #include file="return.wml" -->
</p>
</card>
</wml>  t  D   H T M L   M A I N M O D U L E _ G U E S T       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="demo" title ="手机邮" newcontext="false">
<select name="POP" title="选择服务商" tabindex="1">
  <option value="-1">测试邮箱</option>
  <option value="0">网易邮箱</option>
  <option value="1">新浪邮箱</option>
  <option value="2">搜虎邮箱</option>
</select><br/>
<p>
<#SYSMSG>
信箱名:<input name="UID" emptyok="false" maxlength="25" /><br/>
密　码:<input name="PWD" emptyok="false" type="password" maxlength="25" />
<anchor type="accept" label="登陆" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</anchor><br/>
<a href="<%=Pages.reg.HREF%>">免费注册更精彩！</a><br/>
<a href="<%=Pages.reg.HREF%>">更多其它邮箱登陆通道</a>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card></wml>

�   <   H T M L   O U T B O X M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="card1" title="" newcontext="true">
outbox
<!-- #include file="return.wml" -->
</card></wml>
6  4   H T M L   R E G I S T E R       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="手机邮" newcontext="true">
<p>
<b><u>注册手机邮</u></b><br/>
<#info>
邮箱全称:<br/>
<input name="MID" emptyok="false" maxlength="25"/><br/>
密码(只能是数字):<br/><input name="MUID" emptyok="false" format="10N"/><br/>
再输入一遍密码:<br/><input name="MPWD" emptyok="false" format="10N"/><br/>
<do type="accept" label="注册" name="btReg">
  <go href="<%=Pages.reg.HREF%>" method="post">
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
  </go>
</do>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card></wml>

  p  @   H T M L   R E G I S T E R M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="手机邮" newcontext="true">
<p>
<b><u>注册手机邮箱</u></b><br/>
<#info>
<#SYSMSG>
邮箱全称:<br/>
<input name="MUID" emptyok="false" maxlength="25"/><br/>
密&nbsp;&nbsp;&nbsp;&nbsp;码:<br/><input name="MPWD" emptyok="false" format="10x"/><br/>
重输密码:<br/><input name="MPWD2" emptyok="false" format="10x"/><br/>
<do type="accept" label="注册" name="btReg">
  <go href="<%=Pages.reg.HREF%>" method="post">
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="MPWD" value="$(MPWD2)"/>
  </go>
</do>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card></wml>

�  D   H T M L   R E G I S T E R _ S U C C E S S       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="手机邮" newcontext="true">
<p>
恭喜,注册成功!<br/>
您的魔号是:<b><#userid></b>,对应密码:<#pwd>请牢记.<br/>
请以您的魔号和密码登陆：<br/>
魔号:<input name="MID" emptyok="false" format="10N" maxlength="10"/><br/>
密码:<input name="MPW" emptyok="false" format="10" maxlength="10"/><br/>
<do type="accept" label="登陆" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.login.HREF%>" method="post">
	<postfield name="MID" value="$(MID)"/>
	<postfield name="MPW" value="$(MPW)"/>
  </go>
</do>
<a href="<%=Pages.Main.HREF%>#MLogin">用邮箱作用户名登录</a><br/>
<a href="<%=Pages.action.HREF%>?ac=forgetPWD">忘记魔号/密码</a><br/>
<a href="<%=Pages.reg.HREF%>">免费注册魔号</a><br/>
<a href="<%=Pages.action.HREF%>?ac=help">新手帮助</a><br/>
<a href="<%=Pages.Main.HREF%>">邮箱首页</a>
<do type="prev" label="返回" name="back"><prev/></do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
 �   4   H T M L   R E L O G I N         0         <?xml version="1.0"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card newcontext="true" ontimer="<%=Pages.login.HREF%>?ms=<#ms>"><timer value="1"/></card></wml>  �   4   H T M L   R E L O G I N _       0         <?xml version="1.0"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" newcontext="true" ontimer="<%=Pages.login.HREF%>?s=<#ms>"><timer value="1"/></card></wml>  �   0   H T M L   R E T U R N       0         <br/><a href="http://wap..cc">�˳�����</a>
<br/>ħ����ʱ:<%=Modules.WebDataModuleShare.ScriptObject.GetCurrentTime('hh:nn')%>   4   H T M L   S E N D M A I L       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="card1" title="手机邮" newcontext="true">
<p>
outbox
<!-- #include file="return.wml" -->
</p>
</card></wml>
  L  8   H T M L   S E N D M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮" newcontext="false">
<p>
<#info><#detailInfo>
<!-- #include file="return.wml" -->
</p>
<do type="prev" label="返回"><prev/></do>
</card></wml>
�  0   H T M L   S E N D _         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="card1" title="" newcontext="true">
收件人:<input name="rcpnts" emptyok="false" tabindex="0" size="200"><br/>
主题:<input name="sbjct" emptyok="false" tabindex="1" size="200"/><br/>
<#msg>
内容:<input name="bdy" emptyok="false" tabindex="1" size="200"/><br/>
<do type="accept" label="发送" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>" method="post">
	<postfield name="rcpnts" value="$(rcpnts)"/>
	<postfield name="sbjct" value="$(sbjct)"/>
	<postfield name="bdy" value="$(bdy)"/>
  </go>
</do>
<do type="accept" label="撤消" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
</card></wml>
   =  8   H T M L   S E T M O D U L E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>系统设置</u></b><br/>

手机号(用于免费接收短信通知):
<input name="Mobile" emptyok="false" tabindex="0" maxlength="100" value="<#Mobile>"/><br/>
(目前只支持移动号码，请在稍后的加为好友中回复同意才可使用改项功能)<br/>

<#msg>
<br/>
<anchor>设置保存已发邮件到发件箱<br/>
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(Mobile)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
  </go>
</anchor>
<!--
<anchor>取消保存已发邮件到发件箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(rcpnts)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
  </go>
</anchor>
-->
<do type="accept" label="撤销" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
   �  T   H T M L   S E T M O D U L E _ C A N C E L S A V E M S G         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>系统设置</u></b><br/><br/>
<!--
手机号:<input name="M"  size="10" max-length="13"  value="<#MP>"/>
<anchor><#SAC>
<go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="MP" value="$M"/>
</go>
</anchor>
-->
<#msg>
<br/>
<br/>
您已设置保存已发邮件到发件箱<br/>
<anchor>取消保存已发邮件到发件箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="T" value="0"/>
  </go>
</anchor>
<br/>
<anchor>清空草稿箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="D" value="0"/>
  </go>
</anchor>|<anchor>清空发件箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="D" value="1"/>
  </go>
</anchor>
<br/>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>&amp;p=<#mailListPage>">返回邮件列表</a><br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">返回收件箱</a>
<do type="accept" label="撤销" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
  �  T   H T M L   S E T M O D U L E _ E N A B L E S A V E M S G         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>系统设置</u></b><br/>
<!--
手机号:<input name="M" size="10" max-length="13" format="*N" value="<#MP>"/>
<anchor><#SAC>
<go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="MP" value="$M"/>
</go>
</anchor>
-->
<#msg>
<br/>
<br/>
<anchor>设置保存已发邮件到发件箱<br/>
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="T" value="1"/>
  </go>
</anchor>
<br/>
<br/>
<anchor>清空草稿箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="D" value="0"/>
  </go>
</anchor>
<br/>
<anchor>清空发件箱
  <go accept-charset="utf-8" href="<%=Pages.set.HREF%>?ms=<#ms>" method="post">
	<postfield name="D" value="1"/>
  </go>
</anchor>
<br/>
<a href="<%=Pages.inBox.HREF%>?ms=<#ms>&amp;p=<#mailListPage>">返回邮件列表</a><br/>
<a href="<%=Pages.login.HREF%>?ms=<#ms>">返回收件箱</a>
<do type="accept" label="撤销" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
  J  <   H T M L   S T O P R E G U S E R         0         <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
<card id="login" title="ħ���ֻ���" newcontext="true">
<p>
<#info>
<b><u>��ͣע��֪ͨ</u></b><br/>
��ϵͳĿǰ����Ƶ���ĵ�����,������ͣ���û�ע��,�����ɴ˸��������Ĳ���,�������Ǹ�⡣<br/>
ϵͳ�ٴο���ע��ʱ��Լ�������ں�,���ǻ�Ŭ���ӿ���ȡ�<br/>
δע�ủ�ɵ�<b><u>�ο�����ͨ��</u></b>ʹ�á�<br/><br/>
ħ����ף�㹤�����,���쿪��!<br/>
2008-12-11 12:00<br/>
<a href="/">����</a>
<!-- #include file="return.wml" -->
</p>
</card></wml>  ]  <   H T M L   S Y S S E T M O D U L E       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>系统设置</u></b><br/>
收件人:<input name="rcpnts" emptyok="false" tabindex="0" maxlength="100" value="<#rcpnts>"/><br/>
主题:<input name="sbjct" emptyok="false" tabindex="1" maxlength="100" value="<#sbjct>"/><br/>
<#msg>
内容:<input name="bdy" emptyok="false" tabindex="3" maxlength="500" value="<#bdy>"/><br/>
<anchor>设置保存已发邮件到发件箱
  <go accept-charset="utf-8" href="<%=Pages.sysSet.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(rcpnts)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
  </go>
</anchor>
<anchor>禁止保存已发邮件到发件箱
  <go accept-charset="utf-8" href="<%==Pages.sysSet.HREF%%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(rcpnts)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
  </go>
</anchor>
<do type="accept" label="撤销" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
     ,   H T M L   T E S T       0         <?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml"><wml><card id="crd" title="ħ���ֻ���"><p><b><u>�������ʼ�</u></b><br/>�ռ���:<input name="rcpnts" emptyok="false" tabindex="0" maxlength="100" value="lwg &lt;"&lt;lwg"@ocensoft.com.c&gt;"/><br/>����:<input name="sbjct" emptyok="false" tabindex="1" maxlength="100" value="test"/><br/>����:<input name="bdy" emptyok="false" tabindex="3" maxlength="500" value="test "/><br/><anchor>����  <go accept-charset="utf-8" href="/wapmail2010/WapMail.dll/send?ms=0rgb83zfsAD7MIdU&amp;tm=0&amp;up=b1Z0NUxUQlBRMm9XblEyMSExVVgvd2VzeEN6Z0xYWndrdjh5dUhudDdQS3hq" method="post"><postfield name="R" value="$(rcpnts)"/><postfield name="S" value="$(sbjct)"/><postfield name="C" value="$(bdy)"/><postfield name="mt" value="2"/><postfield name="md" value="EDB820B84F1F4CF2BAA6D7A76A452BA7"/>  </go></anchor><anchor>ɾ��  <go accept-charset="utf-8" href="/wapmail2010/WapMail.dll/outBox?ms=0rgb83zfsAD7MIdU&amp;tm=0&amp;up=b1Z0NUxUQlBRMm9XblEyMSExVVgvd2VzeEN6Z0xYWndrdjh5dUhudDdQS3hq" method="post"><postfield name="md" value="EDB820B84F1F4CF2BAA6D7A76A452BA7"/><postfield name="op" value="2"/>  </go></anchor><do type="accept" label="����" name="btCancel">  <go accept-charset="utf-8" href="login" method="post"><postfield name="POP" value="$(POP)"/><postfield name="UID" value="$(UID)"/><postfield name="PWD" value="$(PWD)"/>  </go></do><br/><a href="http://wap..cc">�˳�����</a><br/>ħ����ʱ:19:12</p></card></wml>   �  8   H T M L   U N T I T L E D 2         0         ﻿<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.2//EN"
 "http://www.wapforum.org/DTD/wml12.dtd">
<wml><card id="crd1" title="">
<p>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<a href="addMailBox_func.wmls#getSvr($box)">下一步</a>
</p>
</card>
<card id="crd2" title="">
<onevent type="oneventforward">
<refresh/>
</onevent>
<p>
邮箱全名:$box <a href="#crd1">更改</a><br/>
$POP3 <br/>
$SMTP  <br/>
$UN   <br/>

POP3服务器:<input name="PSvr" value="$(POP3)" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="$(SMTP)" emptyok="false" talbeindex="2" maxlength="100"/><br/>

用户名:<input name="MUID" value="$UN" emptyok="false" tabindex="3" maxlength="100"/><br/>
密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25"/><br/>
SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>
POP3端口:<input name="PP" value="110" size="5" matxlenghth="5"/><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP端口:<input name="SP" value="25" size="5" maxlength="5"/><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<do type="accept" label="保存" name="btLogin">
  <go accept-charset="utf-8" href="<%=Pages.add.HREF%>?ms=<#ms>" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(PSvr)"/>
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</do>
</p>
</card></wml>
  �  8   H T M L   U N T I T L E D 2 _       0         ﻿<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.2//EN"
 "http://www.wapforum.org/DTD/wml12.dtd">
<wml><card id="crd1" title="">
<p>
邮箱全名:<input name="box" emptyok="false" tabindex="0" maxlength="100"/><br/>
<a href="addMailBox_func.wmls#getSvr($box)">下一步</a>
</p>
</card>
<card id="crd2" title="">
<onevent type="oneventforward">
<refresh/>
</onevent>
<p>
邮箱全名:$box <a href="#crd1">更改</a><br/>
$POP3 <br/>
$SMTP  <br/>
$UN   <br/>

POP3服务器:<input name="PSvr" value="$(POP3)" tabindex="1" maxlength="100"/><br/>
SMTP服务器:<input name="SSvr" value="$(SMTP)" emptyok="false" talbeindex="2" maxlength="100"/><br/>

用户名:<input name="MUID" value="$UN" emptyok="false" tabindex="3" maxlength="100"/><br/>
密码:<input name="MPWD" emptyok="false" tableindex="4" maxlength="25"/><br/>
SMTP服务器需认证
<select name="SA">
	<optgroup title="Auth">
		<option value="1">是</option>
		<option value="0">否</option>
	</optgroup>
</select><br/>
POP3端口:<input name="PP" value="110" size="5" matxlenghth="5"/><br/>
POP3要求SSL加密:
<select name="PS">
	<option value="0">否</option>
	<option value="1">是</option>
</select><br/>
SMTP端口:<input name="SP" value="25" size="5" maxlength="5"/><br/>
SMTP要求SSL加密:
<select name="SS">
		<option value="0">否</option>
		<option value="1">是</option>
</select><br/>
<do type="accept" label="保存" name="btLogin">
  <go accept-charset="utf-8" href="" method="post">
	<postfield name="box" value="$(box)"/>
	<postfield name="PSvr" value="$(PSvr)"/>
	<postfield name="SSvr" value="$(PSvr)"/>
	<postfield name="MUID" value="$(MUID)"/>
	<postfield name="MPWD" value="$(MPWD)"/>
	<postfield name="SA" value="$(SA)"/>
	<postfield name="PP" value="$(PP)"/>
	<postfield name="PS" value="$(PS)"/>
	<postfield name="SP" value="$(SP)"/>
	<postfield name="SS" value="$(SS)"/>
  </go>
</do>
</p>
</card></wml>
  .  <   H T M L   W R I T E M O D U L E         0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>撰写新邮件</u></b><br/>
收件人:<input name="rcpnts" emptyok="false" tabindex="0" maxlength="100" value="<#rcpnts>"/><br/>
主题:<input name="sbjct" emptyok="false" tabindex="1" maxlength="100" value="<#sbjct>"/><br/>
<#msg>
内容:<input name="bdy" emptyok="false" tabindex="3" maxlength="500" value="<#bdy>"/><br/>
<anchor>发送
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(rcpnts)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
  </go>
</anchor>
<do type="accept" label="撤消" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
  =  T   H T M L   W R I T E M O D U L E _ F O R _ D R A F T B O X       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>待发送邮件</u></b><br/>
收件人:<input name="rcpnts" emptyok="false" tabindex="0" maxlength="100" value="<#rcpnts>"/><br/>
主题:<input name="sbjct" emptyok="false" tabindex="1" maxlength="100" value="<#sbjct>"/><br/>
<#msg>
内容:<input name="bdy" emptyok="false" tabindex="3" maxlength="500" value="<#bdy>"/><br/>
<anchor>发送
  <go accept-charset="utf-8" href="<%=Pages.send.HREF%>?ms=<#ms>" method="post">
	<postfield name="R" value="$(rcpnts)"/>
	<postfield name="S" value="$(sbjct)"/>
	<postfield name="C" value="$(bdy)"/>
	<postfield name="mt" value="2"/>
	<postfield name="md" value="<#md>"/>
  </go>
</anchor>
<anchor><#cancel>
  <go accept-charset="utf-8" href="<%=Pages.outBox.HREF%>?ms=<#ms>" method="post">
	<postfield name="md" value="<#md>"/>
	<postfield name="op" value="2"/>
  </go>
</anchor>
<do type="accept" label="撤消" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
     P   H T M L   W R I T E M O D U L E _ F O R _ O U T B O X       0         ﻿<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml><card id="crd" title="手机邮">
<p>
<b><u>已发送邮件</u></b><br/>
收件人:<input name="rcpnts" emptyok="false" tabindex="0" maxlength="100" value="<#rcpnts>"/><br/>
主题:<input name="sbjct" emptyok="false" tabindex="1" maxlength="100" value="<#sbjct>"/><br/>
<#msg>
内容:<input name="bdy" emptyok="false" tabindex="3" maxlength="500" value="<#bdy>"/><br/>
<anchor><#cancel>
  <go accept-charset="utf-8" href="<%=Pages.outBox.HREF%>?ms=<#ms>" method="post">
	<postfield name="md" value="<#md>"/>
  <postfield name="op" value="1"/>
  </go>
</anchor>
<do type="accept" label="撤消" name="btCancel">
  <go accept-charset="utf-8" href="login" method="post">
	<postfield name="POP" value="$(POP)"/>
	<postfield name="UID" value="$(UID)"/>
	<postfield name="PWD" value="$(PWD)"/>
  </go>
</do>
<!-- #include file="return.wml" -->
</p>
</card></wml>
