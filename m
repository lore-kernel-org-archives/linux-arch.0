From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 7/8] locking/barriers: Use '__unqual_scalar_typeof'
 for load-acquire macros
Date: Fri, 10 Jan 2020 20:42:37 +0100
Message-ID: <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-8-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:33551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgAJTm4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 14:42:56 -0500
In-Reply-To: <20200110165636.28035-8-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Fri, Jan 10, 2020 at 5:57 PM Will Deacon <will@kernel.org> wrote:

> @@ -128,10 +128,10 @@ do {                                                                      \
>  #ifndef __smp_load_acquire
>  #define __smp_load_acquire(p)                                          \
>  ({                                                                     \
> -       typeof(*p) ___p1 = READ_ONCE(*p);                               \
> +       __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
>         compiletime_assert_atomic_type(*p);                             \
>         __smp_mb();                                                     \
> -       ___p1;                                                          \
> +       (typeof(*p))___p1;                                              \
>  })

Doesn't that last  (typeof(*p))___p1 mean you put the potential
'volatile' back on the assignment after you went through the
effort of taking it out?

       Arnd
