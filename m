From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v3] lib: optimize cpumask_next_and()
Date: Sat, 28 Oct 2017 16:24:26 +0300
Message-ID: <20171028132426.peyxnmqxcqzffxjm@yury-thinkpad>
References: <CACVxJT9+2wV34iYsQVCeqDi1HnUyJQTc-4Pf2ihW18R0rAmxSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:22400
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751263AbdJ1NYp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Oct 2017 09:24:45 -0400
Content-Disposition: inline
In-Reply-To: <CACVxJT9+2wV34iYsQVCeqDi1HnUyJQTc-4Pf2ihW18R0rAmxSA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: courbet@google.com, arnd@arndb.de, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, mawilcox@microsoft.com, mingo@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 26, 2017 at 02:58:00PM +0200, Alexey Dobriyan wrote:
> >  - Refactored _find_next_common_bit into _find_next_bit., as suggested
> >    by Yury Norov. This has no adverse effects on the performance side,
> >    as the compiler successfully inlines the code.
> 
> 1)
> Gentoo ships 5.4.0 which doesn't inline this code on x86_64 defconfig
> (which has OPTIMIZE_INLINING).
> 
> 
> ffffffff813556c0 <find_next_bit>:
> ffffffff813556c0:       55                      push   rbp
> ffffffff813556c1:       48 89 d1                mov    rcx,rdx
> ffffffff813556c4:       45 31 c0                xor    r8d,r8d
> ffffffff813556c7:       48 89 f2                mov    rdx,rsi
> ffffffff813556ca:       31 f6                   xor    esi,esi
> ffffffff813556cc:       48 89 e5                mov    rbp,rsp
> ffffffff813556cf:       e8 7c ff ff ff          call
> ffffffff81355650 <_find_next_bit>
> ffffffff813556d4:       5d                      pop    rbp
> ffffffff813556d5:       c3                      ret

GCC 7 for ARM64 doesn't inline as well. I wrote test for it to measure
the effect of inlining:
http://www.spinics.net/lists/kernel/msg2635338.html

The performance impact of this patch without inlining: 

Before:
[   96.856195] Start testing find_bit() with random-filled bitmap
[   96.868322] find_next_bit: 34529 cycles, 16304 iterations
[   96.879525] find_next_zero_bit: 35771 cycles, 16465 iterations
[   96.891409] find_last_bit: 17444 cycles, 16304 iterations
[   96.914445] find_first_bit: 1219671 cycles, 16305 iterations
[   96.925802] Start testing find_bit() with sparse bitmap
[   96.936308] find_next_bit: 301 cycles, 66 iterations
[   96.946981] find_next_zero_bit: 70897 cycles, 32703 iterations
[   96.958694] find_last_bit: 286 cycles, 66 iterations
[   96.968710] find_first_bit: 5260 cycles, 66 iterations

After:
[  116.205594] Start testing find_bit() with random-filled bitmap
[  116.217621] find_next_bit: 24979 cycles, 16449 iterations
[  116.228719] find_next_zero_bit: 25666 cycles, 16320 iterations
[  116.240620] find_last_bit: 19407 cycles, 16449 iterations
[  116.268368] find_first_bit: 1690945 cycles, 16449 iterations
[  116.279718] Start testing find_bit() with sparse bitmap
[  116.290219] find_next_bit: 352 cycles, 66 iterations
[  116.300692] find_next_zero_bit: 50916 cycles, 32703 iterations
[  116.312400] find_last_bit: 295 cycles, 66 iterations
[  116.322427] find_first_bit: 6742 cycles, 66 iterations

And with inlining:

Before:
[  169.464229] Start testing find_bit() with random-filled bitmap
[  169.476191] find_next_bit: 17520 cycles, 16336 iterations
[  169.487210] find_next_zero_bit: 17622 cycles, 16433 iterations
[  169.499111] find_last_bit: 19272 cycles, 16335 iterations
[  169.519735] find_first_bit: 978657 cycles, 16337 iterations
[  169.530912] Start testing find_bit() with sparse bitmap
[  169.541414] find_next_bit: 252 cycles, 66 iterations
[  169.551726] find_next_zero_bit: 34554 cycles, 32703 iterations
[  169.563436] find_last_bit: 294 cycles, 66 iterations
[  169.573439] find_first_bit: 3964 cycles, 66 iterations

After
[  191.191170] Start testing find_bit() with random-filled bitmap
[  191.203133] find_next_bit: 17530 cycles, 16346 iterations
[  191.214150] find_next_zero_bit: 17630 cycles, 16423 iterations
[  191.226037] find_last_bit: 17489 cycles, 16347 iterations
[  191.246672] find_first_bit: 979961 cycles, 16347 iterations
[  191.257849] Start testing find_bit() with sparse bitmap
[  191.268351] find_next_bit: 257 cycles, 66 iterations
[  191.278660] find_next_zero_bit: 34547 cycles, 32703 iterations
[  191.290370] find_last_bit: 292 cycles, 66 iterations
[  191.300376] find_first_bit: 4269 cycles, 66 iterations

I didn't investigate why non-inlined version of this patch works
faster than vanilla code, but inlined one is even faster and is
as fast as inlined version of existing code. I think, we should
come with it finally.

It would be great if someone test it on x86.
 
> 2)
> Making "and" operation to be centerpiece of this code is kind of meh
> find_next_or_bit() will be hard to implement.

Not so hard actually. :)
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1521775.html

Yury
