# Architecture & Boas Práticas – Flutter

Este documento define padrões e boas práticas para o desenvolvimento do app em Flutter.

---

## 1. Organização de Pastas

Estrutura sugerida em `lib/`:

- `lib/`
  - `main.dart`
  - `core/`
    - `constants/` – textos fixos, cores básicas
    - `theme/` – temas, estilos
    - `errors/` – classes de erro
    - `network/` – configuração HTTP, interceptors
  - `features/`
    - `talhoes/`
      - `data/`
        - `models/` – modelos de dados (DTOs, mapeamento JSON)
        - `datasources/` – chamadas HTTP, acesso à API
        - `repositories/` – implementação de repositórios
      - `domain/`
        - `entities/` – modelos de domínio (`Talhao`, `Custo`)
        - `repositories/` – contratos/abstrações de repositório
        - `usecases/` – casos de uso (ex.: `ListarTalhoes`, `CriarTalhao`)
      - `presentation/`
        - `pages/` – telas (UI)
        - `widgets/` – componentes reutilizáveis
        - `controllers/` ou `providers/` – gerência de estado (ex.: Riverpod/Provider)
    - `auth/` (futuro)
    - `notas/` (futuro)
  - `shared/`
    - `widgets/` – widgets comuns (botões, campos, loaders)
    - `utils/` – helpers, formatadores, etc.

---

## 2. Padrão de Arquitetura

Recomendado: **Clean Architecture simplificada** ou **Feature-First** com camadas bem definidas.

- **Domain**:
  - Independente de Flutter.
  - Contém entidades, interfaces de repositório, casos de uso.
- **Data**:
  - Implementa repositórios.
  - Faz mapeamento de JSON ↔ modelos.
  - Chama APIs HTTP.
- **Presentation**:
  - Telas, widgets e lógica de apresentação.
  - Usa gerência de estado (ex.: Riverpod, Provider, Bloc).

Regra de dependências:
- `presentation` → depende de `domain`
- `data` → depende de `domain`
- `domain` → não depende de `presentation` nem `data`

---

## 3. Gerência de Estado

Escolha uma abordagem consistente (ex.: **Riverpod**, **Provider**, **Bloc**).  
Boas práticas:

- Não colocar lógica de negócio diretamente nos `Widgets`.
- Controladores (ex.: `Notifier`, `ChangeNotifier`, `Cubit`, `Bloc`) devem:
  - Chamar casos de uso do `domain`.
  - Expor estados imutáveis (loading, sucesso, erro).
- UI:
  - Observa o estado e reage (renderiza loading, listas, mensagens de erro).

---

## 4. Comunicação com Backend

- Usar `Dio` ou `http` com uma camada de serviço própria.
- Centralizar:
  - URL base da API
  - Interceptadores (autenticação, logs)
- Tratar erros:
  - Timeout
  - Erros 4xx/5xx
  - Sem conexão

Boas práticas:
- Não chamar o `Dio` diretamente na UI.
- Criar **datasources** (ex.: `TalhaoRemoteDataSource`) responsáveis por:
  - Executar requisições HTTP.
  - Fazer parse do JSON em modelos.

---

## 5. Modelos e Entidades

- **Entidades (domain)**:
  - Simples, sem dependência de pacotes de rede/JSON.
  - Representam o que o app precisa (ex.: `TalhaoEntity`, `CustoEntity`).
- **Models (data)**:
  - Sabem converter JSON ↔ objeto.
  - Podem estender/estarem relacionadas às entidades do domínio.

Exemplo (conceitual):
- `TalhaoEntity` – no `domain`
- `TalhaoModel` – no `data/models`, com `fromJson` / `toJson`

---

## 6. Tratamento de Erros e Resultados

- Usar tipos explícitos para representar sucesso/erro:
  - Ex.: `Either<Failure, T>`, `Result<T>`, etc.
- Evitar `try/catch` espalhado pela UI:
  - Lidar com erros no `data`/`domain` e expor estados amigáveis à UI.

---

## 7. Estilo e Padrões de Código

- Ativar `analysis_options.yaml` com regras de lint (ex.: `pedantic` ou `flutter_lints`).
- Seguir convenções:
  - Nomes de classes em `PascalCase`.
  - Nomes de métodos/variáveis em `camelCase`.
  - Arquivos em `snake_case`.
- Manter widgets pequenos e reutilizáveis.
- Usar `const` sempre que possível para melhorar performance.

---

## 8. Navegação

- Preferir navegação nomeada ou um gerenciador de rotas.
- Definir rotas em um só lugar (ex.: `app_router.dart`).
- Evitar lógica de negócio dentro das rotas.

---

## 9. Testes

- **Unit tests**:
  - Para casos de uso (domain).
  - Para repositórios (data), usando mocks do datasource.
- **Widget tests**:
  - Para telas críticas (ex.: listagem de talhões, cadastro de custo).

---

## 10. Configurações por Ambiente

- Separar configurações de:
  - Desenvolvimento
  - Homologação
  - Produção
- Ex.: uso de arquivos `.env` (com suporte no Flutter) ou configurações por flavor.

---

## 11. Boas Práticas de UX para o Contexto Rural

- Telas simples, poucas ações por tela.
- Textos claros e grandes.
- Botões bem destacados.
- Feedback visual para:
  - Salvando / Carregando
  - Erros de conexão (com opção “Tentar novamente”)
- Considerar uso offline futuro (cache local) para regiões sem internet.