// ignore_for_file: equal_keys_in_map
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:induktif/domain/model/searching_model.dart';
import 'package:requests/requests.dart';
import 'package:html/dom.dart' as dom;

String loginTI = 'https://d28000000bxxiea2.my.site.com/partners/login';

class SearchingNetwork {
  final String keyWord;
  late Map<String, String> finalHeader;
  late Map<String, String> finalCookie;

  SearchingNetwork({required this.keyWord});

  Future<Response> loginToUrl() async {
    Box pengaturan = await Hive.openBox('pengaturan');
    String name =
        pengaturan.get('userTi', defaultValue: 'imam.mustofa@tfirst.co.id');
    String pass = pengaturan.get('passTi', defaultValue: 'Tdms@12345');
    String username = name;
    String password = pass;

    var hostname = Requests.getHostname(loginTI);
    await Requests.clearStoredCookies(hostname);
    await Requests.get(
        'https://d28000000bxxiea2.my.site.com/partners/secur/logout.jsp');
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
              '[{"width":1366},{"height":768},{"language":"en-US"},{"offset":-7},{"scripts":[{"size":249,"summary":"if (self == top) {document.documentElement.style.v"},{"size":567,"summary":"var SFDCSessionVars={"server":"https:\\/\\/login.sal"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/SfdcSessionBase208.js"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/LoginHint208.js"},{"size":26,"summary":"LoginHint.hideLoginForm();"},{"size":36,"summary":"LoginHint.getSavedIdentities(false);"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/baselogin4.js"},{"url":"https://d28000000bxxiea2.my.site.com/partners/jslibrary/LoginMarketingSurveyResponse.js"},{"size":356,"summary":"function handleLogin(){document.login.un.value=doc"}]},{"scriptCount":9},{"iframes":["https://login.salesforce.com/login/sessionserver212.html"]},{"iframeCount":1},{"referrer":"NO_REFERRER"}]',
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

    return loginPage;
  }

  Future<String> getLinkToken(Response? response) async {
    var frontDoor = response!.headers['location'];
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

    String oinfo = response.headers['set-cookie']!
        .split(';')
        .where((element) => element.contains('oinfo'))
        .elementAt(0)
        .replaceAll('oinfo=', '');

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

    finalCookie = {
      'Cookie':
          'clientSrc=$clientSrc; oid=$oid; sid=$sid; sid_Client=$sidClient; oinfo=$oinfo; BrowserId=iKbtNJpZEeugmYfk9kiAlg; BrowserId_sec=iKbtNJpZEeugmYfk9kiAlg; CookieConsentPolicy=0:1; autocomplete=1; inst=APP_2x; LSKey-c\$CookieConsentPolicy=0:1;'
    };

    finalHeader = {
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

    var s = await Requests.get(
      "https://d28000000bxxiea2.my.site.com/partners/_ui/search/ui/UnifiedSearchResults?str=$keyWord&sen=a01&sen=a03&sen=a0S&sen=a05&sen=a0w&sen=a09&sen=00P&sen=001&sen=01t&sen=00T&sen=015&sen=500&sen=005&sen=00U&sen=801",
    );

    var result = s.body;

    var linkToken = result
        .split(';')
        .where((element) => element.contains('ajaxServletCSRFToken'))
        .elementAt(0)
        .split('"ajaxServletCSRFToken":"')[1]
        .replaceAll('"})', '');
    return linkToken;
  }

  Future<List<SearchingModel>> getSearchResult(String? linkToken) async {
    var r = await Requests.post(
        "https://d28000000bxxiea2.my.site.com/partners/_ui/common/search/client/ui/ajax/UnifiedSearchAjaxServlet",
        body: {
          "searchCount": 2,
          "cmdType": "cmp",
          "cmp": "singleEntitySearchResult",
          "fen": "a03",
          "str": keyWord,
          "initialViewMode": "detail",
          "sen": "a01",
          "sen": "a03",
          "sen": "a0S",
          "sen": "02i",
          "sen": "a05",
          "sen": "a0w",
          "sen": "a09",
          "sen": "00P",
          "sen": "01t",
          "sen": "00T",
          "sen": "500",
          "sen": "00U",
          "sen": "801",
          "_CONFIRMATIONTOKEN": linkToken
        });

    T? mapGetter<T>(Map map, String path, T defaultValue) {
      List<String> keys = path.split('.');
      String key = keys[0];

      if (!map.containsKey(key)) {
        return defaultValue;
      }

      if (keys.length == 1) {
        return map[key] as T;
      }

      return mapGetter(map[keys.removeAt(0)], keys.join('.'), defaultValue);
    }

    var results = r.body;

    var body = results.replaceRange(0, 10, "");

    Map<String, dynamic> valueMap = jsonDecode(body);
    var finalResult =
        mapGetter(valueMap, 'singleEntitySearchResult.html', 'none result');

    var document = parse(finalResult);
    var pBody = document.getElementById('Bulletin__c_body');
    var dataRow = pBody!.getElementsByClassName('dataRow');

    List<SearchingModel> searchingModel = [];

    for (dom.Element b in dataRow) {
      dom.Element barisJudul = b.getElementsByTagName('a')[0];
      String judul = barisJudul.text;
      String model = b
                  .getElementsByClassName('dataCell')[1]
                  .text
                  .replaceAll(' ', '')
                  .replaceAll('\n', '')
                  .length ==
              1
          ? '<empty>'
          : b
              .getElementsByClassName('dataCell')[1]
              .text
              .replaceAll(' ', '')
              .replaceAll('\n', '');
      String owner = b
          .getElementsByClassName('dataCell')[2]
          .text
          .replaceAll(' ', '')
          .replaceAll('\n', '')
          .replaceAll(RegExp(r'(?<=[a-z])(?=[A-Z0-9])'), ' ');
      String idlinkJudul = barisJudul.outerHtml
          .substring(9)
          .replaceAll('"', '')
          .split(' ')[0]
          .replaceAll('/partners/', '')
          .replaceAll('&amp;', '&')
          .toString();

      var finalResult = SearchingModel(
          judul: judul,
          model: model,
          owner: owner,
          idLinkJudul: idlinkJudul,
          headers: finalHeader,
          cookiesWeb: finalCookie);


      searchingModel.add(finalResult);
    }

    return searchingModel;
  }
}
