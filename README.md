# Stock Report

Para ajudar os investidores de ações a terem um relatório de suas ações pegando do site de B3.

[Click here to visit](https://stock-report-app.herokuapp.com/)

## Funcionalidade

Upload de um arquivo (CSV, XLSX) baixado da B3,
irá processar o arquivo e irá criar um novo arquivo
com os recebimentos de Dividendos e JCP junto para por 
ação preparado para usar na declaração do IPRF.

## Dependencies

- Ruby 3.0.4
- Rails 7.0.2
- Postgresql 12
- Docker(optional)

## Como rodar

```bash
cp .env.sample .env
```

Coloque o seu usuário, senha, e host no arquivo `.env`

```bash
./bin/setup
```

```bash
./bin/dev
```

## Run test

```bash
rake db:test:prepare
```

```bash
rspec
```
