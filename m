From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Sun, 22 Nov 2015 17:28:33 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511221721320.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4206238.8hPtvbUZ9X@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36710 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbKVW2h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Nov 2015 17:28:37 -0500
Received: by qgcc31 with SMTP id c31so62111166qgc.3
        for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2015 14:28:36 -0800 (PST)
In-Reply-To: <4206238.8hPtvbUZ9X@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 22 Nov 2015, Arnd Bergmann wrote:

> On Monday 16 November 2015 20:20:38 you wrote:
> > Arnd,
> > 
> > Please pull the following branch:
> > 
> > 	git://git.linaro.org/people/nicolas.pitre/linux div64
> > 
> > This contains those patches I've initially posted here:
> > 
> > 	https://lkml.org/lkml/2015/11/2/715
> > 
> > Only changes to those posted patches are cosmetic improvements such as 
> > the use of ilog2() replacing the custom __div64_ffs(). Exposure in 
> > linux-next would be a good thing.
> > 
> > I also included fixes for a couple do_div() misuses that an allyesconfig 
> > build turned up after switching ARM to the generic do_div() code.  
> > Those patches have been posted separately and addressed to relevant 
> > maintainers. They are included here until/unless those maintainers 
> > include those patches in their tree.
> > 
> > Original cover letter:
> > 
> > This is a generalization of the optimization I produced for ARM a decade
> > ago to turn constant divisors into a multiplication by the divisor
> > reciprocal. Turns out that after all those years gcc is still not
> > optimizing things on its own for that case.
> > 
> > This has important performance benefits as discussed in this thread:
> > 
> > 	https://lkml.org/lkml/2015/10/28/851
> > 
> > This series brings the formerly ARM-only optimization to all 32-bit
> > architectures using C code by default.  The possibility for the actual
> > multiplication to be implemented in assembly is provided in order to get
> > optimal code.  The ARM version can be used as an example implementation
> > for other interested architectures to implement.
> 
> I'm now getting a build regressing with the attached randconfig configuration,
> when compiling drivers/net/wireless/iwlegacy/common.o:
> 
> drivers/built-in.o: In function `il_send_rxon_timing':
> :(.text+0xbbac80): undefined reference to `__aeabi_uldivmod'
> :(.text+0xbbac9c): undefined reference to `__aeabi_uldivmod'
> :(.text+0xbbacdc): undefined reference to `__aeabi_uldivmod'
> :(.text+0xbbadc8): undefined reference to `__aeabi_uldivmod'
> :(.text+0xbbadf8): undefined reference to `__aeabi_uldivmod'
> :(.text+0xbbae3c): more undefined references to `__aeabi_uldivmod' follow
> drivers/built-in.o: In function `il_send_rxon_timing':
> :(.text+0xbbb11c): undefined reference to `____ilog2_NaN'

This looks like some gcc bug from a few years ago.

> I've verified that this goes away if I turn off CONFIG_PROFILE_ALL_BRANCHES,
> and it only shows up with gcc-5.0 through gcc-5.2.1, but not 4.9.3.
> 
> Aside from those, I have not been able to reduce the failure scenario.
> 
> Also, I have only tested on ARM32, no idea if this shows up elsewhere.

What if you revert "ARM: asm/div64.h: adjust to generic codde" and 
recompile?


Nicolas
