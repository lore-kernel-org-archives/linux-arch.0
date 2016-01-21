Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:42719 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcAUADq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2016 19:03:46 -0500
Date: Thu, 21 Jan 2016 00:03:42 +0000
From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Message-ID: <20160121000342.GA7538@NP-P-BURTON>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
Message-ID: <20160121000342.Ybxd7ZymneQlId2OQbNIgeNvKu3PKiCr9vBXvSWZQqg@z>

On Tue, Jan 19, 2016 at 01:37:50PM +0000, James Hogan wrote:
> When a header file is removed from generic-y (often accompanied by the
> addition of an arch specific header), the generated wrapper file will
> persist, and in some cases may still take precedence over the new arch
> header.
> 
> For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> the wrapper when reusing a dirty build tree resulted in build failures
> in arch/mips/kernel/signal.c:
> 
> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
>   return &uc->uc_extcontext;
>             ^
> 
> Fix by detecting and removing wrapper headers in generated header
> directories that do not correspond to a filename in generic-y, genhdr-y,
> or the newly introduced generated-y.
> 
> Reported-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Michal Marek <mmarek@suse.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v2:
> - Rewrite a bit, drawing inspiration from Makefile.headersinst.
> - Exclude genhdr-y and generated-y (thanks to kbuild test robot).
> ---
>  scripts/Makefile.asm-generic | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
> index 045e0098e962..24c29f16f029 100644
> --- a/scripts/Makefile.asm-generic
> +++ b/scripts/Makefile.asm-generic
> @@ -13,11 +13,26 @@ include scripts/Kbuild.include
>  # Create output directory if not already present
>  _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
>  
> +# Stale wrappers when the corresponding files are removed from generic-y
> +# need removing.
> +generated-y   := $(generic-y) $(genhdr-y) $(generated-y)
> +all-files     := $(patsubst %, $(obj)/%, $(generated-y))
> +old-headers   := $(wildcard $(obj)/*.h)
> +unwanted      := $(filter-out $(all-files),$(old-headers))

Hi James,

Thanks a bunch for fixing this!

Though is it my sleepy self or are all-files & old-headers misnomers?
That is, isn't all-files actually a list of headers to be kept, and
old-headers actually the list of all (header) files?

Thanks,
    Paul

> +
>  quiet_cmd_wrap = WRAP    $@
>  cmd_wrap = echo "\#include <asm-generic/$*.h>" >$@
>  
> -all: $(patsubst %, $(obj)/%, $(generic-y))
> +quiet_cmd_remove = REMOVE  $(unwanted)
> +cmd_remove = rm -f $(unwanted)
> +
> +all: $(patsubst %, $(obj)/%, $(generic-y)) FORCE
> +	$(if $(unwanted),$(call cmd,remove),)
>  	@:
>  
>  $(obj)/%.h:
>  	$(call cmd,wrap)
> +
> +.PHONY: $(PHONY)
> +PHONY += FORCE
> +FORCE: ;
> -- 
> 2.4.10
> 
