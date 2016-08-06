From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Sat, 6 Aug 2016 22:14:23 +0200
Message-ID: <20160806201423.GB25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-3-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:33593 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcHFUTo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2016 16:19:44 -0400
Content-Disposition: inline
In-Reply-To: <1470399123-8455-3-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Fri, Aug 05, 2016 at 10:12:00PM +1000, Nicholas Piggin wrote:
> Introduce LINKER_DCE option for architectures to select if they want
> to build with -ffunction-sections, -fdata-sections, and link with
> --gc-sections.

Can you please try to come up with a less cryptic name.
"DCE" may make sense for you today.
Bot the naive reader will benefit from the longer and
more explcit form.


 It requires some work (documented) to ensure all
> unreferenced entrypoints are live, and requires toolchain and
> build verification, so it is made a per-arch option for now.
> 
> On a random powerpc64le build, this yelds a significant size saving,
> it boots and runs fine, but there is a lot I haven't tested as yet,
> so these savings may be reduced if there are bugs in the link.
> 
>     text      data        bss        dec   filename
> 11169741   1180744    1923176	14273661   vmlinux
> 10445269   1004127    1919707	13369103   vmlinux.dce
> 
> ~700K text, ~170K data, 6% removed from kernel image size.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Makefile                          | 10 ++++++++
>  arch/Kconfig                      | 13 ++++++++++
>  include/asm-generic/vmlinux.lds.h | 52 ++++++++++++++++++++++-----------------
>  include/linux/compiler.h          | 18 ++++++++++++++
>  include/linux/export.h            | 30 +++++++++++-----------
>  include/linux/init.h              | 38 ++++++++++------------------
>  init/Makefile                     |  2 ++
>  7 files changed, 100 insertions(+), 63 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b409076..d5ef31a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -618,6 +618,11 @@ include arch/$(SRCARCH)/Makefile
>  
>  KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
>  
> +ifdef CONFIG_LINKER_DCE
> +KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
> +KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
> +endif
> +
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
>  else
> @@ -819,6 +824,11 @@ LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
>  KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
>  LDFLAGS_vmlinux += $(LDFLAGS_BUILD_ID)
>  
> +ifdef CONFIG_LINKER_DCE
> +# LDFLAGS_MODULE	+= $(call ld-option, --gc-sections,)
> +LDFLAGS_vmlinux	+= $(call ld-option, --gc-sections,)
> +endif
Something you missed to clean up

	Sam
