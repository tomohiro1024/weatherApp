メモ

・FutureBuilderなどを使い、データが取得できるまでは、ローディングを表示させたい。
・0000などの郵便番号だと取得できない問題の調査
・UIをMediaQuery.of(context).sizeを使う(端末のサイズによってUIがバラバラなので)
・晴れだった場合、背景を変更する。
・端末の通信がオフの場合、メッセージダイアログを出す

後々実現したいこと。
・現在の居場所を取得させる。(初期表示時)
・郵便番号の検索履歴を表示する(DB)


### Androidリリース

keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key -storetype JKS

open build/app/outputs/bundle



### iosリリースビルドに失敗した場合

https://qiita.com/kokogento/items/fb4f62393ae1e3a76b06







