From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/5] arm64: signal: Allow expansion of the signal frame
Date: Mon, 19 Jun 2017 12:03:47 +0100
Message-ID: <20170619110346.GB3024@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-6-git-send-email-Dave.Martin@arm.com>
 <20170616104740.GA31526@e104818-lin.cambridge.arm.com>
 <20170619101204.GA8543@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753838AbdFSLDv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jun 2017 07:03:51 -0400
Content-Disposition: inline
In-Reply-To: <20170619101204.GA8543@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 19, 2017 at 11:12:29AM +0100, Dave P Martin wrote:
> On Fri, Jun 16, 2017 at 11:47:41AM +0100, Catalin Marinas wrote:
> > On Thu, Jun 15, 2017 at 03:03:42PM +0100, Dave P Martin wrote:
> > > +struct extra_context {
> > > +	struct _aarch64_ctx head;
> > > +	void __user *data;	/* 16-byte aligned pointer to extra space */
> > > +	__u32 size;		/* size in bytes of the extra space */
> > > +	__u32 __reserved[3];
> > > +};
> > 
> > Some more thoughts on the type of "data" above. It's the first time we
> > introduce pointers in sigcontext and wonder whether __u64 would make
> > more sense (invariable size with the ABI).
> 
> I'm happy to change this if you want -- it can be a __u64 without
> impacting the semantics.

I was thinking in the context of ILP32 but we can address this
separately for the exported kernel headers and glibc definitions.
Looking at this structure from an LP64 perspective, it indeed makes
sense to keep it as void *. We have other UAPI structures with user
pointers already.

> > Also for discussion - whether using an offset vs absolute address would
> > be better.
> 
> My rationale here related to the ucontext semantics associated with
> the signal frame, rather than signal handling itself.
> 
> Consider:
> 
> void signal_handler(int n, siginfo_t *si, void *uc)
> {
> 	*signal_context = *(ucontext_t *)uc;
> }
> 
> Will this "work"?  On most machines, yes it will. 
> 
> With an expanded signal frame on arm64, it won't work: the copied
> context will be truncated at the end of __reserved[].  If extra_data
> uses an offset to locate the additional data then someone parsing
> *signal_context won't be able to detect the error and will overrun:
> this includes rt_sigreturn (if that is run on a stack that has the
> copied context).
> 
> If a pointer is used in extra_context, this provides some chance of
> handling this: naive code like the above will result in a ucontext_t
> whose extra_context data pointer is "wrong": extra_context aware
> parsers can detect that and error out or ignore the remaining data.
> extra_context aware code that wants to copy the signal context can walk
> the signal frame to determine its true size, allocate memory, copy, and
> then update the extra_context data pointer in the new copy.

Thanks for the explanation, it makes sense to keep an absolute pointer
here rather than offset. So no further changes needed to this patch.

-- 
Catalin
