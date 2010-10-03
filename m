From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 46/47] powerpc: Use new irq allocator
Date: Sun, 3 Oct 2010 22:04:50 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1010032202570.14550@localhost6.localdomain6>
References: <20100930221351.682772535@linutronix.de> <20100930221743.014571381@linutronix.de> <1285893737.2463.4.camel@pasglop> <alpine.LFD.2.00.1010011504380.2416@localhost6.localdomain6> <m1bp7bfc9n.fsf@fess.ebiederm.org>
 <alpine.LFD.2.00.1010032033090.14550@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42361 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab0JCUFQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Oct 2010 16:05:16 -0400
In-Reply-To: <alpine.LFD.2.00.1010032033090.14550@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>



On Sun, 3 Oct 2010, Thomas Gleixner wrote:

> On Sun, 3 Oct 2010, Eric W. Biederman wrote:
> 
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > 
> > >> That would make things much cleaner and in fact move one large step
> > >> toward being able to make powerpc virq scheme generic, which seems to be
> > >> a good idea from what I've heard :-)
> > >
> > > Yep.
> > 
> > I'm not certain about making the ppc virq scheme generic.  Maybe it is
> > just my distorted impression but I have the understanding that ppc irq
> > numbers mean nothing and are totally unstable whereas on x86 irq numbers
> > in general are stable (across kernel upgrades and changes in device
> > probe order) and the irq number has a useful hardware meaning.  Which
> > means you don't have to go through several layers of translation tables
> > to figure out which hardware pin you are talking about.
> 
> Nobody is forced to use it, but we have already several instances of
> virq mapping implementations in arch/*. Having a generic
> infrastructure for this makes a ton of sense.

Forgot to say: With MSI and dynamic allocated irqs the stable numbers
are completely meaningless. So where is the point ?

Thanks,

	tglx
