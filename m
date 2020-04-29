From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Date: Wed, 29 Apr 2020 16:24:44 +0100
Message-ID: <20200429152443.GD10651@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <e568615c-7f13-5ad6-48cc-45f5211ed1df@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:41058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2PYt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 11:24:49 -0400
Content-Disposition: inline
In-Reply-To: <e568615c-7f13-5ad6-48cc-45f5211ed1df@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>, Luis Machado <luis.machado@linaro.org>, Omair Javaid <omair.javaid@linaro.org>

On Wed, Apr 29, 2020 at 11:27:10AM +0100, Kevin Brodsky wrote:
> On 21/04/2020 15:25, Catalin Marinas wrote:
> > diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> > index bd51ea7e2fcb..45be04a8c73c 100644
> > --- a/arch/arm64/lib/mte.S
> > +++ b/arch/arm64/lib/mte.S
> > @@ -5,6 +5,7 @@
> >   #include <linux/linkage.h>
> >   #include <asm/assembler.h>
> > +#include <asm/mte.h>
> >   /*
> >    * Compare tags of two pages
> > @@ -44,3 +45,52 @@ SYM_FUNC_START(mte_memcmp_pages)
> >   	ret
> >   SYM_FUNC_END(mte_memcmp_pages)
> > +
> > +/*
> > + * Read tags from a user buffer (one tag per byte) and set the corresponding
> > + * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
> > + *   x0 - kernel address (to)
> > + *   x1 - user buffer (from)
> > + *   x2 - number of tags/bytes (n)
> > + * Returns:
> > + *   x0 - number of tags read/set
> > + */
> > +SYM_FUNC_START(mte_copy_tags_from_user)
> > +	mov	x3, x1
> > +1:
> > +USER(2f, ldtrb	w4, [x1])
> 
> Here we are making either of the following assumptions:
> 1. The __user pointer (here `from`) actually points to user memory, not
> kernel memory (and we have set_fs(USER_DS) in place).
> 2. CONFIG_ARM64_UAO is enabled and the hardware implements UAO.
> 
> 1. is currently true because these functions are only used for the new
> ptrace requests, which indeed pass pointers to user memory. However, future
> users of these functions may not know about this requirement.
> 2. is not necessarily true because ARM64_MTE does not depend on ARM64_UAO.
> 
> It is unlikely that future users of these functions actually need to pass
> __user pointers to kernel memory, so adding a comment spelling out the first
> assumption is probably fine.

I found it easier to add uao_user_alternative rather than writing a
comment ;).

Thanks.

-- 
Catalin
