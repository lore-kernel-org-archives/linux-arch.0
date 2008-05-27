From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 14:55:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>  <20080526.184047.88207142.davem@davemloft.net>  <1211854540.3286.42.camel@pasglop>  <20080526.192812.184590464.davem@davemloft.net>  <1211859542.3286.46.camel@pasglop>  <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
  <1211922621.3286.80.camel@pasglop>  <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org> <1211924335.3286.89.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35316 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756591AbYE0V4U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 17:56:20 -0400
In-Reply-To: <1211924335.3286.89.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com



On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> 
> A problem with __raw_ though is that they -also- don't do byteswap,

Well, that's why there is __readl() and __raw_readl(), no?

Neither does ordering, and __raw_readl() doesn't do byte-swap.

Of course, I'm not going to guarantee every architecture even has all 
those versions, nor am I going to guarantee they all work as advertised :)

For x86, they have historially all been 100% identical. With the inline 
asm patch I posted, the "__" version (whether "raw" or not) lack the 
"memory" barrier, so they allow a *little* bit more re-ordering.

(They won't be re-ordered wrt spinlocks etc, unless gcc starts reordering 
volatile asm's against each other, which would be a bug).

In practice, I doubt it matters. Whatever small compiler re-ordering it 
might affect won't have any real performance impack one way or the other, 
I think.

		Linus
