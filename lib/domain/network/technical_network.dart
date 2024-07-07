// ignore_for_file: unnecessary_string_escapes

import 'package:hive/hive.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:induktif/domain/model/technical_model.dart';
import 'package:requests/requests.dart';

class TechnicalNetwork {
  Future<List<TechnicalModel>> getInfoTI() async {
    Box pengaturan = await Hive.openBox('pengaturan');
    Box infoTeknis = await Hive.openBox('info_teknis');
    String name =
        pengaturan.get('userTi', defaultValue: 'imam.mustofa@tfirst.co.id');
    String pass = pengaturan.get('passTi', defaultValue: 'Tdms@12345');
    String username = name;
    String password = pass;

    List<TechnicalModel> technicalModel = [];

    String loginTI = 'https://d28000000bxxiea2.my.site.com/partners/login';
    String linkToTI =
        'https://d28000000bxxiea2.my.site.com/partners/apex/TI_Bulletin?sfdc.tabName=01r28000001DjRN';

    var hostname = Requests.getHostname(loginTI);
    Requests.clearStoredCookies(hostname);

    var loginPage = await Requests.post(loginTI,
        body: {
          'un': username,
          'width': '1366',
          'height': '768',
          'hasRememberUn': 'true',
          'startURL': '',
          'loginURL': '',
          'loginType': '',
          'useSecure': 'true',
          'local': '',
          'lt': 'standard',
          'qs': '',
          'locale': '',
          'oauth_token': '',
          'oauth_callback': '',
          'login': '',
          'serverid': '',
          'display': 'page',
          'username': username,
          'ExtraLog':
              '[{"width":1366},{"height":768},{"language":"en-US"},{"offset":-7},{"scripts":[{"size":249,"summary":"if (self == top) {document.documentElement.style.v"},{"size":567,"summary":"var SFDCSessionVars={\"server\":\"https:\\/\\/login.sal"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/SfdcSessionBase208.js"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/LoginHint208.js"},{"size":26,"summary":"LoginHint.hideLoginForm();"},{"size":36,"summary":"LoginHint.getSavedIdentities(false);"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/baselogin4.js"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/LoginMarketingSurveyResponse.js"},{"size":356,"summary":"function handleLogin(){document.login.un.value=doc"}]},{"scriptCount":9},{"iframes":["https://login.salesforce.com/login/sessionserver212.html"]},{"iframeCount":1},{"referrer":"NO_REFERRER"}]',
          'pw': password
        },
        bodyEncoding: RequestBodyEncoding.FormURLEncoded,
        timeoutSeconds: 60,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0',
          'Accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.5',
          'Accept-Encoding': 'gzip, deflate, br',
          'Referer': 'https://d28000000bxxiea2.my.site.com/partners/login',
          'Host': 'd28000000bxxiea2.my.site.com',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Origin': 'https://d28000000bxxiea2.my.site.com',
          'Connection': 'keep-alive',
          'Cookie':
              'BrowserId=iKbtNJpZEeugmYfk9kiAlg; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1; oid=00D28000000bXXI; oinfo=c3RhdHVzPUFDVElWRSZ0eXBlPTImb2lkPTAwRDI4MDAwMDAwYlhYSQ==; autocomplete=1',
          'Upgrade-Insecure-Requests': '1',
          'Sec-Fetch-Dest': 'document',
          'Sec-Fetch-Mode': 'navigate',
          'Sec-Fetch-Site': 'same-origin',
          'Sec-Fetch-User': '?1'
        },
        persistCookies: true);

    String oinfo = loginPage.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('oinfo'))
        .elementAt(0)
        .replaceAll('oinfo=', '');

    var frontDoor = loginPage.headers['location'];
    var secondPage = await Requests.post(frontDoor!,
        headers: {
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0",
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
          "Accept-Language": "en-US,en;q=0.5",
          "Accept-Encoding": "gzip, deflate, br",
          "Referer": loginTI,
          "Connection": "keep-alive",
          "Upgrade-Insecure-Requests": "1",
          "Sec-Fetch-Dest": "document",
          "Sec-Fetch-Mode": "navigate",
          "Sec-Fetch-Site": "same-origin",
          "Sec-Fetch-User": "?1",
        },
        persistCookies: true);

    String clientSrc = secondPage.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('SameSite=None,clientSrc='))
        .elementAt(0)
        .replaceAll('SameSite=None,clientSrc=', '');

    String oid = secondPage.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('SameSite=None,oid'))
        .elementAt(0)
        .replaceAll('SameSite=None,oid=', '');

    String sid = secondPage.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('SameSite=None,sid='))
        .elementAt(0)
        .replaceAll('SameSite=None,sid=', '');

    String sidClient = secondPage.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('SameSite=None,sid_Client='))
        .elementAt(0)
        .replaceAll('SameSite=None,sid_Client=', '');

    var getTechnicalInformation =
        await Requests.get(linkToTI, timeoutSeconds: 120);

    var doc = getTechnicalInformation.content();

    var document = parse(doc);
    var tBody = document.getElementsByTagName('tbody')[4];
    var baris = tBody.getElementsByTagName('tr');

    for (dom.Element b in baris) {
      var idDetailLink = b
          .getElementsByTagName('a')[0]
          .outerHtml
          .substring(9)
          .replaceAll('"', '')
          .split(' ')[0]
          .replaceAll('/partners/apex/TI_Bulletin?id=', '')
          .replaceAll('&amp;action=detail&amp;isView=true', '')
          .toString();

      Map<String, String> finalCookie = {
        'Cookie':
            'clientSrc=$clientSrc; oid=$oid; sid=$sid; sid_Client=$sidClient; oinfo=$oinfo; BrowserId=iKbtNJpZEeugmYfk9kiAlg; BrowserId_sec=iKbtNJpZEeugmYfk9kiAlg; CookieConsentPolicy=0:1; autocomplete=1; inst=APP_2x; LSKey-c\$CookieConsentPolicy=0:1;'
      };
      
      Map<String, String> finalHeader = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.5',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Referer':
            'https://d28000000bxxiea2.my.site.com/partners/apex/TI_Bulletin?id=a032x00000Ad9fCAAR&action=detail&isView=true',
        'Cookie':
            'clientSrc=$clientSrc; oid=$oid; sid=$sid; sid_Client=$sidClient; oinfo=${oinfo}BrowserId=iKbtNJpZEeugmYfk9kiAlg; BrowserId_sec=iKbtNJpZEeugmYfk9kiAlg; CookieConsentPolicy=0:1; autocomplete=1; inst=APP_2x; LSKey-c\$CookieConsentPolicy=0:1;'
      };

      var kolom = b.getElementsByTagName('td');
      var finalResult = TechnicalModel(
          headers: finalHeader,
          cookiesWeb: finalCookie,
          idUrl: idDetailLink,
          publishedDate: kolom[0].text,
          nomorTI: kolom[1].text,
          forDealer: kolom[2].text,
          judulTI: kolom[3].text,
          namaMobil: kolom[4].text);

      technicalModel.add(finalResult);
    }

    if (technicalModel.isNotEmpty) {
      await infoTeknis.clear();
      await infoTeknis.addAll(technicalModel);
    }
    return technicalModel;
  }
}
