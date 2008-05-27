From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 08:35:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>  <20080526.184047.88207142.davem@davemloft.net>  <1211854540.3286.42.camel@pasglop>  <20080526.192812.184590464.davem@davemloft.net> <1211859542.3286.46.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758800AbYE0Pgp@vger.kernel.org>
In-Reply-To: <1211859542.3286.46.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com
List-Id: linux-arch.vger.kernel.org



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
