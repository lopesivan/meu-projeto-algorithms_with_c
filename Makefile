.PHONY: all clean init config build run rebuild help info

# Configurações
BUILD_DIR := build
BUILD_TYPE ?= Release
EXECUTABLE := $(BUILD_DIR)/meu_app

# Cores para output
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
CYAN := \033[0;36m
MAGENTA := \033[0;35m
NC := \033[0m # No Color

# Target padrão
all: init config build

# Ajuda
help:
	@echo "$(CYAN)╔════════════════════════════════════════════╗$(NC)"
	@echo "$(CYAN)║    Lista Demo - Algorithms with C          ║$(NC)"
	@echo "$(CYAN)╚════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(BLUE)📦 Comandos disponíveis:$(NC)"
	@echo "  $(GREEN)make all$(NC)       - Executa init, config e build"
	@echo "  $(GREEN)make init$(NC)      - Instala dependências com Conan"
	@echo "  $(GREEN)make config$(NC)    - Configura o projeto com CMake"
	@echo "  $(GREEN)make build$(NC)     - Compila o projeto"
	@echo "  $(GREEN)make run$(NC)       - Executa o programa compilado"
	@echo "  $(GREEN)make rebuild$(NC)   - Limpa e reconstrói tudo"
	@echo "  $(GREEN)make clean$(NC)     - Remove arquivos de build"
	@echo "  $(GREEN)make info$(NC)      - Mostra informações do projeto"
	@echo ""
	@echo "$(YELLOW)⚙️  Variáveis:$(NC)"
	@echo "  BUILD_TYPE=Release|Debug (padrão: Release)"
	@echo ""
	@echo "$(CYAN)🚀 Exemplo de uso:$(NC)"
	@echo "  make all && make run"

# Instala as dependências com Conan
init:
	@echo "$(BLUE)>>> 📦 Instalando dependências com Conan...$(NC)"
	@echo "$(YELLOW)ℹ  Buscando pacote algorithms_with_c...$(NC)"
	@conan install . \
		--output-folder=$(BUILD_DIR) \
		--build=missing \
		-s build_type=$(BUILD_TYPE)
	@echo "$(GREEN)✓ Dependências instaladas$(NC)"

# Configura o CMake usando as toolchains do Conan
config:
	@if [ ! -f "$(BUILD_DIR)/conan_toolchain.cmake" ]; then \
		echo "$(YELLOW)⚠  Toolchain do Conan não encontrado. Execute 'make init' primeiro.$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)>>> ⚙️  Configurando CMake...$(NC)"
	@cmake -S . -B $(BUILD_DIR) \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_DIR)/conan_toolchain.cmake \
		-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	@echo "$(GREEN)✓ CMake configurado$(NC)"

# Compila o projeto
build:
	@if [ ! -f "$(BUILD_DIR)/Makefile" ]; then \
		echo "$(YELLOW)⚠  Makefiles do CMake não encontrados. Execute 'make config' primeiro.$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)>>> 🔨 Compilando projeto...$(NC)"
	@cmake --build $(BUILD_DIR) --config $(BUILD_TYPE) -j$$(nproc)
	@echo "$(GREEN)✓ Compilação concluída$(NC)"
	@echo "$(YELLOW)ℹ  Executável: $(EXECUTABLE)$(NC)"

# Executa o programa
run:
	@if [ ! -f "$(EXECUTABLE)" ]; then \
		echo "$(YELLOW)⚠  Executável não encontrado. Execute 'make build' primeiro.$(NC)"; \
		exit 1; \
	fi
	@echo "$(CYAN)╔════════════════════════════════════════════╗$(NC)"
	@echo "$(CYAN)║      🚀 Iniciando Lista Demo 🚀            ║$(NC)"
	@echo "$(CYAN)╚════════════════════════════════════════════╝$(NC)"
	@echo ""
	@$(EXECUTABLE)

# Reconstrói tudo do zero
rebuild: clean all
	@echo "$(GREEN)✓ Rebuild completo$(NC)"

# Limpa arquivos de build
clean:
	@echo "$(YELLOW)>>> 🧹 Limpando arquivos de build...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f CMakeUserPresets.json
	@echo "$(GREEN)✓ Limpeza concluída$(NC)"

# Info sobre o projeto
info:
	@echo "$(CYAN)╔════════════════════════════════════════════╗$(NC)"
	@echo "$(CYAN)║         Informações do Projeto             ║$(NC)"
	@echo "$(CYAN)╚════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(BLUE)Build Type:$(NC) $(BUILD_TYPE)"
	@echo "$(BLUE)Build Dir:$(NC) $(BUILD_DIR)"
	@echo "$(BLUE)Executable:$(NC) $(EXECUTABLE)"
	@echo ""
	@echo "$(YELLOW)Arquivos do projeto:$(NC)"
	@ls -lh main.c conanfile.txt CMakeLists.txt 2>/dev/null || echo "  Arquivos não encontrados"
	@echo ""
	@if [ -d "$(BUILD_DIR)" ]; then \
		echo "$(YELLOW)Estrutura de build:$(NC)"; \
		tree -L 2 $(BUILD_DIR) 2>/dev/null || find $(BUILD_DIR) -maxdepth 2 -type d; \
	else \
		echo "$(YELLOW)Build dir não existe ainda - execute 'make init'$(NC)"; \
	fi
