From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 06/10] arm64/sve: Disallow VL setting for individual
 threads by default
Date: Mon, 16 Jan 2017 12:23:40 +0000
Message-ID: <20170116122337.GN3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
 <20170116113439.GF28060@E107787-LIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdAPMXp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jan 2017 07:23:45 -0500
Content-Disposition: inline
In-Reply-To: <20170116113439.GF28060@E107787-LIN>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yao Qi <qiyaoltc@gmail.com>
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Mon, Jan 16, 2017 at 11:34:39AM +0000, Yao Qi wrote:
> On 17-01-12 11:26:05, Dave Martin wrote:
> > General-purpose code in userspace is not expected to work correctly
> > if multiple threads are allowed to run concurrently with different
> > vector lengths in a single process.
> > 
> > This patch adds an explicit flag PR_SVE_SET_VL_THREAD to request
> > this behaviour.  Without the flag, vector length setting is
> > permitted only for a single-threaded process (which matches the
> > expected usage model of setting the vector length at process
> > startup).

To be clear, PR_SVE_SET_VL_THREAD is not persistent, it just overrides
the default one-thread-per-process restriction for this prctl call.

The idea is that if someone writes some code to set the VL and then
moves the code to a multithreaded environment, by default it will stop
working.  This is a hint that some actual work is likely needed to
port their code to work with multiple threads.

> Hi Dave,
> PR_SVE_SET_VL_THREAD can be arch-independent, IMO, because prctl
> needs a scope.  Looks some of them are system-wide, some of them are
> about threads within the same process (like, PR_MPX_ENABLE_MANAGEMENT).
> IOW, PR_SVE_SET_VL_THREAD can be general flag, to indicate the scope
> of each new ptrcl command is per-thread.

This can't be backported to the existing prctls because that would
change their behaviour.   Rather, what each prctl applies (thread or
process) is part of the definition of that particular prctl.

Since there are no other prctl() calls that can apply per-thread or
per-process, or that differ only in this regard, is seems a bit esoteric
to try to apply this concept across all prctls... ?

Which prctl()s are system-wide?  I didn't see any, but I may have missed
something.

> I happen to see PR_SET_FP_MODE in man pages, which is about setting
> FP register modes in runtime.  It is a little similar to setting VL in
> this patch.  However the doc doesn't mention the effect or the scope
> of this command.

The various FP/SIMD twiddling prctls() all seem to be arch-specific.
PR_SET_FP_MODE only exists for mips.

Unless the semantics are really the same, I'm not too keen on an arm64
prctl with the same name.

Putting "ARM64" in the name of the new prctls might be clearer, but
nobody seemed to care so far...

Cheers
---Dave
