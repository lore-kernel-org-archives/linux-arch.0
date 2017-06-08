From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH v2 4/6] arm64: signal: Allocate extra sigcontext
 space as needed
Date: Thu, 8 Jun 2017 09:46:17 +0100
Message-ID: <20170608084614.GH30160@e103592.cambridge.arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
 <20170512165724.GB8387@e104818-lin.cambridge.arm.com>
 <20170515132442.GB3559@e103592.cambridge.arm.com>
 <20170523113019.GB5948@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdFHIqV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jun 2017 04:46:21 -0400
Content-Disposition: inline
In-Reply-To: <20170523113019.GB5948@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 23, 2017 at 12:30:19PM +0100, Catalin Marinas wrote:
> On Mon, May 15, 2017 at 02:24:45PM +0100, Dave P Martin wrote:
> > On Fri, May 12, 2017 at 05:57:24PM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 12, 2017 at 06:01:13PM +0100, Dave P Martin wrote:
> > > > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > > > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > > > @@ -80,4 +80,31 @@ struct esr_context {
> > > >  	__u64 esr;
> > > >  };
> > > >  
> > > > +/*
> > > > + * Pointer to extra space for additional structures that don't fit in
> > > > + * sigcontext.__reserved[].  Note:
> > > > + *
> > > > + * 1) fpsimd_context, esr_context and extra_context must be placed in
> > > > + * sigcontext.__reserved[] if present.  They cannot be placed in the
> > > > + * extra space.  Any other record can be placed either in the extra
> > > > + * space or in sigcontext.__reserved[].
> > > > + *
> > > > + * 2) There must not be more than one extra_context.
> > > > + *
> > > > + * 3) If extra_context is present, it must be followed immediately in
> > > > + * sigcontext.__reserved[] by the terminating null _aarch64_ctx (i.e.,
> > > > + * extra_context must be the last record in sigcontext.__reserved[]
> > > > + * except for the terminator).
> > > > + *
> > > > + * 4) The extra space must itself be terminated with a null
> > > > + * _aarch64_ctx.
> > > > + */
> > > 
> > > IIUC, if we need to save some state that doesn't fit in what's left of
> > > sigcontext.__reserved[] (e.g. SVE with 1024-bit vector length), we
> > > ignore the available space and go for a memory block following the end
> > > of sigcontext.__reserved[] + 16. Is there a reason we can't store the
> > > new state across the end of sigcontext.__reserved[] and move fp/lr at
> > > the end of the new frame? I'm not sure the fp/lr position immediately
> > > after __reserved[] counts as ABI.
> > 
> > This was my original view.
> > 
> > Originally I preferred not to waste the space and did move fp/lr to the
> > end, but someone (I think you or Will) expressed concern that the fp/lr
> > position relative to the signal frame _might_ count as ABI.
> > 
> > I think it's not that likely that software will be relying on this,
> > since it appears easier just to follow the frame chain than to treat
> > this as a special case.
> > 
> > But it's hard to be certain.  It comes down to a judgement call.
> 
> I would not consider this ABI. The ABI part is that the fp register
> points to where fp/lr were saved.

On this point, it looks like the libgcc unwinder

https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=libgcc/config/aarch64/linux-unwind.h;h=d5d6980442fd47b1f1e499e99cb25b5fffbdbeb3;hb=HEAD

doesn't rely on the frame record location.  It clones the (internal)
struct rt_sigframe definition from v3.7, which doesn't include any frame
record, and mines fp and lr out of the signal frame AFAICT.

It appears that gdb and libunwind likely take the same approach, but
I've not looked closely yet.

The frame record in rt_sigframe was added in by Will in 304ef4e83672
("arm64: signal: push the unwinding prologue on the signal stack"),
which changes from pushing the frame record onto the interrupted stack
(which may be inaccessible for a SEGV), to pushing onto the signal
stack.


Even with the frame record split from rt_sigframe, I've not seen any
failed backtrace in gdb.  Throwing an exception from a SEGV handler in
C++ (with -fnon-call-exceptions) also appears to work reliably with
that change, even when the signal frame grows.

In any case, there is no ABI break unless there is extra_context, so
it shouldn't impact current userspace.

Cheers
---Dave
