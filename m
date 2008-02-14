Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:33162 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbYBNSDB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Feb 2008 13:03:01 -0500
Date: Thu, 14 Feb 2008 19:03:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
In-Reply-To: <20080214150802.GA16789@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0802141814530.1822@scrub.home>
References: <200802132330.23817.alessandro.guido@gmail.com>
 <20080213225058.GA20358@flint.arm.linux.org.uk> <200802140000.52936.alessandro.guido@gmail.com>
 <20080213231512.GB20358@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802140246440.1822@scrub.home>
 <20080214075115.GB17110@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802141351220.1822@scrub.home>
 <20080214150802.GA16789@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

Hi,

On Thu, 14 Feb 2008, Russell King wrote:

> > > Yes, I read that and didn't get the answer to the question above.  It's
> > > unclear how:
> > > 
> > > config CPU_FREQ_INTEGRATOR
> > >         tristate "CPUfreq driver for ARM Integrator CPUs"
> > >         depends on ARCH_INTEGRATOR && CPU_FREQ
> > > 
> > > being under CPU_FREQ rather than ARCH_INTEGRATOR
> > 
> > The doc says it looks at "the previous entry" and ARCH_INTEGRATOR isn't 
> > exactly the previous entry.
> 
> Neither is CPU_FREQ "the previous entry".  The documentation is unclear.
> [..]
> Well, I still don't have the necessary understanding to work out how
> CPU_FREQ is preferred over ARCH_INTEGRATOR, even with your statements
> that "it is the case".  So I'm not in a position to improve the
> documentation except by adding a sentence to suggest people ask you
> about it.

The best thing right now in such cases is to use menuconfig/xconfig and 
actually look at it. xconfig can even show the hidden entries, so it's 
also easier to answer why some entry isn't becoming a child entry.
I can provide a technical explanation of what's happening, but it's likely 
to be even more confusing, I really have no good idea on how to translate 
what is quite easily visible in xconfig to actual written documentation.

bye, Roman
