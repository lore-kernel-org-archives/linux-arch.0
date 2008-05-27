Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52316 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758681AbYE0PgU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 11:36:20 -0400
Date: Tue, 27 May 2008 08:35:29 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <1211859542.3286.46.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>  <20080526.184047.88207142.davem@davemloft.net>  <1211854540.3286.42.camel@pasglop>  <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com
Message-ID: <20080527153529.6ckEFmKGoCIGzVJcw4azWR-GaW5Mt3ZIRL1Vivhxedw@z>



On Tue, 27 May 2008, Benjamin Herrenschmidt wrote:
> 
> Yes. As it is today, tg3 for example is potentially broken on all archs
> with newer gcc unless we either add "memory" clobber to readl/writel or
> stick some wmb's in there (just a random driver I picked).
> 
> So Linus, what is your take on that matter ?

Let's just serialize the damn things, and add a memory clobber to them.

Expecting people to fix up all drivers is simply not going to happen. And 
serializing things shouldn't be *that* expensive. People who cannot take 
the expense can continue to use the magic __raw_writel() etc stuff.

			Linus
