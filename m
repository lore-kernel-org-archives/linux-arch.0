From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH 1/8] ARC: perf: support RAW events
Date: Tue, 16 Jun 2015 11:45:52 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-2-git-send-email-vgupta@synopsys.com>,<20150615153029.GE3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34453 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbFPLp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2015 07:45:58 -0400
In-Reply-To: <20150615153029.GE3644@twins.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi Peter,

On Mon, 2015-06-15 at 17:30 +0200, Peter Zijlstra wrote:
> On Tue, Jun 09, 2015 at 05:49:25PM +0530, Vineet Gupta wrote:
> > +/*
> > + * Raw events are specified in hex value of ASCII chars:
> > + *
> > + * In PCT register CC_NAME{0,1} event name string[] is saved from
> > LSB side:
> > + * e.g. cycles corresponds to ARC "crun" and is saved as
> > 0x6e757263
> > + *							    n u r
> > c
> > + * However in perf cmdline they are specified in human order as
> > r6372756e
> > + *
> > + * Thus event from cmdline requires an word swap
> > + */
> > +static int arc_pmu_raw_event(u64 config)
> > +{
> > +	int i;
> > +	char name[sizeof(u64) + 1] = {0};
> > +	u64 swapped = __swab64(config);
> > +
> > +	/* Trim leading zeroes */
> > +	for (i = 0; i < sizeof(u64); i++)
> > +		if (!(swapped & 0xFF))
> > +			swapped = swapped >> 8;
> > +		else
> > +			break;
> > +
> > +	for (i = 0; i < arc_pmu->n_events; i++) {
> > +		if (swapped == arc_pmu->raw_events[i])
> > +			break;
> > +	}
> > +
> > +	if (i == arc_pmu->n_events)
> > +		return -ENOENT;
> > +
> > +	memcpy(name, &swapped, sizeof(u64));
> > +
> > +	pr_debug("Initializing raw event: %s\n", name);
> > +
> > +	return i;
> > +}
> 
> Urgh, what? Why?
> 
> raw is just that _raw_, no mucking about with the value.
> 
> If you want convenience, provide the event/format stuff so you can
> write:
> 
> 	perf record -e 'cpu/c=0xff,r=0cff,u=0xff,n=0xff'
> 
> Or whatever that syntax was again (I keep forgetting).

It was me who implemented that code so let me comment on that.

First let me clarify a bit how we deal with hardware events in ARC cores.

 a) ARC core may have an arbitrary set of hardware events built-in. Upon creation of new ASIC project hardware engineer may select which events will be exposed to event counters. For example only a very basic set of events could be made available like "cycles running", "committed instructions" etc. Or much more extensive set of events could be exposed to event counters including very specific architectural events like separate "committed 16-bit instructions" and "committed 32-bit instructions".

 b) Also list of all possible events is much longer than 32 or 64 entries that makes it impossible to map all possible events as a separate bits in 32- or 64-bit word.

Having both [a] and [b] in mind we implemented the following scheme of working with HW events.

 [1] Hardware may report a list of all event that could be counted in this particular CPU.

 [2] That lists consists of short ASCII names (up to 8 characters) for each event.

 [3] Index of the particular even in the list is used to setup an event counter.

See corresponding code for it here: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/kernel/perf_event.c#n308

I.e. if we need to count "xxx" event and we know it's 10th in the list of events we set event counter to count event #10, see http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/kernel/perf_event.c#n151

With generic hardware events we don't do any visible trickery as you may see from code by the link above simply because we know how to translate PERF_COUNT_HW_CPU_CYCLES to the index of corresponding event, see: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arc/include/asm/perf_event.h#n87

But in case of raw events we need to set a counter with index of a particular event. For example we need to count "myevnt0" events. For this we need first to find-out what's an index in events list of "myevnt0" event and then set event counter to count event #x.

Even though in theory we may set raw even passing an index of desired event but given my explanation above each particular CPU may have the same event with different index in events list.

And to make life of perf user a bit easier we allow specification of raw event as a hex-encoded ASCII name of the event.

For example if we want to count "crun" events we pass "r6372756e" which is "r" for raw event and 0x63 ("c"), 0x72 ("r"), 0x75 ("u") and 0x6e ("n").

Here're more examples:
 * "bflush" (pipeline bubbles caused by any type of flush) will be "r62666c757368"
 * "icm" (instruction cache miss) will be "r69636d"
 * "imemwrc" (instruction: memory write) will be "r696d656d777263"

I understand that even this method of raw events specification is not the most human friendly but given rare need to use we believe it worth having it.

Fortunately there's already a patch series floating in LKML that attempts to simplify usage of architecture-specific events, see http://www.spinics.net/lists/kernel/msg2010232.html

And once mentioned patch series is accepted (it's on its 15th respin so I hope sooner or later it will be in mainline) probably we'll be able to get rid of discussed tricky functionality in ARC perf. But for now we'd like to have currently working tool that allows us to do low-level profiling today.

I hope my explanation makes some sense. Otherwise please don;'t hesitate to ask more questions and I'll try to address them.

-Alexey