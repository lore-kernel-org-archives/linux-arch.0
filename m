Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33118 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab2GSCQq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2012 22:16:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h
In-Reply-To: <2597.1342617840@warthog.procyon.org.uk>
References: <32350.1342615619@warthog.procyon.org.uk> <2597.1342617840@warthog.procyon.org.uk>
Date: Thu, 19 Jul 2012 11:15:24 +0930
Message-ID: <874np4cymj.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20120719014524.Hf5WKtjNgUl5J0zLQxrPU2ku6m5WG0LPNol5N77f0rU@z>

On Wed, 18 Jul 2012 14:24:00 +0100, David Howells <dhowells@redhat.com> wrote:
> diff --git a/arch/sh/include/asm/module.h b/arch/sh/include/asm/module.h
> index b7927de..81300d8b 100644
> --- a/arch/sh/include/asm/module.h
> +++ b/arch/sh/include/asm/module.h
> @@ -1,21 +1,13 @@
>  #ifndef _ASM_SH_MODULE_H
>  #define _ASM_SH_MODULE_H
>  
> -struct mod_arch_specific {
> +#include <asm-generic/module.h>
> +
>  #ifdef CONFIG_DWARF_UNWINDER
> +struct mod_arch_specific {
>  	struct list_head fde_list;
>  	struct list_head cie_list;
> -#endif
>  };

Hmm, this means we get two definitions if CONFIG_DWARF_UNWINDER?

Seems like a useful effort.  Fiddly though.

Cheers,
Rusty.
