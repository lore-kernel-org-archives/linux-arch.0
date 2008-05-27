From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 22:46:51 +0100
Message-ID: <20080527224651.671fc454@core>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<20080527223822.57306677@core>
	<20080527215328.GB22636@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58406 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756924AbYE0WBB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 18:01:01 -0400
In-Reply-To: <20080527215328.GB22636@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Tue, 27 May 2008 15:53:28 -0600
Matthew Wilcox <matthew@wil.cx> wrote:

> On Tue, May 27, 2008 at 10:38:22PM +0100, Alan Cox wrote:
> > > re-ordering, even though I doubt it will be visible in practice. So if you 
> > > use the "__" versions, you'd better have barriers even on x86!
> > 
> > Are we also going to have __ioread*/__iowrite* ?
> 
> Didn't we already define ioread*() to have loose semantics?

The ATA layer doesn't think so.

Alan
