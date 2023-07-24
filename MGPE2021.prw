User Function MGPE2021
    Local cHtml	:= ""
    Local cArquivo 	:= "\system\contratotrabalho.html"
    Local cEmpresa  := "Empresa XYZ"
    Local cFunciona := "Fulano de Tal"
    Local cCidade   := "São Paulo"
    Local cEstado   := "SP"
    Local cSalario  := "2550,58 " + Extenso(2550.58,.F.,1)
    Local cDia 	:= StrZero(Day(dDatabase),2)
    Local cMes 	:= MesExtenso(Month(dDatabase))
    Local cAno 	:= StrZero(Year(dDatabase),0)
    Local cFuncao   := "Mecânico"
    Local oEdit
    Static oDlg

    //Verifique se o arquivo html modelo realmente existe usando a função File()
    if !File(cArquivo)
        MsgStop("O Arquivo " + cArquivo + ", não existe, verifique!","Erro")
        Return
    Endif

    //Com a função MemoRead(), leia o arquivo html
    cHtml := MemoRead( cArquivo )

    //com a função Replace(), substitua as variaveis dentro do HTML
    cHtml := Replace(cHtml,"[DADOSEMPRESA]","&lt;strong&gt;&lt;u&gt;"+Capital(cEmpresa)+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[DADOSTRABALHADOR]","&lt;strong&gt;&lt;u&gt;"+Capital(cFunciona)+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[FUNCAOTRABALHADOR]","&lt;strong&gt;&lt;u&gt;"+Capital(cFuncao)+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[SALARIO]","&lt;strong&gt;&lt;u&gt;"+cSalario+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[DIA]","&lt;strong&gt;&lt;u&gt;"+cDia+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[MES]","&lt;strong&gt;&lt;u&gt;"+cMes+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[ANO]","&lt;strong&gt;&lt;u&gt;"+cAno+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[CIDADE]","&lt;strong&gt;&lt;u&gt;"+cCidade+"&lt;/u&gt;&lt;/strong&gt;")
    cHtml := Replace(cHtml,"[ESTADO]","&lt;strong&gt;&lt;u&gt;"+cEstado+"&lt;/u&gt;&lt;/strong&gt;")

    DEFINE DIALOG oDlg TITLE "Contrato" FROM 0, 0 TO 550, 800 PIXEL
    oEdit := tSimpleEditor():New(0, 0, oDlg, 500, 300)
    oEdit:TextFormat(1)
    oEdit:Load("&lt;html&gt;&lt;head&gt;&lt;style&gt;* {font:Normal 10pt Arial;text-align: justify;} .titulo {font:Bold 14pt Arial;text-align: center;} p {text-align: justify;text-justify: inter-word;}&lt;/style&gt;&lt;/head&gt;&lt;body&gt;"+cHtml+"&lt;/body&gt;&lt;/html&gt;")
    oEdit:Align := CONTROL_ALIGN_ALLCLIENT 
    ACTIVATE DIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| oEdit:SaveToPDF("C:\TMP\contrato.pdf"), MsgInfo("Arquivo salvo em C:\TMP\contrato.pdf","Info") },{|| oDlg:End()}) CENTERED

Return
