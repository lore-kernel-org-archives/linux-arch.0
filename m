Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44716 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbYBMKLX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 05:11:23 -0500
Date: Wed, 13 Feb 2008 10:05:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
Message-ID: <20080213100503.GA21694@flint.arm.linux.org.uk>
References: <20080211211751.3e265754@laptopd505.fenrus.org> <20080211.221126.230471463.davem@davemloft.net> <47B1CB08.4020101@garzik.org> <alpine.LFD.1.00.0802120847500.2920@woody.linux-foundation.org> <1202838082.3137.54.camel@localhost.localdomain> <alpine.LFD.1.00.0802120945290.2920@woody.linux-foundation.org> <1202840682.3137.83.camel@localhost.localdomain> <alpine.LFD.1.00.0802121037340.2920@woody.linux-foundation.org> <alpine.LFD.1.00.0802121051341.2920@woody.linux-foundation.org> <20080212191914.GB20883@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080212191914.GB20883@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>, arjan@infradead.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Tue, Feb 12, 2008 at 11:19:14AM -0800, Greg KH wrote:
> We usually get this warning today in -mm.

We don't always - and I'd say in terms of ARM it would be extremely rare.
The sysfs API changes at the start of the last merge window is one example
of this.

I had everything nicely prepared in the ARM tree for merging shortly
after the window opened, and then wham bam thankyou mam, the merge
window opened and a lot ended up breaking.

We know that the -mm tree is pretty much useless in terms of code
coverage for ARM, and it's getting increasingly unlikely that anything
short of a build of all ARM defconfigs will pick up on merge issues -
which is a lot of CPU cycles, and I'm not going to insist its something
that should be done.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
