From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
Date: Thu, 6 Jun 2019 18:11:56 +0100
Message-ID: <20190606171155.GI56860@arrakis.emea.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
 <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
 <20190524130217.GA15566@lakrids.cambridge.arm.com>
 <20190524145306.GZ28398@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190524145306.GZ28398@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Jones <drjones@redhat.com>, Paul Elliott <paul.elliott@arm.com>, Arnd Bergmann <arnd@arndb.de>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 24, 2019 at 03:53:06PM +0100, Dave P Martin wrote:
> On Fri, May 24, 2019 at 02:02:17PM +0100, Mark Rutland wrote:
> > On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> > >  #endif /* _UAPI__ASM_HWCAP_H */
> > > diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
> > > new file mode 100644
> > > index 0000000..4776b43
> > > --- /dev/null
> > > +++ b/arch/arm64/include/uapi/asm/mman.h
> > > @@ -0,0 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _UAPI__ASM_MMAN_H
> > > +#define _UAPI__ASM_MMAN_H
> > > +
> > > +#include <asm-generic/mman.h>
> > > +
> > > +#define PROT_BTI_GUARDED	0x10		/* BTI guarded page */
> > 
> > From prior discussions, I thought this would be PROT_BTI, without the
> > _GUARDED suffix. Do we really need that?
> > 
> > AFAICT, all other PROT_* definitions only have a single underscore, and
> > the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
> > powerpc.
> 
> No strong opinon.  I was trying to make the name less obscure, but I'm
> equally happy with PROT_BTI if people prefer that.

I prefer PROT_BTI as well. We are going to add a PROT_MTE at some point
(and a VM_ARM64_MTE in the high VMA flag bits).

-- 
Catalin
