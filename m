From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/5] Blackfin arch: SMP supporting patchset: Blackfin header files and machine common code
Date: Wed, 19 Nov 2008 16:20:07 +0800
Message-ID: <386072610811190020w619e5623p8fe2caf3373f8012@mail.gmail.com>
References: <1226999108-13839-1-git-send-email-cooloney@kernel.org>
	 <1226999108-13839-3-git-send-email-cooloney@kernel.org>
	 <20081118225629.eddd23ae.akpm@linux-foundation.org>
	 <1227081170.24481.41.camel@dyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:29245 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbYKSIUI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 03:20:08 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1403786ywe.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2008 00:20:07 -0800 (PST)
In-Reply-To: <1227081170.24481.41.camel@dyang>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gyang <graf.yang@analog.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, mingo@elte.hu, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Wed, Nov 19, 2008 at 3:52 PM, gyang <graf.yang@analog.com> wrote:
>
> 在 2008-11-18二的 22:56 -0800，Andrew Morton写道：
>> On Tue, 18 Nov 2008 17:05:05 +0800 Bryan Wu <cooloney@kernel.org> wrote:
>>
>> > From: Graf Yang <graf.yang@analog.com>
>> >
>> > Blackfin dual core BF561 processor can support SMP like features.
>> > https://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:smp-like
>> >
>> > In this patch, we provide SMP extend to Blackfin header files
>> > and machine common code
>> >
>> >
>> > ...
>> >
>> > +#define atomic_add_unless(v, a, u)                         \
>> > +({                                                         \
>> > +   int c, old;                                             \
>> > +   c = atomic_read(v);                                     \
>> > +   while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
>> > +           c = old;                                        \
>> > +   c != (u);                                               \
>> > +})
>>
>> The macro references its args multiple times and will do weird or
>> inefficient things when called with expressions which have
>> side-effects, or which do slow things.
>>
>> >
>> > ...
>> >
>> > +#include <asm/system.h>            /* save_flags */
>> > +
>> > +static inline void set_bit(int nr, volatile unsigned long *addr)
>> >  {
>> >     int *a = (int *)addr;
>> >     int mask;
>> > @@ -57,21 +91,23 @@ static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>> >     a += nr >> 5;
>> >     mask = 1 << (nr & 0x1f);
>> >     local_irq_save(flags);
>> > -   *a &= ~mask;
>> > +   *a |= mask;
>>
>> I think you just broke clear_bit().  Maybe I'm misreading the diff.
> OK, We have corrected it on our own tree.

Both the code and the patch are all right. Because the mess from diff,
we all misread it.

-Bryan

>>
>> >     local_irq_restore(flags);
>> >  }
>> >
>> >
>> > ...
>> >
>> > +#define smp_mb__before_clear_bit() barrier()
>> > +#define smp_mb__after_clear_bit()  barrier()
>> > +
>> > +static inline void __set_bit(int nr, volatile unsigned long *addr)
>> > +{
>> > +   int *a = (int *)addr;
>> > +   int mask;
>> > +
>> > +   a += nr >> 5;
>> > +   mask = 1 << (nr & 0x1f);
>> > +   *a |= mask;
>> > +}
>> > +
>> > +static inline void __clear_bit(int nr, volatile unsigned long *addr)
>> > +{
>> > +   int *a = (int *)addr;
>> > +   int mask;
>> > +
>> > +   a += nr >> 5;
>> > +   mask = 1 << (nr & 0x1f);
>> > +   *a &= ~mask;
>> > +}
>> > +
>> > +static inline void __change_bit(int nr, volatile unsigned long *addr)
>> > +{
>> > +   int mask;
>> > +   unsigned long *ADDR = (unsigned long *)addr;
>> > +
>> > +   ADDR += nr >> 5;
>> > +   mask = 1 << (nr & 31);
>> > +   *ADDR ^= mask;
>> > +}
>>
>> I'm surprised there isn't any generic code which can be used for the above.
>>
>> >
>> > ...
>> >
>>
>> Gad what a lot of code.  I don't think I have time to read it all, sorry.
>
