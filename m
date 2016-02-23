Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42484 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbcBWKj6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2016 05:39:58 -0500
Date: Tue, 23 Feb 2016 11:39:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Interesting csd deadlock on ARC
Message-ID: <20160223103950.GJ6356@twins.programming.kicks-ass.net>
References: <56C6BA82.1060909@synopsys.com>
 <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CC32A3.5020804@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56CC32A3.5020804@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20160223103950.CAYNVTVEx_mg4eU_z0uSf2JzlFu6-Ja3-oeJaDgwt2w@z>

On Tue, Feb 23, 2016 at 03:51:23PM +0530, Vineet Gupta wrote:
> > 
> > Now the distinct difference between arch_irq_work_raise() and
> > arch_send_call_function_single_ipi() is that arch_irq_work_raise()
> > should be NMI-safe.
> 
> Ok - so when I implement interrupt priorities (aka NMI for ARC), this needs to be
> highest.

So on x86 the issue is that the NMI can interrupt someone else writing
to the lapic. So there's a bit of extra care to be taken.

If your platform doesn't suffer such issues, then that should be fine.

The only requirement for irq_work is that it runs after the NMI
completes and runs from regular IRQ context. There are no strict
interrupt priority requirements, only that it happens.

> > I seem to have forgotten the status of NMIs on ARC, but this is
> > something to make a note of.
> 
> Not had a chance to go back to it since we last discussed.
> I've just been swamped with bug fixing like this one :-(

Yeah, I'm familiar with the problem ...
