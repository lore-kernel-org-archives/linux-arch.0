Return-Path: <SRS0=JYYx=A2=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56651 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgGOTqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 15:46:08 -0400
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <524b87c5-0e94-1578-4395-fd53226d02aa@physik.fu-berlin.de>
Date: Wed, 15 Jul 2020 21:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Message-ID: <20200715194559.t88LXVM6ER-2NsqllVHDHHgEKkVuzMnBTJcwOYpzmdE@z>

Hi!

On 12/4/19 1:32 PM, Geert Uytterhoeven wrote:
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Nick Piggin <npiggin@gmail.com>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Cc: Rich Felker <dalias@libc.org>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>
>>> I got remote access to an SH7722-based Migo-R again, which spews a long
>>> sequence of BUGs during userspace startup.  I've bisected this to commit
>>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
>>
>> Whoopsy.. also, is this really the first time anybody booted an SH
>> kernel in over a year ?!?
> 
> Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
> CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.
> 
>>> Do you have a clue?
>>
>> Does the below help?
> 
> Unfortunately not.
> 
>> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
>> index 22d968bfe9bb..73a2c00de6c5 100644
>> --- a/arch/sh/include/asm/pgalloc.h
>> +++ b/arch/sh/include/asm/pgalloc.h
>> @@ -36,9 +36,8 @@ do {                                                  \
>>  #if CONFIG_PGTABLE_LEVELS > 2
>>  #define __pmd_free_tlb(tlb, pmdp, addr)                        \
>>  do {                                                   \
>> -       struct page *page = virt_to_page(pmdp);         \
>> -       pgtable_pmd_page_dtor(page);                    \
>> -       tlb_remove_page((tlb), page);                   \
>> +       pgtable_pmd_page_dtor(pmdp);                    \
> 
> expected ‘struct page *’ but argument is of type ‘pmd_t * {aka struct
> <anonymous> *}’
> 
>> +       tlb_remove_page((tlb), (pmdp));                 \
> 
> likewise
> 
>>  } while (0);
>>  #endif

Any chance we can have another go at this? The original change

commit c5b27a889da92f4a969d61df77bd4f79ffce57c9 (refs/bisect/bad)
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Sep 4 14:45:04 2018 +0200

    sh/tlb: Convert SH to generic mmu_gather
    
    Generic mmu_gather provides everything SH needs (range tracking and
    cache coherency).

breaks systemd for me on my SH-7785LCR [1].

Adrian

> [1] https://marc.info/?l=linux-kernel&m=159479951822677&w=2

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
