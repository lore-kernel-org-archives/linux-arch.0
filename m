From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC patch 15/15] LTTng timestamp x86
Date: Mon, 20 Oct 2008 11:07:05 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA353346068@orsmsx505.amr.corp.intel.com>
References: <20081016234657.837704867@polymtl.ca>
 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
 <20081017012835.GA30195@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
 <20081017172515.GA9639@goodmis.org>
 <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
 <20081017184215.GB9874@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA35334594F@orsmsx505.amr.corp.intel.com>
 <20081017202313.GA13597@Krystal>
 <57C9024A16AD2D4C97DC78E552063EA353345B9B@orsmsx505.amr.corp.intel.com>
 <20081018170118.GA22243@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50394 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbYJTSH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Oct 2008 14:07:29 -0400
In-Reply-To: <20081018170118.GA22243@Krystal>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>

> And what do we say when we detect this ? "sorry, please upgrade your
> hardware to get a reliable trace" ? ;)

My employer might be happy with that answer ;-) ... but I think
we could tell the user to:

        1) adjust something in /sys/...
        2) boot with some special option
        3) rebuild kernel with CONFIG_INSANE_TSC=y

to switch over to a heavyweight workaround in s/w.  Systems
that require this are already in the minority ... and I
think (hope!) that current and future generations of cpus
won't have these challenges.

So this is mostly a campaign for the default code path to
be based on current (sane) TSC behaviour ... with the workarounds
for past problems kept to one side.

> Nope, this is not required. I removed the heartbeat event from LTTng two
> weeks ago, implementing detection of the delta from the last timestamp
> written into the trace. If we detect that the new timestamp is too far
> from the previous one, we write the full 64 bits TSC in an extended
> event header. Therefore, we have no dependency on interrupt latency to
> get a sane time-base.

Neat.  Could you grab the HPET value here too?


> (8 cores up)

Interesting results.  I'm not at all sure why HPET scales so badly.
Maybe some h/w throttling/synchronizing going on???

-Tony
