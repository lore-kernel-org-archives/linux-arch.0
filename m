Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45114 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYBNPN1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2008 10:13:27 -0500
Date: Thu, 14 Feb 2008 15:08:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
Message-ID: <20080214150802.GA16789@flint.arm.linux.org.uk>
References: <200802132330.23817.alessandro.guido@gmail.com> <20080213225058.GA20358@flint.arm.linux.org.uk> <200802140000.52936.alessandro.guido@gmail.com> <20080213231512.GB20358@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802140246440.1822@scrub.home> <20080214075115.GB17110@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802141351220.1822@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802141351220.1822@scrub.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

On Thu, Feb 14, 2008 at 03:00:12PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 14 Feb 2008, Russell King wrote:
> 
> > Yes, I read that and didn't get the answer to the question above.  It's
> > unclear how:
> > 
> > config CPU_FREQ_INTEGRATOR
> >         tristate "CPUfreq driver for ARM Integrator CPUs"
> >         depends on ARCH_INTEGRATOR && CPU_FREQ
> > 
> > being under CPU_FREQ rather than ARCH_INTEGRATOR
> 
> The doc says it looks at "the previous entry" and ARCH_INTEGRATOR isn't 
> exactly the previous entry.

Neither is CPU_FREQ "the previous entry".  The documentation is unclear.

> For me it was kind of obvious that kconfig wouldn't arbitrarily reorder 
> the menu entries.

It's always obvious for the person who wrote the code.  It isn't for those
who haven't.

> Only the indentation of an entry is changed not the 
> whole order. Any contributions to clarify this are more than welcome.

Well, I still don't have the necessary understanding to work out how
CPU_FREQ is preferred over ARCH_INTEGRATOR, even with your statements
that "it is the case".  So I'm not in a position to improve the
documentation except by adding a sentence to suggest people ask you
about it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
