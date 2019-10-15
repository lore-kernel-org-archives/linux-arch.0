Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39606 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOWGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 18:06:48 -0400
Subject: Re: [PATCH v2 1/5] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
References: <20191015191926.9281-1-vgupta@synopsys.com>
 <20191015191926.9281-2-vgupta@synopsys.com>
 <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
From: Vineet Gupta <vineetg76@gmail.com>
Message-ID: <a1aee16f-cde7-0bed-e1ab-f94b6268e4ff@gmail.com>
Date: Tue, 15 Oct 2019 15:06:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi3QC7tj3rmTPg5RmK_ugVKYs-jKqX=TaASWfd73Owaig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191015220641.X2lB2aYMkeqRpFbL1e5O5gLlxEzjmkiCC3RtRdrDU9A@z>

On 10/15/19 2:48 PM, Linus Torvalds wrote:
> On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> This is a non-functional change anyways since ARC has software page walker
>> with 2 lookup levels (pgd -> pte)
>
> Could we encourage other architectures to do the same, and get rid of
> all uses of __ARCH_USE_5LEVEL_HACK?

IMHO this should have been done at the onset. The actual changes don't seem that
difficult, just need to add the missing p4d calls although I can sympathize with
hassles of coordinating/building/testing/yadi yada cross arch.

OTOH, the [45]LEVEL_HACK seem like a nice way to "fold" the levels: the
skipped/folded level vanishes completely. Among others it does things like

     #define p4d_t	pgd_t	

On ARC 2-level code:

   free_pte_range
	pmd_pgtable(*pmd);

	    ((((((*pmd).pud).pgd))) & PAGE_MASK));	     <-- 5LEVEL_HACK
			vs.
	    ((((((((*pmd).pud).p4d).pgd)))) & PAGE_MASK ));  <-- w/o 5LEVEL_HACK
	
	pmd_clear(pmd);

	    *(pmd)).pud).pgd)))) = 0
			vs.
	    *(pmd)).pud).p4d).pgd)))) = 0


So we may not be able to fix all he historical misgivigs, but this might alleviate
the pain a bit. I'll try to dabble a bit.

Thx for taking a look and te ACKs.
-Vineet
