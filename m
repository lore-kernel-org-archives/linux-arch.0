Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeBVNNj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Feb 2018 08:13:39 -0500
Date: Thu, 22 Feb 2018 13:13:35 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 1/3] signal: Add FPE_FLTUNK si_code for undiagnosable fp
 exceptions
Message-ID: <20180222131333.GD32331@e103592.cambridge.arm.com>
References: <1519228960-10883-1-git-send-email-Dave.Martin@arm.com>
 <1519228960-10883-2-git-send-email-Dave.Martin@arm.com>
 <5A8EB419.1020508@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8EB419.1020508@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20180222131335.y7n-wuCYAqFTOkayP_TboSwskUOZ4BnnasSawdo_jbs@z>

On Thu, Feb 22, 2018 at 12:14:17PM +0000, James Morse wrote:
> Hi Dave,
> 
> On 21/02/18 16:02, Dave Martin wrote:
> > Some architectures cannot always report accurately what kind of
> > floating-point exception triggered a floating-point exception trap.
> > 
> > This can occur with fp exceptions occuring on lanes in a vector
> 
> (Nit: occurring)
> 
> > instruction on arm64 for example.
> > 
> > Rather than have every architecture come up with its own way of
> > descrbing such a condition, this patch adds a common FPE_FLTUNK do
> 
> (Nits: describing; 'to report')
> 
> > report that an fp exception caused a trap but we cannot be certain

Hmmm, this wasn't my best effort...

> > which kind of fp exception it was.
> 
> 
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index 85dc965..10304de 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -229,7 +229,8 @@ typedef struct siginfo {
> >  # define __FPE_INVASC	12	/* invalid ASCII digit */
> >  # define __FPE_INVDEC	13	/* invalid decimal digit */
> >  #endif
> > -#define NSIGFPE		13
> > +#define FPE_FLTUNK	14	/* undiagnosed floating-point exception */
> > +#define NSIGFPE		14
> 
> It looks like x86's compat relies on this value not changing:
> | arch/x86/kernel/signal_compat.c:        BUILD_BUG_ON(NSIGFPE  != 13);
> | include/uapi/asm-generic/siginfo.h:#define NSIGFPE              13
> 
> (from v4.16-rc2)

Hmmm, that's embarrassing -- thanks for spotting!

I think we can justifiably bump the number there, since x86 won't use
FPT_FLTUNK (for now, perhaps for ever) and anyway it doesn't add any new
information to siginfo.

I'll respin with these changes.

Cheers
---Dave
