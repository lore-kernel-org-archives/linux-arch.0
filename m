Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:49530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfGKKel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 06:34:41 -0400
Date: Thu, 11 Jul 2019 12:34:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] arm64: vdso: Fix ABI regression in compat vdso
In-Reply-To: <20190711094505.rwy6t6wu2cvmvwr6@willie-the-truck>
Message-ID: <alpine.DEB.2.21.1907111232000.1889@nanos.tec.linutronix.de>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com> <20190710140119.23417-1-vincenzo.frascino@arm.com> <20190711094505.rwy6t6wu2cvmvwr6@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, andre.przywara@arm.com, arnd@arndb.de, huw@codeweavers.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, will.deacon@arm.com, linux@armlinux.org.uk, ralf@linux-mips.org, salyzyn@android.com, luto@kernel.org, paul.burton@mips.com, john.stultz@linaro.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, sthotton@marvell.com, pcc@google.com
Message-ID: <20190711103427.kEt8xdlN-gNSBxNnLSsM1fGRwNnbKKNctr3r6Bz053M@z>

On Thu, 11 Jul 2019, Will Deacon wrote:

> On Wed, Jul 10, 2019 at 03:01:19PM +0100, Vincenzo Frascino wrote:
> > Prior to the introduction of Unified vDSO support and compat layer for
> > vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> > In the current implementation, AT_SYSINFO_EHDR is defined even if the
> > compat vdso layer is not built and this causes a regression in the
> > expected behavior of the ABI.
> > 
> > Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> > tasks is defined only when CONFIG_COMPAT_VDSO is enabled.
> > 
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/arm64/include/asm/elf.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > index 3c7037c6ba9b..b618017205a3 100644
> > --- a/arch/arm64/include/asm/elf.h
> > +++ b/arch/arm64/include/asm/elf.h
> > @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> >  ({									\
> >  	set_thread_flag(TIF_32BIT);					\
> >   })
> > -#ifdef CONFIG_GENERIC_COMPAT_VDSO
> > +#ifdef CONFIG_COMPAT_VDSO
> >  #define COMPAT_ARCH_DLINFO						\
> >  do {									\
> >  	/*								\
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I can take this at -rc1 via arm64 unless tglx plans to send it during the
> rest of the merge window. Please let me know.

I had no plan to pick it up, but if you want I can route it through timer
urgents so it hits Linus tree before rc1.

Thanks,

	tglx
