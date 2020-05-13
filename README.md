# SALES TALK
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/README.png" width=90%> 

https://www.sales-talk.net/  
自分の好きなモノ（映画や本など）を皆へ紹介する、記事投稿サイトです。  

# 開発の背景
### ①ポジティブな意見の集まるレビューサイトを作りたかった。
* 映画や本が好きで、ネット上のレビューをよく拝見するのですが、  
批判的なレビューも多いため「ポジティブな意見だけが集まるレビューサイトがあっても良いのでは」と感じていました。  
* そこで「自分の好きなモノを紹介する」という形であればポジティブな意見だけが集まると考え、このサービスの開発に至りました。

### ②自分の好きなモノを語りたい人が多いと思った。  
* 好きな本や映画・音楽などについて語りたいけれど、  
「自分の話ばかりするのは...」と普段は遠慮している方が多いと感じる出来事があり、そんな方たちのために存分に語れる場所を作りたいと思ったことも開発理由の一つです。

### ③ユニーク性を持たせるため、「営業」というコンセプトに。
* 「好きなモノを紹介する＝売り込む」と考え、  
  営業担当やマネージャーの様に、好きなモノの魅力を伝えるという意味で「営業」というコンセプトにしました。

# ターゲット
* 自分の好きなモノについて語りたいが、普段は遠慮しがちな方
* 自分の好きなモノを広めて、皆にも知って欲しい方
* 何か面白い映画や本をお探しの方
* 「紹介する事(セールストーク)」が好きな方

# 主な機能の紹介
### 記事の基本機能
* 記事の投稿/表示/編集/削除
* いいね機能(Ajax)
* 記事内に貼られたURLはリンク化  
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/article.png" width=60%>  


### 記事の検索機能(Ajax)  
* 「キーワード」「カテゴリー」「最新順orいいね順」の３つを組み合わせて検索可能  
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/search.png" width=60%>  

* タイムライン機能  
  →フォロー中のユーザーの記事のみ表示

### ユーザー関連の基本機能
* ユーザーの登録/表示/編集/削除
* ログイン/ログアウト機能
* フォロー/アンフォロー機能(Ajax)  
* ユーザーの画像アイコン設定機能  
  →画像の削除可能  
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/follow.png" width=45%>  

### 特殊ユーザー機能
* テストログイン機能（機能制限つき）  
  →ユーザー登録情報の編集/削除、記事の削除を制限
* adminユーザー機能  
  →全ユーザーの登録情報、記事を編集/削除可能  
  →admin自身のユーザー削除は不可  
  →adminのみ登録ユーザー一覧の表示が可能  
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/following_user.png" width=40%>   

### その他
* ページネーション機能
* レスポンシブ対応  
* Twitterカード対応

# 意識したこと
* 操作が分かりやすい画面設計
* gem「bullet」を使用し、N+1問題を発見・解消
* プルリクエストを利用しての擬似的なチーム開発
* RSpecにてテストコード記述

# 主な使用言語・技術
* Ruby 2.6.5
* Ruby on Rails 5.2.4.2
* PostgreSQL 12.1
* AWS（S3のみ）
## ER図
<img src="https://sales-talk-picture.s3-ap-northeast-1.amazonaws.com/+thumbnail/ER.png" width=90%>  

