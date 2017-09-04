From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip 2/4] arm: Cleanup in_exception_text() and move it
 in asm/sections.h
Date: Tue, 5 Sep 2017 00:22:27 +0900
Message-ID: <20170905002227.066c6d44386f881a99ccc620@kernel.org>
References: <150295395797.14424.968407208436624832.stgit@devbox>
        <150295409062.14424.11976553130089631456.stgit@devbox>
        <20170903222152.GA25743@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753764AbdIDPWc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Sep 2017 11:22:32 -0400
In-Reply-To: <20170903222152.GA25743@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Russell,

On Sun, 3 Sep 2017 23:21:52 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Thu, Aug 17, 2017 at 04:15:00PM +0900, Masami Hiramatsu wrote:
> > Cleanup in_exception_text() using memory_contains() and
> > move it in asm/sections.h from asm/trap.h because
> > section symbols and memory_contains() are defined in
> > asm/sections.h.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/arm/include/asm/sections.h |   17 +++++++++++++++++
> >  arch/arm/include/asm/traps.h    |   22 +---------------------
> >  2 files changed, 18 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
> > index 803bbf2b20b8..76791cfc7619 100644
> > --- a/arch/arm/include/asm/sections.h
> > +++ b/arch/arm/include/asm/sections.h
> > @@ -4,5 +4,22 @@
> >  #include <asm-generic/sections.h>
> >  
> >  extern char _exiprom[];
> > +extern char __exception_text_start[], __exception_text_end[];
> > +
> > +/**
> > + * in_exception_text - check if an address is in exception_text or
> > + *			irqentry_text
> > + * @addr: virtual address to be checked
> > + *
> > + * Returns: true if the address specified by @addr is in the exception_text or
> > + * irqentry_text, false otherwise.
> > + */
> > +static inline bool in_exception_text(unsigned long addr)
> > +{
> > +	return memory_contains(__exception_text_start, __exception_text_end,
> > +			       (void *)addr, 0) ||
> > +		memory_contains(__irqentry_text_start, __irqentry_text_end,
> > +				(void *)addr, 0);
> 
> Patch looks buggy - where is __irqentry_text_start and __irqentry_text_end
> declared?

Those are declared in asm-generic/sections.h by below patch (on -tip tree)

https://patchwork.kernel.org/patch/9878033/

So, I thougt it was a good time to clean up related code.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
