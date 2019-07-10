Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJNZk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 09:25:40 -0400
Date: Wed, 10 Jul 2019 14:25:33 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: vdso: Fix ABI regression in compat vdso
Message-ID: <20190710132532.r27yryvt25ex76xk@willie-the-truck>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <20190710130452.44111-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710130452.44111-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, john.stultz@linaro.org
Message-ID: <20190710132533.CqgrqL4j93Qc2Oub7kMgHwHRtsesPBL_0-3WgqP6gDc@z>

On Wed, Jul 10, 2019 at 02:04:52PM +0100, Vincenzo Frascino wrote:
> Prior to the introduction of Unified vDSO support and compat layer for
> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> In the current implementation, AT_SYSINFO_EHDR is defined even if the
> compat vdso layer is not built and this causes a regression in the
> expected behavior of the ABI.
> 
> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> tasks is defined only when CONFIG_GENERIC_COMPAT_VDSO and
> CONFIG_COMPAT_VDSO are enabled.

I think you could do a better job in the changelog of explaining what's
actually going on here. The problem seems to be that you're advertising
the presence of a non-existent vDSO to userspace.

> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 3c7037c6ba9b..b7992bb9d414 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>  ({									\
>  	set_thread_flag(TIF_32BIT);					\
>   })
> -#ifdef CONFIG_GENERIC_COMPAT_VDSO
> +#if defined(CONFIG_COMPAT_VDSO) && defined(CONFIG_GENERIC_COMPAT_VDSO)

Can't this just be #ifdef CONFIG_COMPAT_VDSO ?

John -- can you give this a whirl, please?

Cheers,

Will
