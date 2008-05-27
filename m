From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 22:38:22 +0100
Message-ID: <20080527223822.57306677@core>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57401 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758296AbYE0Vw0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 17:52:26 -0400
In-Reply-To: <alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com

> re-ordering, even though I doubt it will be visible in practice. So if you 
> use the "__" versions, you'd better have barriers even on x86!

Are we also going to have __ioread*/__iowrite* ?

Also is the sematics of __readl/__writel defined for all architectures -
I used it ages ago in the i2o drivers for speed and it got removed
because it didn't build on some platforms.

Alan
