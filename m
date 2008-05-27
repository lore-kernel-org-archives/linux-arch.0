From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 14:59:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805271456060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop> <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
 <1211922621.3286.80.camel@pasglop> <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <20080527223822.57306677@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37506 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758055AbYE0V7q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 17:59:46 -0400
In-Reply-To: <20080527223822.57306677@core>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com



On Tue, 27 May 2008, Alan Cox wrote:
>
> > re-ordering, even though I doubt it will be visible in practice. So if you 
> > use the "__" versions, you'd better have barriers even on x86!
> 
> Are we also going to have __ioread*/__iowrite* ?

I doubt there is any reason to. Let's just keep them very strictly 
ordered. 

> Also is the sematics of __readl/__writel defined for all architectures -
> I used it ages ago in the i2o drivers for speed and it got removed
> because it didn't build on some platforms.

Agreed - I'm not sure the __ versions are really worth it. We have them, 
but the semantics are subtle enough that most drivers will never care 
enough to really use them.

I would suggest using them mainly for architecture-specific drivers, on 
architectures where it actually matters (which is not the case on x86).

		Linus
