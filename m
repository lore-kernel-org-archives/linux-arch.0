From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Wed, 22 Oct 2008 12:51:29 -0400
Message-ID: <20081022165129.GD12650@Krystal>
References: <20081017012835.GA30195@Krystal> <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com> <20081017172515.GA9639@goodmis.org> <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com> <20081017184215.GB9874@Krystal> <57C9024A16AD2D4C97DC78E552063EA35334594F@orsmsx505.amr.corp.intel.com> <20081017202313.GA13597@Krystal> <57C9024A16AD2D4C97DC78E552063EA353345B9B@orsmsx505.amr.corp.intel.com> <20081018170118.GA22243@Krystal> <57C9024A16AD2D4C97DC78E552063EA353346068@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:48123 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046AbYJVQ4d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Oct 2008 12:56:33 -0400
Content-Disposition: inline
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA353346068@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>

* Luck, Tony (tony.luck@intel.com) wrote:
> > And what do we say when we detect this ? "sorry, please upgrade your
> > hardware to get a reliable trace" ? ;)
> 
> My employer might be happy with that answer ;-) ... but I think
> we could tell the user to:
> 
>         1) adjust something in /sys/...
>         2) boot with some special option
>         3) rebuild kernel with CONFIG_INSANE_TSC=y
> 
> to switch over to a heavyweight workaround in s/w.  Systems
> that require this are already in the minority ... and I
> think (hope!) that current and future generations of cpus
> won't have these challenges.
> 
> So this is mostly a campaign for the default code path to
> be based on current (sane) TSC behaviour ... with the workarounds
> for past problems kept to one side.
> 

This is exactly what I do in this patchset actually :) The common case,
when a synchronized TSC is detected, is to do a plain TSC read. However,
if a non-synchronized TSC is detected, a warning message is written to
the console (pointing to some documentation to get precise timestamping)
and the heavyweight cmpxchg-based workaround is enabled.


> > Nope, this is not required. I removed the heartbeat event from LTTng two
> > weeks ago, implementing detection of the delta from the last timestamp
> > written into the trace. If we detect that the new timestamp is too far
> > from the previous one, we write the full 64 bits TSC in an extended
> > event header. Therefore, we have no dependency on interrupt latency to
> > get a sane time-base.
> 
> Neat.  Could you grab the HPET value here too?
> 

Yes, I could. When I detect that the TSC value is too far apart from the
previous one, I reserve extra space for the header (this could include
an extra 64-bits for the HPET). At that moment, I could also sample the
HPET, given this happens relatively rarely.

Given the frequency is expected to go at about 1GHz, the 27 bits would
overflow 7-8 times per second. The only thing is that I only need this
extended field when there are absolutely no events in the stream for
an whole overflow period, which is the only case that makes the overflow
impossible to detect without having more TSC bits. In the common case
where there is a steady flow of event, we would never have such "large
TSC header" event.

However, I could do something slightly different from the large TSC
header detection. I could make sure there would be a HPET sampling done
"periodically", or at least periodically when there are events saved to
the buffer by saving, for each buffer, the last TSC value at which the
HPET sampling has been done. When we log following events, we do a HPET
sampling (and write an extended event header) if we are too far apart
from the previous sample.

We would probably need to sample the HPET at subbuffer switch too to
allow fast time-based seek on the trace when we read it.

We could then do a pre-processing on the trace buffers which would
calculate the linear interpolation of cycles counters between the
per-buffer HPET values. The nice thing is that we know the _next_ value
coming _after_ an event (which is not the case for a standard kernel
time-base), so we can be a bit more precise and we do not suffer from
things like "the TSC of a given cpu accelerates and times appears to go
backwards when the next HPET sample is taken".

But I am not sure this would be sufficient to insure generally correct
event order; the maximum interpolation error can become quite large on
systems with different clock speeds in halt states and which would
happen to have a non-steady flow of events.

> 
> > (8 cores up)
> 
> Interesting results.  I'm not at all sure why HPET scales so badly.
> Maybe some h/w throttling/synchronizing going on???
> 

As Linus said, there is probably some contention at the IO hub level.
But it implies that we have to be careful about the frequency at which
we sample the HPET, otherwise it wouldn't scale.

Mathieu

> -Tony
> 

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
