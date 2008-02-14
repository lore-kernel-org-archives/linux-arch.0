Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44846 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933170AbYBNH4q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2008 02:56:46 -0500
Date: Thu, 14 Feb 2008 07:51:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
Message-ID: <20080214075115.GB17110@flint.arm.linux.org.uk>
References: <200802132330.23817.alessandro.guido@gmail.com> <20080213225058.GA20358@flint.arm.linux.org.uk> <200802140000.52936.alessandro.guido@gmail.com> <20080213231512.GB20358@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802140246440.1822@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802140246440.1822@scrub.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

On Thu, Feb 14, 2008 at 02:47:56AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 13 Feb 2008, Russell King wrote:
> 
> > > No because they all depend on CPU_FREQ and as far as I understand Kconfig
> > > automagically puts them under the same menu.
> > 
> > Hmm, that's not documented behaviour.  If we're starting to rely on that
> > maybe it should be documented as being the expected behaviour?
> 
> It is. :)

I disagree.

> Look for "Menu structure" in kconfig-language.txt.

Yes, I read that and didn't get the answer to the question above.  It's
unclear how:

config CPU_FREQ_INTEGRATOR
        tristate "CPUfreq driver for ARM Integrator CPUs"
        depends on ARCH_INTEGRATOR && CPU_FREQ

being under CPU_FREQ rather than ARCH_INTEGRATOR

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
