From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Fri, 30 May 2008 10:27:06 +0200
Message-ID: <20080530102706.56fca248@siona.local>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
	<1211926636.3286.100.camel@pasglop>
	<20080528103648.54eb8734@hskinnemo-gx745.norway.atmel.com>
	<1212110003.15633.0.camel@pasglop>
	<20080530080700.773a82cc@siona.local>
	<1212132267.15633.69.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:39440 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbYE3I1k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 04:27:40 -0400
In-Reply-To: <1212132267.15633.69.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Fri, 30 May 2008 17:24:27 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2008-05-30 at 08:07 +0200, Haavard Skinnemoen wrote:
> > I think the drivers I've written have the necessary barriers (or dma
> > ops with implicit barriers) that they don't actually depend on any
> > DMA vs. MMIO ordering guarantees. I hope MMIO vs. MMIO ordering is
> > guaranteed though?
> 
> Only to the same address I'd say.

Right, I sort of suspected that.

Now, I'm pretty sure the architectures that can actually run those
drivers (ARM9 and AVR32 AP7) provide stronger guarantees than that, and
I suspect the same is true on most other embedded architectures that
use __raw_* in their drivers. So I don't think adding barriers is the
right thing to do because they won't do anything useful in practice, so
it's hard to tell whether they are used "correctly". And it will hurt
performance at least on AVR32 since wmb() evaluates to a "sync"
instruction, which flushes the write buffer to RAM. Since MMIO writes
are unbuffered, that's pure overhead.

Maybe we need another interface that does not do byteswapping but
provides stronger ordering guarantees?

Haavard
