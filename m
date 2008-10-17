From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 17 Oct 2008 13:25:16 -0400
Message-ID: <20081017172515.GA9639@goodmis.org>
References: <20081016232729.699004293@polymtl.ca> <20081016234657.837704867@polymtl.ca> <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org> <20081017012835.GA30195@Krystal> <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:61193 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbYJQRZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Oct 2008 13:25:23 -0400
Content-Disposition: inline
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Oct 16, 2008 at 07:19:48PM -0700, Luck, Tony wrote:
> > This cache-line bouncing global clock is a best-effort to provide
> > correct event order in the trace on architectures with unsync tsc. It's
> > actually better than a global tracing buffer because it limits the
> > number of cache line transfers required to one per event.
> 
> Even one line bouncing between cpus can be a performamce disaster.
> You'll probably hit a serious wall somewhere between 8 and 16
> cpus (ia64 has code that looks a lot like this in the gettimeofday()
> path because it does not synchronize cpu cycle counters ... some
> applications that are overly fond of timestamping internal
> events using gettimeofday() end up spending significant time
> doing so on large systems ... even with only a few thousands
> of calls per second).
> 

I agree that one cache line bouncer is devastating to performance. But
as Mathieu said, it is better than a global tracer with lots of bouncing
going on. My logdev tracer (something similar to ftrace, but used only
for debugging) use to have a single buffer. By moving it to a per cpu
buffer and using an atomic counter to sort the events, the increase of
speed was a few magnitudes.

ftrace does not have a global counter, but on some boxes with out of
sync TSCs, it could not find race conditions. I had to pull in logdev,
which found the race right away, because of this atomic counter.

logdev adds a bit of perfomance degradation, but for debugging, I don't
care, and it has helped me quite a bit.

ftrace can help in debugging most of the time, but on some boxes with
wacky time stamps, it is useless to find race problems between CPUS. But
ftrace is for production, and can not afford the performance penalty of
a global counter.

-- Steve
