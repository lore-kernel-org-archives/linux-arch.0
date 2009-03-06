From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Sat, 07 Mar 2009 08:40:36 +1100
Message-ID: <1236375636.7260.160.camel@pasglop>
References: <1235996477.5330.174.camel@laptop>
	 <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
	 <1236329922.7260.127.camel@pasglop>  <1236330733.6326.15.camel@laptop>
	 <1236333543.7260.138.camel@pasglop>  <1236335049.6326.114.camel@laptop>
	 <1236358944.6326.538.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53303 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbZCFVlP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Mar 2009 16:41:15 -0500
In-Reply-To: <1236358944.6326.538.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Tho mas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


> Ok, people put me straight here. Since linux not support interrupt
> priorities, wouldn't it simply be a matter of implementing
> local_irq_en/dis-able() as masking the lowest level you use to run
> normal interrupts on?
> 
> That will leave your other interrupt level available as NMI/debug
> thingies.

No, you are missing some subtle things here.

local_irq_enable/disable() is about masking interrupts at the core
level. This will, on archs like powerpc, mask them -all- including the
timer for example, which is not sourced externally for us but comes from
a specific CPU facility and generates a different exception vector from
external interrupts. It also include to some extent perfmon interrupts
etc...

Now, once you get to -external- interrupts, there is one input line per
core/thread (some archs have more, and some powerpc variants also have a
second one for "critical" interrupts but let's not go there for now).
This line is controlled by a PIC, which can be one of many sorts, such
as the OpenMPIC (aka MPIC, popular on macs among other things), XICS
(newer pseries), etc...

Those PICs have a concept of priority (they don't all do, but on powerpc
it happens that a good chunk of them do). IE. individual external
interrupts can be prioritized. Also, because some of these are "smart"
PICs, (they use a fasteoi flow handler), they know whether an interrupt
is still being serviced and can handle priorities at eoi time. They
typically maintain a per-cpu current priority register internally,
raised when a CPU gets/acks an interrupt and lowered when that CPU does
an EOI).

So basically, you not only have the ability to control what interrupts
can nest what interrupts, but you -know- that at equal priorities, no
nesting will occur, which allows to fairly easily limit the amount of
nesting overall.

Hence, there is effectively no risk of uncontrolled nesting (unless it's
configured like shit which is always a possibility);

Now, as I proposed in an earlier email (maybe it got lost), if
uncontrolled nesting is what motivates you here, why not just change the
test of IRQF_DISABLED to also test for an arch hook, let's call it
arch_nest_irq(). Archs can hard wire that to 0 effectively enforcing
IRQF_DISABLED semantics on all interrupts. But you can be smarter and
look at how much stack space remains on your interrupt stack, and only
allow nesting if it's for example more than a couple of KBs.

Cheers,
Ben.
