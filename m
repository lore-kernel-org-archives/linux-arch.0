From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -tip -v5] irq_work: generic hard-irq context callbacks
Date: Mon, 20 Sep 2010 11:13:01 +0200
Message-ID: <1284973981.2275.642.camel@laptop>
References: <1284689131.32373.63.camel@yhuang-dev>
	 <1284728802.28028.470.camel@twins>  <20100920042011.GA13542@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:60103 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0ITJNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2010 05:13:23 -0400
In-Reply-To: <20100920042011.GA13542@drongo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Huang Ying <ying.huang@intel.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Mon, 2010-09-20 at 14:20 +1000, Paul Mackerras wrote:
> On Fri, Sep 17, 2010 at 03:06:42PM +0200, Peter Zijlstra wrote:
> 
> > Provide a mechanism that allows running code in IRQ context. It is most
> > useful for NMI code that needs to interact with the rest of the system
> > -- like wakeup a task to drain buffers.
> > 
> > Perf currently has such a mechanism, so extract that and provide it as a
> > generic feature, independent of perf so that others may also benefit.
> > 
> > The IRQ context callback is generated through self-IPIs where possible,
> > or on architectures like powerpc which have soft-disabled IRQs, its ran
> > on the soft-enable path.
> 
> Actually these days we do it by setting the decrementer (the built-in
> timer facility) to generate an interrupt immediately (well, within one
> timebase tick, i.e. a small number of nanoseconds).

Then that is something that wants curing I guess.. 
