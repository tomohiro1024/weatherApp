メモ

・prefsを使い、前回の郵便番号を表示する。
・UIを整える
・郵便番号検索時のメッセージを増やす
・↑のメッセージをテキスト表示させる。
・FutureBuilderなどを使い、データが取得できるまでは、ローディングを表示させたい。
・文字のフォントを変更してみる
・初期表示時は画面の中央にメッセージを表示する。



後々実現したいこと。
・現在の居場所を取得させる。(初期表示時)
・郵便番号の検索履歴を表示する(DB)


別アプリ
・翻訳機脳アプリ


### Androidリリース

keytool -genkey -v -keystore ./key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key -storetype JKS

open build/app/outputs/bundle


isVisible
                    ? Container()
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 5),
                            Text('あなたが郵便番号を入力するのを待っています...'),
                            SpinKitPulse(
                              color: Colors.green,
                              size: 30,
                            ),
                          ],
                        ),
                      ),







