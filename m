Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270477AbUJTDdn@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:64667 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270488AbUJTDdk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 23:33:40 -0400
Subject: Re: All archs: NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
References: <1098169077.11400.51.camel@gaston>
	 <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
	 <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1098242818.25295.4.camel@gaston>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 13:26:59 +1000
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-10-19 at 19:27, David Woodhouse wrote:

> And also for every arch where there isn't an overriding reason for it
> _not_ to be -1. If either zero or -1 works, use -1. We'll get better
> coverage of random driver authors doing 'if (!irq)' that way. 
> 
> So your question becomes: anyone whose architecture can't cope with
> NO_IRQ being -1, please shout now before we break it.

There is a problem using -1 that I noticed when converting drivers/ide.

The probe_irq_off() thing (that we never implemented on ppc, but I
suppose we'll inherit of it via mingo patches now) is defined as...
returning 0 when no interrupt is found. Some drivers actually rely
on that.

So what should I do ? Fix probe_irq_off() & friends to return NO_IRQ
and fix as many drivers as I can find ?

Ben.
