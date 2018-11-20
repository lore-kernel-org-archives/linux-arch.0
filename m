From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 5/9] kbuild: simplify dependency generation for
 CONFIG_TRIM_UNUSED_KSYMS
Date: Mon, 19 Nov 2018 22:47:00 -0500 (EST)
Message-ID: <nycvar.YSQ.7.76.1811192245001.20453@knanqh.ubzr>
References: <1542675930-21114-1-git-send-email-yamada.masahiro@socionext.com> <1542675930-21114-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542675930-21114-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 20 Nov 2018, Masahiro Yamada wrote:

> My main motivation of this commit is to clean up scripts/Kbuild.include
> and scripts/Makefile.build.
> 
> Currently, CONFIG_TRIM_UNUSED_KSYMS works with a tricky gimmick;
> possibly exported symbols are detected by letting $(CPP) replace
> EXPORT_SYMBOL* with a special string '=== __KSYM_*===', which is
> post-processed by sed, and passed to fixdep. The extra preprocessing
> is costly, and hacking cmd_and_fixdep is ugly.
> 
> I came up with a new way to find exported symbols; insert a dummy
> symbol __ksym_marker_* to each potentially exported symbol. Those
> dummy symbols are picked up by $(NM), post-processed by sed, then
> appended to .*.cmd files. I collected the post-process part to a
> new shell script scripts/gen_ksymdeps.sh for readability. The dummy
> symbols are put into the .discard.* section so that the linker
> script rips them off the final vmlinux or modules.
> 
> A nice side-effect is building with CONFIG_TRIM_UNUSED_KSYMS will
> be much faster.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Nice work.

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
> 
> Changes in v2:
>   - Let gen_ksymdeps.sh add dependencies to .*.cmd file directly
>   - Fix typos
> 
>  include/asm-generic/export.h | 13 ++++++++-----
>  include/linux/export.h       | 18 +++++++++---------
>  scripts/Kbuild.include       | 28 ----------------------------
>  scripts/Makefile.build       |  7 +++++++
>  scripts/basic/fixdep.c       | 31 ++++---------------------------
>  scripts/gen_ksymdeps.sh      | 25 +++++++++++++++++++++++++
>  6 files changed, 53 insertions(+), 69 deletions(-)
>  create mode 100755 scripts/gen_ksymdeps.sh
> 
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 4d73e6e..294d6ae 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -59,16 +59,19 @@ __kcrctab_\name:
>  .endm
>  #undef __put
>  
> -#if defined(__KSYM_DEPS__)
> -
> -#define __EXPORT_SYMBOL(sym, val, sec)	=== __KSYM_##sym ===
> -
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +#if defined(CONFIG_TRIM_UNUSED_KSYMS)
>  
>  #include <linux/kconfig.h>
>  #include <generated/autoksyms.h>
>  
> +.macro __ksym_marker sym
> +	.section ".discard.ksym","a"
> +__ksym_marker_\sym:
> +	 .previous
> +.endm
> +
>  #define __EXPORT_SYMBOL(sym, val, sec)				\
> +	__ksym_marker sym;					\
>  	__cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
>  #define __cond_export_sym(sym, val, sec, conf)			\
>  	___cond_export_sym(sym, val, sec, conf)
> diff --git a/include/linux/export.h b/include/linux/export.h
> index ce764a5..fd8711e 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -92,22 +92,22 @@ struct kernel_symbol {
>   */
>  #define __EXPORT_SYMBOL(sym, sec)
>  
> -#elif defined(__KSYM_DEPS__)
> +#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +
> +#include <generated/autoksyms.h>
>  
>  /*
>   * For fine grained build dependencies, we want to tell the build system
>   * about each possible exported symbol even if they're not actually exported.
> - * We use a string pattern that is unlikely to be valid code that the build
> - * system filters out from the preprocessor output (see ksym_dep_filter
> - * in scripts/Kbuild.include).
> + * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
> + * from the $(NM) output (see scripts/gen_ksymdeps.sh). These symbols are
> + * discarded in the final link stage.
>   */
> -#define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
> -
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> -
> -#include <generated/autoksyms.h>
> +#define __ksym_marker(sym)	\
> +	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
>  
>  #define __EXPORT_SYMBOL(sym, sec)				\
> +	__ksym_marker(sym);					\
>  	__cond_export_sym(sym, sec, __is_defined(__KSYM_##sym))
>  #define __cond_export_sym(sym, sec, conf)			\
>  	___cond_export_sym(sym, sec, conf)
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 6cf6a8b..4b943f4 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -260,39 +260,11 @@ if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
>  	@set -e;                                                             \
>  	$(cmd_and_fixdep), @:)
>  
> -ifndef CONFIG_TRIM_UNUSED_KSYMS
> -
>  cmd_and_fixdep =                                                             \
>  	$(echo-cmd) $(cmd_$(1));                                             \
>  	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
>  	rm -f $(depfile);
>  
> -else
> -
> -# Filter out exported kernel symbol names from the preprocessor output.
> -# See also __KSYM_DEPS__ in include/linux/export.h.
> -# We disable the depfile generation here, so as not to overwrite the existing
> -# depfile while fixdep is parsing it.
> -flags_nodeps = $(filter-out -Wp$(comma)-M%, $($(1)))
> -ksym_dep_filter =                                                            \
> -	case "$(1)" in                                                       \
> -	  cc_*_c|cpp_i_c)                                                    \
> -	    $(CPP) $(call flags_nodeps,c_flags) -D__KSYM_DEPS__ $< ;;        \
> -	  as_*_S|cpp_s_S)                                                    \
> -	    $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
> -	  boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
> -	  *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
> -	esac | tr ";" "\n" | sed -n 's/^.*=== __KSYM_\(.*\) ===.*$$/_\1/p'
> -
> -cmd_and_fixdep =                                                             \
> -	$(echo-cmd) $(cmd_$(1));                                             \
> -	$(ksym_dep_filter) |                                                 \
> -		scripts/basic/fixdep -e $(depfile) $@ '$(make-cmd)'          \
> -			> $(dot-target).cmd;	                             \
> -	rm -f $(depfile);
> -
> -endif
> -
>  # Usage: $(call if_changed_rule,foo)
>  # Will check if $(cmd_foo) or any of the prerequisites changed,
>  # and if so will execute $(rule_foo).
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4f94579..c23ee45 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -254,9 +254,15 @@ objtool_dep = $(objtool_obj)					\
>  	      $(wildcard include/config/orc/unwinder.h		\
>  			 include/config/stack/validation.h)
>  
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +cmd_gen_ksymdeps = \
> +	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd;
> +endif
> +
>  define rule_cc_o_c
>  	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
>  	$(call cmd_and_fixdep,cc_o_c)					  \
> +	$(cmd_gen_ksymdeps)						  \
>  	$(cmd_checkdoc)							  \
>  	$(call echo-cmd,objtool) $(cmd_objtool)				  \
>  	$(cmd_modversions_c)						  \
> @@ -265,6 +271,7 @@ endef
>  
>  define rule_as_o_S
>  	$(call cmd_and_fixdep,as_o_S)					  \
> +	$(cmd_gen_ksymdeps)						  \
>  	$(call echo-cmd,objtool) $(cmd_objtool)				  \
>  	$(cmd_modversions_S)
>  endef
> diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
> index 850966f3..facbd60 100644
> --- a/scripts/basic/fixdep.c
> +++ b/scripts/basic/fixdep.c
> @@ -105,8 +105,7 @@
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: fixdep [-e] <depfile> <target> <cmdline>\n");
> -	fprintf(stderr, " -e  insert extra dependencies given on stdin\n");
> +	fprintf(stderr, "Usage: fixdep <depfile> <target> <cmdline>\n");
>  	exit(1);
>  }
>  
> @@ -131,21 +130,6 @@ static void print_dep(const char *m, int slen, const char *dir)
>  	printf(".h) \\\n");
>  }
>  
> -static void do_extra_deps(void)
> -{
> -	char buf[80];
> -
> -	while (fgets(buf, sizeof(buf), stdin)) {
> -		int len = strlen(buf);
> -
> -		if (len < 2 || buf[len - 1] != '\n') {
> -			fprintf(stderr, "fixdep: bad data on stdin\n");
> -			exit(1);
> -		}
> -		print_dep(buf, len - 1, "include/ksym");
> -	}
> -}
> -
>  struct item {
>  	struct item	*next;
>  	unsigned int	len;
> @@ -293,7 +277,7 @@ static int is_ignored_file(const char *s, int len)
>   * assignments are parsed not only by make, but also by the rather simple
>   * parser in scripts/mod/sumversion.c.
>   */
> -static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
> +static void parse_dep_file(char *m, const char *target)
>  {
>  	char *p;
>  	int is_last, is_target;
> @@ -369,9 +353,6 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
>  		exit(1);
>  	}
>  
> -	if (insert_extra_deps)
> -		do_extra_deps();
> -
>  	printf("\n%s: $(deps_%s)\n\n", target, target);
>  	printf("$(deps_%s):\n", target);
>  }
> @@ -379,13 +360,9 @@ static void parse_dep_file(char *m, const char *target, int insert_extra_deps)
>  int main(int argc, char *argv[])
>  {
>  	const char *depfile, *target, *cmdline;
> -	int insert_extra_deps = 0;
>  	void *buf;
>  
> -	if (argc == 5 && !strcmp(argv[1], "-e")) {
> -		insert_extra_deps = 1;
> -		argv++;
> -	} else if (argc != 4)
> +	if (argc != 4)
>  		usage();
>  
>  	depfile = argv[1];
> @@ -395,7 +372,7 @@ int main(int argc, char *argv[])
>  	printf("cmd_%s := %s\n\n", target, cmdline);
>  
>  	buf = read_file(depfile);
> -	parse_dep_file(buf, target, insert_extra_deps);
> +	parse_dep_file(buf, target);
>  	free(buf);
>  
>  	return 0;
> diff --git a/scripts/gen_ksymdeps.sh b/scripts/gen_ksymdeps.sh
> new file mode 100755
> index 0000000..1324986
> --- /dev/null
> +++ b/scripts/gen_ksymdeps.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# List of exported symbols
> +ksyms=$($NM $1 | sed -n 's/.*__ksym_marker_\(.*\)/\1/p' | tr A-Z a-z)
> +
> +if [ -z "$ksyms" ]; then
> +	exit 0
> +fi
> +
> +echo
> +echo "ksymdeps_$1 := \\"
> +
> +for s in $ksyms
> +do
> +	echo $s | sed -e 's:^_*:    $(wildcard include/ksym/:' \
> +			-e 's:__*:/:g' -e 's/$/.h) \\/'
> +done
> +
> +echo
> +echo "$1: \$(ksymdeps_$1)"
> +echo
> +echo "\$(ksymdeps_$1):"
> -- 
> 2.7.4
> 
> 
