From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 26 May 2008 20:42:33 -0700
Message-ID: <20080526204233.75b71bb8@infradead.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57897 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbYE0Dmq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 May 2008 23:42:46 -0400
In-Reply-To: <20080526.192812.184590464.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

On Mon, 26 May 2008 19:28:12 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 27 May 2008 12:15:40 +1000
> 
> > Some of them. USB comes to mind. I'd be happy to make it "the rule"
> > and document that MMIO vs. coherent access aren't implicitely
> > ordered. I would still keep them ordered on powerpc for a little
> > while tho until I'm happy enough with driver auditing.
> > 
> > But heh, it's you who was telling me that it would be a bad
> > engineering decision and we had to make everybody look like x86 &
> > fully ordered :-) I decided to agree back then and stuck all those
> > nasty heavy barriers in the powerpc variants of readl/writel/...
> 
> I still believe this.
> 
> It's just another complicated thing for driver authors to get wrong.
> The other side of the coin is of course the cost.
> 
> The only thing I am absolutely sure of is that we should make a
> decision fast, document it, and just stick to it.

... and try to find a way to test for it at runtime or compile time.

either via sparse or some fancy lockdep like "device store" thing?
If we can't test for it and it doesn't show up on x86 ... it'll just be
an eterrnal chase.

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
