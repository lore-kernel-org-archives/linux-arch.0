Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16961.2923.978726.881635@cargo.ozlabs.ibm.com>
Date: Wed, 23 Mar 2005 17:23:39 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
In-Reply-To: <20050322160324.GA4980@krispykreme>
References: <20050321150619.2ea75257.davem@davemloft.net>
	<20050321225904.GF23908@krispykreme>
	<20072.1111488229@redhat.com>
	<20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
	<20050322160324.GA4980@krispykreme>
To: Anton Blanchard <anton@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Anton Blanchard writes:

> 2. drivers/net/typhoon.c
> 
>                 INIT_COMMAND_NO_RESPONSE(cmd, TYPHOON_CMD_HELLO_RESP);
>                 smp_wmb();
>                 writel(ring->lastWrite, tp->ioaddr + TYPHOON_REG_CMD_READY);
> 
> it looks a lot like smp_wmb is being used to order IO.

There's a word for that, it has 3 letters, starts with B and ends with
G. 8-)

Paul.
