From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for retried page fault
Date: Wed, 29 Jul 2020 23:58:02 +1000
Message-ID: <87o8ny5sph.fsf@mpe.ellerman.id.au>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org> <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com> <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com> <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia> <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com> <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com> <1595932767.wga6c4yy6a.astroid@bobo.none> <CAHk-=wgrgRqeEo-YUgec7yQNkN+_+sHBP-NtCnfktCFEuPHTDQ@mail.gmail.com> <1595974242.esf9644sf3.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgG2N6L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 09:58:11 -0400
In-Reply-To: <1595974242.esf9644sf3.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Hillf Danton <hdanton@sina.com>, mm-commits@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Hugh Dickins <hughd@google.com>, Josef Bacik <josef@toxicpanda.com>, Will Deacon <will.deacon@arm.com>, Linux-MM <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, Yu Xu <xuyu@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Yang Shi <yang.shi@linux.alibaba.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Linus Torvalds's message of July 29, 2020 5:02 am:
>> On Tue, Jul 28, 2020 at 3:53 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> The quirk is a problem with coprocessor where it's supposed to
>>> invalidate the translation after a fault but it doesn't, so we can get a
>>> read-only TLB stuck after something else does a RO->RW upgrade on the
>>> TLB. Something like that IIRC.  Coprocessors have their own MMU which
>>> lives in the nest not the core, so you need a global TLB flush to
>>> invalidate that thing.
>> 
>> So I assumed, but it does seem confused.
>> 
>> Why? Because if there are stale translations on the co-processor,
>> there's no guarantee that one of the CPU's will have them and take a
>> fault.
>> 
>> So I'm not seeing why a core CPU doing spurious TLB invalidation would
>> follow from "stale TLB in the Nest".
>
> If the nest MMU access faults, it sends an interrupt to the CPU and
> the driver tries to handle the page fault for it (I think that's how
> it works).

Yeah AFAIK. I think they all end up calling copro_handle_mm_fault().

Except for NX/vas, where the model is a fault just causes the request to
be dropped and sent back to userspace to fix things up.

cheers
