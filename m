From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 5/5] arm64: signal: Allow expansion of the signal frame
Date: Mon, 19 Jun 2017 11:12:29 +0100
Message-ID: <20170619101204.GA8543@e103592.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
 <20170616104740.GA31526@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753682AbdFSKMi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jun 2017 06:12:38 -0400
Content-Disposition: inline
In-Reply-To: <20170616104740.GA31526@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jun 16, 2017 at 11:47:41AM +0100, Catalin Marinas wrote:
> On Thu, Jun 15, 2017 at 03:03:42PM +0100, Dave P Martin wrote:
> > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > @@ -41,9 +41,10 @@ struct sigcontext {
> >   *
> >   *	0x210		fpsimd_context
> >   *	 0x10		esr_context
> > + *	 0x20		extra_context (optional)
> >   *	 0x10		terminator (null _aarch64_ctx)
> >   *
> > - *	0xdd0		(reserved for future allocation)
> > + *	0xdb0		(reserved for future allocation)
> >   *
> >   * New records that can exceed this space need to be opt-in for userspace, so
> >   * that an expanded signal frame is not generated unexpectedly.  The mechanism
> > @@ -80,4 +81,39 @@ struct esr_context {
> >  	__u64 esr;
> >  };
> >  
> > +/*
> > + * extra_context: describes extra space in the signal frame for
> > + * additional structures that don't fit in sigcontext.__reserved[].
> > + *
> > + * Note:
> > + *
> > + * 1) fpsimd_context, esr_context and extra_context must be placed in
> > + * sigcontext.__reserved[] if present.  They cannot be placed in the
> > + * extra space.  Any other record can be placed either in the extra
> > + * space or in sigcontext.__reserved[], unless otherwise specified in
> > + * this file.
> > + *
> > + * 2) There must not be more than one extra_context.
> > + *
> > + * 3) If extra_context is present, it must be followed immediately in
> > + * sigcontext.__reserved[] by the terminating null _aarch64_ctx.
> > + *
> > + * 4) The extra space to which data points must start at the first
> > + * 16-byte aligned address immediately after the terminating null
> > + * _aarch64_ctx that follows the extra_context structure in
> > + * __reserved[].  The extra space may overrun the end of __reserved[],
> > + * as indicated by a sufficiently large value for the size field.
> > + *
> > + * 5) The extra space must itself be terminated with a null
> > + * _aarch64_ctx.
> > + */
> > +#define EXTRA_MAGIC	0x45585401
> > +
> > +struct extra_context {
> > +	struct _aarch64_ctx head;
> > +	void __user *data;	/* 16-byte aligned pointer to extra space */
> > +	__u32 size;		/* size in bytes of the extra space */
> > +	__u32 __reserved[3];
> > +};
> 
> Some more thoughts on the type of "data" above. It's the first time we
> introduce pointers in sigcontext and wonder whether __u64 would make
> more sense (invariable size with the ABI).

I'm happy to change this if you want -- it can be a __u64 without
impacting the semantics.

> Also for discussion - whether using an offset vs absolute address would
> be better.

My rationale here related to the ucontext semantics associated with
the signal frame, rather than signal handling itself.

Consider:

void signal_handler(int n, siginfo_t *si, void *uc)
{
	*signal_context = *(ucontext_t *)uc;
}

Will this "work"?  On most machines, yes it will. 

With an expanded signal frame on arm64, it won't work: the copied
context will be truncated at the end of __reserved[].  If extra_data
uses an offset to locate the additional data then someone parsing
*signal_context won't be able to detect the error and will overrun:
this includes rt_sigreturn (if that is run on a stack that has the
copied context).

If a pointer is used in extra_context, this provides some chance of
handling this: naive code like the above will result in a ucontext_t
whose extra_context data pointer is "wrong": extra_context aware
parsers can detect that and error out or ignore the remaining data.
extra_context aware code that wants to copy the signal context can walk
the signal frame to determine its true size, allocate memory, copy, and
then update the extra_context data pointer in the new copy.

This isn't foolproof, but it at least gives us some protection.

Cheers
---Dave
