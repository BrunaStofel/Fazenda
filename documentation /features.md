
# Aplicativo para fazenda

A ideia é que o produtor utilize este aplicativo para cadastrar **talhões** (áreas da fazenda) e controlar os **custos de produção**.

## Cadastro de talhões

O produtor poderá cadastrar talhões informando, no mínimo:
- **Nome do talhão**
- **Tamanho em hectares** (número)

Esses dados devem ser salvos em um **backend** (API) com persistência em **banco de dados**.

## Custos por talhão

Para cada talhão, o produtor poderá registrar os **custos dos produtos utilizados**, como:
- Defensivos
- Sementes
- Adubos
- Outros insumos

Cada lançamento de custo deve conter, pelo menos:
- **Descrição do produto**
- **Valor** (numérico)
- (Opcional) **Data** do lançamento

O aplicativo deve:
- Enviar os lançamentos de custo para o backend.
- Somar, no backend ou no app, os lançamentos para apresentar o **custo total de cada talhão**.

# Documentação de Features

Este documento descreve as principais funcionalidades do aplicativo, bem como o comportamento esperado e orientações de implementação.

---

## 1. Gestão de Talhões

### 1.1. Listagem de talhões

**Descrição:**  
Exibir a lista de todos os talhões cadastrados para o produtor.

**Requisitos funcionais:**
- Exibir uma lista com:
  - Nome do talhão
  - Tamanho em hectares
  - Custo total já lançado para o talhão (se disponível)
- Permitir:
  - Acessar o detalhe de um talhão ao tocar em um item da lista
  - Criar um novo talhão via botão de ação (ex.: FAB “+”)

**Comportamento da UI:**
- Tela com `AppBar` (título: “Talhões”).
- Lista (`ListView`) de `Card` ou `ListTile`.
- Estado de carregamento (spinner) enquanto busca dados no backend.
- Estado de vazio: mensagem quando não houver talhões.

**Integração com backend:**
- Endpoint: `GET /talhoes`
- Tratamento de:
  - Sucesso: atualizar lista
  - Erro: exibir mensagem amigável e opção de tentar novamente

---

### 1.2. Cadastro/Edição de talhão

**Descrição:**  
Permitir criar e editar talhões.

**Requisitos funcionais:**
- Campos obrigatórios:
  - Nome do talhão (texto)
  - Tamanho em hectares (numérico, positivo)
- Validações:
  - Nome não pode ser vazio
  - Hectares deve ser > 0
- Ações:
  - Salvar
  - Cancelar (voltar sem salvar)

**Comportamento da UI:**
- Tela com `Form` e `TextFormField` para:
  - Nome
  - Hectares
- Botão “Salvar” habilitado somente quando o formulário for válido.

**Integração com backend:**
- Criar talhão:
  - Endpoint: `POST /talhoes`
  - Body JSON: `{ "nome": string, "hectares": number }`
- Editar talhão:
  - Endpoint: `PUT /talhoes/:id`
  - Body com dados atualizados
- Após sucesso:
  - Voltar para a lista de talhões
  - Atualizar a lista (recarregar ou atualizar em memória)

---

## 2. Gestão de Custos por Talhão

### 2.1. Detalhe do talhão

**Descrição:**  
Exibir os dados do talhão e os custos associados.

**Requisitos funcionais:**
- Mostrar:
  - Nome do talhão
  - Tamanho em hectares
  - Custo total acumulado
- Listar custos lançados para o talhão:
  - Descrição do produto
  - Valor
  - Data (se houver)

**Comportamento da UI:**
- Tela com cabeçalho do talhão e lista de custos.
- Botão para:
  - Adicionar novo custo
  - (Opcional) Editar dados do talhão

**Integração com backend:**
- Endpoint: `GET /talhoes/:id`
  - Pode retornar:
    - Dados do talhão
    - Lista de custos (embutida ou via outro endpoint: `GET /talhoes/:id/custos`)

---

### 2.2. Cadastro de custo

**Descrição:**  
Permitir registrar um custo associado a um talhão.

**Requisitos funcionais:**
- Campos:
  - Descrição do produto (texto, obrigatório)
  - Valor (numérico, obrigatório, > 0)
  - Data (opcional; se não informada, usar data atual)
- Ações:
  - Salvar
  - Cancelar

**Comportamento da UI:**
- Tela ou modal com `Form` e campos:
  - `TextFormField` para descrição
  - `TextFormField` para valor (teclado numérico)
  - Seletor de data (opcional)
- Validação em tempo de digitação ou ao salvar.

**Integração com backend:**
- Endpoint: `POST /talhoes/:id/custos`
- Body JSON:  
  `{ "descricao": string, "valor": number, "data": string (ISO opcional) }`
- Após sucesso:
  - Voltar para a tela de detalhe do talhão
  - Atualizar lista de custos e custo total

---

## 3. Autenticação (futuro)

*(Opcional, para quando for implementar login do produtor.)*

### 3.1. Login do produtor

**Descrição:**  
Permitir que o produtor acesse seus dados com segurança.

**Requisitos básicos:**
- Tela de login com:
  - E-mail / usuário
  - Senha
- Fluxo:
  - Enviar credenciais para API
  - Receber token (JWT ou similar)
  - Armazenar token com segurança no app
  - Usar token nas próximas requisições

---

## 4. Captura de Nota Fiscal por Foto (futuro)

### 4.1. Upload de foto de nota fiscal

**Descrição:**  
Permitir tirar foto da nota e enviar para o backend para leitura dos dados e lançamento automático de custos.

**Requisitos funcionais (front):**
- Permitir escolher câmera ou galeria.
- Exibir preview da foto antes de enviar.
- Enviar imagem para endpoint específico.

**Integração com backend:**
- Endpoint: `POST /talhoes/:id/notas`
  - Upload multipart (imagem)
- Backend faz OCR e cria lançamentos de custo.
- App atualiza a lista de custos ao receber resposta da API.