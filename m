From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 15:53:28 -0600
Message-ID: <20080527215328.GB22636@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop> <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org> <1211922621.3286.80.camel@pasglop> <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <20080527223822.57306677@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:44142 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398AbYE0Vxp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 17:53:45 -0400
Content-Disposition: inline
In-Reply-To: <20080527223822.57306677@core>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Tue, May 27, 2008 at 10:38:22PM +0100, Alan Cox wrote:
> > re-ordering, even though I doubt it will be visible in practice. So if you 
> > use the "__" versions, you'd better have barriers even on x86!
> 
> Are we also going to have __ioread*/__iowrite* ?

Didn't we already define ioread*() to have loose semantics?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
