From: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 14:29:33 -0700
Message-ID: <adaod6rsaf6.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211906268.3435.44.camel@localhost.localdomain>
	<adad4n71wb3.fsf@cisco.com>
	<1211910825.7160.1.camel@localhost.localdomain>
	<adamymbvcxi.fsf@cisco.com> <483C7BE7.10204@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:58443 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915AbYE0V3s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 17:29:48 -0400
In-Reply-To: <483C7BE7.10204@nortel.com> (Chris Friesen's message of "Tue, 27
	May 2008 15:23:51 -0600")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>

 > > Writes are posted yes, but not reordered arbitrarily.  If I have code like:
 > >
 > > 	spin_lock(&mmio_lock);
 > > 	writel(val1, reg1);
 > > 	writel(val2, reg2);
 > > 	spin_unlock(&mmio_lock);
 > >
 > > then I have a reasonable expectation that if two CPUs run this at the
 > > same time, their writes to reg1/reg2 won't be interleaved with each
 > > other (because the whole section is inside a spinlock).  And Altix
 > > violates that expectation.
 > 
 > Does that necessarily follow?
 > 
 > If you've got a large system with multiple pci bridges, could you end
 > up with posted writes coming from different cpus taking a different
 > amount of time to propagate to a device and thus colliding?

Not on x86.  And a given PCI device can only be reached from a single
host bridge, so I don't see how it can happen.  But on SGI altix
systems, there is a routed fabric between the CPU and the PCI bus, so
the reordering can happen there.  Hence mmiowb() and the endless supply
of driver bugs that it causes.

 - R.
