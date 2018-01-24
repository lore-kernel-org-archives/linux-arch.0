Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932891AbeAXK5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jan 2018 05:57:09 -0500
Date: Wed, 24 Jan 2018 10:57:05 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
Message-ID: <20180124105704.GD5862@e103592.cambridge.arm.com>
References: <1516623798-25001-1-git-send-email-Dave.Martin@arm.com>
 <1516623798-25001-2-git-send-email-Dave.Martin@arm.com>
 <878tcp8umz.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878tcp8umz.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>
Message-ID: <20180124105705.gPObu14ST2sq-mthFxNYbI-huu1QMvXVJ8D9a3rmYf8@z>

On Mon, Jan 22, 2018 at 03:13:08PM -0600, Eric W. Biederman wrote:
> 
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index e447283..77edb00 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -193,7 +193,8 @@ typedef struct siginfo {
> >  #define FPE_FLTRES	6	/* floating point inexact result */
> >  #define FPE_FLTINV	7	/* floating point invalid operation */
> >  #define FPE_FLTSUB	8	/* subscript out of range */
> > -#define NSIGFPE		8
> > +#define FPE_UNKNOWN	9	/* undiagnosed floating-point exception */
> > +#define NSIGFPE		9
> 
> Minor nit here.
> 
> At least before this is final I would really appreciate if you could
> rebase this on top of my unificiation of siginfo.h that I posted on
> linux-arch and is in my siginfo-next branch.
> 
> As that already pushes NSIGFPE up to 13.
> 
> Which would make this patch change NSIGFPE to 14 and allocate the number
> 14 for FPE_UNKNOWN

Looking at this, I note a few things:

 * For consistent naming, FPE_FLTUNK might be a better name for
   FPE_UNKNOWN.

   FPE_FLTUNK seems generic, tempting me to insert it as number 9
   (since only the numbers up to 8 are ABI just now).

   (The temptation to call it FPE_FLUNK is strong, but I can't argue
   that's consistent...)

 * No distinction is drawn between generic and arch-dependent codes
   here, so NSIGFPE will typically be too big.  The generic siginfo
   handling code can detect random garbage in si_code this way, but
   off-by-ones or misused arch-specific codes may slip through.

   In particular, new x86-specific FPE_* codes will likely be
   invisible to the BUILD_BUG_ON()s in arch/x86/kernel/signal_compat.c
   unless so many are added that x86 overtakes ia64.

 * Should we reserve space for future generic codes (say up to 15)?
   Downside: si_code validation is not a simple matter of checking
   <= NSIGFPE in that case.  (Though <= is still better than no
   check at all, and no worse than the current situation.)

 * What are NSIGFPE etc. doing in this header?  These aren't specified
   by POSIX and I'm not sure what userspace would legitimately use them
   for... though it may be too late to change this now.

   Most instances on codeseaarch.debian.net are the kernel, copies
   of kernel headers, and translated versions of kernel headers.
   It's hard to be exhaustive though.


We could have something like this:

#define FPE_FLTUNK	9
#define __NSIGFPE_GENERIC	9
#define NSIGFPE		__NSIGFPE_GENERIC

/* si_code <= 15 reserved for arch-independent codes */

#if defined(__frv__)

# define FPE_MDAOF	16
# undef NSIGFPE
# define NSIGFPE	16

#elif define(__ia64__)

# define __FPE_DECOVF	16
# define __FPE_DECDIV	17
# define __FPE_DECERR	18
# define __FPR_INVASC	19
# undef NSIGFPE
# define NSIGFPE	19

#endif

(Avoiding a (base + offset) approach for the arch codes, since that
would make it look like the codes can be renumbered safely without
breaking anything).

The generic vs. arch vs. NSIGFOO problem already exists for other
signals.  We could take a similar approach for those, but OTOH it
may just not be worth the effort.

Cheers
---Dave
