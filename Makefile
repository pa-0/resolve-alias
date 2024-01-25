NAME = resolve-alias

RM_RF = rm -rf
SWIFT = swift

all = $(bin) $(bash_completions) $(fish_completions) $(zsh_completions)

build = .build
release = $(build)/release

bin = $(release)/$(NAME)
bash_completions = $(release)/$(NAME).bash
fish_completions = $(release)/$(NAME).fish
zsh_completions = $(release)/_$(NAME)

all: $(all)

clean:
	$(RM_RF) $(build)

$(bin):
	$(SWIFT) build --configuration release

$(bash_completions): $(bin)
	$< --generate-completion-script bash >$@

$(fish_completions): $(bin)
	$< --generate-completion-script fish >$@

$(zsh_completions): $(bin)
	$< --generate-completion-script zsh >$@

.PHONY: all clean

