# Controle de Produtividade Banho — Pintura Eletrostática

Sistema de monitoramento em tempo real do tratamento de peças (pré-banho e
banho), com grade de cestos, leitura de código de barras da OP, pausa de tempo,
dashboards, painel público e exportação em Excel. Roda 24h no Railway com
PostgreSQL. Otimizado para tablet (Samsung Galaxy Tab A9).

---

## LEIA PRIMEIRO — por que o build falhou antes

O erro "Railpack could not determine how to build the app" aconteceu porque os
arquivos NAO estavam na raiz do repositorio do GitHub. O Railway olhou a pasta
principal, nao encontrou o app.py, e nao soube que era Python.

REGRA DE OURO: o app.py precisa aparecer DIRETO na pagina inicial do
repositorio, NAO dentro de uma pasta.

Este pacote ja vem com arquivos extras (nixpacks.toml, .python-version,
start.sh, railway.json) que reforcam o reconhecimento como Python.

---

## Subir no GitHub do jeito certo

### Opcao A — pelo site do GitHub (mais simples)
1. Crie um repositorio novo (vazio, sem README).
2. Extraia este .zip. Voce vera os arquivos soltos: app.py, requirements.txt,
   Procfile, pastas templates e static, etc.
3. Na pagina do repo: Add file -> Upload files.
4. Arraste os arquivos SOLTOS e as pastas templates e static. NAO arraste a
   pasta-mae. Tem que aparecer o app.py direto na lista do repo.
5. Commit changes.

CERTO: aparece app.py, requirements.txt, templates/ na pagina do repo.
ERRADO: aparece so uma pasta que voce precisa clicar pra entrar -> build falha.

### Opcao B — git (linha de comando)
    cd caminho/ate/os/arquivos    (a pasta que contem o app.py)
    git init
    git add .
    git commit -m "Controle de Produtividade Banho"
    git branch -M main
    git remote add origin https://github.com/SEU_USUARIO/SEU_REPO.git
    git push -u origin main

---

## Publicar no Railway
1. railway.app -> New Project -> Deploy from GitHub repo -> escolha o repo.
2. New -> Database -> Add PostgreSQL (cria DATABASE_URL automaticamente).
3. No servico web, em Variables, adicione SECRET_KEY = uma frase longa aleatoria.
4. Em Settings -> Networking -> Generate Domain para obter a URL publica.

Se ainda falhar: Settings -> Build -> confira que o Builder esta como Nixpacks
(nao Railpack). O railway.json ja forca isso.

Sem o PostgreSQL conectado, o app usa SQLite local que se perde a cada reinicio.
Para uso 24/7, o passo 2 e obrigatorio.

---

## Fluxo de uso
1. Preparacao: grade de cestos 1-19 (livres coloridos, em uso com cadeado).
   Toca num livre -> Iniciar preparacao (cronometro comeca).
2. Pode Pausar (cafe, ginastica) — tempo parado nao conta — e Retomar.
3. Ao terminar, toca em Parar tempo (cronometro congela). DEPOIS preenche os
   dados: bipa a OP (preenche codigo, texto breve e quantidade da lista mestra,
   editaveis), escolhe processo/tipo e conclui. Vai para a fila do banho.
4. Banho: operador inicia e finaliza. O cesto volta a ficar livre.
5. Qualquer card pode ser editado depois (tocar no cesto ocupado).

---

## Usuarios padrao (criados na 1a execucao — troque as senhas)
  admin / admin123   -> admin (dashboard, usuarios, lista mestra, Excel)
  banho / banho123   -> operador de banho
  op1..op6 / op1234  -> operadores de preparacao

Entre como admin para trocar senhas, criar usuarios e importar a lista mestra.

---

## Lista mestra (Excel do SAP)
Tela Lista Mestra (admin) -> importar o relatorio do SAP em .xlsx.
Colunas usadas: Ordem (OP), Material (codigo), Texto breve material,
Quantidade total. Ao bipar a OP, esses dados preenchem o card automaticamente.

## Relatorios / backup
No dashboard ha Excel pre-banho e Excel banho (download com data/hora no nome).
O painel da gerencia fica em SUA_URL/painel (aberto, so leitura, filtro por data).
