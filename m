Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270149AbUJTIbw@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:22430 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270035AbUJTI1R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 04:27:17 -0400
Subject: Re: All archs: NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20041020091335.E1047@flint.arm.linux.org.uk>
References: <1098169077.11400.51.camel@gaston>
	 <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
	 <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
	 <1098242818.25295.4.camel@gaston>
	 <20041020091335.E1047@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098260677.6263.1.camel@gaston>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 18:24:37 +1000
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-10-20 at 18:13, Russell King wrote:

> That's a bit of a problem - negative numbers means that an interrupt
> was detected, but that other interrupts also triggered...  However,
> I don't think any driver actually makes use of this information.

Well, I hate that probe thing ... note that the current bk blows up
on me at boot with yenta_socket trying to do similar probing (hrm...
it should have a perfectly working PCI irq on ppc, and nothing else)
and the new "common" code actually implements that probe stuff... and
ends up calling a NULL function pointer. I'll have to check that out
too.

Anyway, I'll have a patch tonight or tomorrow after reviewing all
drivers using that interface. I'll also fix IDE & 8250 to use NO_IRQ,
I'll leave other drivers alone.

Ben.
