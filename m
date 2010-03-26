From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/7] perf updates and fixes
Date: Fri, 26 Mar 2010 08:58:17 +0100
Message-ID: <20100326075817.GA27394@elte.hu>
References: <1269568362-13690-1-git-send-regression-fweisbec@gmail.com>
 <20100326060229.GA5259@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40879 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab0CZH6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 03:58:31 -0400
Content-Disposition: inline
In-Reply-To: <20100326060229.GA5259@drongo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Miller <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Archs <linux-arch@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Stephane Eranian <eranian@google.com>


* Paul Mackerras <paulus@samba.org> wrote:

> On Fri, Mar 26, 2010 at 02:52:35AM +0100, Frederic Weisbecker wrote:
> 
> > The series is not yet mergeable because it would break PowerPc (hot regs 
> > snapshot API has been changed, and I don't know how to update PowerPc for 
> > that).
> > 
> > But if you're fine with the ideas, I can integrate the necessary changes 
> > to fix this, and also separate fixes and updates.
> 
> The patch below adds the necessary stuff for powerpc.  You could fold it 
> into your "perf: Move perf_arch_fetch_caller_regs into a macro" patch, or 
> keep it as a separate patch in the series (though that would make preserving 
> bisectability more difficult).

Since the series needs a resend anyway folding back ought to be fine i think.

I'm wondering whether this should get into tip:perf/urgent - or in 
tip:perf/core for 2.6.35.

It fixes sw event call trace ugliness, but is that a 2.6.34 regression? Is 
there any other aspect of the series that points towards accelerating this 
into .34?

Thanks,

	Ingo
