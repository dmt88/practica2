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

# funció que emmagatzema les dades dels jutjats de la provincia corresponent al codi numéric passat per paràmtre
def scrapeJutjats(str,nomFitxer):
    
    linkProvincia = str

    try:
        page = requests.get(str, headers=headers)
        page.raise_for_status()
        tree = html.fromstring(page.content)

        partitsJudicials = tree.xpath('//table[@class="listado"]//a')

        # per cada partit judicial
        i = 0
        for partitJudicial in partitsJudicials:
            partitJudicial = tree.xpath('//table[@class="listado"]//a/text()')[i]
            linkPartitJudicial = tree.xpath('//table[@class="listado"]//a/@href')[i]
            
            i = i+1

            linkPartitJudicial = 'http://demarcacion.cgpe.es/' + linkPartitJudicial.replace("partido.aspx","juzgados.aspx")

            page2 = requests.get(linkPartitJudicial, headers=headers)
            tree2 = html.fromstring(page2.content)
            descripcioPartit = tree2.xpath('//h1/text()')[0]
            jutjats = tree2.xpath('//table[@class="listado"]//a')

            # per cada jutjat
            j = 0
            for jutjat in jutjats:
                jutjat = tree2.xpath('//table[@class="listado"]//a/text()')[j]
                linkJutjat = tree2.xpath('//table[@class="listado"]//a/@href')[j]

                j = j+1

                linkJutjat = 'http://demarcacion.cgpe.es/' + linkJutjat

                page3 = requests.get(linkJutjat, headers=headers)
                tree3 = html.fromstring(page3.content)

                try:
                    adrecaJutjat = tree3.xpath('//tr[@class="line"]//td/text()')[0]
                except:
                    adrecaJutjat = ''
                try:
                    poblacioJutjat = tree3.xpath('//tr[@class="line"]//td/text()')[1]
                    cpJutjat = poblacioJutjat[:5]
                    cpJutjat = cpJutjat.rstrip()
                    if (len(cpJutjat) == 4):
                        poblacioJutjat = poblacioJutjat[7:]
                    else:
                        poblacioJutjat = poblacioJutjat[8:]
                except:
                    poblacioJutjat = ''
                    cpJutjat = ''
                try:
                    provinciaJutjat = tree3.xpath('//tr[@class="line"]//td/text()')[2]
                except:
                    provinciaJutjat = ''
                
                newLine=linkProvincia+";"+partitJudicial+";"+descripcioPartit+";"+linkPartitJudicial+";"+jutjat+";"+linkJutjat+";"+adrecaJutjat+";"+cpJutjat+";"+poblacioJutjat+";"+provinciaJutjat+"\n"
                newLine=newLine.encode(sys.stdout.encoding, errors='replace')
       
                with open(nomFitxer, "ab") as myfile:
                    myfile.write(newLine)
                    myfile.close()
               
    except requests.exceptions.HTTPError as e:
        print('Error HTTP: {}'.format(e))
    except requests.exceptions.RequestException as e:
        print('Error de connexió: {}'.format(e))
