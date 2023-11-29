メモ

・initStateを用意して、ダイアローグを用意する。
・prefsを使い、前回の郵便番号を表示する。
・UIを整える
・郵便番号検索時のメッセージを増やす
・↑のメッセージをテキスト表示させる。
・初期表示時は、郵便番号テキストフィールド以外は、何も表示しない

・郵便番号を8桁以上入力できないようにする
・送信ボタン連打防止する



後々実現したいこと。
・現在の居場所を取得させる。(初期表示時)
・郵便番号の検索履歴を表示する(DB)

keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias release -storetype JKS

keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key


keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key -storetype JKS


open build/app/outputs/bundle