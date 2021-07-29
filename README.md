# 実行コマンド
## ecs_exec.sh
ECSクラスタのコンテナにログイン

**[オプション]**
```
--profile   -p  AWSプロファイル名
--ecs       -e  ECSクラスタ名
--service   -s  ECSサービス名
--container -c  ログインするコンテナ名 (nginx/rails/mysql/redis/memcached)
```

**[例]**
```
/bin/bash ecs_exec.sh -p kimitap-dev -e kimitap-trial-ecs-cluster -s kimitap-trial-web -c rails
/bin/bash ecs_exec.sh --profile kimitap-dev --ecs kimitap-trial-ecs-cluster --service kimitap-trial-web --container rails
```
