From: David Miller <davem@davemloft.net>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 26 May 2008 18:40:47 -0700 (PDT)
Message-ID: <20080526.184047.88207142.davem@davemloft.net>
References: <1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211852026.3286.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39358
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753777AbYE0Bkv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 May 2008 21:40:51 -0400
In-Reply-To: <1211852026.3286.36.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 27 May 2008 11:33:46 +1000

> Quick summary: gcc is happily re-ordering readl/writel vs. surrounding
> memory accesses (and thus accesses to DMA coherent memory) which is
> obviously a _BAD_THING_.
> 
> This is on all archs. Quick fix is to stick a "memory" clobber in all arch
> implementations of readl/writel/... (ie, making them a barrier()).
> 
> However, I'm using that as an excuse to bring back my pet subject, which
> is basically, should we instead just finally mandate the use of explicit
> rmb/wmb/mb's (which boils down to barrier() on x86) to drivers who want
> to order memory consistent accesses vs. MMIO ?

This is basically what drivers are effectively doing.
