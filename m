From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/8] ARC: perf: support RAW events
Date: Wed, 17 Jun 2015 19:40:37 +0530
Message-ID: <55817FDD.7060902@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com> <1433852372-29494-2-git-send-email-vgupta@synopsys.com> <20150615153029.GE3644@twins.programming.kicks-ass.net> <4881796E12491D4BB15146FE0209CE64656C9E81@DE02WEMBXB.internal.synopsys.com> <20150617133358.GR3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:36097 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbbFQOK6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 10:10:58 -0400
In-Reply-To: <20150617133358.GR3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

On Wednesday 17 June 2015 07:03 PM, Peter Zijlstra wrote:
>> But in case of raw events we need to set a counter with index of a
>> > particular event. For example we need to count "myevnt0" events. For
>> > this we need first to find-out what's an index in events list of
>> > "myevnt0" event and then set event counter to count event #x.
>> > 
>> > Even though in theory we may set raw even passing an index of desired
>> > event 
> That is what I was thinking of, until I read:
> 
>> > but given my explanation above each particular CPU may have the
>> > same event with different index in events list.
> ...
> 
>> > Fortunately there's already a patch series floating in LKML that
>> > attempts to simplify usage of architecture-specific events, see
>> > http://www.spinics.net/lists/kernel/msg2010232.html
> So you _can_ know a priory in which order the events are for a
> particular CPU ? Say through /proc/cpuinfo.
> 
> I would much prefer the raw thing to remain a number; it puts you in
> pretty much the same place as most other archs, including x86.

Sure, but that doesn't mean we start using the index of event as a raw ID. There
are zillion ways to configure cores and the index will certainly start varying.
Which means that user has to determine at run time (using whatever /proc/xxx) what
crun corresponds to. Why inflict such pain on poor guy.

The current raw event, despite representing an ASCII string is still a u64 number.
So it is not more "raw" than what others have. We can get rid of the swapping
business when setting up a raw event, by making sure that cached values from probe
are already in same format.

But using index as a event id is no go sorry...

> 
> On x86 we have a huge event list (see the Intel SDM for example) and the
> only way to access those (currently, without the above patch series) is
> to look in the PDF under the right model and enter the numbers by hand.

It is not much different for us !

> The only way in which your hardware appears different is in that it
> seems to include these names in hardware; which to me seems a waste of
> perfectly fine silicon, but hey not my call.

Yeah sins of the past.... :-)
