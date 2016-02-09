Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41292 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbcBIQBs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Feb 2016 11:01:48 -0500
Date: Tue, 9 Feb 2016 16:01:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Tree for Feb 9
Message-ID: <20160209160117.GB9332@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
 <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
 <20160209143554.GA9332@leverpostej>
 <3561538.HMPaSbaoce@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3561538.HMPaSbaoce@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
Message-ID: <20160209160118.TraOlibFYiNj2LqQAmxFTDW5kSRzmVgKlK6iAE_ue30@z>

On Tue, Feb 09, 2016 at 04:08:03PM +0100, Arnd Bergmann wrote:
> On Tuesday 09 February 2016 14:35:54 Mark Rutland wrote:
> > diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> > index f9c27b6..e5255ff 100644
> > --- a/include/asm-generic/fixmap.h
> > +++ b/include/asm-generic/fixmap.h
> > @@ -69,6 +69,8 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
> >         __set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
> >  #endif
> >  
> > +void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> > +
> >  /* Return a pointer with offset calculated */
> >  static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
> >                                                 phys_addr_t phys,
> > 
> 
> 
> I think there is a conflicting declaration in arch/x86/include/asm/paravirt.h:
> 
> static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
>                                 phys_addr_t phys, pgprot_t flags)
> {
>         pv_mmu_ops.set_fixmap(idx, phys, flags);
> }
> 
> Can you test on x86 with CONFIG_PARAVIRT set?

That builds fine for me atop of for-next/pgtable, both 64-bit and
32-bit.

GCC seems to treat enum fixed_addresses the same as unsigned. Only if I
change the type of idx in fixmap.h (e.g. to char) do I get a conflict
against paravirt.h

Mark.
