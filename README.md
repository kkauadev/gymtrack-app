# gymtrack

![License](https://img.shields.io/badge/license-MIT-blue.svg)
### 📦 Tecnologias utilizadas
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

### 📂 Estrutura de Pastas
O projeto segue uma organização modular, separando responsabilidades em diferentes camadas para facilitar a manutenção e escalabilidade. A seguir cada diretório e seus arquivos principais:
```mermaid
graph LR;
    LIB[lib] --> CONFIG[config]
    CONFIG --> A1[assets.dart]
    CONFIG --> A2[dependencies.dart]

    LIB --> DATA[data]
    DATA --> REPOSITORIES[repositories]
    REPOSITORIES --> LOCAL_REPO[entity_repository_local.dart]
    REPOSITORIES --> REMOTE_REPO[entity_repository_remote.dart]

    DATA --> SERVICES[services]
    SERVICES --> LOCAL_SERVICE[local]
    SERVICES --> API_SERVICE[api]
    API_SERVICE --> DTO[model - dto]
    API_SERVICE --> API_CLIENT[api_client.dart]

    LIB --> DOMAIN[domain]
    DOMAIN --> MODELS[models]
    DOMAIN --> USE_CASES[use_cases]

    LIB --> ROUTING[routing]
    ROUTING --> R1[router.dart]
    ROUTING --> R2[routes.dart]

    LIB --> UI[ui]
    UI --> CORE[core]
    CORE --> WIDGETS[widgets]
    CORE --> THEME[theme]
    UI --> PAGES[pages]

    LIB --> UTILS[utils]
    LIB --> MAIN[main.dart]
```

### 🛠️ Como Instalar e Rodar
Para configurar e executar o projeto Flutter corretamente no seu ambiente, siga os passos abaixo:
#### 1.Pré-requisitos
Antes de iniciar, certifique-se de ter instalado:
- Flutter SDK (Baixar aqui)
- Dart SDK (já incluído no Flutter)
- Android Studio ou VS Code (para desenvolvimento)
- Dispositivo físico ou emulador configurado
- Git (para clonar o repositório, opcional)
```sh
flutter doctor
```
#### 2.Instalar Dependências
Antes de rodar o aplicativo, instale todas as dependências do Flutter:
```sh
flutter pub get
```
#### 3.Rodar o Aplicativo
Com tudo configurado, execute o comando abaixo para iniciar o app:
```sh
flutter run
```
