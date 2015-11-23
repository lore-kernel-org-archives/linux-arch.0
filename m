From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Mon, 23 Nov 2015 11:04:33 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511231053450.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4206238.8hPtvbUZ9X@wuerfel> <alpine.LFD.2.20.1511221721320.22569@knanqh.ubzr> <4172767.ihrTf0eWtM@wuerfel> <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35040 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbKWQEg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 11:04:36 -0500
Received: by qgec40 with SMTP id c40so116442373qge.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2015 08:04:35 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Nov 2015, Nicolas Pitre wrote:

> On Mon, 23 Nov 2015, Arnd Bergmann wrote:
> 
> > On Sunday 22 November 2015 17:28:33 Nicolas Pitre wrote:
> > > On Sun, 22 Nov 2015, Arnd Bergmann wrote:
> > > > On Monday 16 November 2015 20:20:38 you wrote:
> > > > I'm now getting a build regressing with the attached randconfig configuration,
> > > > when compiling drivers/net/wireless/iwlegacy/common.o:
> > > > 
> > > > drivers/built-in.o: In function `il_send_rxon_timing':
> > > > :(.text+0xbbac80): undefined reference to `__aeabi_uldivmod'
> > > > :(.text+0xbbac9c): undefined reference to `__aeabi_uldivmod'
> > > > :(.text+0xbbacdc): undefined reference to `__aeabi_uldivmod'
> > > > :(.text+0xbbadc8): undefined reference to `__aeabi_uldivmod'
> > > > :(.text+0xbbadf8): undefined reference to `__aeabi_uldivmod'
> > > > :(.text+0xbbae3c): more undefined references to `__aeabi_uldivmod' follow
> > > > drivers/built-in.o: In function `il_send_rxon_timing':
> > > > :(.text+0xbbb11c): undefined reference to `____ilog2_NaN'
> > > 
> 
> I'm able to reproduce it, and I am in the process of reintroducing the 
> last patch piece by piece to see what breaks.  The presence of 
> ____ilog2_NaN is particularly intriguing as this would mean 0 is passed 
> to ilog2() somewhere.

OK... I'm able to "fix" the build with:

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 163f77999e..d246c4c801 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -206,7 +206,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	uint32_t __rem;					\
 	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
 	if (__builtin_constant_p(__base) &&		\
-	    is_power_of_2(__base)) {			\
+	    is_power_of_2(__base) && __base != 0) {	\
 		__rem = (n) & (__base - 1);		\
 		(n) >>= ilog2(__base);			\
 	} else if (__div64_const32_is_OK &&		\

What doesn't make sense to me is the fact that is_power_of_2() is 
defined as:

static inline __attribute__((const))
bool is_power_of_2(unsigned long n)
{
        return (n != 0 && ((n & (n - 1)) == 0));
}

So the test for zero is already in there.

And adding BUILD_BUG_ON(__builtin_constant_p(__base) && __base == 0) 
before the if doesn't trig either.

Confused.


Nicolas
