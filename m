From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v3] lib: optimize cpumask_next_and()
Date: Thu, 26 Oct 2017 14:58:00 +0200
Message-ID: <CACVxJT9+2wV34iYsQVCeqDi1HnUyJQTc-4Pf2ihW18R0rAmxSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:53898 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbdJZM6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2017 08:58:01 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: courbet@google.com
Cc: arnd@arndb.de, linux@rasmusvillemoes.dk, akpm@linux-foundation.org, mawilcox@microsoft.com, ynorov@caviumnetworks.com, mingo@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

>  - Refactored _find_next_common_bit into _find_next_bit., as suggested
>    by Yury Norov. This has no adverse effects on the performance side,
>    as the compiler successfully inlines the code.

1)
Gentoo ships 5.4.0 which doesn't inline this code on x86_64 defconfig
(which has OPTIMIZE_INLINING).


ffffffff813556c0 <find_next_bit>:
ffffffff813556c0:       55                      push   rbp
ffffffff813556c1:       48 89 d1                mov    rcx,rdx
ffffffff813556c4:       45 31 c0                xor    r8d,r8d
ffffffff813556c7:       48 89 f2                mov    rdx,rsi
ffffffff813556ca:       31 f6                   xor    esi,esi
ffffffff813556cc:       48 89 e5                mov    rbp,rsp
ffffffff813556cf:       e8 7c ff ff ff          call
ffffffff81355650 <_find_next_bit>
ffffffff813556d4:       5d                      pop    rbp
ffffffff813556d5:       c3                      ret

2)
Making "and" operation to be centerpiece of this code is kind of meh
find_next_or_bit() will be hard to implement.
