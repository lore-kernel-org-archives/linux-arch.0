Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICOiH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:38:07 -0400
Date: Tue, 3 Sep 2019 15:38:01 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/8] arm64: compat: vdso: Expose BUILD_VDSO32
Message-ID: <20190903143800.k6r663abs2g2ddpg@willie-the-truck>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-2-vincenzo.frascino@arm.com>
 <c0b1673d-e37d-a526-0862-ad07f779f5bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b1673d-e37d-a526-0862-ad07f779f5bf@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, catalin.marinas@arm.com, 0x7f454c46@gmail.com, salyzyn@android.com, paul.burton@mips.com, luto@kernel.org, tglx@linutronix.de
Message-ID: <20190903143801.wEaBW5fz2mnALE8VXXQh_ybjUYsSYsM-ylfIdqQdNKo@z>

On Tue, Sep 03, 2019 at 03:36:16PM +0100, Vincenzo Frascino wrote:
> On 8/30/19 2:58 PM, Vincenzo Frascino wrote:
> > clock_gettime32 and clock_getres_time32 should be compiled only with the
> > 32 bit vdso library.
> > 
> > Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
> > indication to the generic library to include these symbols.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > index c50ee1b7d5cd..fe7afe0f1a3d 100644
> > --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > @@ -17,6 +17,7 @@
> >  #define VDSO_HAS_CLOCK_GETRES		1
> >  
> >  #define VDSO_HAS_32BIT_FALLBACK		1
> > +#define BUILD_VDSO32			1
> >  
> >  static __always_inline
> >  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
> > 
> 
> This patch is independent from the rest and touches only arch code. Can it go in
> via the arm64 tree?

Why not take it via -tip along with patch 6? Otherwise we'll get a silly
conflict. I'd assumed this series was going in as one thing.

Will
