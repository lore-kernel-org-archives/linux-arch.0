From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 6/6] arch: Remove stub cputime.h headers
Date: Wed, 12 Mar 2014 16:23:28 +0100
Message-ID: <20140312152323.GA12280@localhost.localdomain>
References: <1394590202-772-1-git-send-email-fweisbec@gmail.com>
 <1394590202-772-7-git-send-email-fweisbec@gmail.com>
 <20140312094447.GP30956@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:59892 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937AbaCLPXc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Mar 2014 11:23:32 -0400
Content-Disposition: inline
In-Reply-To: <20140312094447.GP30956@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Archs <linux-arch@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>

On Wed, Mar 12, 2014 at 10:44:47AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 12, 2014 at 03:10:02AM +0100, Frederic Weisbecker wrote:
> > diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> > index a73a8e2..1a81a8b 100644
> > --- a/arch/alpha/include/asm/Kbuild
> > +++ b/arch/alpha/include/asm/Kbuild
> > @@ -5,3 +5,4 @@ generic-y += exec.h
> >  generic-y += trace_clock.h
> >  generic-y += preempt.h
> >  generic-y += hash.h
> > +generic-y += cputime.h
> > \ No newline at end of file
> 
> That's a double fail there, not sorted and no EOL.
> 
> Please run the script from commit: b119fa61d440f after you touch the
> asm/Kbuild files.

I don't see why we need to sort them. But I'm running the script anyway.
Will resend, thanks.
