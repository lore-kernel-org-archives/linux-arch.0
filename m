Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37546 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfJNRlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 13:41:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so12403110lff.4
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 10:41:38 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 25sm4559481lje.58.2019.10.14.10.41.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 7so17474343ljw.7
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2019 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191011121951.nxna6hruuskvdxod@box> <20191011223818.7238-1-vgupta@synopsys.com>
In-Reply-To: <20191011223818.7238-1-vgupta@synopsys.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Oct 2019 10:41:18 -0700
Message-ID: <CAHk-=whLs=TrRzmB9KRLxcPERq0QXPUUkbD8vzKzaDszBcUspg@mail.gmail.com>
Subject: Re: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191014174118.-uDyylDzRjZvqGs9usEWyCXigJXczk2pPDE8aDKpfp4@z>

On Fri, Oct 11, 2019 at 3:38 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> This is inine with similar patches for nopud [1] and nop4d [2] cases.

I don't think your patch is wrong, but wouldn't it be easier and
cleaner to just do this instead

    --- a/include/asm-generic/pgtable-nopmd.h
    +++ b/include/asm-generic/pgtable-nopmd.h
    @@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud,
unsigned long address)
     static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
     {
     }
    -#define __pmd_free_tlb(tlb, x, a)          do { } while (0)
    +#define pmd_free_tlb(tlb, x, a)            do { } while (0)

     #undef  pmd_addr_end
     #define pmd_addr_end(addr, end)                    (end)

and just rely on the regular "#ifndef pmd_free_tlb" in
include/asm-generic/tlb.h?

Completely untested.

              Linus
