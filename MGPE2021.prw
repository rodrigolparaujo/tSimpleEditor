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
    cHtml := Replace(cHtml,"[DADOSEMPRESA]","<strong><u>"+Capital(cEmpresa)+"</u></strong>")
    cHtml := Replace(cHtml,"[DADOSTRABALHADOR]","<strong><u>"+Capital(cFunciona)+"</u></strong>")
    cHtml := Replace(cHtml,"[FUNCAOTRABALHADOR]","<strong><u>"+Capital(cFuncao)+"</u></strong>")
    cHtml := Replace(cHtml,"[SALARIO]","<strong><u>"+cSalario+"</u></strong>")
    cHtml := Replace(cHtml,"[DIA]","<strong><u>"+cDia+"</u></strong>")
    cHtml := Replace(cHtml,"[MES]","<strong><u>"+cMes+"</u></strong>")
    cHtml := Replace(cHtml,"[ANO]","<strong><u>"+cAno+"</u></strong>")
    cHtml := Replace(cHtml,"[CIDADE]","<strong><u>"+cCidade+"</u></strong>")
    cHtml := Replace(cHtml,"[ESTADO]","<strong><u>"+cEstado+"</u></strong>")

    DEFINE DIALOG oDlg TITLE "Contrato" FROM 0, 0 TO 550, 800 PIXEL
    oEdit := tSimpleEditor():New(0, 0, oDlg, 500, 300)
    oEdit:TextFormat(1)
    oEdit:Load("<html><head><style>* {font:Normal 10pt Arial;text-align: justify;} .titulo {font:Bold 14pt Arial;text-align: center;} p {text-align: justify;text-justify: inter-word;}</style></head><body>"+cHtml+"</body></html>")
    oEdit:Align := CONTROL_ALIGN_ALLCLIENT 
    ACTIVATE DIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| oEdit:SaveToPDF("C:\TMP\contrato.pdf"), MsgInfo("Arquivo salvo em C:\TMP\contrato.pdf","Info") },{|| oDlg:End()}) CENTERED

Return
