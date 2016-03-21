From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 21 Mar 2016 17:32:15 +0100
Message-ID: <20160321163215.GC6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-5-git-send-email-cmetcalf@mellanox.com>
 <20160321154201.GA6344@twins.programming.kicks-ass.net>
 <56F01E10.6030909@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34987 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbcCUQcY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 12:32:24 -0400
Content-Disposition: inline
In-Reply-To: <56F01E10.6030909@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Aaron Tomlin <atomlin@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>, Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Mar 21, 2016 at 12:15:12PM -0400, Chris Metcalf wrote:
> On 03/21/2016 11:42 AM, Peter Zijlstra wrote:

> >The most common idle function for x86 is: mwait_idle_with_hints(),
> >trouble is, its an inline, so I'm not sure adding __cpuidle to it does
> >anything.
> 
> No, you're right, it wouldn't help.  I didn't look at the drivers/cpuidle
> subsystem at all in my patch, since I'm not that familiar with it,
> but it seems like tagging acpi_processor_ffh_cstate_enter(), as the
> only user of mwait_idle_with_hints(), will do the job.

intel_idle() also uses it.

> >I've yet to find the magic objdump incantation to check. Or rather
> >objdump -h doesn't appear to list .cpuidle.text at all :/
> >
> >I'm probably doing something silly...
> 
> The easiest way to check for a given function is just to look
> at the "nm -n" output and see that all the functions you expect
> to reflect idle behavior are in the cpuidle begin/end range.

# nm -n ivb-ep-build/vmlinux | awk '/__cpuidle_text_start/ {p=1} {if (p) print $0} /__cpuidle_text_end/ {p=0}'
ffffffff81b16ca8 T __cpuidle_text_start
ffffffff81b16cb0 T default_idle
ffffffff81b16e50 t mwait_idle
ffffffff81b17080 t cpu_idle_poll
ffffffff81b17280 T default_idle_call
ffffffff81b172be T __cpuidle_text_end

So no intel_idle for me..

> objdump -h certainly works to show .cpuidle.text if you look at
> individual objects (e.g. arch/x86/kernel/process.o) but by the time
> you're looking at the linked vmlinux image they have all been linked
> into the giant .text section.

Indeed.
