Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62752 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756566Ab2ILKZR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Sep 2012 06:25:17 -0400
Date: Wed, 12 Sep 2012 11:24:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 11/31] arm64: IRQ handling
Message-ID: <20120912102402.GB21823@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-12-git-send-email-catalin.marinas@arm.com>
 <201209071937.19156.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201209071937.19156.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20120912102402.4kFqS3bScEkVEuKfaK93kDSCXrIP3YzKi2PstUfc4n8@z>

On Fri, Sep 07, 2012 at 08:37:18PM +0100, Arnd Bergmann wrote:
> On Friday 07 September 2012, Catalin Marinas wrote:
> 
> > +#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
> > +#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
> 
> Isn't this something that the IRQ core code already keeps track of?

That's for the IPIs which are handled directly by the arch code. We
don't even allocate irq descriptors for them.

> > +#endif /* __ASM_HARDIRQ_H */
> > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> > new file mode 100644
> > index 0000000..a4e1cad
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/irq.h
> > @@ -0,0 +1,8 @@
> > +#ifndef __ASM_IRQ_H
> > +#define __ASM_IRQ_H
> > +
> > +#include <asm-generic/irq.h>
> > +
> > +extern void (*handle_arch_irq)(struct pt_regs *);
> > +
> > +#endif
> 
> Is this one still needed?

Yes. It's initialised by the GIC code (called via of_irq_init) and we
want to allow different GIC versions (GICv2 used by the model currently
but we would expect GICv3 with hardware).

-- 
Catalin
