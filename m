Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45410 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbXKIMJS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2007 07:09:18 -0500
Date: Fri, 9 Nov 2007 12:02:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] dependencies for platform drivers (was Re: ax88796: add superh to kconfig dependencies)
Message-ID: <20071109120255.GB8101@flint.arm.linux.org.uk>
References: <20071108073105.3996.70418.sendpatchset@clockwork.opensource.se> <20071108081854.GN8181@ftp.linux.org.uk> <20071109092652.GA13350@linux-mips.org> <20071109094023.GA7022@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071109094023.GA7022@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>, Al Viro <viro@ftp.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, jeff@garzik.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Nov 09, 2007 at 06:40:23PM +0900, Paul Mundt wrote:
> On Fri, Nov 09, 2007 at 09:26:52AM +0000, Ralf Baechle wrote:
> > If writesb() is not an official API then maybe the answer should have been
> > to either add that API to other architectures or fix the driver.
> > 
> > I guess this incident means I need to go through all Kconfig* files to
> > see what bogus architecture dependencies on MIPS or !MIPS exist ...
> > 
> While writesb() isn't an official API, the iowriteX_rep() interfaces
> theoretically are. Tidying up the driver for iomap is probably a better
> option.

writesb() predates iowriteX_rep() interfaces by quite a number of years,
though if you're using writesb(), converting over to iowriteX_rep() is
really a no-brainer.

writesb() is effectively what mmio_outsb() is, and exists to do what
outsb() does but for peripherals mapped using ioremap on ARM rather
than trying to emulate them via the legacy x86 IO interfaces.

Note that it would've been far better that whoever invented mmio_outsb()
looked around and noticed that some of us already have an implementation
called writesb()... but time has proven that folk seem to be blinkered
to anything not x86.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
