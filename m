Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270054AbUJTIRm@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55814 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268342AbUJTINp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 04:13:45 -0400
Date: Wed, 20 Oct 2004 09:13:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: All archs: NO_IRQ definition
Message-ID: <20041020091335.E1047@flint.arm.linux.org.uk>
References: <1098169077.11400.51.camel@gaston> <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk> <1098178059.13633.1071.camel@hades.cambridge.redhat.com> <1098242818.25295.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098242818.25295.4.camel@gaston>; from benh@kernel.crashing.org on Wed, Oct 20, 2004 at 01:26:59PM +1000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Oct 20, 2004 at 01:26:59PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-19 at 19:27, David Woodhouse wrote:
> 
> > And also for every arch where there isn't an overriding reason for it
> > _not_ to be -1. If either zero or -1 works, use -1. We'll get better
> > coverage of random driver authors doing 'if (!irq)' that way. 
> > 
> > So your question becomes: anyone whose architecture can't cope with
> > NO_IRQ being -1, please shout now before we break it.
> 
> There is a problem using -1 that I noticed when converting drivers/ide.
> 
> The probe_irq_off() thing (that we never implemented on ppc, but I
> suppose we'll inherit of it via mingo patches now) is defined as...
> returning 0 when no interrupt is found. Some drivers actually rely
> on that.

That's a bit of a problem - negative numbers means that an interrupt
was detected, but that other interrupts also triggered...  However,
I don't think any driver actually makes use of this information.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
