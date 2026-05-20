# SM — Tela de Login (Flutter)

## Estrutura de arquivos

```
sm/
├── lib/
│   ├── main.dart                          # Entry point do app
│   │
│   ├── theme/
│   │   └── sm_theme.dart              # Cores, ThemeData e tokens de design
│   │
│   ├── screens/
│   │   ├── login_screen.dart              # Tela principal de login
│   │   ├── register_screen.dart           # Tela de cadastro (placeholder)
│   │   └── forgot_password_screen.dart    # Tela de recuperação de senha (placeholder)
│   │
│   ├── widgets/
│   │   ├── sm_text_field.dart         # Campo de input customizado
│   │   └── sm_button.dart             # Botão primário com loading state
│   │
│   └── utils/
│       └── app_routes.dart                # Constantes e mapa de rotas
│
├── assets/
│   └── images/                            # Imagens e assets visuais
│
└── pubspec.yaml                           # Dependências do projeto
```

## Como rodar

```bash
flutter pub get
flutter run
```

## Dependências

- **flutter**: SDK principal
- **google_fonts**: Fontes customizadas (opcional, já configurado)

## Funcionalidades implementadas

- [x] Tela de login com e-mail e senha
- [x] Validação de formulário (e-mail válido, senha mínima)
- [x] Toggle de visibilidade da senha
- [x] Estado de loading no botão "Entrar"
- [x] Link "Esqueci minha senha"
- [x] Link "Ainda não tem uma conta? Registre-se"
- [x] Fiel ao design original (cores azul escuro, card branco, ícones)
- [x] Responsivo via `SingleChildScrollView` + `maxWidth`

## Próximos passos sugeridos

- [ ] Integrar autenticação real (Firebase, REST API, etc.)
- [ ] Implementar tela de cadastro
- [ ] Implementar tela de recuperação de senha
- [ ] Adicionar navegação com rotas nomeadas
- [ ] Adicionar gerenciamento de estado (Provider, Bloc, Riverpod)
