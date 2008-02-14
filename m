Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:37912 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbYBNOAU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Feb 2008 09:00:20 -0500
Date: Thu, 14 Feb 2008 15:00:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
In-Reply-To: <20080214075115.GB17110@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0802141351220.1822@scrub.home>
References: <200802132330.23817.alessandro.guido@gmail.com>
 <20080213225058.GA20358@flint.arm.linux.org.uk> <200802140000.52936.alessandro.guido@gmail.com>
 <20080213231512.GB20358@flint.arm.linux.org.uk> <Pine.LNX.4.64.0802140246440.1822@scrub.home>
 <20080214075115.GB17110@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

Hi,

On Thu, 14 Feb 2008, Russell King wrote:

> Yes, I read that and didn't get the answer to the question above.  It's
> unclear how:
> 
> config CPU_FREQ_INTEGRATOR
>         tristate "CPUfreq driver for ARM Integrator CPUs"
>         depends on ARCH_INTEGRATOR && CPU_FREQ
> 
> being under CPU_FREQ rather than ARCH_INTEGRATOR

The doc says it looks at "the previous entry" and ARCH_INTEGRATOR isn't 
exactly the previous entry.
For me it was kind of obvious that kconfig wouldn't arbitrarily reorder 
the menu entries. Only the indentation of an entry is changed not the 
whole order. Any contributions to clarify this are more than welcome.

bye, Roman
