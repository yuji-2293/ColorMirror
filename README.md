# 🎨 ColorMirror

## 🚀 サービス概要（3行で説明）
- その日の気分と相関する「色」を通じて、1日をポジティブに始められる記録アプリです。
- 登録した気分に対して、天気や感情をもとにAIがパーソナライズコメントを生成します。
- コメントは“自分だけの手紙”として記録され、自己対話を促します。

---

## 🎯 このアプリで実現したいこと（開発背景）
気候や気圧の変化で体調や気分が落ち込みやすい「天気痛」を持つ自分自身の経験から、
誰にも言えず抱え込みがちな気分を、**自分自身が理解するためのアウトプット**として開発しました。

「なんとなく落ち込む」を可視化し、
「今の私はこうだからこう感じるんだ」と**納得しながら日常を送る**ことをサポートしたい。
そのために、このアプリではただの気分ログではなく、**AIとの対話**を通じて自己認知を深められる仕組みを意識しています。

---

## 🧠 サービス設計思想（体験設計のこだわり）
本サービスは「記録・見る・振り返る」の3つの柱で設計されています。

### 🔹 1. 記録：最小ステップで感情をアウトプット
- 気分を選択（色変換）
- 天気取得（自動）
- コメント生成（AI）
- すべてを**3タップで完結**させ、ユーザーが「思考を手放して感情を記録できる」ように設計しました

### 🔹 2. 見る：その日の自分と向き合う
- 登録された気分やコメントを一覧で表示
- コメントはまるで手紙のように演出できるよう**個別モーダル化**
### 🔹 3. 振り返る：気分の傾向を可視化して認知する
- `heatmap.js`と`chart.js`によるグラフ可視化
- 日別／週別の気分スコアと密度を俯瞰

**今後の実装予定：振り返りグラフに対するAIコメント生成**
→ 気分の傾向に基づいた自己対話メッセージをAIが自動で生成し、
「気分を記録して終わり」から「振り返りに意味を与える」へ。

---

## 🧑‍💻 ターゲットユーザー
- 天気や気圧に敏感で気分が左右されやすい人
- 周囲に共感されづらい不調を一人で抱えてしまう人
- 自己理解やメンタルケアに関心のある人
- 自分の内面にじっくり向き合いたい人

### 👧 ユーザーの獲得方法
- 開発記事をqiita or noteで書いて周知
- RUNTEQコミュニティにて周知

---


## 👩‍💻機能候補

### MVP
- deviseによるログイン認証
  - ログイン機能
  - ログアウト機能
- 基本CRUD
- 天気APIによる天気情報の表示

### 本リリース
- deviseによるユーザー機能
  - パスワードの編集機能
  - メールアドレス編集機能
  - 居住都市編集機能
  - ユーザー退会機能
* 上記3つはモーダル表示させ,Hotwireで非同期処理させます
- AIによるデータの分析、コメント生成、色の生成
- 非同期処理（SolidQueue）によるキューイングジョブ
- LINE連携 or 通知によるリマインダ機能
- Google連携 or 認証によるログイン
- CalHeatmap.jsによるグラフ作図
- chart.jsによるグラフ作図
- swiper.jsによるスライド式form画面
- 静的OGP
- Googleフォームによるお問い合わせ機能
- 利用規約
- プライバシーポリシー
- レスポンシブ対応

## 🔧 技術スタック

| 分類             | 技術                     | 補足                         |
|------------------|--------------------------|------------------------------|
| フロントエンド   | HTML / CSS / JS / Tailwind CSS | UI設計 |
| バックエンド     | Ruby on Rails 8.x        | Rails 8.0 / Ruby 3.2        |
| データベース     | PostgreSQL               | 本番 / 開発共通             |
| 認証             | Devise  / Google                 | ログイン認証   Google認証              |
| 非同期処理       | SolidQueue / ActiveJob   | AIコメント生成・通知処理     |
| ライブラリ          | chart.js / CalHeatmap.js swiper.js | チャートグラフ作図 / ヒートマップ作図 | スライド式form画面 |
| API連携          | OpenWeatherMap / OpenAI / LINE | 天気取得・コメント生成・通知 |
| デプロイ         | Render                   | GitHub連携CI/CD              |
| テスト           | RSpec                    | モデル・システム        |

---

## 📊 ER図 / 画面遷移図

### 画面遷移図
[Figmaで確認する](https://www.figma.com/design/c6JfZFIlQ5UGLUAM31DEuB/RUNTEQ%E5%8D%92%E5%88%B6%E3%82%A2%E3%83%97%E3%83%AA-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1)

### ER図
![ER図](https://i.gyazo.com/fd6e6cf2045a23f99c0da60f9c564521.png)

---

## 🗣️ 差別化ポイント（競合比較）

| 競合サービス       | 特徴                                               |
|--------------------|----------------------------------------------------|
| Good Morning Color | チーム向け業務支援型 / 一言掲示板 / 有料          |
| ColorMirror（本作）| **個人向け / メンタルケア特化 / AI手紙コメント付き** |

- チームで共有するためではなく、**自分の気分と静かに向き合う**ためのアプリ
- 気分の要因として**気候・天気の影響も明示的に組み込み**
- ログを貯めるだけでなく**言葉で寄り添ってくれる**体験設計

---

## 📣 今後の展望
- 振り返り画面でのAIコメント分析機能（自己対話化）
- データの自動リセットとリフレッシュ設計（新鮮な記録体験）
- LINEリマインダー強化（記録習慣の定着）

## 🧭 開発を通じて得た気づきと今後の技術展望

今回の開発ではVanilla JSでインタラクティブな操作を実装しましたが、結果的に構造がコンポーネントベースになっていたことに気づきました。
意図せず自然にそうなっていたことで、このアプリのファイル構成がUI状態管理やロジックの分離といった観点から、ReactやVueといったモダン技術への親和性が高い構造だったと振り返ることができました。

この気づきから、将来的にはモダンフレームワークへリプレイスし、UIの柔軟性・保守性を高めながら、より洗練されたユーザー体験を提供する自信を得られました。

---

## 🔗 公開URL

https://colormirror.jp/

---


## 🏁 おわりに

ここまでお読みいただいてありがとうございます。

このアプリに触れることで、課題を解決することができなくとも、
感情を第三者からフィードバックされたとき、
自分がそれをどう解釈するのか。
その解釈について考える時間を提供できることができれば幸いです。

---
