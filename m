Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47458 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdHVRW2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Aug 2017 13:22:28 -0400
Date: Tue, 22 Aug 2017 18:22:24 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 12/27] arm64/sve: Support vector length resetting for new
 processes
Message-ID: <20170822172224.GY6321@e103592.cambridge.arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-13-git-send-email-Dave.Martin@arm.com>
 <871so3bmj0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871so3bmj0.fsf@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20170822172224.puMGSJkxg8smGFZmfEavxnMlo22RTLghQQQAJIhVZQU@z>

On Tue, Aug 22, 2017 at 05:22:11PM +0100, Alex Bennée wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > It's desirable to be able to reset the vector length to some sane
> > default for new processes, since the new binary and its libraries
> > processes may or may not be SVE-aware.
> >
> > This patch tracks the desired post-exec vector length (if any) in a
> > new thread member sve_vl_onexec, and adds a new thread flag
> > TIF_SVE_VL_INHERIT to control whether to inherit or reset the
> > vector length.  Currently these are inactive.  Subsequent patches
> > will provide the capability to configure them.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/processor.h   |  1 +
> >  arch/arm64/include/asm/thread_info.h |  1 +
> >  arch/arm64/kernel/fpsimd.c           | 13 +++++++++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 969feed..da8802a 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -87,6 +87,7 @@ struct thread_struct {
> >  	struct fpsimd_state	fpsimd_state;
> >  	void			*sve_state;	/* SVE registers, if any */
> >  	u16			sve_vl;		/* SVE vector length */
> > +	u16			sve_vl_onexec;	/* SVE vl after next
> > exec */
> 
> Inconsistent size usage here as well...

Agreed, the same history applies as for sve_vl.  I'll replace this with
an unsigned int.

[...]

Cheers
---Dave
