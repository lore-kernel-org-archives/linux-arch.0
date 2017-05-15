From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Mon, 15 May 2017 23:04:13 +0200
Message-ID: <CAK8P3a0VgwOiPZ96FmV6+hEOJLgZVJ7zkkcsrW2z90+=fB7=pQ@mail.gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com> <20170515154728.amzw3d67tw722wmu@yury-N73SV>
 <CAK8P3a3vLW+bX4PcZ6J6At49ptFnyqEM8FxCRKVDBD9wv2YyKQ@mail.gmail.com>
 <20170515161708.aatms7fcwlguxkri@yury-N73SV> <CAK8P3a2z=aM0bJCQ_ykjxUGC8Z93sOEk99jaKuFQGB0qnmBA_w@mail.gmail.com>
 <20170515205819.womvfygyo55hbua6@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36809 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdEOVEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 17:04:15 -0400
In-Reply-To: <20170515205819.womvfygyo55hbua6@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>

On Mon, May 15, 2017 at 10:58 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Mon, May 15, 2017 at 10:31:17PM +0200, Arnd Bergmann wrote:
>> On Mon, May 15, 2017 at 6:17 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>
> Yes, something like this. But size is not the multiple of BITS_PER_LONG in
> general. This should work better:
>
>        switch (round_up(size), BITS_PER_LONG) {
>        case BITS_PER_LONG * 4:
>                if (addr[0])
>                        goto ret;
>                addr++;
>                idx += BITS_PER_LONG;
>        case BITS_PER_LONG * 3:
>                if (addr[0])
>                        goto ret;
>                addr++;
>                idx += BITS_PER_LONG;
>        case BITS_PER_LONG * 2:
>                if (addr[0])
>                        goto ret;
>                addr++;
>                idx += BITS_PER_LONG;
>        case BITS_PER_LONG * 1:
>                if (addr[0])
>                        goto ret;
>                addr++;
>                idx += BITS_PER_LONG;
>                return idx;
>        }
>
>        return __find_first_bit(addr, size);
>
> ret:
>        return idx + min(__ffs(addr[0]), size % BITS_PER_LONG;
>        }
>
> (I didn't test it yet though)
>
>> However, on architectures that rely on
>> include/asm-generic/bitops/__ffs.h or something
>> similarly verbose, this would just add needless bloat
>> to the size rather than actually making a difference
>> in performance.

I tried something along these lines earlier and couldn't
get it to produce the comparable object code in the
common case.

For sched_find_first_bit() I was able to cheat and
pass 128 as the length (along with a comment), and
most others are either multiples of BITS_PER_LONG,
or they are not constant.

       Arnd
