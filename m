From: "john stultz" <johnstul@us.ibm.com>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Mon, 20 Oct 2008 14:38:37 -0700
Message-ID: <1f1b08da0810201438g6a109af5i75b34841462b655d@mail.gmail.com>
References: <20081016232729.699004293@polymtl.ca>
	 <20081016234657.837704867@polymtl.ca>
	 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
	 <20081017012835.GA30195@Krystal>
	 <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
	 <20081017172515.GA9639@goodmis.org>
	 <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
	 <20081017184215.GB9874@Krystal>
	 <alpine.LFD.2.00.0810201256350.3518@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:63598 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbYJTVij (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Oct 2008 17:38:39 -0400
Received: by gxk9 with SMTP id 9so4527532gxk.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2008 14:38:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810201256350.3518@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Oct 20, 2008 at 1:10 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I think it's a mistake for us to maintain a single clock for
> gettimeofday() (well, "getnstimeofday" and the whole "clocksource_read()"
> crud to be technically correct). And sure, I bet clocksource_read() can do
> various per-CPU things and try to do that, but it's complex and pretty
> generic code, and as far as I know none of the clocksources have even
> tried. The TSC clocksource read certainly does not (it just does a very
> similar horrible "at least don't go backwards" crud that the LTTng patch
> suggested).
>
> So I think we should make "xtime" be a per-CPU thing, and add support for
> per-CPU clocksources. And screw that insane "mark_tsc_unstable()" thing.
>
> And if we did it well, we migth be able to get good timestamps that way
> too.

Personally I'd been hoping that the experiments in the trace
timestamping code would provide a safe area of experimentation before
we adapt it to the TSC clocksource implementation for
getnstimeofday(). Earlier I know Andi and Jiri were working on such a
per-cpu TSC clocksource, but I don't know where it ended up.

I'm not quite sure I followed your per-cpu xtime thoughts.  Could you
explain further your thinking as to why the entire timekeeping
subsystem should be per-cpu instead of just keeping that back in the
arch-specific clocksource implementation?  In other words, why keep
things synced at the nanosecond level instead of keeping the per-cpu
TSC synched at the cycle level?

thanks
-john
