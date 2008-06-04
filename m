From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:25:49 +1000
Message-ID: <200806041225.50058.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop> <20080603213310.GC3549@parisc-linux.org> <Pine.LNX.4.64.0806031439520.3242@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755288AbYFDC0V@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806031439520.3242@t2.domain.actdsltmp>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Trent Piepho <tpiepho@freescale.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Russell King <rmk+lkml@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 04 June 2008 07:44, Trent Piepho wrote:
> On Tue, 3 Jun 2008, Matthew Wilcox wrote:

> > I don't understand why you keep talking about DMA.  Are you talking
> > about ordering between readX() and DMA?  PCI proides those guarantees.
>
> I guess you haven't been reading the whole thread.  The reason it started
> was because gcc can re-order powerpc (and everyone else's too) IO accesses
> vs accesses to cachable memory (but not spin-locks), which ends up only
> being a problem with coherent DMA.

I don't think it is only a problem with coherent DMA.

CPU0                         CPU1
mutex_lock(mutex);
writel(something, DATA_REG);
writel(GO, CTRL_REG);
started = 1;
mutex_unlock(mutex);
                             mutex_lock(mutex);
                             if (started)
                               /* oops, this can reach device before GO */
                               writel(STOP, CTRL_REG);
                               
