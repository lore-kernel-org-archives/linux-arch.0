From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on 32-bit machines
Date: Mon, 23 Nov 2015 08:59:34 +0100
Message-ID: <4172767.ihrTf0eWtM@wuerfel>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4206238.8hPtvbUZ9X@wuerfel> <alpine.LFD.2.20.1511221721320.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53588 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbKWH7j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 02:59:39 -0500
In-Reply-To: <alpine.LFD.2.20.1511221721320.22569@knanqh.ubzr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 22 November 2015 17:28:33 Nicolas Pitre wrote:
> On Sun, 22 Nov 2015, Arnd Bergmann wrote:
> > On Monday 16 November 2015 20:20:38 you wrote:
> > I'm now getting a build regressing with the attached randconfig configuration,
> > when compiling drivers/net/wireless/iwlegacy/common.o:
> > 
> > drivers/built-in.o: In function `il_send_rxon_timing':
> > :(.text+0xbbac80): undefined reference to `__aeabi_uldivmod'
> > :(.text+0xbbac9c): undefined reference to `__aeabi_uldivmod'
> > :(.text+0xbbacdc): undefined reference to `__aeabi_uldivmod'
> > :(.text+0xbbadc8): undefined reference to `__aeabi_uldivmod'
> > :(.text+0xbbadf8): undefined reference to `__aeabi_uldivmod'
> > :(.text+0xbbae3c): more undefined references to `__aeabi_uldivmod' follow
> > drivers/built-in.o: In function `il_send_rxon_timing':
> > :(.text+0xbbb11c): undefined reference to `____ilog2_NaN'
> 
> This looks like some gcc bug from a few years ago.

Yes, I clearly remember debugging something in this area before,
but I don't remember what we did about it.

We already have the workaround for OABI (which you kept), and I have
another workaround to disable the optimized function for ARMv3 as
well, as newer gcc versions also get that wrong here (internal compiler
error IIRC).

We could add yet another such workaround for CONFIG_PROFILE_ALL_BRANCHES,
but I don't have a good feeling about doing this unless we understand
well enough why it breaks. At some point, I did this workaround, which
is still in my randconfig tree:

--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -144,7 +144,7 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
  */
 #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
 #define __trace_if(cond) \
-       if (__builtin_constant_p((cond)) ? !!(cond) :                   \
+       if (__builtin_constant_p(!!(cond)) ? !!(cond) :                 \
        ({                                                              \
                int ______r;                                            \
                static struct ftrace_branch_data                        \

However, it doesn't seem related to the problem at hand. I think it was
about some false 'maybe uninitialized' warning, but I currently don't see any
difference with or without that patch for either issues.

> > I've verified that this goes away if I turn off CONFIG_PROFILE_ALL_BRANCHES,
> > and it only shows up with gcc-5.0 through gcc-5.2.1, but not 4.9.3.
> > 
> > Aside from those, I have not been able to reduce the failure scenario.
> > 
> > Also, I have only tested on ARM32, no idea if this shows up elsewhere.
> 
> What if you revert "ARM: asm/div64.h: adjust to generic codde" and 
> recompile?

Without that patch, it works again.

	Arnd
