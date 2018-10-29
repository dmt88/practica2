# -*- coding: utf-8 -*-
import requests
from lxml import html
import sys

# definició de la capçalera de la petició, inclós el User Agent
headers = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Encoding": "gzip, deflate, sdch, br",
    "Accept-Language": "en-US,en;q=0.8",
    "Cache-Control": "no-cache",
    "dnt": "1",
    "Pragma": "no-cache",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36"
}
    
# funció que emmagatzema les dades del procurador corresponent a l'enllaç passat per paràmtre
def scrapeProcurador(str,nomFitxer):
    
    link = str

    try:
        page = requests.get(str, headers=headers)
        page.raise_for_status()
        tree = html.fromstring(page.content)
        try:
            nom = tree.xpath('//div[@class="detcabecera"]/text()')[0]
        except:
            nom = ''            
        try:
            colegi = tree.xpath('//a[@class="detlinkcontacto"]/text()')[0]
        except:
            colegi = ''            
        try:
            idProcurador = tree.xpath('//span/text()')[0]
        except:
            idProcurador = ''
        try:
            telefonProcurador = tree.xpath('//th/text()')[0]
        except:
            telefonProcurador = ''
        try:
            colegi2 = tree.xpath('//a[@class="detlinkcontacto"]/text()')[1]
        except:
            colegi2 = '' 
        try:
            webProcurador = tree.xpath('//a[@class="detlinkcontacto"]/text()')[2]
        except:
            webProcurador = ''
        try:
            emailProcurador = tree.xpath('//a[@class="detlinkcontacto"]/text()')[3]
        except:
            emailProcurador = ''           
        try:
            adreca = tree.xpath('//td[@class="dettexto"]/text()')[0]
        except:
            adreca =''
        try:
            poblacio = tree.xpath('//td[@class="dettexto"]/text()')[1]
        except:
            poblacio = ''
        try:
            provincia = tree.xpath('//td[@class="dettexto"]/text()')[2]
        except:
            provincia = ''
        try:
            telefonDespatx = tree.xpath('//th/text()')[1]
        except:
            telefonDespatx = ''
        try:
            faxDespatx = tree.xpath('//th/text()')[2]
        except:
            faxDespatx = ''

        if (colegi2.find('ILUSTRE COLEGIO') != -1):
            colegi = colegi.rstrip() + "," + colegi2.rstrip()
            if (webProcurador.find('@') != -1):
                emailProcurador = webProcurador
                webProcurador = ''
        else:
            if (colegi2.find('@') != -1):
                emailProcurador = colegi2
                webProcurador = ''
                colegi2 = ''
            else:
                if(webProcurador.find('@') != -1):
                    emailProcurador = webProcurador
                    webProcurador = colegi2
                    colegi2 = ''

        adreca = adreca.replace(";","")

        newLine=nom+";"+colegi+";"+idProcurador+";"+telefonProcurador+";"+webProcurador+";"+emailProcurador+";"+adreca+";"+poblacio+";"+provincia+";"+telefonDespatx+";"+faxDespatx+";"+link+"\n"
        newLine=newLine.encode(sys.stdout.encoding, errors='replace')
       
        with open(nomFitxer, "ab") as myfile:
            myfile.write(newLine)
            myfile.close()
               
    except requests.exceptions.HTTPError as e:
        print('Error HTTP: {}'.format(e))
    except requests.exceptions.RequestException as e:
        print('Error de connexió: {}'.format(e))
