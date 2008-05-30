Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-33.bluehost.com ([69.89.18.153]:49618 "HELO
	outbound-mail-33.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752219AbYE3R2g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 13:28:36 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Fri, 30 May 2008 10:21:00 -0700
References: <1211852026.3286.36.camel@pasglop> <1212073289.3428.30.camel@localhost.localdomain> <483FCA94.1060506@sgi.com>
In-Reply-To: <483FCA94.1060506@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200805301021.00883.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jes Sorensen <jes@sgi.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk, Jeremy Higdon <jeremy@sgi.com>
Message-ID: <20080530172100.1sxpo4zOcYaYdq52xrNnZblqMOtCtYAnO2SX3ZAdbts@z>

On Friday, May 30, 2008 2:36 am Jes Sorensen wrote:
> James Bottomley wrote:
> >> The only way to guarantee ordering in the above setup, is to either
> >> make writel() fully ordered or adding the mmiowb()'s inbetween the two
> >> writel's. On Altix you have to go and read from the PCI brige to
> >> ensure all writes to it have been flushed, which is also what mmiowb()
> >> is doing. If writel() was to guarantee this ordering, it would make
> >> every writel() call extremely expensive :-(
> >
> > So if a read from the bridge achieves the same effect, can't we just put
> > one after the writes within the spinlock (an unrelaxed one).  That way
> > this whole sequence will look like a well understood PCI posting flush
> > rather than have to muck around with little understood (at least by most
> > driver writers) io barriers?
>
> Hmmm,
>
> I think mmiowb() does some sort of status read from the bridge, I am not
> sure if it's enough to just do a regular readl().
>
> I'm adding Jeremy to the list, he should know for sure.

I think a read from the target host bridge is enough.  What mmiowb() does 
though is to read a *local* host bridge register, which contains a count of 
the number of PIO ops still "in flight" on their way to their target bridge.  
When it reaches 0, all PIOs have arrived at the target host bridge (they 
still may be bufferd), so ordering is guaranteed.

Jesse
