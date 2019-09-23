
{ $DEFINE THREADSAFE}

{$IFNDEF MSWINDOWS}
  {$IFDEF WIN32}
  	{$DEFINE MSWINDOWS}
	{$ENDIF}
{$ENDIF}

// Delphi 7
{$IFDEF VER150}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
{$ENDIF}

// Delphi 6/ Kylix
{$IFDEF VER140}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
{$ENDIF}

// Delphi 5
{$IFDEF VER130}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
{$ENDIF}

// Delphi 4
{$IFDEF VER120}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
{$ENDIF}

// Delphi 3
{$IFDEF VER100}
  {$DEFINE DELPHI3_UP}
{$ENDIF}