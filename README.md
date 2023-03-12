# Ruby on Rails 6 Docker Template

- Ruby 2.7.7
- Node.js 18.x
- PostgreSQL
- Bundler 2.4.6

## 環境構築のステップ

ワーキングディレクトリ、コンテナ名は適宣変更してください。

### 1. Rails アプリケーションの作成

以下のコマンドを実行し、Rails アプリケーションを作成します。

```sh
docker-compose run --no-deps web rails new . --force --database=postgresql
```

### 2. Dockerfile の更新

Rails のアプリケーションを作成したら、Dockerfile でコメントアウトしている箇所のコメントを外します。

```dockerfile
COPY Gemfile /myapp
COPY Gemfile.lock /myapp
COPY package.json /myapp
COPY yarn.lock /myapp

RUN yarn install --check-files

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle _$BUNDLER_VERSION\_ install -j4
```

### 3. ビルドの実行

ビルドを実行し、gem をインストールします。

```sh
docker-compose build
```

### 4. データベースの設定変更

`config/database.yml` の default を以下に変更します。

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

### 5. Rails サーバーの起動

```sh
docker-compose up -d
```

続いて以下のコマンドを実行してデータベースを作成してください。

```sh
docker-compose exec web bash
rails db:create
```
