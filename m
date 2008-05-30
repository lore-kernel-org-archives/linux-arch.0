From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Fri, 30 May 2008 10:21:00 -0700
Message-ID: <200805301021.00883.jbarnes@virtuousgeek.org>
References: <1211852026.3286.36.camel@pasglop> <1212073289.3428.30.camel@localhost.localdomain> <483FCA94.1060506@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754500AbYE3RWN@vger.kernel.org>
In-Reply-To: <483FCA94.1060506@sgi.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jes Sorensen <jes@sgi.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk, Jeremy Higdon <jeremy@sgi.com>
List-Id: linux-arch.vger.kernel.org

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
