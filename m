From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Tue, 24 Nov 2015 00:37:17 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511240007580.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr> <alpine.LFD.2.20.1511231053450.22569@knanqh.ubzr> <4277009.MDAEAbRExl@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1558412039-1448343438=:22569"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35258 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbKXFhV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 00:37:21 -0500
Received: by qkao63 with SMTP id o63so1976989qka.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2015 21:37:20 -0800 (PST)
In-Reply-To: <4277009.MDAEAbRExl@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1558412039-1448343438=:22569
Content-Type: text/plain; charset=US-ASCII

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

OK... I produced a minimal test case. I think gcc is screwed. And it is 
not a question of __builtin_constant_p being best effort. The resulting 
code is plain wrong where a variable is suddenly turned into a constant 
of value 0. Any random modification to various part of the code just 
makes it disappear but I didn't check the disassembly to see if it is 
then correct.

And the good news(tm) is that the same bug is triggered with x86 gcc as 
well.

Please try the attached test case.


Nicolas
--8323328-1558412039-1448343438=:22569
Content-Type: application/gzip; name=gcc_testcase.tgz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LFD.2.20.1511240037170.22569@knanqh.ubzr>
Content-Description: 
Content-Disposition: attachment; filename=gcc_testcase.tgz

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
AAA=

--8323328-1558412039-1448343438=:22569--
