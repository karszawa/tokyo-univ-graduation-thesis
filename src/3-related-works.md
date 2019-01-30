\chapter{関連研究と類似サービス}

<!--
- Athlete
  - 料金体系が不透明
  - 包括的なサービスなので既存のサービスをすべて取り替えないと導入できない
  - 手間を軽減しているわけではない
- Slack
  - 過去の記録を参照できない
  - 何でも送信できてコストがないので現状はこれを使っている
- FoodLogアプリ
  - 汎用的な食事記録ツールなので利用者間でコミュニケーションが取れない
-->

# FoodLog

FoodLog [\cite{bib:foodlog}] はfoo.log株式会社によって開発されている毎日の食事を簡単に記録するためのモバイルアプリケーションである。
このアプリケーションではスマートフォンによって撮影された画像を機械学習技術よって分析することができる。
このアプリケーションによってユーザーは自身の食生活の実態を理解・把握することができる。

このサービスはユーザーが自身で食事記録を作成・利用するものなので、本研究のように記録者と閲覧者が異なるユースケースには対応できない。
しかしながら、食事画像の分析機能は本研究にも応用可能であるため、本研究で作成するシステムではFoodLogの食事画像の分類機能をAPIとして利用する。

\begin{figure}[htbp]
  \centering
  \subfigure[食事画像の認識結果]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/foodlog/1.eps}}
    \label{fig:foodlog-1}
  }
  \subfigure[食事記録によるカレンダー画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/foodlog/2.eps}}
    \label{fig:foodlog-2}
  }
  \subfigure[食事記録の訂正画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/foodlog/3.eps}}
    \label{fig:foodlog-3}
  }
  \caption{FoodLog のアプリ画面}
  \label{fig:foodlog}
\end{figure}

# Atlete

Atleta [\cite{bib:atleta}] はアスリートのコンディション管理、食事管理、指導者・選手感のコミュニケーション管理などを行うことができるサービスである。
Atletaを使うことで、スポーツチームの指導者はアスリートの情報をすべて包括的に管理することができる。
Atletaの機能は大きく分けて次の5つがある。

1. コンディション -- 体調・睡眠時間・疲労度・体組成値等を入力・管理できる
2. 食事管理 -- アスリートがとった食事を写真付きで管理できるが、管理自体はアスリートが行う <!-- TODO: よくわからない -->
3. スケジュール管理 -- チーム全体のスケジュールを管理することができる
4. 指導者・選手間のコミュニケーション -- 指導者・選手間でチャットメッセージによるコミュニケーションをとることができる
5. 全体メッセージ -- 指導者からチームメンバー全体へのメッセージを送ることができる

このように多様な機能が実装されていることがこのサービスの魅力である。
しかしながら、個別の機能に注目してみれば入力補助などの利便性はないという状況である。
また、従来は別々のサービスをそれぞれの団体がカスタマイズして組み合わせて使っていたので、
それらをすべて統合するとなると移行の手間も大きく、このサービスにロックインされてしまうというデメリットもある。

\begin{figure}[htbp]
  \centering
  \subfigure[食事記録の一覧画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/atleta/1.eps}}
    \label{fig:foodlog-1}
  }
  \subfigure[練習スケジュールのカレンダー画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/atleta/2.eps}}
    \label{fig:foodlog-2}
  }
  \subfigure[指導者とのメッセージ画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/atleta/3.eps}}
    \label{fig:foodlog-3}
  }
  \caption{Atleta のアプリ画面}
  \label{fig:atleta}
\end{figure}


# MyFitnessPal

MyFitnessPal [\cite{bib:myfitnesspal}] はアスリートや一般人が自身で栄養管理を行うためのアプリケーションで、世界的に広く使われている。
このアプリケーションでは食事記録の他に運動量・体重・水分量なども登録でき、
目標体重に合わせて日毎のカロリー摂取目標を算出してくれる。
MyFitnessPalでは400万件以上の食品を登録することができ、
登録も製品のバーコードを使って行うことができるため、
食品登録時に所望の食品が登録できないというフラストレーションが非常に少ない。

\begin{figure}[htbp]
  \centering
  \subfigure[テキストによる食事の検索画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/myfitnesspal/1.eps}}
    \label{fig:myfitnesspal-1}
  }
  \subfigure[食事の詳細画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/myfitnesspal/2.eps}}
    \label{fig:myfitnesspal-2}
  }
  \subfigure[運動の登録画面]{
    \fbox{\includegraphics*[width=0.3\linewidth]{fig/myfitnesspal/3.eps}}
    \label{fig:myfitnesspal-3}
  }
  \caption{MyFitnessPal のアプリ画面}
  \label{fig:myfitnesspal}
\end{figure}

# Slack

Slack [\cite{bib:slack}] は主にビジネス上のコミュニケーションを図るためのチャットツールの一種である。
単なるチャットツールであり食事に特化した機能は一切ないが、食事画像やアドバイスを共有できるため本研究が対象とする課題を解決するために使われることがある。
このようなツールが利用されている背景には、アスリートも管理栄養士も食事のアドバイスを通したコミュニケーションに重きを置いているという事情が見える。
Slackはモバイルアプリケーションでもデスクトップアプリケーションでも提供されているため、
アスリートは投稿がいつでも簡単にでき、管理栄養士はツールに集中して作業することができる。

また、チャットツールが栄養指導に用いられる似たような例としてLINE [\cite{bib:line}] が使われることもある。
