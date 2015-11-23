From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Mon, 23 Nov 2015 11:38:56 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511231128390.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr> <alpine.LFD.2.20.1511231053450.22569@knanqh.ubzr> <4277009.MDAEAbRExl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:32835 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbbKWQi7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 11:38:59 -0500
Received: by qgea14 with SMTP id a14so117055027qge.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2015 08:38:58 -0800 (PST)
In-Reply-To: <4277009.MDAEAbRExl@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Nov 2015, Arnd Bergmann wrote:

> On Monday 23 November 2015 11:04:33 Nicolas Pitre wrote:
> > 
> > OK... I'm able to "fix" the build with:
> > 
> > diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
> > index 163f77999e..d246c4c801 100644
> > --- a/include/asm-generic/div64.h
> > +++ b/include/asm-generic/div64.h
> > @@ -206,7 +206,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> >         uint32_t __rem;                                 \
> >         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
> >         if (__builtin_constant_p(__base) &&             \
> > -           is_power_of_2(__base)) {                    \
> > +           is_power_of_2(__base) && __base != 0) {     \
> >                 __rem = (n) & (__base - 1);             \
> >                 (n) >>= ilog2(__base);                  \
> >         } else if (__div64_const32_is_OK &&             \
> > 
> > What doesn't make sense to me is the fact that is_power_of_2() is 
> > defined as:
> > 
> > static inline __attribute__((const))
> > bool is_power_of_2(unsigned long n)
> > {
> >         return (n != 0 && ((n & (n - 1)) == 0));
> > }
> > 
> > So the test for zero is already in there.
> > 
> > And adding BUILD_BUG_ON(__builtin_constant_p(__base) && __base == 0) 
> > before the if doesn't trig either.
> 
> I've seen similarly messed up situations with PROFILE_ALL_BRANCHES
> before, I think it's got something to do with how __builtin_constant_p()
> is used inside of the __trace_if() macro, and how gcc sometimes falls
> back to treating variables as not-really-constant based on context.
> 
> To gcc, __builtin_constant_p is just best-effort, and they don't care
> about returning false sometimes if they catch most cases in practice.

But here it must have returned true, and is_power_of_2() returned true 
as well (which implies that __base is not zero), ans somehow aving an 
additional __base != 0 test changes the outcome.  There is a correctness 
issue beyond __builtin_constant_p it seems.

> Note that llvm will always return false for __builtin_constant_p on
> non-pointer arguments, which breaks a lot of optimizations.

If llvm is able to optimize this case on its own then we won't need all 
this contraption.


Nicolas
