From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/refcount: Implement fast refcount_t handling
Date: Mon, 24 Apr 2017 13:19:24 -0700
Message-ID: <CAGXu5jJY2cD=nTVdv9PsAgBaJ-9KMnR5NWFScWmc_KQSSWY01Q@mail.gmail.com>
References: <20170421220939.GA65363@beast> <20170424104539.qa2jva2jytwboeam@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33234 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174305AbdDXUTc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 16:19:32 -0400
Received: by mail-io0-f174.google.com with SMTP id k87so203638152ioi.0
        for <linux-arch@vger.kernel.org>; Mon, 24 Apr 2017 13:19:26 -0700 (PDT)
In-Reply-To: <20170424104539.qa2jva2jytwboeam@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, "David S. Miller" <davem@davemloft.net>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>

On Mon, Apr 24, 2017 at 3:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 21, 2017 at 03:09:39PM -0700, Kees Cook wrote:
>> +static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
>> +{
>> +     const int a = 1;
>> +     const int u = 0;
>> +     int c, old;
>> +
>> +     c = atomic_read(&(r->refs));
>> +     for (;;) {
>> +             if (unlikely(c == (u)))
>> +                     break;
>> +             old = atomic_cmpxchg(&(r->refs), c, c + (a));
>
> Please use atomic_try_cmpxchg(), that generates saner code.

Ah-ha, thanks. I actually copied this directly out of the existing
atomic_t function, so we should probably update it there too.

-Kees

>
>> +             if (likely(old == c))
>> +                     break;
>> +             c = old;
>> +     }
>> +     return c != u;
>> +}



-- 
Kees Cook
Pixel Security
