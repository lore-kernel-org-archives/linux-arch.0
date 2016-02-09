Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:61842 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbcBIPIS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 10:08:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: Tree for Feb 9
Date: Tue, 09 Feb 2016 16:08:03 +0100
Message-ID: <3561538.HMPaSbaoce@wuerfel>
In-Reply-To: <20160209143554.GA9332@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au> <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com> <20160209143554.GA9332@leverpostej>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
Message-ID: <20160209150803.r1_vXWFWW3DH3h-cWmuwsF3lxVzSjZsqaEaVPPd5U6Y@z>

On Tuesday 09 February 2016 14:35:54 Mark Rutland wrote:
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index f9c27b6..e5255ff 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -69,6 +69,8 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
>         __set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
>  #endif
>  
> +void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
> +
>  /* Return a pointer with offset calculated */
>  static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
>                                                 phys_addr_t phys,
> 


I think there is a conflicting declaration in arch/x86/include/asm/paravirt.h:

static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
                                phys_addr_t phys, pgprot_t flags)
{
        pv_mmu_ops.set_fixmap(idx, phys, flags);
}

Can you test on x86 with CONFIG_PARAVIRT set?

	Arnd
