Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53212 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaErf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Aug 2018 00:47:35 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Fri, 31 Aug 2018 00:42:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B091016@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180831004246.hvE1uaflNnUx-SCGHTFs0RdxCqVSFUwwy32UiyhqqpM@z>

On 08/30/2018 02:51 AM, Will Deacon wrote:=0A=
> Yeah, the bit_spin_lock()/__bit_spin_unlock() race described in f75d48644=
c56a=0A=
> boils down to concurrent atomic_long_set_release() vs=0A=
> atomic_long_fetch_or_acquire(), which really needs to work.=0A=
=0A=
I don't see how: __clear_bit_unlock() reads @old, flips a bit and then call=
s=0A=
atomic_long_set_release() so the race is not just with set_release.=0A=
=0A=
    static inline int test_and_set_bit_lock(unsigned int nr, volatile unsig=
ned=0A=
long *p)=0A=
    {=0A=
      long old;=0A=
      unsigned long mask =3D (1UL << ((nr) % 32));=0A=
=0A=
      p +=3D ((nr) / 32);=0A=
      old =3D atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);=0A=
      return !!(old & mask);=0A=
    }=0A=
=0A=
    static inline void __clear_bit_unlock(unsigned int nr, volatile unsigne=
d long *p)=0A=
    {=0A=
       unsigned long old;=0A=
=0A=
     p +=3D ((nr) / 32);=0A=
    old =3D // soem typecheck magic on *p=0A=
    old &=3D ~(1UL << ((nr) % 32));=0A=
    atomic_long_set_release((atomic_long_t *)p, old);=0A=
  }=0A=
