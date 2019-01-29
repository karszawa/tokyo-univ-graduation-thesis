\newpage
\thispagestyle{empty}

\chapter*{付録}

\section*{システムの使い方}

管理栄養士とアスリート向けのシステムの使い方をWebに公開した。
それぞれ次のリンクから参照できる。

- 管理栄養士: \url{https://karszawa.github.io/food-consul-app/usage-for-dietitians}
- アスリート: \url{https://karszawa.github.io/food-consul-app/usage-for-athletes}

\section*{システムアーキテクチャ}

本稿ではシステムの特徴について使用者の操作やデータフローを用いて説明してきたが、
ここでは実際に使用したサービスを用いてシステムアーキテクチャを詳細に述べる。
図\ref{fig:system-architecture}は本システムで活用したサービスをコンポーネントとしてまとめた図である。

![システムアーキテクチャ](fig/system-architecture.eps){width=\linewidth}

アスリートの用いるモバイルアプリケーションは食事記録の認識と保持をFoodLog APIを通して行う。
メッセージやアドバイスの保持にはFirebase Firestoreを用いる。
このようにデータストアが別れている理由は、Firestoreではデータの追加などにトリガーしてFirebase Cloud Functionsなどの処理を実行できるからである。
実際に本システムではFirestoreへのメッセージの追加にトリガーしてアスリートのモバイルアプリケーションにPush通知を送信している。
また、Firestoreはデータの変更をただちにデータの利用先に反映するという仕組みがあるため、メッセージの送受信のように即時応答性が求められるような利用に適している。

本システムではEatSmartの食事データを登録することもできるようになっている。
この仕組みはEatSmartの食事データをモバイルアプリケーションを通してFoodLogに新しい食事データとして作成することで実現している。
EatSmartのデータをFoodLogでも利用できるようにする正規化はモバイルアプリケーションで行っているので、
管理栄養士側のWebアプリケーションでは両者のデータの違いを意識することなく栄養の分析ができる。

管理栄養士側のWebアプリケーションはFirebase Hostingでホスティングされた静的ファイルにより管理栄養士のブラウザで実行される。
ブラウザからFoodLogのAPIにアクセスする場合、サーバーにてCORSポリシーへの対応が必要になるが、
他サービスでも利用されているFoodLog APIの制約でFoodLog APIにCORSポリシーを適用することはできなかった。
そのため、FoodLog APIにCORSポリシーを適用するためだけのリバースプロキシが必要であった。
リバースプロキシはGoogle App Engine上で動作するWebアプリケーションとして実装した。

本システムで実験を行った管理栄養士が栄養情報に対して統計的な分析を行うために、
栄養情報をExcelファイルに書き出すという機能を実装した。
Excelファイルの作成はFirebase Cloud Functionsの機能として実装し、
ファイルの保存にはFirebase Storageを利用した。
これにより保存したファイルがブラウザからダウンロードできるようになった。

エラー監視はモバイルアプリケーション・Webアプリケーション共にSentry[^sentry]を用いて行った。

[^sentry]: 様々なプラットフォームに対応したエラー情報を集積するためのサービス \url{https://sentry.io/}

コードベースで捉えると本システムは5つの部分に分かれる。
以下に各コードをリポジトリのURLと共に列挙する。

- アスリート向けのモバイルアプリケーション
  - \url{https://github.com/karszawa/food-consul-app}
- 管理栄養士向けのWebアプリケーション
  - \url{https://github.com/karszawa/food-consul-admin}
- Push通知用のFunctionタスク
  - \url{https://github.com/karszawa/food-consul-functions}
- Excelファイル作成のFunctionタスク
  - Push通知用のFunctionタスクと同じリポジトリ
- Webアプリケーション用のリバースプロキシ
  - \url{https://github.com/karszawa/food-consul-proxy}

\section*{ソフトウェアアーキテクチャ}

管理栄養士側のWebアプリケーションはReact[^react]を用いて作成し、すべての処理をユーザーのブラウザ上で実行している。
こうしたことでWebページを提供する際のサーバー側の負担がほとんどなくなった。
また、Firebase Hostingによりサービスが負荷に応じて自動でスケールするため、
仮にユーザーが増えたとしてもWebサーバーがボトルネックとなることはない。

アスリート向けのモバイルアプリケーションの開発にはReact Native[^react-native]とExpo[^expo]を用いた。
これによりアプリケーションのコードをiOS・Androidで共通にすることができた。
また、Expoを用いたことでOTA(Over the Air)更新[^ota]によるデプロイが可能になり、実験のフィードバックを漸次的に本番環境のアプリケーションに反映できた。
これがなければモバイルアプリケーションの更新は各プラットフォームの審査を通さなければならないのでソフトウェアの更新には1日から3日ほどの時間がかかっていた。
このように、Expoを採用したことで短い実験期間で多くの試行を行うことができた。

[^react]: Webページのユーザーインターフェイスを作成するための JavaScript ライブラリ \url{https://reactjs.org/}
[^expo]: React Native 上で高速にモバイルアプリケーションを作成するためのプラットフォーム \url{https://expo.io/}
[^react-native]: React を用いてモバイルアプリケーションを開発するためのライブラリ \url{https://facebook.github.io/react-native/}
[^ota]: アプリケーションストアの審査を通さない実行コードだけのオンラインアップデートのこと
