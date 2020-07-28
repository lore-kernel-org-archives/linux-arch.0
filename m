From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
Date: Tue, 28 Jul 2020 20:53:23 +1000
Message-ID: <1595932767.wga6c4yy6a.astroid@bobo.none>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
        <20200724041508.QlTbrHnfh%akpm@linux-foundation.org>
        <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
        <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
        <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com>
        <20200727110512.GB25400@gaia>
        <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com>
        <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
        <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgG1Kxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 06:53:30 -0400
In-Reply-To: <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yang Shi <yang.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, Hillf Danton <hdanton@sina.com>, Hugh Dickins <hughd@google.com>, Josef Bacik <josef@toxicpanda.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthew Wilcox <willy@infradead.org>, Yu Xu <xuyu@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org

Excerpts from Linus Torvalds's message of July 28, 2020 4:37 am:
> [ Adding linux-arch, just to make other architectures aware of this issue=
 too.
>=20
>   We have a "flush_tlb_fix_spurious_fault()" thing to take care of the
> "TLB may contain stale entries, we can't take the same fault over and
> over again" situation.
>=20
>   On x86, it's a no-op, because x86 doesn't do that. x86 will re-walk
> the page tables - or possibly just always invalidate the faulting TLB
> entry - before taking a fault, so there can be no long-term stale
> TLB's.

[snip]

>   It looks like powerpc people at least thought about this, and only
> do it if there is a coprocessor. Which sounds a bit confused, but I
> don't know the rules.

I'm not sure about ppc32 and 64e, I'm almost certain they should do a=20
local flush if anyting, and someone with a good understanding of the=20
ISAs and CPUs might be able to nop it entirely. I agree global can't=20
ever really make sense (except as a default because we have no generic=20
local flush).

powerpc/64s reloads translations after taking a fault, so it's fine with=20
a nop here.

The quirk is a problem with coprocessor where it's supposed to=20
invalidate the translation after a fault but it doesn't, so we can get a=20
read-only TLB stuck after something else does a RO->RW upgrade on the=20
TLB. Something like that IIRC.  Coprocessors have their own MMU which=20
lives in the nest not the core, so you need a global TLB flush to
invalidate that thing.

Thanks,
Nick
