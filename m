From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
Date: Tue, 28 Jul 2020 12:02:08 -0700
Message-ID: <CAHk-=wgrgRqeEo-YUgec7yQNkN+_+sHBP-NtCnfktCFEuPHTDQ@mail.gmail.com>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia>
 <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
 <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com> <1595932767.wga6c4yy6a.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgG1TCa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 15:02:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DCC061794
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so5699736lfm.2
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:29 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b2sm3625182lji.63.2020.07.28.12.02.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:02:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y18so11579604lfh.11
        for <linux-arch@vger.kernel.org>; Tue, 28 Jul 2020 12:02:25 -0700 (PDT)
In-Reply-To: <1595932767.wga6c4yy6a.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Yang Shi <yang.shi@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, Hillf Danton <hdanton@sina.com>, Hugh Dickins <hughd@google.com>, Josef Bacik <josef@toxicpanda.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthew Wilcox <willy@infradead.org>, Yu Xu <xuyu@linux.alibaba.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Tue, Jul 28, 2020 at 3:53 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The quirk is a problem with coprocessor where it's supposed to
> invalidate the translation after a fault but it doesn't, so we can get a
> read-only TLB stuck after something else does a RO->RW upgrade on the
> TLB. Something like that IIRC.  Coprocessors have their own MMU which
> lives in the nest not the core, so you need a global TLB flush to
> invalidate that thing.

So I assumed, but it does seem confused.

Why? Because if there are stale translations on the co-processor,
there's no guarantee that one of the CPU's will have them and take a
fault.

So I'm not seeing why a core CPU doing spurious TLB invalidation would
follow from "stale TLB in the Nest".

If anything, I think "we have a coprocessor that needs to never have
stale TLB entries" would impact the _regular_ TLB invalidates (by
update_mmu_cache()) and perhaps make those more aggressive, exactly
because the coprocessor may not handle the fault as gracefully.

I dunno. I don't know the coprocessor side well enough to judge, I'm
just looking at it from a conceptual standpoint.

          Linus
