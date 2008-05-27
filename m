From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 15:02:15 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805271459550.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop> <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
 <1211922621.3286.80.camel@pasglop> <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <20080527223822.57306677@core> <20080527215328.GB22636@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48176 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759091AbYE0WCd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 18:02:33 -0400
In-Reply-To: <20080527215328.GB22636@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com



On Tue, 27 May 2008, Matthew Wilcox wrote:

> On Tue, May 27, 2008 at 10:38:22PM +0100, Alan Cox wrote:
> > > re-ordering, even though I doubt it will be visible in practice. So if you 
> > > use the "__" versions, you'd better have barriers even on x86!
> > 
> > Are we also going to have __ioread*/__iowrite* ?
> 
> Didn't we already define ioread*() to have loose semantics?

They are supposed to have the same semantics as readl/writel.

And yes, it's "loose", but only when compared to inb/outb (which are 
really very strict, if you want to emulate x86 - an "outb" basically is 
not only ordered, it doesn't even post the write, and waits until it has 
hit the bus!)

		Linus
