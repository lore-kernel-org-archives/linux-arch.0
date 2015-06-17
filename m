From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Wed, 17 Jun 2015 15:33:58 +0200
Message-ID: <20150617133358.GR3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-2-git-send-email-vgupta@synopsys.com>
 <20150615153029.GE3644@twins.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59732 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbbFQNeC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 09:34:02 -0400
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

On Tue, Jun 16, 2015 at 11:45:52AM +0000, Alexey Brodkin wrote:
> First let me clarify a bit how we deal with hardware events in ARC cores.
> 
>  a) ARC core may have an arbitrary set of hardware events built-in.
>  Upon creation of new ASIC project hardware engineer may select which
>  events will be exposed to event counters. For example only a very
>  basic set of events could be made available like "cycles running",
>  "committed instructions" etc. Or much more extensive set of events
>  could be exposed to event counters including very specific
>  architectural events like separate "committed 16-bit instructions"
>  and "committed 32-bit instructions".
> 
>  b) Also list of all possible events is much longer than 32 or 64
>  entries that makes it impossible to map all possible events as a
>  separate bits in 32- or 64-bit word.
> 
> Having both [a] and [b] in mind we implemented the following scheme of working with HW events.
> 
>  [1] Hardware may report a list of all event that could be counted in this particular CPU.
> 
>  [2] That lists consists of short ASCII names (up to 8 characters) for each event.
> 
>  [3] Index of the particular even in the list is used to setup an event counter.
> 
> See corresponding code for it here:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/kernel/perf_event.c#n308
> 
> I.e. if we need to count "xxx" event and we know it's 10th in the list
> of events we set event counter to count event #10, see
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/kernel/perf_event.c#n151
> 
> With generic hardware events we don't do any visible trickery as you
> may see from code by the link above simply because we know how to
> translate PERF_COUNT_HW_CPU_CYCLES to the index of corresponding
> event, see:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/include/asm/perf_event.h#n87
> 
> But in case of raw events we need to set a counter with index of a
> particular event. For example we need to count "myevnt0" events. For
> this we need first to find-out what's an index in events list of
> "myevnt0" event and then set event counter to count event #x.
> 
> Even though in theory we may set raw even passing an index of desired
> event 

That is what I was thinking of, until I read:

> but given my explanation above each particular CPU may have the
> same event with different index in events list.

...

> Fortunately there's already a patch series floating in LKML that
> attempts to simplify usage of architecture-specific events, see
> http://www.spinics.net/lists/kernel/msg2010232.html

So you _can_ know a priory in which order the events are for a
particular CPU ? Say through /proc/cpuinfo.

I would much prefer the raw thing to remain a number; it puts you in
pretty much the same place as most other archs, including x86.

On x86 we have a huge event list (see the Intel SDM for example) and the
only way to access those (currently, without the above patch series) is
to look in the PDF under the right model and enter the numbers by hand.


The only way in which your hardware appears different is in that it
seems to include these names in hardware; which to me seems a waste of
perfectly fine silicon, but hey not my call.
