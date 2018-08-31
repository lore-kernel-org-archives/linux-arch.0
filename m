From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
Date: Fri, 31 Aug 2018 00:29:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08/30/2018 02:44 AM, Peter Zijlstra wrote:=0A=
>> Back in 2016, Peter had fixed this file due to a problem I reported on A=
RC. See=0A=
>> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for=0A=
>> __clear_bit_unlock()")=0A=
>> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic=
=0A=
>> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unl=
ock() same.=0A=
>>=0A=
>> This patch undoes that which could explain the issues you see. @Peter, @=
Will ?=0A=
> Right, so the thinking is that on platforms that suffer that issue,=0A=
> atomic_set*() should DTRT. And if you look at your spinlock based atomic=
=0A=
> implementation, you'll note that atomic_set() does indeed do the right=0A=
> thing.=0A=
>=0A=
> arch/arc/include/asm/atomic.h:108=0A=
=0A=
For !LLSC atomics, ARC has always had atomic_set() DTRT even in the git rev=
ision=0A=
of 2016. The problem was not in atomics, but the asymmetric way slub bit lo=
ck etc=0A=
worked (haven't checked if this changed), i.e.=0A=
=0A=
     slab_lock() -> bit_spin_lock() -> test_and_set_bit()    # atomic=0A=
     slab_unlock() -> __bit_spin_unlock() -> __clear_bit()    # non-atomic=
=0A=
=0A=
And with v4.19-rc1, we have essentially reverted f75d48644c56a due to 84c65=
91103db=0A=
("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*(=
)")=0A=
=0A=
So what we have with 4.19-rc1 is=0A=
=0A=
   static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned=
 long *p)=0A=
   {=0A=
     unsigned long old;=0A=
     p +=3D ((nr) / 32);=0A=
     old =3D // some typecheck magic on *p=0A=
     old &=3D ~(1UL << ((nr) % 32));=0A=
     atomic_long_set_release((atomic_long_t *)p, old);=0A=
   }=0A=
=0A=
So @p is being r-m-w non atomically. The lock variant uses atomic op...=0A=
=0A=
   int test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)=0A=
   { =0A=
      ...=0A=
      old =3D atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);=0A=
      ....=0A=
   }=0A=
=0A=
Now I don't know why we don't see the issue with LLSC atomics, perhaps race=
 window=0A=
reduces due to less verbose code itself etc..=0A=
=0A=
Am I missing something still ?=0A=
=0A=
-Vineet=0A=
