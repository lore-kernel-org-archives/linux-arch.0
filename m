From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 0/7] perf updates and fixes
Date: Fri, 26 Mar 2010 18:38:44 +0100
Message-ID: <20100326173841.GD5188@nowhere>
References: <1269568362-13690-1-git-send-regression-fweisbec@gmail.com> <20100326060229.GA5259@drongo> <20100326075817.GA27394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:44586 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0CZRit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 13:38:49 -0400
Content-Disposition: inline
In-Reply-To: <20100326075817.GA27394@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Miller <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Archs <linux-arch@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Stephane Eranian <eranian@google.com>

On Fri, Mar 26, 2010 at 08:58:17AM +0100, Ingo Molnar wrote:
> 
> * Paul Mackerras <paulus@samba.org> wrote:
> 
> > On Fri, Mar 26, 2010 at 02:52:35AM +0100, Frederic Weisbecker wrote:
> > 
> > > The series is not yet mergeable because it would break PowerPc (hot regs 
> > > snapshot API has been changed, and I don't know how to update PowerPc for 
> > > that).
> > > 
> > > But if you're fine with the ideas, I can integrate the necessary changes 
> > > to fix this, and also separate fixes and updates.
> > 
> > The patch below adds the necessary stuff for powerpc.  You could fold it 
> > into your "perf: Move perf_arch_fetch_caller_regs into a macro" patch, or 
> > keep it as a separate patch in the series (though that would make preserving 
> > bisectability more difficult).
> 
> Since the series needs a resend anyway folding back ought to be fine i think.
> 
> I'm wondering whether this should get into tip:perf/urgent - or in 
> tip:perf/core for 2.6.35.
> 
> It fixes sw event call trace ugliness, but is that a 2.6.34 regression? Is 
> there any other aspect of the series that points towards accelerating this 
> into .34?


Let's have a look:

	perf: Correctly align perf event tracing buffer

Should probably go into urgent. The change is not invasive at
all. It doesn't fix a regression but it's still an important fix.

	The rest

It depends. The whole bunch is rather invasive.
The callchains of context switches never worked correctly
I think. I couldn't tell if the cpu migration has ever worked.
If it ever did, then it's a regression fix but in the middle of
too much hot regs improvements. So I can cook a specific fix for
the cpu migration event to work, and keep the rest for perf/core.
