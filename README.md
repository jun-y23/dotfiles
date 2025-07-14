# dotfiles

新しいMacで簡単にdotfilesを設定できるセットアップスクリプトです。

## 使い方

### 方法1: ワンライナーで実行（推奨）
```bash
curl -sSL https://raw.githubusercontent.com/jun-y23/dotfiles/main/bootstrap.sh | bash
```

### 方法2: 手動でクローンして実行
1. このリポジトリをクローンする
```bash
git clone https://github.com/jun-y23/dotfiles.git
cd dotfiles
```

2. インストールスクリプトを実行する
```bash
chmod +x install.sh
./install.sh
```

## 何がインストールされるか

- **Homebrew**: macOSのパッケージマネージャー
- **Brewfile**: 必要なアプリケーションとツールをインストール
- **mise**: バージョン管理ツール
- **stow**: dotfilesのシンボリックリンク管理
- **macOS設定**: キーボード、トラックパッド、Dockなどの設定

## 含まれるファイル

- `install.sh`: メインのインストールスクリプト
- `Brewfile`: Homebrewでインストールするパッケージ一覧
- `macos_setup.sh`: macOSの設定スクリプト

## カスタマイズ

`install.sh`の`STOW_PACKAGES`変数を編集して、stowするパッケージを変更できます。

## 注意事項

- このスクリプトはmacOS専用です
- 実行前に必ずファイルの内容を確認してください
- 既存の設定が上書きされる可能性があります