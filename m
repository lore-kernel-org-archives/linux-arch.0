From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 18:17:38 +0100
Message-ID: <20160321171738.GE6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321154201.GA6344@twins.programming.kicks-ass.net>
 <56F01E10.6030909@mellanox.com>
 <20160321163215.GC6344@twins.programming.kicks-ass.net>
 <56F02B87.2000307@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51988 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbcCURRr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 13:17:47 -0400
Content-Disposition: inline
In-Reply-To: <56F02B87.2000307@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Mar 21, 2016 at 01:12:39PM -0400, Chris Metcalf wrote:
> I do see mwait used in the ACPI 4.0 Processor Aggregator Device driver, but
> this seems sufficiently far removed from regular cpuidle that I don't
> think it's appropriate to tag the power_saving_thread() function -
> the initial commit talks about using the mechanism "to ride-out
> transient electrical and thermal emergencies."
> 
> There's also the thermal "powerclamp" driver that enforces a particular
> amount of idle time across the system.  For this one it's less clear to
> me whether this is a valid "idle" state that we should ignore when doing
> NMI backtracing.  This would be the clamp_thread() function in
> drivers/thermal/intel_powerclamp.c.  For now I'm not including it,
> but what do you think?

Both the acpi power aggregator and the powerclamp driver are forced idle
and have some serious issues, so are safe to ignore for now.

Also, I would explicitly not include them, because forced idle might
still be interesting.


> ># nm -n ivb-ep-build/vmlinux | awk '/__cpuidle_text_start/ {p=1} {if (p) print $0} /__cpuidle_text_end/ {p=0}'
> >ffffffff81b16ca8 T __cpuidle_text_start
> >ffffffff81b16cb0 T default_idle
> >ffffffff81b16e50 t mwait_idle
> >ffffffff81b17080 t cpu_idle_poll
> >ffffffff81b17280 T default_idle_call
> >ffffffff81b172be T __cpuidle_text_end
> >
> >So no intel_idle for me..
> 
> With the changes discussed so far in this email thread, we've gotten to:
> 
> ffffffff818df178 T __cpuidle_text_start
> ffffffff818df180 T default_idle
> ffffffff818df260 t mwait_idle
> ffffffff818df3f0 T acpi_processor_ffh_cstate_enter
> ffffffff818df4a0 T default_idle_call
> ffffffff818df4e0 t cpu_idle_poll

> ffffffff818df600 t intel_idle_freeze

You can skip this one, that only happens when you suspend to idle.

> ffffffff818df6a0 t intel_idle
> ffffffff818df7b5 T __cpuidle_text_end
> 
> This is about 1,600 bytes (or about 450 instructions) that will cause
> NMI to skip doing a backtrace if the PC is anywhere in the range.

Yeah, the alternative is making mwait_idle_with_hints an actual
function, but then we get to somehow exclude the other users like the
forced idle stuff.
