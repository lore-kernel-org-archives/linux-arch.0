From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Wed, 17 Jun 2015 14:44:48 +0200
Message-ID: <20150617124448.GQ3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
 <20150615162525.GH3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A59A6@IN01WEMBXB.internal.synopsys.com>
 <20150616090713.GJ3644@twins.programming.kicks-ass.net>
 <55815E8B.9090600@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59076 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbFQMox (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 08:44:53 -0400
Content-Disposition: inline
In-Reply-To: <55815E8B.9090600@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Chuck Jordan <Chuck.Jordan@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

On Wed, Jun 17, 2015 at 05:18:27PM +0530, Vineet Gupta wrote:
> Turns out that it is possible to implement NMI on ARCv2 in a pretty
> straightforward way.
> 
> Our RTOS Guru, Chuck, told me off list, that instead of using CLRI / SETI, we can
> use SETI with different args which would keep the stat32.IE enabled all the times,
> but wiggle the stat32.E[ ] to change the intr prio level, effectively locking out
> only lower prio interrupts in any local_irq_save() / restore() region.

Nice.

> But isn't this defying the irq disable/enable semantics and could lead to
> potential breach of *some* critical section.

Well only if you then hand out interrupts for that priority level
without treating them as NMIs.

Note that NMIs do not nest, so if your hardware can raise multiple
interrupts for any one level it needs to mask the level in your
handler's entry code.

> Neverthless, doing this requires some more changes in ARCv2 support code - so for
> now we will go with the normal interrupts and later bolt on the NMI emulation.

Sure, smalls steps etc.. :-)
