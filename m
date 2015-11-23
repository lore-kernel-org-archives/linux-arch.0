Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55256 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbKWQLY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 11:11:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on 32-bit machines
Date: Mon, 23 Nov 2015 17:11:20 +0100
Message-ID: <4277009.MDAEAbRExl@wuerfel>
In-Reply-To: <alpine.LFD.2.20.1511231053450.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr> <alpine.LFD.2.20.1511231053450.22569@knanqh.ubzr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151123161120.v0EwcAuh6SnDNl9puo3VYAjnVrktrjN70jeS4ajq7no@z>

On Monday 23 November 2015 11:04:33 Nicolas Pitre wrote:
> 
> OK... I'm able to "fix" the build with:
> 
> diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
> index 163f77999e..d246c4c801 100644
> --- a/include/asm-generic/div64.h
> +++ b/include/asm-generic/div64.h
> @@ -206,7 +206,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
>         uint32_t __rem;                                 \
>         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>         if (__builtin_constant_p(__base) &&             \
> -           is_power_of_2(__base)) {                    \
> +           is_power_of_2(__base) && __base != 0) {     \
>                 __rem = (n) & (__base - 1);             \
>                 (n) >>= ilog2(__base);                  \
>         } else if (__div64_const32_is_OK &&             \
> 
> What doesn't make sense to me is the fact that is_power_of_2() is 
> defined as:
> 
> static inline __attribute__((const))
> bool is_power_of_2(unsigned long n)
> {
>         return (n != 0 && ((n & (n - 1)) == 0));
> }
> 
> So the test for zero is already in there.
> 
> And adding BUILD_BUG_ON(__builtin_constant_p(__base) && __base == 0) 
> before the if doesn't trig either.

I've seen similarly messed up situations with PROFILE_ALL_BRANCHES
before, I think it's got something to do with how __builtin_constant_p()
is used inside of the __trace_if() macro, and how gcc sometimes falls
back to treating variables as not-really-constant based on context.

To gcc, __builtin_constant_p is just best-effort, and they don't care
about returning false sometimes if they catch most cases in practice.

Note that llvm will always return false for __builtin_constant_p on
non-pointer arguments, which breaks a lot of optimizations.

	Arnd
