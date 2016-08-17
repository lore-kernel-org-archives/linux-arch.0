From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Wed, 17 Aug 2016 11:56:33 +0200
Message-ID: <20160817095632.GA5187@ravnborg.org>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
 <1470910580-18458-4-git-send-email-npiggin@gmail.com>
 <57B2DBA1.6090304@suse.com>
 <20160817144322.4067391f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160817144322.4067391f@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

> diff --git a/Makefile b/Makefile
> index 1d26fdb..20d3bfd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -954,8 +954,14 @@ include/generated/autoksyms.h: FORCE
>        cmd_link-vmlinux = $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
>  quiet_cmd_link-vmlinux = LINK    $@
>  
> +# Optional arch pass after final link
> +ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
> +      cmd_postlink-vmlinux = \
> +          $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> +
>  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
>  	+$(call if_changed,link-vmlinux)
> +	+$(call if_changed,postlink-vmlinux)
>  
>  # Build samples along the rest of the kernel
>  ifdef CONFIG_SAMPLES
> @@ -1279,6 +1285,7 @@ $(clean-dirs):
>  
>  vmlinuxclean:
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
> +	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
>  
>  clean: archclean vmlinuxclean
>  
Another option would be to embed the logic in the link-vmlinux shell script.
It is much simpler for normal humans to read and understand shell scripts,
and it would be simpler too.


> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 1366a94..a3e862e 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -121,8 +121,14 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                               $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
>                               -o $@ $(filter-out FORCE,$^)
>  
> +# Optional arch pass after final link
> +ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
> +      cmd_postlink-ko = \
> +          $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> +
>  $(modules): %.ko :%.o %.mod.o FORCE
>  	$(call if_changed,ld_ko_o)
> +	+$(call if_changed,postlink-ko)
For modules we have no script, so here we need this.

	Sam
