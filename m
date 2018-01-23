From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
Date: Tue, 23 Jan 2018 10:14:48 +0000
Message-ID: <20180123101446.GP22781@e103592.cambridge.arm.com>
References: <1516623798-25001-1-git-send-email-Dave.Martin@arm.com>
 <1516623798-25001-2-git-send-email-Dave.Martin@arm.com>
 <878tcp8umz.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbeAWKOw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jan 2018 05:14:52 -0500
Content-Disposition: inline
In-Reply-To: <878tcp8umz.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

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

My bad -- I hadn't looked in detail at the whole series.

However, the purpose of this as an RFC was to get feedback on whether
adding FPE_UNKNOWN is considered acceptable at all from an API
perspective -- the precise number doesn't matter for that discussion.

Do you have any view on this?

Cheers
---Dave
