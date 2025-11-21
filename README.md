Pronto! Criei um Makefile no estilo que você pediu. 

## Como usar:

```bash
# Ver comandos disponíveis
make help

# Compilar e executar
make all && make run

# Ou passo a passo
make init      # Instala dependências
make config    # Configura CMake
make build     # Compila
make run       # Executa

# Limpar e reconstruir
make rebuild

# Ver informações
make info
```

## Principais diferenças do original:

- **Mais simples**: Conan 2 coloca arquivos direto em `build/`, não precisa da estrutura `build/build/Release/generators`
- **Cores e estilo**: Mantive o visual bonito com cores e caixinhas
- **Mensagens claras**: Indica o que está acontecendo em cada etapa
- **Validações**: Checa se os passos anteriores foram executados antes de continuar

Agora é só rodar `make all` e depois `make run`! 🚀

